-- SQL --> Structured Query Lenguage (Lenguaje de Consultas Estructuradas)

-- Sentencias DLL
-- DDL --> Data Definition Language (Lenguaje de Definicion de Datos)
-- Sentencias de SQL para crear , Modificar , Borrar una Base de Datos(DB) o las tablas

-- Crear una base de Datos

create database bd_matricula_senati_IA201
go

-- Eliminar la BD
drop database bd_matricula_senati_IA201
go

-- Poner en uso la BD
use bd_matricula_senati_IA201
go

-- Crear la Tabla Departamento
create table tb_Departamento(
	codigo_dpto char(5) not null primary key,
	departamento varchar(20) not null)
go


-- Crear la Tabla de Colegio
create table tb_Colegio(
	codigo_colegio char(5) not null,
	colegio varchar(50) not null)
go

-- Modificar la Tabla
-- Agregar PK
alter table tb_Colegio add primary key(codigo_colegio)
go

-- Crear la tabla de Provincia
create table tb_provincia(
	codigo_provincia char(6) not null primary key,
	provincia varchar(50) not null,
	provincia_codigo_dpto char(6) not null foreign key references tb_Departamento (codigo_dpto))
go

-- Crear la Tabla Distrito
create table tb_Distrito(
	codigo_distrito char(6) not null primary key,
	distrito varchar(50) not null,
	distrito_codigo_provincia char(6) not null foreign key references tb_provincia ( codigo_provincia))
go

-- Modificar la Tabla Distrito
-- Agregar una llave primaria (PK)
alter table tb_Distrito add primary key (codigo_distrito)
go

-- Agregar una llave foranea (PK)
alter table tb_Distrito add foreign key (distrito_codigo_provincia)
references tb_Provincia (codigo_provincia)
go

-- Crear la tabla de Alumno
create table tb_Alumno(
	codigo_alumno char(5) not null primary key,
	nombre varchar(25) not null,
	ap_paterno varchar(25) not null,
	ap_materno varchar(25) not null,
	genero char(1),
	tipo_documento smallint,	
	numero_documento char(8),
	fecha_nacimiento date,
	direccion varchar(50),
	alumno_codigo_distrito char(5) not null foreign key references tb_Distrito (codigo_distrito),
	telefono varchar(13),
	correo_personal varchar(50),
	correo_institucional varchar(15),
	codigo_colegio char(5) not null foreign key references tb_Colegio (codigo_colegio))
go

-- Crear codigo de escuela
create table c_escuela(
	codigo_escuela char(5) not null primary key,
	escuela varchar(50) not null)
go

-- Crear tb de Carrera
create table tb_carrera(
	cod_carrera char(5) not null primary key,
	nombre varchar(50) not null,
	duracion char(2) not null,
	carrera_codigo_escuela char(5) not null foreign key references c_escuela(codigo_escuela),
	perfil varchar(50) not null)
go

drop table tb_carrera
go

-- crear tb de sede
create table tb_sede(
	codigo_sede char(5) not null primary key,
	nombre varchar(25) not null,
	direccion varchar(50) not null,
	sede_codigo_provincia char(5) not null foreign key references tb_provincia(codigo_provincia))	
go

--crear la tabla carreras alumno
create table tb_Carrera_Alumno(
	ca_codigo_alumno char(5) not null,
	ca_codigo_carrera char(5) not null,
	ca_codigo_sede char(5) not null,
	fecha_inicio date,
	fecha_fin date,
	titulo smallint)
go

--Modificar la tabla Carrera Alumno
--Agregar una llave primaria (PK) compuesta
alter table tb_Carrera_Alumno
add primary key (ca_codigo_alumno, ca_codigo_carrera)
go

--Agregar una llave foranea (FK)
alter table tb_Carrera_Alumno add foreign key (ca_codigo_alumno)
references tb_Alumno (codigo_alumno)
go

alter table tb_Carrera_Alumno add foreign key (ca_codigo_alumno)
references tb_carrera (cod_carrera)
go

alter table tb_Carrera_Alumno add foreign key (ca_codigo_alumno)
references tb_Sede (codigo_sede)
go

-- Crear la tabla carrera sede
create table tb_Carrera_Sede(
	cs_codigo_sede char(5) not null,
	cs_codigo_carrera char(5) not null,
	ciclo char(7),
	costo numeric(7,2))
go

--Modificar la tabla Carrera Sede
--Agregar una llave primaria (PK) compuesta
alter table tb_Carrera_Sede
add primary key (cs_codigo_sede, cs_codigo_carrera)
go

--Agregar llaves foraneas(FK)
alter table tb_Carrera_Sede add foreign key (cs_codigo_sede)
references tb_sede (codigo_sede)
go

alter table tb_Carrera_Sede add foreign key (cs_codigo_carrera)
references tb_Carrera (cod_carrera)
go

alter table tb_Carrera_Sede add foreign key (cs_codigo_carrera)
references tb_Carrera (cod_carrera)
go

--Crear la tabla de Curso
create table tb_Curso(
	codigo_curso char(5) not null primary key,
	curso varchar(40) not null,
	curso_codigo_carrera char(5) not null foreign key references tb_Carrera (cod_carrera))
go

--Crear la tabla Especialidad 
create table tb_Especialidad(
	codigo_especialidad char(5) not null primary key,
	especialidad varchar(40) not null)
go

--Crear la tabla Instructor
create table tb_Instructor(
	codigo_inst char(5) not null primary key,
	nombre varchar(25) not null,
	ap_paterno varchar(25) not null,
	ap_materno varchar(25) not null,
	genero char(1),
	DNI char(8),
	fecha_nacimiento date,
	direccion varchar(50),
	inst_codigo_distrito char(5) not null foreign key references tb_Distrito (codigo_distrito),
	telefono varchar(13),
	correo_personal varchar(50),
	correo_institucional varchar(15),
	inst_codigo_especialidad char(5) not null foreign key references tb_Especialidad (codigo_especialidad))
go

--Sentencias DML
--DML -> Data Manipulation Languaje (Lenguaje de Manipulacion de Datos)
--Sentencia de SQL para agregar, Actualizar,
--Borrar y seleccionar registros de las tablas
--CRUD
--C ->Create......... Crear (Insert)
--R ->Read........... Leer (Read)
--U ->Update......... Actualizar (Update)
--D ->Delete......... Eliminar (Delete)

--Insertar datos
--Tabla Departamentos
--Forma1
insert into tb_Departamento (codigo_dpto, departamento)
values ('D0001','Lima')
go

insert into tb_Departamento (codigo_dpto, departamento)
values ('Tumbe','D0002')
go

--Forma2
insert into tb_Departamento values ('D0003','Arequipa')
go

--Forma3
insert into tb_Departamento values
('D0004','Lima'),
('D0005','Ucayali'),
('D0006','La Libertad')
go

--Listar los registros de la tabla de Departamento
select * from tb_Departamento
go

--Insertar datos
--Tabla de Colegio

--Forma3
insert into tb_Colegio values
('CL001','Señor de los Milagros 3082'),
('CL002','Peruano Suizo'),
('CL003','Saco Oliveros'),
('CL004','Jesus Obrero'),
('CL005','Esther Festini De Ramos Ocampo')
go

select * from tb_Colegio
go

--Insertar datos
--Tabla Provincia

--Forma 3
insert into tb_provincia values
('D0004','Lima','D0001'),
('D0005','Cañete','D0001'),
('D0006','Barranca','D0001')
go

insert into tb_provincia values
('PR004','Arequipa','D0003'),
('PR005','Camana','D0003')
go

insert into tb_provincia values
('PR006','Pacasmayo','D0006'),
('PR007','Bolivar','D0006'),
('PR008','Trujillo','D0006')
go

--Listar los registros de la tabla Provincia
select * from tb_provincia
go

--Insertar Datos
--Tabla Distrito

--Forma3
insert into tb_Distrito values
('B0001','Arequipa','PR004'),
('B0002','Camana','PR005'),
('B0003','Pacasmayo','PR006')
go

select * from tb_Distrito
go