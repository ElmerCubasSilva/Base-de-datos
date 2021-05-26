
DROP DATABASE bd_matricula_senati_IA201
GO

-- CREAR DATABASE
CREATE DATABASE bd_matricula_senati_IA201
GO

-- Poner en uso una base de datos
USE  bd_matricula_senati_IA201
GO

-- CREAR TABLA DEPARTAMENTO
CREATE TABLE tb_Departamento(
    codigo_dpto CHAR(5) NOT NULL PRIMARY KEY,
    departamento VARCHAR(20)
)
GO

-- CREAR TABLA DE COLEGIO
CREATE TABLE tb_Colegio(
    codigo_colegio CHAR(5) NOT NULL,
    colegio VARCHAR(50) NOT NULL
)
GO

-- agregar una llave primaria a la tabla colegio(PK)
ALTER TABLE tb_Colegio ADD PRIMARY KEY  (codigo_colegio)
GO

-- CREAR TABLA DE PROVINCIA
CREATE TABLE tb_Provincia(
    codigo_provincia CHAR(5) NOT NULL PRIMARY KEY,
    provincia VARCHAR(40) NOT NULL,
    provincia_codigo_dpto CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Departamento(codigo_dpto)
)
GO

-- CREAR LA TABLA DE DISTRITO
CREATE TABLE tb_Distrito(
    codigo_distrito CHAR(5)  NOT NULL,
    distrito VARCHAR(30) NOT NULL,
    distrito_codigo_provincia CHAR(5) NOT NULL
)
GO

-- Añadiendo PK para distrito
ALTER TABLE tb_Distrito ADD PRIMARY KEY (codigo_distrito)
GO
-- Añadir FK  para distrito
ALTER TABLE tb_Distrito ADD FOREIGN KEY (distrito_codigo_provincia) REFERENCES tb_Provincia(codigo_provincia)
GO

-- CREAR LA TABLA DE ALUMNO
CREATE TABLE tb_Alumno(
    codigo_alumno char (5) NOT NULL PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    ap_paterno VARCHAR(20) NOT NULL,
    ap_materno VARCHAR(20) NOT NULL,
    genero CHAR(1),
    tipo_documento SMALLINT,
    numero_documento CHAR(8),
    fecha_nacimiento DATE,
    direccion VARCHAR(50),
    alumno_codigo_distrito CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Distrito(codigo_distrito),
    telefono VARCHAR(13),
    correo_personal VARCHAR(50),
    correo_institucional VARCHAR(50),
    alumno_codigo_colegio CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Colegio(codigo_colegio),
)
GO

--CREAR LA TABLA DOC ALUMNO
CREATE TABLE tb_Doc_Alumno(
    da_codigo_alumno CHAR(5) not null,
    descripcion VARCHAR(100),
    fecha_Entrega DATE
)
GO

-- modificar la tabla doc_alumno
--Agregar una llave primaria
ALTER TABLE tb_Doc_Alumno ADD PRIMARY KEY (da_codigo_alumno)
GO
-- Agregar llave foranea
ALTER TABLE tb_Doc_Alumno ADD FOREIGN KEY (da_codigo_alumno) 
REFERENCES tb_Alumno(codigo_alumno)
GO

-- CREAR LA TABLA ESCUELA
CREATE TABLE tb_Escuela (
	codigo_escuela CHAR(5) NOT NULL PRIMARY KEY,
	escuela VARCHAR(25) NOT NULL
)
GO

-- CREAR LA TABLA CARRERA
CREATE TABLE tb_Carrera (
	codigo_carrera CHAR(5) NOT NULL PRIMARY KEY,
	carrera VARCHAR(25) NOT NULL,
	duracion SMALLINT,
	carrera_codigo_escuela CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Escuela (codigo_escuela)
)
GO

-- Agregando columnas a la tabla carrera
ALTER TABLE tb_Carrera ADD perfil VARCHAR(100)
GO

-- CREAR LA TABLA SEDE
CREATE TABLE tb_Sede (
	codigo_sede CHAR(5) NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	direccion varchar(60) NOT NULL,
	sede_codigo_provincia CHAR(5) FOREIGN KEY REFERENCES tb_Provincia (codigo_provincia)
)
GO
-- Agregando columnas a la tabla sede
ALTER TABLE tb_Sede ADD telefono VARCHAR(13), numero_ws VARCHAR(13)
GO

-- CREAR LA TABLA CARRERA_ALUMNO
CREATE TABLE tb_Carrera_Alumno (
	ca_codigo_alumno CHAR(5) NOT NULL,
	ca_codigo_carrera CHAR(5) NOT NULL,
    ca_codigo_sede CHAR(5) NOT NULL,
	fecha_inicio DATE,
	fecha_fin DATE,
	titulo VARCHAR(30)
)
GO

-- Modificar la tabla Carrera_Alumno
-- Agregar llave primaria (PK) Compuesta
ALTER TABLE tb_Carrera_Alumno
ADD PRIMARY KEY (ca_codigo_alumno, ca_codigo_carrera)
GO

-- Agregar llaves foráneas (FK)
ALTER TABLE tb_Carrera_Alumno
ADD FOREIGN KEY (ca_codigo_alumno) REFERENCES tb_Alumno (codigo_alumno)
GO

ALTER TABLE tb_Carrera_Alumno
ADD FOREIGN KEY (ca_codigo_carrera) REFERENCES tb_Carrera (codigo_carrera)
GO

ALTER TABLE tb_Carrera_Alumno
ADD FOREIGN KEY (ca_codigo_sede) REFERENCES tb_Sede (codigo_sede)
GO

-- CREAR LA TABLA CARRERA_SEDE
CREATE TABLE tb_Carrera_Sede(
    cs_codigo_sede CHAR(5) NOT NULL,
    cs_codigo_carrera CHAR(5) NOT NULL,
    ciclo CHAR(7),
    costo NUMERIC(7,2)
)
GO

-- Modificar la tabla carrera_Sede
-- Agregar una PK compuesta
ALTER TABLE tb_Carrera_Sede ADD PRIMARY KEY (cs_codigo_sede,cs_codigo_carrera)
GO

-- Agregar llaves foráneas (FK)
ALTER  TABLE tb_Carrera_Sede ADD FOREIGN KEY (cs_codigo_sede) REFERENCES tb_Sede(codigo_sede)
GO
ALTER  TABLE tb_Carrera_Sede ADD FOREIGN KEY (cs_codigo_carrera) REFERENCES tb_Carrera(codigo_carrera)
GO

-- CREAR UNA TABLA DE CURSO
CREATE TABLE tb_Curso(
    codigo_curso CHAR(5) NOT NULL PRIMARY KEY,
    curso VARCHAR(40) NOT NULL,
    curso_codigo_carrera CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Carrera(codigo_carrera)
)
GO

-- CREAR LA TABLA ESPECIALIDAD
CREATE TABLE tb_Especialidad(
    codigo_especialidad CHAR(5) NOT NULL PRIMARY KEY,
    especialidad VARCHAR(50) NOT NULL
)
GO

-- CREAR LA TABLA INSTRUCTOR

CREATE TABLE tb_Instructor(
    codigo_inst char (5) NOT NULL PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    ap_paterno VARCHAR(25) NOT NULL,
    ap_materno VARCHAR(25) NOT NULL,
    genero CHAR(1),
    DNI CHAR(8),
    fecha_nacimiento DATE,
    direccion VARCHAR(50),
    inst_codigo_distrito CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Distrito(codigo_distrito),
    telefono VARCHAR(13),
    correo_personal VARCHAR(50),
    correo_institucional VARCHAR(15),
    inst_codigo_especialidad CHAR(5) NOT NULL FOREIGN KEY REFERENCES tb_Especialidad(codigo_especialidad)
)
GO

-- CREAR TABLA DE NOTAS
-- Falta ejecutar
CREATE TABLE tb_Notas(
    notas_codigo_alumno CHAR(5) NOT NULL,
    notas_codigo_curso CHAR(5) NOT NULL,
    notas_codigo_inst CHAR(5) NOT NULL,
    fecha_registro DATE NOT NULL,
    practica CHAR(2),
    proyecto CHAR(2),
    final CHAR(2)
)
GO

-- Modificar la tabla tb_Notas
-- Agregar una PK compuesta
ALTER TABLE tb_Notas ADD PRIMARY KEY (notas_codigo_alumno,notas_codigo_curso,notas_codigo_inst,fecha_registro)
GO

-- Agregar llaves foráneas (FK)
ALTER  TABLE tb_Notas ADD FOREIGN KEY (notas_codigo_alumno) REFERENCES tb_Alumno(codigo_alumno)
GO
ALTER  TABLE tb_Notas ADD FOREIGN KEY (notas_codigo_curso) REFERENCES tb_Curso(codigo_curso)
GO
ALTER  TABLE tb_Notas ADD FOREIGN KEY (notas_codigo_inst) REFERENCES tb_Instructor(codigo_inst)
GO



-- Insertar datos
-- forma 1
INSERT INTO tb_Departamento (codigo_dpto,departamento) 
VALUES ('D0001','Lima')
GO

-- forma 2
INSERT INTO tb_Departamento VALUES ('D0002','Tumbes')
GO
INSERT INTO tb_Departamento VALUES ('D0003','Arequipa')
GO

-- forma 3
INSERT INTO tb_Departamento VALUES
    ('D0004','Madre de Dios'),
    ('D0005','Ucayali'),
    ('D0006','La Libertad')
GO

--Listar campos de la tabla departamento
SELECT * FROM tb_Departamento
GO

-- Registro tabla colegio (5)
INSERT INTO tb_Colegio VALUES
('CL001','Nuestra Señora de la Paz 2004'),
('CL002','Santa Úrsula 4203'),
('CL003','Alfonso Ugarte 2530'),
('CL004','Abelardo Gamarra 5030'),
('CL005','Santa Isabel 3206')
GO

-- Registro tabla provincia
INSERT INTO tb_Provincia VALUES
('PR001','Lima','D0001'),
('PR002','Cañete','D0001'),
('PR003','Barranco','D0001')
GO

INSERT INTO tb_Provincia VALUES
('PR004','Arequipa','D0003'),
('PR005','Camaná','D0003')
GO

INSERT INTO tb_Provincia VALUES
('PR006','Pacasmayo','D0006'),
('PR007','Bolivar','D0006'),
('PR008','Trujillo','D0006')
GO


-- Registro tabla distrito
INSERT INTO tb_Distrito VALUES
('D0001','Lima','PR001'),
('D0002','Los Olivos','PR001'),
('D0003','San Martin de Porres','PR001'),
('D0004','Comas','PR001'),
('D0005','Breña','PR001'),
('D0006','Puente Piedra','PR001'),
('D0007','La Victoria','PR001'),
('D0008','Lince','PR001'),
('D0009','Supe Puerto','PR003'),
('D0010','Pativilca','PR003'),
('D0011','Polobaya de Arequipa','PR004'),
('D0012','Cayma','PR004'),
('D0013','La Joya','PR004'),
('D0014','La ','PR008'),
('D0015','El Porvenir','PR008'),
('D0016','La Esperanza','PR008'),
('D0017','Huanchaco','PR008')
GO
SELECT * FROM tb_Distrito
GO

SELECT * FROM tb_Distrito
GO
-- Registro tabla alumno
INSERT INTO tb_Alumno VALUES
('A0001','Carla','FLores','Villa','F',1,'43251478','10-15-1999',
null,'D0002',null,'carla_flores@gmail.com','','CL002'),
('A0002','Roberto','Montes','Llanos','M',1,'71281478','01-23-2001',
null,'D0003',null,null,'','CL001'),
('A0003','Mariela','Gonzales','Julca','F',1,'16253947','04-02-2000',
null,'D0003',null,'mari_gonza16@gmail.com','','CL001'),
('A0004','Xander','Rojas','Huaman','M',1,'78346981','12-25-1998',
null,'D0007',null,'xander_1561@gmail.com','','CL004'),
('A0005','Jose','Basquez','Ramos','M',1,'71332314','07-29-2001',
null,'D0012',null,null,'','CL002'),
('A0006','Samira','Casas','Julca','F',1,'39428655','04-03-2000',
'Av. Colonial 326','D0017',null,'samira_ca16@gmail.com.com','','CL001'),
('A0007','Maria','Basquez','Ramos','F',1,'71332316','09-16-2003',
null,'D0003',null,null,'','CL001'),
('A0008','Mateo','Ramirez','Acosta','M',1,'12485531','01-01-1998',
null,'D0017',null,'Mateo_Ramirez@gmail.com.com','','CL005'),
('A0009','Abel','Furuya','Del Campo','M',1,'77753691','05-11-2001',
'Av. Los rosales 236','D0013',null,null,'','CL004'),
('A0010','Rosa','Sotelo','Morales','F',1,'24369877','04-02-1999',
'Av. Naranjal','D0003',null,'rosa_sotelo@outlook.com','','CL001')
GO

INSERT INTO tb_Alumno VALUES
('A0011','Erick','Delgado','Morales','M',2,'89771236','04-12-2000',
'Jr. Rimac 522','D0015','967842214','erick_de@outlook.com',null,'CL001')
GO

SELECT * FROM tb_Alumno
GO

-- Registro tabla tb_Escuela
INSERT INTO tb_Escuela VALUES
('E0001','Escuela de Tecnología de la Información'),
('E0002','Electrotécnia'),
('E0003','Industrias Alimentarias'),
('E0004','Artes Gráficas')
GO

-- Modificando la tabla tb_Escuela
-- Aumentando la cantidad de caracteres en la columna escuela
ALTER TABLE tb_Escuela ALTER COLUMN escuela VARCHAR (100)
GO

SELECT * FROM tb_Escuela
GO

-- Registro tabla sede
INSERT INTO tb_Sede VALUES
('S0001','Lima - Callao', 'Av. Alfredo Mendiola 3540','PR001','012089999','939963092'),
('S0002','Cañete', 'Av. Santa Rosa Mz. X Lt. 27 - Urb. Santa Rosa de Hualcara','PR002',null,'939963092')
GO

-- Modificando la tabla sede
-- Cambiar la cantidad de caracteres de direccion
ALTER TABLE tb_Sede ALTER COLUMN direccion VARCHAR(100)
GO

SELECT * FROM tb_Sede
GO

-- Registro tabla carrera
INSERT INTO tb_Carrera VALUES
('C0001','Ingenieria de Software con Inteligencia artificial',6,'E0001',null),
('C0002','Diseño Grafico',7,'E0004',null),
('C0003','Produccion Grafica',6,'E0004',null)
GO
-- Modificando la tabla tb_Carrera
-- Cambiar la cantidad de caracteres de carrera
ALTER TABLE tb_Carrera ALTER COLUMN carrera VARCHAR(100) NOT NULL
GO

SELECT * FROM tb_Carrera
GO


-- Falta agregar los datos q dejo como actividad (rellenar datos)



-- Ultima clase 


-- Ordenar campo
SELECT * FROM tb_Departamento ORDER BY departamento
GO
--Ordenar por varios campos
--// SELECT * tb_Alumno  ORDER BY genero DESC, ap_paterno ASC
-- GO

-- // Relacionar tablas inner join
-- SELECT columa,columna,columna fk 
-- FROM tabla_principal inner join tabla_Secundaria
-- ON (columan fk = columna pk secundaria)
-- GO

-- //JOIN con mas de 2 tablas
-- SELECT  column_main,column_main,colum_sec, column_terc 
-- FROM tabla_main INNER JOIN tabla_secundaria
-- ON (columna_main fk = columna_Sec pk) inner Join tabla_terciaria
-- ON (columna2_main fk=column_terc pk)
-- ORDER BY columa_x ASC, columna_y ASC
-- GO


-- codigo alumno, apellidos, nombre, nombre de carrera
