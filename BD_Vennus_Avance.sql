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
	provincia varchar(50) not null)
go

--Creando la Tabla Distrito
create table tb_Distrito(
	codigo_distrito char(5) not null primary key,
	distrito varchar(50) not null)
go

--Creando la Tabla Cliente 
create table tb_Cliente(
	id_cliente char(5) not null primary key,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	celular varchar(13),
	correo varchar(50),
	departamento char(5) not null foreign key references tb_Departamento(codigo_departamento),
	provincia char(5) not null foreign key references tb_Provincia (codigo_provincia),
	distrito char(5) not null foreign key references tb_Distrito (codigo_distrito),
	direccion varchar(100) not null)
go

--Creando la Tabla Categoria
create table tb_Categoria(
	id_categoria char(2) not null primary key,
	categoria varchar(20) not null)
go

--Creando la Tabla Producto
create table tb_Producto(
	id_producto char(5) not null primary key,
	nombre varchar(20) not null,
	descripcion varchar(100),
	marca varchar(20) not null,
	estado char(1) not null,
	seccion char(1) not null,
	id_categoria char(2) not null foreign key references tb_Categoria (id_categoria))
go

--Creando la Tabla Detalles de Producto
create table tb_Detalle_Producto(
	id_producto_venta char(5) not null primary key,
	id_producto char(5) not null foreign key references tb_Producto (id_producto),
	talla char(1) not null,
	precio numeric(7,2))
go

--Creando la Tabla Colores
create table tb_Color(
	id_color char(3) not null primary key,
	color varchar(30) not null)
go

--Creando la Tabla Colores por Producto
create table tb_Color_Producto(
	id_producto_venta char(5) not null foreign key references tb_Detalle_Producto (id_producto_venta),
	id_color char(3) not null foreign key references tb_Color (id_color))
go

--Agregando PK a dos columnas
alter table tb_Color_Producto
add primary key (id_producto_venta, id_color)
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
	telefono varchar(13) not null,
	id_pais char(5) not null foreign key references tb_Pais (id_pais))
go

--Creando la Tabla Producto por Proveedor
create table tb_Producto_Proveedor(
	id_proveedor char(5) not null foreign key references tb_Proveedor (id_proveedor),
	id_producto char(5) not null foreign key references tb_Producto (id_producto))
go

--Agregando PK a dos Columnas
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
	id_color char(3) not null foreign key references tb_Color (id_color),
	cantidad varchar(3) not null,
	precio numeric(7,2) not null)
go

--Agregando PK a tres Columnas
alter table tb_Detalle_Pedido
add primary key (id_pedido, id_producto_venta, id_color)
go


--Insertar datos
--Tabla Departamentos
--Forma3

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
('P0001','Lima'),
('P0002','chiclayo'),
('P0003','Ica'),
('P0004','Cerro de Pasco'),
('P0005','Huamanga')
go

--Listar los registros de la tabla de Provincia
select * from tb_Provincia
go


--Insertar datos
--Tabla Distrito
--Forma3

insert into tb_Distrito values
('DI001','Independencia'),
('DI002','Eten'),
('DI003','Pachacútec'),
('DI004','Paucartambo'),
('DI005','Jesus Nazareno')
go

--Listar los registros de la tabla de Distrito
select * from tb_Distrito
go

--Insertar datos
--Tabla Clientes
--Forma3

insert into tb_Cliente values
('C0001','Joseph','Fuentes Velasquez','902020209','Joseph@hotmail.com','D0001','P0001','DI001','Mz-H1lt25 Av.Sirenas'),
('C0002','Gerson','Berrocal Najarro','905030269','Gerson@hotmail.com','D0002','P0002','DI002','Mz-H1lt2 Asoc.portales'),
('C0003','Dante','Sembrera Cruz','906040279','Dante@hotmail.com','D0003','P0003','DI003','Mz-Hlt25 Urb.Asentamiento Humano'),
('C0004','Elmer','Cubas Silva','908050289','ElmerCs@hotmail.com','D0004','P0004','DI004','Mz-Hlt25 Jardinez')
go

--Listar los registros de la tabla de Cliente
select * from tb_Cliente
go
