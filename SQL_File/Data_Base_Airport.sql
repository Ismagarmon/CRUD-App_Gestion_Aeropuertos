DROP DATABASE IF EXISTS aeropuerto;
CREATE DATABASE IF NOT EXISTS aeropuerto CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

DROP USER 'admin.ribera'@'localhost'; --
CREATE USER 'admin.ribera'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON aeropuerto. * TO 'admin.ribera'@'localhost';
FLUSH PRIVILEGES;

DROP USER 'ismael.garmon'@'localhost'; --
CREATE USER 'ismael.garmon'@'localhost' IDENTIFIED BY 'password1234';
GRANT ALL PRIVILEGES ON aeropuerto. * TO 'ismael.garmon'@'localhost';
FLUSH PRIVILEGES;

USE aeropuerto;

--------------------------------------------------------
----------------------- Tabla Piloto -------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS piloto (
    ID_Piloto INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(20) NOT NULL,
    Apellidos varchar(30) NOT NULL,
    Edad TINYINT NOT NULL,
    Sexo char NOT NULL,
    Foto LONGBLOB NULL,
    PRIMARY KEY (ID_Piloto)
) ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

--------------------------------------------------------
----------------------- Tabla Copiloto------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS copiloto (
    ID_Copiloto INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(20) NOT NULL,
    Apellidos varchar(30) NOT NULL,
    Edad TINYINT NOT NULL,
    Sexo char NOT NULL,
    PRIMARY KEY (ID_Copiloto)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

--------------------------------------------------------
----------------------- Tabla Azafata ------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS azafata (
    ID_Azafata INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(20) NOT NULL,
    Apellidos varchar(30) NOT NULL,
    Edad TINYINT NOT NULL,
    Sexo char NOT NULL,
    Foto LONGBLOB NULL,
    PRIMARY KEY (ID_Azafata)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

--------------------------------------------------------
-------------- Tabla proveedorcombustible---------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS proveedorcombustible (
    ID_Proveedor INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(20) NOT NULL,
    Direccion varchar(50) NOT NULL,
    Pais varchar(20) NOT NULL,
    Tipo_Combustible varchar(35) NOT NULL,
    PRIMARY KEY (ID_Proveedor)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

--------------------------------------------------------
------------------ Tabla aeropuerto --------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS aeropuerto (
    ID_Aeropuerto INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(40) NOT NULL,
    Direccion varchar(60) NOT NULL,
    Ciudad varchar(20) NOT NULL,
    Pais varchar(30) NOT NULL,
    C_Terminales TINYINT NOT NULL,
    Servicios_VIP boolean,
    Parking boolean,
    PRIMARY KEY (ID_Aeropuerto)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

--------------------------------------------------------
-------------- Tabla companiapromotora -----------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS companiapromotora (
    ID_Compania INT AUTO_INCREMENT NOT NULL,
    Tipo_Sociedad varchar(10) NOT NULL,
    Nombre varchar(20) NOT NULL,
    Contacto varchar(30) NOT NULL,
    Email varchar(30) NOT NULL,
    CIF varchar(20) NOT NULL,
    Pais varchar(15) NOT NULL,
    Provincia varchar(15) NOT NULL,
    PRIMARY KEY (ID_Compania)
) ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

--------------------------------------------------------
------------- Tabla aeropuerto_compania-----------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS aeropuerto_compania (
    ID_Aeropuerto INT NOT NULL,
    ID_Compania INT NOT NULL,
    AreaResponsable varchar(25) NOT NULL,
    CONSTRAINT PK_aeropuerto_compania PRIMARY KEY (ID_Aeropuerto, ID_Compania)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE aeropuerto_compania ADD CONSTRAINT fk_aer FOREIGN KEY (ID_Aeropuerto) REFERENCES aeropuerto.aeropuerto (ID_Aeropuerto) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE aeropuerto_compania ADD CONSTRAINT fk_com FOREIGN KEY (ID_Compania) REFERENCES aeropuerto.companiapromotora (ID_Compania) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
---------------- Tabla Trabajadores --------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS Trabajadores (
    ID_Trabajador INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(15) NOT NULL,
    Apellidos varchar(20) NOT NULL,
    Edad TINYINT NOT NULL,
    Sexo char NOT NULL,
    Direccion varchar(50) NOT NULL,
    Salario INT NOT NULL,
    ID_Compania INT NOT NULL,
    Foto LONGBLOB NULL,
    PRIMARY KEY (ID_Trabajador)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE trabajadores ADD CONSTRAINT fk_trabajador_compaia FOREIGN KEY (ID_Compania) REFERENCES aeropuerto.companiapromotora (ID_Compania) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
----------------- Tabla terminal -----------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS terminal (
    ID_Terminal INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(45) NOT NULL,
    Superficie INT,
    Z_Publica boolean NOT NULL,
    Z_Privada boolean NOT NULL,
    Z_Pasajeros boolean NOT NULL,
    ID_Aeropuerto INT NOT NULL,
    PRIMARY KEY (ID_Terminal)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE terminal ADD CONSTRAINT fk_terminal_aeropuerto FOREIGN KEY (ID_Aeropuerto) REFERENCES aeropuerto.aeropuerto (ID_Aeropuerto) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
------------------- Tabla avion ------------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS avion (
    ID_Avion INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(30) NOT NULL,
    Aerolinea varchar(25) NOT NULL,
    Modelo varchar(15) NOT NULL,
    C_Pasajeros INT NOT NULL,
    Tipo_Avion varchar(15) NOT NULL,
    T_Combustible varchar(35) NOT NULL,
    ID_Proveedor INT NOT NULL,
    ID_Piloto INT NOT NULL,
    ID_Copiloto INT NOT NULL,
    ID_Terminal INT NOT NULL,
    PRIMARY KEY (ID_Avion)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE avion ADD CONSTRAINT fk_avion_proveedor FOREIGN KEY (ID_Proveedor) REFERENCES aeropuerto.proveedorcombustible (ID_Proveedor) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE avion ADD CONSTRAINT fk_avion_piloto FOREIGN KEY (ID_Piloto) REFERENCES aeropuerto.piloto (ID_Piloto) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE avion ADD CONSTRAINT fk_avion_copiloto FOREIGN KEY (ID_Copiloto) REFERENCES aeropuerto.copiloto (ID_Copiloto) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE avion ADD CONSTRAINT fk_avion_terminal FOREIGN KEY (ID_Terminal) REFERENCES aeropuerto.terminal (ID_Terminal) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
------------------- Tabla vuelos -----------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS vuelos (
    Num_Vuelo varchar(10) NOT NULL,
    Origen varchar(20) NOT NULL,
    Destino varchar(20) NOT NULL,
    Hora_Salida time NOT NULL,
    Hora_Llegada time NOT NULL,
    Fecha date NOT NULL,
    In_Progress boolean NOT NULL,
    Zona_H_Destino varchar(10) NOT NULL,
    ID_Avion INT NOT NULL,
    PRIMARY KEY (Num_Vuelo)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE vuelos ADD CONSTRAINT fk_flight FOREIGN KEY (ID_Avion) REFERENCES aeropuerto.avion (ID_Avion) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
------------------- Tabla Pasajero ---------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS Pasajero (
    ID_Pasajero INT AUTO_INCREMENT NOT NULL,
    Nombre varchar(15) NOT NULL,
    Apellidos varchar(35) NOT NULL,
    Edad TINYINT NOT NULL,
    Sexo char NOT NULL,
    Direccion varchar(50) NOT NULL,
    Pais varchar(35) NOT NULL,
    Servicio_Privado boolean NOT NULL,
    OnBoard boolean NOT NULL,
    Num_Vuelo varchar(10) NOT NULL,
    Foto LONGBLOB NULL,
    PRIMARY KEY (ID_Pasajero)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE Pasajero ADD CONSTRAINT fk_pasajero_vuelo FOREIGN KEY (Num_Vuelo) REFERENCES aeropuerto.vuelos (Num_Vuelo) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
-------------------- Tabla maleta ----------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS maleta (
    ID_Maleta INT AUTO_INCREMENT NOT NULL,
    Peso decimal NOT NULL,
    ID_Pasajero INT NOT NULL,
    PRIMARY KEY (ID_Maleta)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE maleta ADD CONSTRAINT fk_maleta_cliente FOREIGN KEY (ID_Pasajero) REFERENCES aeropuerto.Pasajero (ID_Pasajero) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
----------------- Tabla avion_azafata ------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS avion_azafata (
    ID_Avion INT NOT NULL,
    ID_Azafata INT NOT NULL,
    Fecha date NOT NULL,
    CONSTRAINT PK_avion_azafata PRIMARY KEY (ID_Avion, ID_Azafata)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci;

ALTER TABLE avion_azafata ADD CONSTRAINT fk_azz FOREIGN KEY (ID_Azafata) REFERENCES aeropuerto.azafata (ID_Azafata) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE avion_azafata ADD CONSTRAINT fk_az FOREIGN KEY (ID_Avion) REFERENCES aeropuerto.avion (ID_Avion) ON DELETE CASCADE ON UPDATE CASCADE;

--------------------------------------------------------
------------------- Tabla usuarios ---------------------
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS usuarios (
    ID_Usuario TINYINT AUTO_INCREMENT NOT NULL,
    Usuario varchar(20) NOT NULL,
    PW varchar(64) NOT NULL,
    PRIMARY KEY (ID_Usuario)
)ENGINE = INNODB CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci; 

INSERT INTO usuarios (Usuario,PW) VALUES ("ismael.garmon","b9c950640e1b3740e98acb93e669c65766f6670dd1609ba91ff41052ba48c6f3");
INSERT INTO usuarios (Usuario,PW) VALUES ("admin.ribera","3ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4");

INSERT INTO piloto (Nombre, Apellidos, Edad, Sexo)
VALUES
('Juan', 'Pérez', 35, 'M'),
('María', 'Gómez', 28, 'F'),
('Pedro', 'Fernández', 42, 'M'),
('Ana', 'López', 31, 'F'),
('Javier', 'Ruiz', 45, 'M'),
('Lucía', 'Torres', 27, 'F'),
('Sergio', 'Sánchez', 39, 'M'),
('Cristina', 'Hernández', 29, 'F'),
('Antonio', 'García', 37, 'M'),
('Isabel', 'Díaz', 30, 'F'),
('Francisco', 'Torres', 38, 'M'),
('Sara', 'Jiménez', 25, 'F');

INSERT INTO copiloto (Nombre, Apellidos, Edad, Sexo)
VALUES
('José', 'Martínez', 29, 'M'),
('Lucas', 'González', 32, 'M'),
('Elena', 'Jiménez', 27, 'F'),
('Adrián', 'Romero', 35, 'M'),
('Alicia', 'Pérez', 28, 'F'),
('Carlos', 'Gómez', 30, 'M'),
('Marta', 'Fernández', 33, 'F'),
('Óscar', 'López', 31, 'M'),
('Sara', 'Ruiz', 26, 'F'),
('Francisco', 'Torres', 38, 'M'),
('Sara', 'Romero', 26, 'F'),
('Óscar', 'Hernandez', 30, 'M');

INSERT INTO azafata (Nombre, Apellidos, Edad, Sexo)
VALUES
('Laura', 'Sánchez', 26, 'F'),
('Alberto', 'Hernández', 29, 'M'),
('Raquel', 'García', 25, 'F'),
('Jorge', 'Díaz', 28, 'M'),
('Lorena', 'Martínez', 27, 'F'),
('Juan Carlos', 'González', 30, 'M'),
('Paula', 'Jiménez', 28, 'F'),
('Diego', 'Romero', 33, 'M'),
('Marina', 'Pérez', 29, 'F'),
('Fernando', 'Gómez', 35, 'M');

INSERT INTO proveedorcombustible (Nombre, Direccion, Pais,Tipo_Combustible)
VALUES 
('Gasolinera La Ruta', 'Calle del Pino 123', 'España','Jet fuel (jet A-1, queroseno)'),
('PetroMax', 'Avenida del Mar 456', 'México','Mezcla queroseno-gasolina'),
('Fuel Depot', 'Main Street 789', 'Estados Unidos','Bioqueroseno'),
('Gasoil SA', 'Carrera 7 # 45-77', 'Colombia','Mezcla queroseno-gasolina'),
('Diesel Emporium', 'Rua da Praia 321', 'Brasil','Mezcla queroseno-gasolina'),
('JetFuel Inc', 'Pier 39', 'Canadá','Jet fuel (jet A-1, queroseno)'),
('Petrolandia', 'Calle Mayor 1', 'España','Jet fuel (jet A-1, queroseno)'),
('Oil Central', 'Rue de la Gare 12', 'Francia','Bioqueroseno'),
('Energy Express', 'Oxford Street 22', 'Reino Unido','Bioqueroseno'),
('DieselFuel', 'Bahnhofstrasse 55', 'Alemania','Jet fuel (jet A-1, queroseno)');

INSERT INTO aeropuerto (Nombre, Direccion, Ciudad, Pais, C_Terminales, Servicios_VIP, Parking)
VALUES
('Aeropuerto Internacional de Tokio', '2 Chome-6-1 Haneda, Ota City, Tokyo 144-0041, Japón', 'Tokio', 'Japón', 4, true, true),
('Aeropuerto Internacional de Los Ángeles', '1 World Way, Los Angeles, CA 90045, EE. UU.', 'Los Ángeles', 'Estados Unidos', 8, true, true),
('Aeropuerto Internacional de Dubái', 'Dubai - United Arab Emirates', 'Dubái', 'Emiratos Árabes Unidos', 3, true, true),
('Aeropuerto de Heathrow', 'Longford, Hounslow TW6, Reino Unido', 'Londres', 'Reino Unido', 4, false, true),
('Aeropuerto Internacional de Pudong', 'S1 Yingbin Expy, Pudong Xinqu, Shanghai Shi, China', 'Shanghai', 'China', 2, true, false),
('Aeropuerto Internacional de México', 'Venustiano Carranza, 15620 Ciudad de México, CDMX, México', 'Ciudad de México', 'México', 2, false, true),
('Aeropuerto de Barajas', '28042 Madrid, España', 'Madrid', 'España', 4, true, true),
('Aeropuerto Internacional de Guarulhos', 'Rodovia Hélio Smidt s/n - Cumbica, 07190-100, Brasil', 'São Paulo', 'Brasil', 3, true, true),
('Aeropuerto Internacional de Tocumen', 'Vía Tocumen, Panamá', 'Panamá', 'Panamá', 1, true, true),
('Aeropuerto Internacional de Auckland', 'Auckland Airport, Auckland 2022, Nueva Zelanda', 'Auckland', 'Nueva Zelanda', 2, false, true);

INSERT INTO companiapromotora (Tipo_Sociedad, Nombre, Contacto, Email, CIF, Pais, Provincia)
VALUES
('S.A.','Zentix','Juan Pérez', 'juan.perez@example.com', 'A12345678', 'España', 'Madrid'),
('S.L.','Jollix', 'María García', 'maria.garcia@example.com', 'B98765432', 'España', 'Barcelona'),
('S.A.','Alumax', 'Pedro Rodríguez', 'pedro.rodriguez@example.com', 'C54321678', 'España', 'Valencia'),
('S.A.','Nexgen', 'Ana López', 'ana.lopez@example.com', 'D45678123', 'España', 'Sevilla'),
('S.L.','Vintex','Luis Torres', 'luis.torres@example.com', 'E87654321', 'España', 'Alicante'),
('S.A.','Coreco', 'Sara Gómez', 'sara.gomez@example.com', 'F34567812', 'España', 'Murcia'),
('S.A.','Logive', 'Javier Fernández', 'javier.fernandez@example.com', 'G12345678', 'España', 'Zaragoza'),
('S.L.','Cybert', 'Carmen Martínez', 'carmen.martinez@example.com', 'H87654321', 'España', 'Málaga'),
('S.A.','Zephyr', 'Jorge Ruiz', 'jorge.ruiz@example.com', 'I65432187', 'España', 'Bilbao'),
('S.L.','Veloce', 'Lucía Sánchez', 'lucia.sanchez@example.com', 'J43218765', 'España', 'Santander');

INSERT INTO aeropuerto_compania (ID_Aeropuerto, ID_Compania, AreaResponsable) VALUES
(10, 1, 'Ventas'),
(9, 2, 'Recursos Humanos'),
(8, 3, 'Marketing'),
(7, 4, 'Contabilidad'),
(6,2,'Mantenimiento'),
(6, 5, 'Ventas'),
(5, 6, 'Recursos Humanos'),
(4, 7, 'Marketing'),
(3, 8, 'Contabilidad'),
(2,4,'Seguridad'),
(8,2,'Seguridad'),
(2, 9, 'Ventas'),
(1, 10, 'Recursos Humanos');

INSERT INTO Trabajadores (Nombre, Apellidos, Edad, Sexo, Direccion, Salario, ID_Compania) 
VALUES 
('Juan', 'García Pérez', 28, 'M','Calle Mayor 123', 2000, 8),
('Juan', 'Pérez', 32, 'M','Calle 123', 2500, 1),
('María', 'García', 28, 'F','Avenida 456', 3000, 2),
('Pedro', 'López', 40, 'M','Calle 789', 4000, 3),
('Ana', 'Martínez', 35, 'F','Calle 456', 2800, 2),
('Jorge', 'Hernández', 45, 'M','Avenida 789', 4500, 1),
('Luis', 'González', 50, 'M','Calle 1011', 5000, 10),
('Marta', 'Sánchez', 30, 'F','Avenida 1213', 3500, 9),
('Carlos', 'Ramírez', 38, 'M','Calle 1415', 4200, 8),
('Lucía', 'Flores', 25, 'F','Calle 1617', 2200, 7),
('Fernando', 'Castillo', 42, 'M','Avenida 1819', 3800, 6),
('Sofía', 'Díaz', 29, 'F','Calle 2021', 2900, 5),
('Pablo', 'Ruíz', 36, 'M','Avenida 2223', 3900, 4),
('Laura', 'Lara', 33, 'F','Calle 2425', 3200, 2),
('Diego', 'Alvarez', 31, 'M','Avenida 2627', 2700, 1),
('Isabel', 'Torres', 27, 'F','Calle 2829', 2600, 3),
('Pedro', 'Sánchez López', 35, 'M','Avenida de la Constitución 56', 2500, 1),
('Sara', 'Martínez Fernández', 24, 'F','Calle de la Libertad 8', 1800, 9),
('Lucía', 'González Ruiz', 29, 'F','Calle del Sol 22', 2200, 2),
('Pablo', 'Rodríguez García', 32, 'M','Calle Mayor 87', 2300, 3),
('María', 'López González', 27, 'F','Avenida del Parque 12', 1900, 7),
('Carlos', 'Pérez Jiménez', 26, 'M','Calle del Pilar 16', 1700, 4),
('Ana', 'Fernández Sánchez', 31, 'F','Calle de la Rosa 3', 2100, 6),
('Javier', 'Ruiz Martínez', 33, 'M','Calle del Bosque 7', 2400, 10),
('Laura', 'García Rodríguez', 28, 'F','Avenida de la Paz 20', 1950, 5),
("Juan", "Lopez González", 25, 'M',"Calle Mayor 12", 3000, 1),
("Maria", "Gomez Fernández", 33, 'F',"Calle del Sol 5", 4500, 2),
("Pedro", "Garcia González", 45, 'M',"Calle de la Luna 8", 5500, 3),
("Ana", "Perez González", 28, 'F',"Avenida de la Playa 20", 2500, 4),
("Luis", "Fernandez Fernández", 37, 'M',"Calle del Mar 15", 4200, 5),
("Sara", "Martin González", 29, 'F',"Calle de la Montaña 4", 3200, 6),
("Javier", "Hernandez López", 50, 'M',"Avenida de la Libertad 10", 6500, 7),
("Laura", "Ruiz López", 27, 'F',"Calle del Rio 6", 2800, 8),
("Carlos", "Gutierrez Rodríguez", 42, 'M',"Calle del Puente 13", 5000, 9),
("Elena", "Sanchez García", 31, 'F',"Calle del Bosque 2", 3500, 10),
("Mario", "Diaz Fernández", 39, 'M',"Avenida del Prado 18", 4800, 1),
("Isabel", "Alonso Rodríguez", 26, 'F',"Calle del Olivo 3", 2600, 2),
("Roberto", "Ortega García", 44, 'M',"Calle del Cerro 7", 5700, 3),
("Natalia", "Mendez Rodríguez", 30, 'F',"Avenida del Sol 12", 3400, 4),
("Antonio", "Jimenez López", 36, 'M',"Calle de la Sierra 9", 4100, 5);

INSERT INTO terminal (Nombre, Superficie, Z_Publica, Z_Privada, Z_Pasajeros, ID_Aeropuerto)
VALUES 
('Terminal Nacional de Salidas', 5000, 1, 1, 1, 1),
('Terminal Ejecutiva del Norte', 3000, 1, 0, 1, 2),
('Terminal Regional del Sur', 4000, 0, 1, 1, 3),
('Terminal Internacional de Llegadas', 6000, 1, 1, 0, 1),
('Terminal Privada de Carga', 2000, 0, 1, 1, 2),
('Terminal Pública de Carga', 3500, 1, 0, 0, 3),
('Terminal Comercial de Pasajeros', 4500, 0, 0, 1, 1),
('Terminal VIP de Pasajeros', 2500, 1, 1, 0, 2),
('Terminal de Mantenimiento de Aeronaves', 5500, 0, 1, 0, 3),
('Terminal de Almacenamiento y Distribución', 4000, 1, 0, 1, 1);

INSERT INTO avion (Nombre, Aerolinea, Modelo, C_Pasajeros, Tipo_Avion, T_Combustible, ID_Proveedor, ID_Piloto, ID_Copiloto, ID_Terminal) VALUES
('Boeing 737', 'American Airlines', '737-800', 160, 'Comercial', 'Mezcla queroseno-gasolina', 2, 1, 2, 1),
('Airbus A380', 'Emirates', 'A380-800', 853, 'Comercial', 'Bioqueroseno', 3, 2, 3, 2),
('Boeing 787 Dreamliner', 'United Airlines', '787-9', 290, 'Comercial', 'Mezcla queroseno-gasolina', 4, 3, 4, 3),
('Cessna 172 Skyhawk', 'Private owner', '172', 753, 'Privado', 'Mezcla queroseno-gasolina', 5, 4, 5, 4),
('Bombardier Challenger 350', 'NetJets', 'Challenger 350', 264, 'Privado', 'Jet fuel (jet A-1, queroseno)', 1, 5, 6, 5),
('Airbus A319 Corporate Jet', 'Royal Jet', 'A319', 148, 'Corporativo', 'Jet fuel (jet A-1, queroseno)', 7, 6, 7, 6),
('Embraer E175', 'SkyWest Airlines', 'E175', 276, 'Comercial', 'Jet fuel (jet A-1, queroseno)', 6, 7, 8, 7),
('Airbus A340', 'Lufthansa', 'A340-300', 380, 'Comercial', 'Bioqueroseno', 8, 8, 9, 8),
('Boeing 777', 'Cathay Pacific', '777-300ER', 368, 'Comercial', 'Jet fuel (jet A-1, queroseno)', 10, 9, 10, 9),
('Boeing 757', 'Delta Air Lines', '757-200', 199, 'Comercial', 'Bioqueroseno', 9, 10, 1, 10);

INSERT INTO avion_azafata (ID_Avion, ID_Azafata, Fecha) VALUES
(1, 1, '2023-06-22'),
(2, 3, '2023-07-05'),
(3, 2, '2023-06-22'),
(4, 4, '2023-07-01'),
(5, 1, '2023-06-25'),
(1, 2, '2023-06-15'),
(3, 4, '2023-06-25'),
(2, 1, '2023-06-18'),
(4, 3, '2023-06-27'),
(8, 10, '2023-06-18'),
(7, 6, '2023-02-24'),
(9, 6, '2023-03-13'),
(7, 7, '2023-04-28'),
(2, 10, '2023-05-12'),
(5, 9,'2023-07-03'),
(10, 5,'2023-07-11'),
(6, 8,'2023-06-30');

INSERT INTO vuelos (Num_Vuelo, Origen, Destino, Hora_Salida, Hora_Llegada, Fecha, In_Progress, Zona_H_Destino, ID_Avion) VALUES
('VY1234', 'Madrid', 'Barcelona', '08:00:00', '09:10:00', '2023-06-15', 0, 'UTC+2', 1),
('BA4567', 'Londres', 'Nueva York', '13:30:00', '17:45:00', '2023-07-01', 1, 'UTC-4', 2),
('FR5678', 'Dublín', 'Roma', '10:45:00', '14:20:00', '2023-06-22', 0, 'UTC+2', 3),
('LH2345', 'Frankfurt', 'Tokyo', '23:30:00', '17:15:00', '2023-07-11', 1, 'UTC+9', 4),
('EK7891', 'Dubai', 'Melbourne', '01:00:00', '14:30:00', '2023-06-30', 0, 'UTC+10', 5),
('UA2345', 'San Francisco', 'Londres', '07:15:00', '14:20:00', '2023-06-27', 0, 'UTC+1', 6),
('AA1234', 'Nueva York', 'Los Ángeles', '10:00:00', '13:30:00', '2023-07-05', 1, 'UTC-7', 7),
('AF4567', 'París', 'Shanghái', '22:45:00', '14:50:00', '2023-06-18', 0, 'UTC+8', 8),
('TP5678', 'Lisboa', 'Rio de Janeiro', '12:00:00', '18:30:00', '2023-07-03', 1, 'UTC-3', 9),
('TK2345', 'Estambul', 'Sídney', '02:30:00', '20:45:00', '2023-06-25', 0, 'UTC+10', 10);

INSERT INTO Pasajero (Nombre, Apellidos, Edad, Sexo, Direccion, Pais, Servicio_Privado, OnBoard, Num_Vuelo) VALUES
('Juan', 'Perez', 28, 'M', 'Calle del Sol 123', 'España', 0, 0, 'VY1234'),
('Laura', 'Garcia', 32, 'F', 'Av. de la Libertad 456', 'México', 0, 0, 'VY1234'),
('Pedro', 'Sanchez', 45, 'M', 'Rua do Comercio 789', 'Portugal', 1, 0, 'VY1234'),
('Maria', 'Lopez', 29, 'F', 'Avenida Brasil 1234', 'Brasil', 0, 0, 'VY1234'),
('Ricardo', 'Gonzalez', 22, 'M', 'Calle de la Cruz 456', 'España', 0, 0, 'VY1234'),
('Lucia', 'Hernandez', 31, 'F', 'Calle Mayor 789', 'España', 0, 0, 'VY1234'),
('Pablo', 'Martinez', 40, 'M', 'Rue de la Paix 12', 'Francia', 1, 1, 'BA4567'),
('Ana', 'Rodriguez', 27, 'F', 'Rue du Faubourg 456', 'Francia', 0, 1, 'BA4567'),
('Jose', 'Gomez', 36, 'M', 'Main Street 123', 'EEUU', 0, 1, 'BA4567'),
('Marta', 'Fernandez', 25, 'F', 'Broadway 456', 'EEUU', 1, 1, 'BA4567'),
('Luis', 'Jimenez', 29, 'M', 'Passeig de Gracia 123', 'España', 0, 1, 'BA4567'),
('Sofia', 'Alvarez', 33, 'F', 'Carrer dels Horts 456', 'España', 1, 0, 'FR5678'),
('Antonio', 'Ruiz', 47, 'M', 'Rua do Ouro 123', 'Portugal', 0, 0, 'FR5678'),
('Isabel', 'Diaz', 28, 'F', 'Rua das Flores 456', 'Portugal', 0, 0, 'FR5678'),
('Jorge', 'Vega', 38, 'M', 'Avenida de Mayo 123', 'Argentina', 1, 0, 'FR5678'),
('Julia', 'Fuentes', 26, 'F', 'Calle de Alcalá 456', 'España', 0, 0, 'FR5678'),
('Fernando', 'Morales', 41, 'M', 'Rue de Rivoli 123', 'Francia', 0, 0, 'FR5678'),
('Carla', 'Santos', 30, 'F', 'Avenue des Champs-Élysées 456', 'Francia', 1, 0, 'FR5678'),
('Alberto', 'Perez', 31, 'M', 'Rua dos Andradas 123', 'Brasil', 0, 0, 'EK7891'),
('Maria', 'Gomez', 28, 'F', 'Calle Mayor 45', 'España', 0, 1, 'LH2345'),
('Juan', 'Perez', 42, 'M', 'Avenida Libertad 7', 'Argentina', 0, 1, 'LH2345'),
('Carla', 'Sanchez', 35, 'F', 'Rua da Praia 32', 'Brasil', 0, 0, 'EK7891'),
('Pedro', 'Fernandez', 25, 'M', 'Rua do Carmo 12', 'Portugal', 1, 1, 'LH2345'),
('Luis', 'Rodriguez', 39, 'M', 'Calle de la Paz 10', 'España', 0, 1, 'LH2345'),
('Ana', 'Martinez', 31, 'F', 'Avenida Paulista 123', 'Brasil', 0, 0, 'EK7891'),
('Jorge', 'Gonzalez', 28, 'M', 'Calle Goya 8', 'España', 0, 1, 'LH2345'),
('Marta', 'Alonso', 27, 'F', 'Calle de Alcalá 20', 'España', 0, 1, 'AA1234'),
('Carlos', 'Garcia', 33, 'M', 'Avenida Libertad 23', 'Argentina', 1, 1, 'AA1234'),
('María', 'Martínez', 35, 'F', 'Calle de la Paloma 789', 'España', 0, 0, 'EK7891'),
('Mario', 'Ramos', 58, 'M', 'Calle de la Paloma 456', 'México', 1, 0, 'AF4567'),
('Laura', 'Torres', 27, 'F', 'Calle del Mar 789', 'Colombia', 0, 0, 'EK7891'),
('Juan', 'Perez', 25, 'M', 'Av. Libertador 123', 'Argentina', 1, 0, 'AF4567'),
('Laura', 'Fernandez', 45, 'F', 'Rua do Carmo 75', 'Portugal', 0, 1, 'AA1234'),
('Maria', 'Garcia', 30, 'F', 'Calle 1 de Mayo 456', 'México', 0, 0, 'EK7891'),
('Pedro', 'Lopez', 40, 'M', 'Rua Augusta 789', 'Brasil', 1, 0, 'AF4567'),
('Lucia', 'Fernandez', 22, 'F', 'Avenida de la Constitucion 567', 'España', 0, 0, 'EK7891'),
('Carlos', 'Sanchez', 50, 'M', 'Broadway 234', 'Estados Unidos', 1, 0, 'AF4567'),
('Ana', 'Martinez', 27, 'F', 'Rue de la Paix 890', 'Francia', 1, 0, 'EK7891'),
('Gabriel', 'Gonzalez', 35, 'M', 'Kurfürstendamm 123', 'Alemania', 1, 0, 'AF4567'),
('Fernanda', 'Castillo', 28, 'F', 'Av. Paulista 456', 'Brasil', 0, 0, 'EK7891'),
('David', 'Ruiz', 45, 'M', 'Calle Velazquez 789', 'España', 1, 0, 'AF4567'),
('Laura', 'Lopez', 31, 'F', 'Champs-Élysées 234', 'Francia', 0, 0, 'AF4567'),
('Mauricio', 'Rodriguez', 29, 'M', 'Kreuzbergstraße 567', 'Alemania', 1, 0, 'UA2345'),
('Sofia', 'Gutierrez', 24, 'F', 'Avenida Reforma 890', 'México', 0, 1, 'AA1234'),
('Martin', 'Hernandez', 38, 'M', 'Rua Oscar Freire 123', 'Brasil', 1, 0, 'AF4567'),
('Isabella', 'Diaz', 26, 'F', 'Carrer de Balmes 456', 'España', 1, 0, 'UA2345'),
('Pablo', 'Gomez', 33, 'M', 'Rue du Faubourg Saint-Honoré 789', 'Francia', 1, 0, 'UA2345'),
('Valeria', 'Torres', 23, 'F', 'Oranienstraße 234', 'Alemania', 0, 1, 'AA1234'),
('Diego', 'Jimenez', 37, 'M', 'Avenida Insurgentes 567', 'México', 1, 0, 'UA2345'),
('Camila', 'Mendoza', 32, 'F', 'Avenida Paulista 890', 'Brasil', 0, 1, 'AA1234'),
('Ricardo', 'Chavez', 36, 'M', 'Carrer de Pau Claris 123', 'España', 1, 0, 'UA2345'),
('Laura', 'García', 25, 'F', 'Calle Mayor 12', 'España', 0, 1, 'TP5678'),
('Antonio', 'Martínez', 35, 'M', 'Av. de la Constitución 20', 'España', 1, 0, 'TK2345'),
('María', 'López', 28, 'F', 'Calle Gran Vía 8', 'España', 1, 1, 'TP5678'),
('Juan', 'Gómez', 42, 'M', 'Calle Alcalá 100', 'Guinea Ecuatorial', 0, 1, 'TP5678'),
('Lucía', 'Sánchez', 19, 'F', 'Calle Serrano 50', 'España', 0, 0, 'TK2345'),
('David', 'González', 31, 'M', 'Calle Fuencarral 80', 'España', 1, 1, 'TP5678'),
('Ana', 'Romero', 23, 'F', 'Calle de la Paz 3', 'Seychelles', 0, 1, 'TP5678'),
('Pablo', 'Pérez', 29, 'M', 'Calle Preciados 25', 'España', 0, 0, 'TK2345'),
('Sara', 'Rodríguez', 26, 'F', 'Calle Atocha 40', 'Emiratos Árabes Unidos', 1, 0, 'TK2345'),
('Manuel', 'Fernández', 40, 'M', 'Calle Mayor 50', 'España', 1, 1, 'TP5678'),
('Isabel', 'Díaz', 22, 'F', 'Calle Gran Vía 15', 'Tayikistán', 0, 0, 'TK2345'),
('Javier', 'Alonso', 33, 'M', 'Calle Serrano 20', 'España', 1, 1, 'TP5678'),
('Marta', 'Gutiérrez', 27, 'F', 'Calle Princesa 10', 'España', 0, 1, 'TP5678'),
('Carlos', 'Ramos', 38, 'M', 'Calle Alcalá 150', 'España', 1, 0, 'TK2345'),
('Cristina', 'Jiménez', 24, 'F', 'Calle Fuencarral 60', 'España', 0, 0, 'TK2345'),
('Jorge', 'Santos', 37, 'M', 'Calle Gran Vía 25', 'Nicaragua', 1, 1, 'TP5678'),
('Laura', 'Suárez', 30, 'F', 'Calle Serrano 35', 'España', 0, 1, 'TP5678'),
('Pedro', 'Morales', 44, 'M', 'Calle Mayor 80', 'Kirguistán', 0, 0, 'TK2345'),
('Carmen', 'Ortega', 21, 'F', 'Calle Prado 5', 'España', 1, 0, 'TK2345');

INSERT INTO maleta (Peso, ID_Pasajero)
VALUES
(23.5, 1),
(30.2, 2),
(15.7, 3),
(18.1, 4),
(20.0, 5),
(27.8, 6),
(12.3, 7),
(16.5, 8),
(22.4, 9),
(19.9, 10),
(23.5, 11),
(15.2, 12),
(20.0, 13),
(18.7, 14),
(10.3, 15),
(25.6, 16),
(12.9, 17),
(9.1, 18),
(17.8, 19),
(14.4, 20),
(16.0, 21),
(22.3, 22),
(19.6, 23),
(21.1, 24),
(13.2, 25),
(23.5, 26),
(15.2, 27),
(18.7, 28),
(21.1, 29),
(12.3, 30),
(30.0, 31),
(16.8, 32),
(19.5, 33),
(25.3, 34),
(11.2, 35),
(17.9, 36),
(22.0, 37),
(14.6, 38),
(26.7, 39),
(20.4, 40),
(20.5, 41),
(15.2, 42),
(18.3, 43),
(23.7, 44),
(13.1, 45),
(17.2, 46),
(21.9, 47),
(9.5, 48),
(14.8, 49),
(16.6, 50),
(19.1, 51),
(10.3, 52),
(22.7, 53),
(11.9, 54),
(25.4, 55),
(20.5, 56),
(15.2, 57),
(18.3, 58),
(23.7, 59),
(13.1, 60),
(17.2, 61),
(21.9, 62),
(9.5, 63),
(14.8, 64),
(16.6, 65),
(19.1, 66),
(10.3, 67),
(22.7, 68),
(11.9, 69),
(25.4, 70);