-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sep
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `productos`
--

CREATE DATABASE IF NOT EXISTS sep_productos;

USE sep_productos;

CREATE USER 'sep_user'@'%' IDENTIFIED BY 'sep_password';

GRANT ALL PRIVILEGES ON sep_productos.* TO 'sep_user'@'%';
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `producto` varchar(255) DEFAULT NULL,
  `codigo` int NOT NULL,
  `descripcion` text,
  `stock` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `imagen` text,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES ('Macarilla de Arroz',1,'Mascarillas Karite',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/revox-mascarilla-facial-3-minutos-ultra-hidratante-ritual-japones-1-67478_thumb_315x352.jpg'),('Macarilla de Miel',2,'Mascarillas Karite',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/ziaja-mascarilla-facial-de-miel-de-manuka-antiacne-para-pieles-grasas-1-47527_thumb_315x352.jpg'),('Macarilla Acido Hialuronico',3,'Mascarillas Karite',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/ziaja-mascarilla-y-exfoliante-facial-con-acido-hialuronico-1-79226_thumb_315x352.jpg'),('Macarilla Colageno',5,'Mascarillas Karite',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/jigott-mascarilla-facial-con-extracto-de-colageno-real-1-67999_thumb_315x352.jpg'),('Macarilla Vitamina C',6,'Mascarillas Karite',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/beauty-formulas-brightening-vitamin-c-mascarilla-hidratante-iluminador-1-74671_thumb_315x352.jpg'),('Macarilla Baba de caracol',7,'Mascarillas Karite',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/jigott-mascarilla-facial-con-extracto-de-baba-de-caracol-1-68000_thumb_315x352.jpg'),('Macarilla 4K Oro',8,'Mascarillas Karite',100,8.00,'Skincare','https://cdn.grupoelcorteingles.es/SGFM/dctm/MEDIA03/202102/15/00113514805954____7__516x640.jpg'),('Mascarilla Carbon',10,'Mascarillas Liquida Peel off',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/revuele-gel-limpieza-3-en-1-con-carbon-activo-no-problem-1-33753_thumb_315x352.jpg'),('Mascarilla Aloe Vera',11,'Mascarillas Liquida Peel off',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/jigott-mascarilla-facial-con-extracto-de-aloe-1-68004_thumb_315x352.jpg'),('Mascarilla Anti-Arrugas',12,'Mascarillas Liquida Peel off',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/nivea-mascarilla-antiarrugas-q10-plus-1-60230_thumb_315x352.jpg'),('Mascarilla Mora',13,'Mascarillas de tela chovemoar',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/essence-hello-good-stuff-mascarilla-facial-peel-off-iluminador-fresh-glow-1-75631_thumb_315x352.jpg'),('Mascarilla Frambuesa',14,'Mascarillas de tela chovemoar',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/montagne-jeunesse-7th-heaven-mascarilla-facial-superfood-blueberry-1-50719_thumb_315x352.jpg'),('Mascarilla Naranja',15,'Mascarillas de tela chovemoar',100,8.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/garnier-mascarilla-de-tejido-para-ojos-anti-fatiga-1-39162_thumb_315x352.jpg'),('Mascarilla Hidrantante',16,'Mascarillas Hidratantes',100,5.00,'Skincare','https://th.bing.com/th/id/OIP.tkGTuHTz97eJ_Hw53M1zyQHaHa?pid=ImgDet&rs=1'),('Tonico facial de arroz',17,'Skin Care',100,30.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/missha-mascarilla-airy-fit-sheet-mask-arroz-1-47998_thumb_315x352.jpg'),('Primers',18,'Skin Care',100,15.00,'Skincare','https://i.pinimg.com/originals/e0/3a/1d/e03a1d5c4176ad8fc59c7537243dca32.jpg'),('Serum de Caviar',19,'Skin Care',100,30.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/natura-siberica-serum-facial-revitalizante-royal-caviar-accion-profunda-anti-age-1-18380_thumb_315x352.jpg'),('Serum de Colageno',20,'Skin Care',100,30.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/revox-just-solucion-hidratante-aminoacidos-de-colageno-ha-1-55319_thumb_315x352.jpg'),('Jabon de arroz',21,'Skin Care',100,15.00,'Skincare','https://www.farma-amparo.es/1795-large_default/jabon-natural-arroz-100g-premium-sys.jpg'),('Vinchas',22,'Accesorio',100,15.00,'Skincare','https://th.bing.com/th/id/OIP.gGNFQsJQxFrE2A4VB3Sc3wHaHa?pid=ImgDet&rs=1'),('Balsamo de aloe vera',23,'Hidrantante de labios',100,7.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/idc-institute-balsamo-labial-aloe-vera-1-34682_thumb_315x352.jpg'),('Base Fit Me Mc',24,'Maquillaje',100,20.00,'Skincare','https://http2.mlstatic.com/base-maybelline-fit-me-efeito-matte-24h-pronta-entrega-D_NQ_NP_871911-MLB20670055961_042016-F.jpg'),('Brochas 2 en 1',25,'Herramienta de Maquillaje',100,10.00,'Skincare','https://m.media-amazon.com/images/I/412qevJ7ADL._AC_SX569_.jpg'),('Parches ojeras',26,'Skin Care',100,5.00,'Skincare','https://media.glamour.mx/photos/61907b102d97bd4c522a87a3/master/w_320%2Cc_limit/210735.jpg'),('Parches labios',27,'Skin Care',100,5.00,'Skincare','https://i.pinimg.com/originals/36/9e/21/369e21c579573aaa525836bc65b55554.jpg'),('Pulpito Limpiador',28,'Skin Care',100,15.00,'Skincare','https://th.bing.com/th/id/R.8c374e848ef334317562c70016f6f579?rik=Zg1Vd3MIryKX5g&riu=http%3a%2f%2fwww.ginza.com.bo%2fwp-content%2fuploads%2f2020%2f10%2fpulpito-doble.jpg&ehk=1UmDpThtgJcBuG%2bDqrfNjUAbn8ON8SYsHr2BNfb4Vrg%3d&risl=&pid=ImgRaw&r=0'),('Jabon Cejas',29,'Maquillaje',100,15.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/jovo-jabon-para-cejas-styling-soap-1-77294_thumb_315x352.jpg'),('Gel de cejas',30,'Maquillaje',100,15.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/maybelline-gel-de-cejas-tattoo-brow-257-medium-brown-1-75021_thumb_315x352.jpg'),('Limpiador de Brochas',31,'Herramienta de Maquillaje',100,20.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/isoclean-limpiador-de-brochas-275ml-1-78485_thumb_315x352.jpg'),('Perfiladores',32,'Herramienta de Maquillaje',100,12.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/loreal-paris-perfilador-de-labios-lip-liner-couture-colour-riche-124-s-il-vous-plait-1-65597_thumb_315x352.jpg'),('Labiales Nude',33,'Maquillaje',100,12.00,'Skincare','https://th.bing.com/th/id/OIP.U5lT5nTbP6ukv_tSNCSN5wHaHa?pid=ImgDet&rs=1'),('KIT 1 classic',34,'3 mascarillas a elección, 1 mascarilla peel off, 1 parche de ojeras, 1 parche de labios, 1 mascarilla comprimida, 1 gel de cejas y pestañas, 1 set de 3 perfiladores, 1 mascarilla 3 pasos nariz, 1 cepillo de cejas',20,55.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 2 classic',35,'3 mascarillas a elección, 2 parches de labios, 2 parches de ojeras, 1 serum a elección, 1 set de 3 perfiladores, 1 bálsamo labial, 1 rimel de cejas y pestañas, 1 vincha skincare, 1 mascarilla en gel, 1 mascarilla comprimida, 1 cepillo de cejas',20,100.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 3 classic',36,'2 mascarillas a elección, 1 mascarilla peel off, 2 parches de ojeras, 1 parche de labios, 1 mascarilla comprimida, 1 mascarilla 3 pasos nariz, 2 mascarillas en gel, 2 exfoliantes faciales, 1 gel de cejas y pestañas, 1 brocha 2 en 1, 1 cepillo de cejas',20,75.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 4 classic',37,'2 mascarillas a elección, 1 parche de ojeras, 1 parche de labios, 1 vincha skincare, 1 jabón de arroz, 1 set de 3 perfiladores, 1 serum a elección, 1 mascarilla comprimida, 1 mascarilla 3 pasos nariz, 2 mascarillas en gel, 2 exfoliantes faciales, 1 gel de cejas y pestañas, 1 cepillo de cejas',20,120.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 5 classic',38,'3 mascarillas a elección, 1 bálsamo labial, 1 parche de labios, 2 parches de ojeras, 2 mascarillas en gel, 1 vincha skincare, 1 mascarilla comprimida, 1 cepillo de cejas',20,50.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 6 classic',39,'5 mascarillas a elección, 2 parches de labios, 1 parche de ojeras, 1 vincha skincare, 1 mascarilla en gel, 1 cepillo de cejas',20,55.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 7 classic',40,'4 mascarillas a elección, 2 mascarillas exfoliantes, 2 parches de ojeras, 2 parches de labios, 4 mascarillas comprimidas, 2 mascarillas nocturnas, 1 mascarilla en gel, 1 cepillo de cejas',20,75.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('KIT 8 classic',41,'3 mascarillas a elección, 1 parche de labios, 1 parche de ojeras, 1 serum a elección, 1 set de 3 perfiladores, 1 brocha a elección, 1 vincha skincare, 1 mascarilla en gel, 1 mascarilla comprimida, 1 cepillo de cejas',20,80.00,'Kit','https://th.bing.com/th/id/OIP.ycS-QNjiwXn7yeeQTd9bOwHaHa?pid=ImgDet&rs=1'),('Brochas',105,'Herramienta de Maquillaje',100,15.00,'Skincare','https://www.maquillalia.com/images/productos/thumbnails/ecotools-new-natural-set-de-brochas-blush-highlight-duo-2-79800_thumb_315x352.jpg'),('Mascarilla Chocolate',106,'Esta es un prueba para mostrar que se pueden agregar productos ',5,8.00,'Skincare','https://www.google.com/url?sa=i&url=https%3A%2F%2Festeticmundo.com%2Fmascarilla-facial-peel-off-chocolate-400g%2F&psig=AOvVaw0kjfn745w2FfNGY6LjLtYU&ust=1732131772281000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLivz-yT6YkDFQAAAAAdAAAAABAE');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- Crear tabla usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE, -- Nombre de usuario único
    password VARCHAR(255) NOT NULL,       -- Contraseña cifrada
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha de creación
);

-- Insertar usuario inicial
-- La contraseña "123" será almacenada cifrada (usando MD5 en este ejemplo para simplicidad, pero se recomienda bcrypt o SHA-256 en producción)
INSERT INTO usuarios (username, password)
VALUES
    ('admin', MD5('123'));

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-20 22:31:32
