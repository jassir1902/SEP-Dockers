const productList = document.getElementById('productList');
const productModal = document.getElementById('productModal');
const productForm = document.getElementById('productForm');
const closeModalButton = document.getElementById('closeModalButton');
const editProductButton = document.getElementById('editProductButton');
const deleteProductButton = document.getElementById('deleteProductButton');
let currentPage = 1;
let editingProductCode = null; // Variable para almacenar el código del producto que estamos editando


document.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token'); // Verifica si ya hay una sesión activa
    const loginModal = document.getElementById('loginModal');
    const appContent = document.getElementById('appContent');

    if (token) {
        // Si hay un token, muestra la aplicación directamente
        loginModal.style.display = 'none';
        appContent.style.display = 'block';
    } else {
        // Si no hay sesión, muestra el formulario de login
        loginModal.style.display = 'block';
        appContent.style.display = 'none';
    }

    // Manejo del envío del formulario de login
    document.getElementById('loginForm').addEventListener('submit', async (event) => {
        event.preventDefault(); // Evita que el formulario recargue la página
    
        const username = document.getElementById('username').value; // Obtén el nombre de usuario
        const password = document.getElementById('password').value; // Obtén la contraseña
    
        try {
            const response = await fetch('http://localhost:5000/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, password }) // Envia los datos como JSON
            });
    
            if (!response.ok) {
                // Si el inicio de sesión falla, muestra un error
                const errorData = await response.json();
                document.getElementById('loginError').innerText = errorData.error;
                document.getElementById('loginError').style.display = 'block';
                throw new Error(errorData.error);
            }
    
            const data = await response.json();
            console.log('Inicio de sesión exitoso:', data.message);
    
            // Guarda algo en el frontend para identificar la sesión (por ejemplo, un token)
            localStorage.setItem('session', 'active'); // Puedes guardar un token si estás utilizando JWT
    
            // Oculta el modal de login y muestra la aplicación
            document.getElementById('loginModal').style.display = 'none';
            document.getElementById('appContent').style.display = 'block';
    
        } catch (error) {
            console.error('Error al iniciar sesión:', error.message);
        }
    });
});

document.getElementById('logoutButton').addEventListener('click', () => {
    // Borra el token del almacenamiento local
    localStorage.removeItem('token');

    // Recarga la página para volver al login
    location.reload();
});

// Cargar productos
async function loadProducts(page = 1) {
    try {
        const response = await fetch(`http://localhost:5000/productos?page=${page}&limit=8`);
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Error al obtener los productos');
        }
        const data = await response.json();

        productList.innerHTML = '';
        data.products.forEach(product => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${product.codigo}</td>
                <td>${product.producto}</td>
                <td>${product.descripcion}</td>
                <td>${product.stock}</td>
                <td>${product.precio_unitario}</td>
                <td>${product.categoria}</td>
                <td><img src="${product.imagen}" width="50"></td>
            `;
            productList.appendChild(row);
        });

        updatePagination(data.total_pages, page);
    } catch (error) {
        console.error('Error:', error);
        alert(error.message); // Mostrar un mensaje amigable al usuario
    }
}


// Actualizar paginación
function updatePagination(totalPages, currentPage) {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';
    for (let i = 1; i <= totalPages; i++) {
        const button = document.createElement('button');
        button.textContent = i;
        button.disabled = i === currentPage;
        button.addEventListener('click', () => loadProducts(i));
        pagination.appendChild(button);
    }
}

// Abrir el modal de edición
function openEditProductModal() {
    document.getElementById('editProductModal').style.display = 'block';
}

// Cerrar el modal de edición
function closeEditProductModal() {
    document.getElementById('editProductModal').style.display = 'none';
    document.getElementById('editProductForm').reset(); // Resetear el formulario
    document.getElementById('editProductCode').readOnly = false; // Habilitar la edición del código
    editingProductCode = null; // Limpiar la variable de código
}

// Función para cargar los detalles del producto cuando se ingresa el código
async function loadProductForEditing() {
    console.log('Botón "Cargar Producto" presionado');
    const codigo = document.getElementById('editProductCode').value;
    console.log('Código ingresado:', codigo);

    if (codigo) {
        try {
            const response = await fetch(`http://localhost:5000/productos/${codigo}`);
            console.log('Estado de la respuesta:', response.status);
            if (!response.ok) throw new Error('Producto no encontrado');
            
            const product = await response.json();
            console.log('Producto recibido:', product);

            // Rellenar el formulario con los datos del producto
            document.getElementById('editName').value = product.producto; // Nombre del producto
            document.getElementById('editDescription').value = product.descripcion; // Descripción
            document.getElementById('editQuantity').value = product.stock; // Stock
            document.getElementById('editPrice').value = product.precio_unitario; // Precio unitario
            document.getElementById('editCategory').value = product.categoria; // Categoría
            document.getElementById('editImage').value = product.imagen; // URL de la imagen

            // Bloquea el campo de código después de cargar los datos
            document.getElementById('editProductCode').readOnly = true;
        } catch (error) {
            console.error('Error al cargar el producto:', error);
            alert(error.message);
        }
    } else {
        alert('Por favor, introduce un código.');
    }
}


// Enviar formulario para editar producto
document.getElementById('editProductForm').addEventListener('submit', async (event) => {
    event.preventDefault();


    // Recopila los datos del formulario de edición
    const productData = {
        producto: document.getElementById('editName').value, // Nombre
        descripcion: document.getElementById('editDescription').value, // Descripción
        stock: parseInt(document.getElementById('editQuantity').value), // Cantidad
        precio_unitario: parseFloat(document.getElementById('editPrice').value), // Precio
        categoria: document.getElementById('editCategory').value, // Categoría
        imagen: document.getElementById('editImage').value // URL de la imagen
    };

    console.log('Datos enviados al backend:', productData);

    const codigo = document.getElementById('editProductCode').value;

    try {
        // Realiza la solicitud PUT al backend
        const response = await fetch(`http://localhost:5000/productos/${codigo}`, {
            method: 'PUT',
            body: JSON.stringify(productData),
            headers: { 'Content-Type': 'application/json' }
        });

        if (!response.ok) throw new Error('Error al actualizar el producto');
        
        // Recarga la lista de productos
        loadProducts(currentPage);
        closeEditProductModal(); // Cierra el modal de edición
    } catch (error) {
        console.error('Error al actualizar el producto:', error);
        alert('No se pudo actualizar el producto.');
    }
});



// Abrir el modal de eliminación
function openDeleteProductModal() {
    document.getElementById('deleteProductModal').style.display = 'block';
}

// Cerrar el modal de eliminación
function closeDeleteProductModal() {
    document.getElementById('deleteProductModal').style.display = 'none';
}

// Función para eliminar el producto
async function deleteProductByCode(codigo) {
    try {
        const response = await fetch(`http://localhost:5000/productos/${codigo}`, {
            method: 'DELETE'
        });
        if (!response.ok) throw new Error('Error al eliminar el producto');
        loadProducts(currentPage); // Recargar la lista de productos
        closeDeleteProductModal(); // Cerrar el modal
    } catch (error) {
        alert(error.message);
    }
}

// Enviar formulario para eliminar producto
document.getElementById('deleteProductForm').addEventListener('submit', async (event) => {
    event.preventDefault();
    const codigo = document.getElementById('deleteProductCode').value;
    if (codigo) {
        deleteProductByCode(codigo);  // Llamar la función para eliminar el producto
    }
});

// Abrir el modal de agregar producto
function openProductModal() {
    productModal.style.display = 'block';
}

// Cerrar el modal de agregar producto
function closeProductModal() {
    productModal.style.display = 'none';
    productForm.reset(); // Limpiar el formulario
}

// Asociar el botón de cerrar modal
closeModalButton.addEventListener('click', closeProductModal);


// Enviar formulario para agregar/editar producto
productForm.addEventListener('submit', async (event) => {
    event.preventDefault();
    const productData = {
        producto: document.getElementById('name').value,
        descripcion: document.getElementById('description').value,
        stock: document.getElementById('quantity').value,
        precio_unitario: document.getElementById('price').value,
        categoria: document.getElementById('category').value,
        imagen: document.getElementById('image').value
    };

    try {
        let response;
        if (editingProductCode) {
            // Actualizar producto
            response = await fetch(`http://localhost:5000/productos/${editingProductCode}`, {
                method: 'PUT',
                body: JSON.stringify(productData),
                headers: { 'Content-Type': 'application/json' }
            });
        } else {
            // Agregar producto
            response = await fetch('http://localhost:5000/productos', {
                method: 'POST',
                body: JSON.stringify(productData),
                headers: { 'Content-Type': 'application/json' }
            });
        }

        if (!response.ok) throw new Error('Error al guardar el producto');
        loadProducts(currentPage);
        closeProductModal(); // Asegúrate de que también se cierra el modal
    } catch (error) {
        console.error('Error:', error);
    }
});




// Inicializar la carga de productos al cargar la página
loadProducts();
