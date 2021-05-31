--Creando la base de datos de Vennus
create database bd_Vennus
go

--Poniendo en Uso
use bd_Vennus
go

--Creando la Tabla Departamento
create table tb_Departamento(
	codigo_departamento char(5) not null primary key,
	departamento varchar(50) not null)
go

--Creando la Tabla Provincia
create table tb_Provincia(
	codigo_provincia char(5) not null primary key,
	provincia varchar(50) not null,
	provincia_codigo_dpto char(5) not null foreign key 
	references tb_Departamento(codigo_departamento)
)
go

--Creando la Tabla Distrito
create table tb_Distrito(
	codigo_distrito char(5) not null primary key,
	distrito varchar(50) not null,
	distrito_codigo_provincia char(5) not null foreign key 
	references tb_Provincia(codigo_provincia) 
)
go


--Creando la Tabla Cliente 
create table tb_Cliente(
	id_cliente char(5) not null primary key,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	celular varchar(13),
	correo varchar(50),
	distrito char(5) not null foreign key 
	references tb_Distrito (codigo_distrito),
	direccion varchar(100) not null)
go

--Creando la Tabla Categoria
create table tb_Categoria(
	id_categoria char(2) not null primary key,
	categoria varchar(20) not null)
go


alter table tb_Categoria 

--Creando la Tabla Producto
create table tb_Producto(
	id_producto char(5) not null primary key,
	nombre varchar(30) not null,
	descripcion varchar(100),
	marca varchar(20) not null,
	estado char(1) not null,
	seccion char(1) not null,
	producto_id_categoria char(2) not null foreign key references tb_Categoria (id_categoria))
go

-- Crear la tabla colores
create table tb_Color(
	id_color char(5) not null primary key,
	color varchar(15) not null
)
go

--Creando la Tabla Detalles de Producto
create table tb_Detalle_Producto(
	id_producto_venta char(5) not null primary key,
	id_producto char(5) not null foreign key references tb_Producto (id_producto),
	talla varchar(2) not null,
	producto_id_color char(5) not null foreign key references tb_Color(id_color),
	precio numeric(7,2)
)
go

--Creando la Tabla Pais
create table tb_Pais(
	id_pais char(5) not null primary key,
	pais varchar(30) not null)
go

--Creando la Tabla Proveedor
create table tb_Proveedor(
	id_proveedor char(5) not null primary key,
	nombre_proveedor varchar(30) not null,
	correo varchar(50) not null,
	telefono varchar(13),
	id_pais char(5) not null foreign key references tb_Pais (id_pais))
go

--Creando la Tabla Producto por Proveedor
create table tb_Producto_Proveedor(
	id_proveedor char(5) not null foreign key references tb_Proveedor (id_proveedor),
	id_producto char(5) not null foreign key references tb_Producto (id_producto))
go

--Agregando PK a dos Columnas de la tabla Producto_Proveedor
alter table tb_Producto_Proveedor
add primary key(id_proveedor, id_producto)
go

--Creando la Tabla Pedido
create table tb_Pedido(
	id_pedido char(5) not null primary key,
	id_cliente char(5) not null foreign key references tb_Cliente (id_cliente),
	fecha date,
	hora time,
	importe numeric(7,2) not null,
	proceso char(1) not null)
go

--Creando la Tabla Detalle de Pedido
create table tb_Detalle_Pedido(
	id_pedido char(5) not null foreign key references tb_Pedido (id_pedido),
	id_producto_venta  char(5) not null foreign key references tb_Detalle_Producto (id_producto_venta),
	cantidad smallint not null,
	precio numeric(7,2) not null)
go

--Agregando PK a tres Columnas
alter table tb_Detalle_Pedido
add primary key (id_pedido, id_producto_venta)
go




--INSERTAR DATOS
--Tabla Departamentos


insert into tb_Departamento values
('D0001','Lima'),
('D0002','Lambayeque'),
('D0003','Ica'),
('D0004','Pasco'),
('D0005','Ayacucho')
go

--Listar los registros de la tabla de Departamento
select * from tb_Departamento
go

--Insertar datos
--Tabla Provincia
--Forma3

insert into tb_Provincia values
('PR001','Lima','D0001'),
('PR002','Cañete','D0001'),
('PR003','Barranco','D0001'),
('PR004','Ica','D0003'),
('PR005','Cerro de Pasco','D0004'),
('PR006','Huamanga','D0005')
go

--Listar los registros de la tabla de Provincia
select * from tb_Provincia
go


--Insertar datos
--Tabla Distrito
--Forma3

insert into tb_Distrito values
('DI001','Lima','PR001'),
('DI002','Los Olivos','PR001'),
('DI003','San Martin de Porres','PR001'),
('DI004','Comas','PR001'),
('DI005','Breña','PR001'),
('DI006','Independencia','PR001')
go

--Listar los registros de la tabla de Distrito
select * from tb_Distrito
go

--Insertar datos
--Tabla Clientes
--Forma3

insert into tb_Cliente values
('C0001','Joseph','Fuentes Velasquez',null,'Joseph@hotmail.com','DI001','Mz-H1lt25 Av.Sirenas'),
('C0002','Gerson','Berrocal Najarro',null,'Gerson@hotmail.com','DI002','Mz-H1lt2 Asoc.portales'),
('C0003','Dante','Sembrera Cruz','906040279','Dante@hotmail.com','DI003','Mz-Hlt25 Urb.Asentamiento Humano'),
('C0004','Elmer','Cubas Silva',null,null,'DI004','Mz-Hlt25 Jardinez')
go

--Listar los registros de la tabla de Cliente
select * from tb_Cliente
go


--Insertar datos
--Tabla Categoria
--Forma3

insert into tb_Categoria values
('01','Camisas'),
('02','Polos'),
('03','Pantalones'),
('04','Blusas'),
('05','Vestidos')
GO
--Listar los registros de la tabla de Categoria
select * from tb_Categoria
go


-- Seleccionar datos especificos
-- tb_Cliente, tb_Distrito
-- id cliente, nombre, apellido , distrito
select id_cliente,nombre,apellido, tb_Distrito.distrito
from tb_Cliente inner join tb_Distrito
on (tb_Cliente.distrito=tb_Distrito.codigo_distrito)
go
