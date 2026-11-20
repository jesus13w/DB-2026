

CREATE TABLE IF NOT EXISTS persona_contacto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(60) NOT NULL,
    segundo_nombre VARCHAR(60),
    primer_apellido VARCHAR(60) NOT NULL,
    segundo_apellido VARCHAR(60),
    genero VARCHAR(30) NOT NULL,
    tipo_documento VARCHAR(30) NOT NULL,
    numero_documento VARCHAR(30) NOT NULL UNIQUE,
    edad SMALLINT NOT NULL,
    numero_telefono VARCHAR(20) NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS ubicacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    barrio VARCHAR(100),
    corregimiento VARCHAR(100),
    vereda VARCHAR(100),
    comunidad VARCHAR(100),
    referencia_ubicacion VARCHAR(255)
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS necesidad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS condicion_prioridad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    embarazadas BOOLEAN NOT NULL,
    ninos BOOLEAN NOT NULL,
    discapacitados BOOLEAN NOT NULL,
    adultos_mayores BOOLEAN NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS donante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_donante VARCHAR(40) NOT NULL,
    nombre VARCHAR(120) NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS tipo_ayuda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL,
    nombre_articulo VARCHAR(120) NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT NOT NULL,
    disponible BOOLEAN NOT NULL
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS hogar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_persona_contacto INT,
    id_ubicacion INT,
    numero_integrantes SMALLINT NOT NULL,

    FOREIGN KEY (id_persona_contacto) REFERENCES persona_contacto(id),

    FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id)

) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS reporte (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_hogar INT,
    id_necesidad INT,
    id_condicion_prioridad INT,
    cantidad INT NOT NULL,
    observacion TEXT,
    fecha DATETIME NOT NULL,

    nivel_urgencia ENUM('BAJA', 'MEDIA', 'ALTA', 'CRITICA') NOT NULL,
    estado ENUM('PENDIENTE', 'ATENDIDO') NOT NULL,

    FOREIGN KEY (id_hogar) REFERENCES hogar(id),
    FOREIGN KEY (id_necesidad) REFERENCES necesidad(id),
    FOREIGN KEY (id_condicion_prioridad) REFERENCES condicion_prioridad(id)

) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS ayudas_disponibles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_inventario INT,
    cantidad INT NOT NULL,

    FOREIGN KEY (id_inventario) REFERENCES inventario(id)
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS donacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_donante INT,
    fecha DATE NOT NULL,

    FOREIGN KEY (id_donante)REFERENCES donante(id)

) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS detalle_donacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_donacion INT,
    id_tipo_ayuda INT,
    id_inventario INT,
    cantidad INT NOT NULL,
    unidad_medida VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_donacion) REFERENCES donacion(id),
    FOREIGN KEY (id_tipo_ayuda) REFERENCES tipo_ayuda(id),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id)

) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS punto_atencion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_seleccion_ayuda INT,
    ubicacion VARCHAR(255) NOT NULL,
    id_inventario INT,
    fecha DATE NOT NULL,

    FOREIGN KEY (id_inventario) REFERENCES inventario(id)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS seleccion_ayuda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_punto_atencion INT,
    id_inventario INT,
    cantidad INT NOT NULL,

    FOREIGN KEY (id_punto_atencion) REFERENCES punto_atencion(id),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id)
) ENGINE = InnoDB;



ALTER TABLE punto_atencion ADD CONSTRAINT fk_punto_seleccion FOREIGN KEY (id_seleccion_ayuda) REFERENCES seleccion_ayuda(id);



CREATE TABLE IF NOT EXISTS jornada_entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL,
    lugar VARCHAR(200) NOT NULL,
    descripcion TEXT,

    estado ENUM('PROGRAMADA', 'EN_CURSO', 'FINALIZADA', 'CANCELADA')
) ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_punto_atencion INT,
    id_jornada_entrega INT,

    FOREIGN KEY (id_punto_atencion) REFERENCES punto_atencion(id),
    FOREIGN KEY (id_jornada_entrega) REFERENCES jornada_entrega(id)

) ENGINE = InnoDB;
