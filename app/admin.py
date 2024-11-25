from flask import Flask, request, jsonify, render_template, session
from flask_mysqldb import MySQL
from flask_cors import CORS
from MySQLdb import DatabaseError
from flask import send_from_directory
from flask_bcrypt import Bcrypt
import hashlib

import os

app = Flask(__name__)
CORS(app)

app.config['MYSQL_HOST'] = os.getenv('DB_HOST', 'db')  # Host de la base de datos
app.config['MYSQL_USER'] = os.getenv('DB_USER', 'sep_user')  # Usuario
app.config['MYSQL_PASSWORD'] = os.getenv('DB_PASSWORD', 'sep_password')  # Contraseña
app.config['MYSQL_DB'] = os.getenv('DB_NAME', 'sep_productos')  # Nombre de la base de datos
app.config['MYSQL_PORT'] = int(os.getenv('DB_PORT', 3306))  # Puerto

mysql = MySQL(app)
bcrypt = Bcrypt(app)

# Llave secreta para sesiones (importante para proteger las cookies de sesión)
app.secret_key = '5dd5f3d3b8c8e07e4f08398dd3a3e2c7'  # Una clave aleatoria fuerte


@app.route('/js/<path:filename>')
def serve_js(filename):
    return send_from_directory('js', filename)

@app.route('/')
def index():
    return render_template('inicio.html')

# Función auxiliar para obtener el conteo total de productos
def get_product_count():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT COUNT(*) FROM productos")
    return cursor.fetchone()[0]

# Validación de campos requeridos
def validate_fields(data, required_fields):
    missing_fields = [field for field in required_fields if field not in data]
    if missing_fields:
        return False, missing_fields
    return True, []

@app.route('/productos/<int:codigo>', methods=['GET'])
def get_product(codigo):
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM productos WHERE codigo = %s", (codigo,))
        product = cursor.fetchone()
        if not product:
            return jsonify({'message': 'Producto no encontrado'}), 404

        # Ajuste del mapeo según el orden de las columnas en la tabla
        return jsonify({
            'producto': product[0],  # Nombre del producto
            'codigo': product[1],  # Código del producto
            'descripcion': product[2],  # Descripción
            'stock': product[3],  # Stock
            'precio_unitario': float(product[4]),  # Precio unitario
            'categoria': product[5],  # Categoría
            'imagen': product[6]  # URL de la imagen
        })
    except DatabaseError as db_err:
        return jsonify({'error': 'Error en la base de datos', 'details': str(db_err)}), 500
    except Exception as e:
        return jsonify({'error': 'Error interno', 'details': str(e)}), 500


@app.route('/productos', methods=['GET'])
def get_products():
    try:
        page = int(request.args.get('page', 1))
        limit = int(request.args.get('limit', 8))
        offset = (page - 1) * limit

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT COUNT(*) FROM productos")
        total_products = cursor.fetchone()[0]

        # Verificar si la página solicitada es válida
        total_pages = -(-total_products // limit)  # Cálculo del techo
        if page > total_pages or page < 1:
            return jsonify({
                'error': 'Página no válida',
                'total_pages': total_pages,
                'current_page': page
            }), 400

        # Obtener los productos de la página solicitada
        cursor.execute("SELECT * FROM productos LIMIT %s OFFSET %s", (limit, offset))
        products = cursor.fetchall()

        return jsonify({
            'products': [{
                'codigo': row[1],
                'producto': row[0],
                'descripcion': row[2],
                'stock': row[3],
                'precio_unitario': float(row[4]),
                'categoria': row[5],
                'imagen': row[6]
            } for row in products],
            'total_pages': total_pages,
            'current_page': page
        })
    except DatabaseError as db_err:
        return jsonify({'error': 'Error en la base de datos', 'details': str(db_err)}), 500
    except Exception as e:
        return jsonify({'error': 'Error interno', 'details': str(e)}), 500


@app.route('/productos', methods=['POST'])
def add_product():
    try:
        data = request.json
        required_fields = ['producto', 'descripcion', 'stock', 'precio_unitario', 'categoria', 'imagen']
        valid, missing_fields = validate_fields(data, required_fields)

        if not valid:
            return jsonify({'error': 'Faltan campos requeridos', 'missing_fields': missing_fields}), 400

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT MAX(codigo) FROM productos")
        result = cursor.fetchone()
        next_code = (result[0] or 0) + 1

        cursor.execute(
            "INSERT INTO productos (codigo, producto, descripcion, stock, precio_unitario, categoria, imagen) "
            "VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (next_code, data['producto'], data['descripcion'], data['stock'], data['precio_unitario'], data['categoria'], data['imagen'])
        )
        mysql.connection.commit()
        return jsonify({'message': 'Producto agregado', 'codigo': next_code}), 201
    except DatabaseError as db_err:
        return jsonify({'error': 'Error en la base de datos', 'details': str(db_err)}), 500
    except Exception as e:
        return jsonify({'error': 'Error interno', 'details': str(e)}), 500

@app.route('/productos/<int:codigo>', methods=['PUT'])
def update_product(codigo):
    try:
        # Obtén los datos enviados desde el frontend
        data = request.json
        print("Datos recibidos para actualizar:", data)  # Log para verificar los datos
        required_fields = ['producto', 'descripcion', 'stock', 'precio_unitario', 'categoria', 'imagen']
        valid, missing_fields = validate_fields(data, required_fields)

        if not valid:
            return jsonify({'error': 'Faltan campos requeridos', 'missing_fields': missing_fields}), 400

        # Realiza la actualización en la base de datos
        cursor = mysql.connection.cursor()
        cursor.execute(
            "UPDATE productos SET producto = %s, descripcion = %s, stock = %s, precio_unitario = %s, categoria = %s, imagen = %s WHERE codigo = %s",
            (data['producto'], data['descripcion'], data['stock'], data['precio_unitario'], data['categoria'], data['imagen'], codigo)
        )
        mysql.connection.commit()
        return jsonify({'message': 'Producto actualizado'})
    except DatabaseError as db_err:
        return jsonify({'error': 'Error en la base de datos', 'details': str(db_err)}), 500
    except Exception as e:
        return jsonify({'error': 'Error interno', 'details': str(e)}), 500



@app.route('/productos/<int:codigo>', methods=['DELETE'])
def delete_product(codigo):
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("DELETE FROM productos WHERE codigo = %s", (codigo,))
        mysql.connection.commit()
        return jsonify({'message': 'Producto eliminado'})
    except DatabaseError as db_err:
        return jsonify({'error': 'Error en la base de datos', 'details': str(db_err)}), 500
    except Exception as e:
        return jsonify({'error': 'Error interno', 'details': str(e)}), 500
    

@app.route('/login', methods=['POST'])
def login():
    try:
        data = request.json
        username = data.get('username')
        password = data.get('password')

        if not username or not password:
            return jsonify({'error': 'Faltan datos'}), 400

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT id, password FROM usuarios WHERE username = %s", (username,))
        user = cursor.fetchone()

        if user:
            user_id, hashed_password = user
            # Si usaste MD5 para almacenar la contraseña, usa esto (aunque no es seguro para producción):
            if hashed_password == hashlib.md5(password.encode()).hexdigest():
                session['user_id'] = user_id
                return jsonify({'message': 'Inicio de sesión exitoso'}), 200
            else:
                return jsonify({'error': 'Credenciales incorrectas'}), 401
        else:
            return jsonify({'error': 'Usuario no encontrado'}), 404
    except Exception as e:
        print(f"Error en /login: {e}")  # Registra el error en la consola
        return jsonify({'error': 'Error interno'}), 500


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
