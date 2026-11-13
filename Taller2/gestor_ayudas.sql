CREATE TABLE IF NOT EXISTS hogar(
    id INTEGER PRIMARY KEY,
    id_persona_contacto INTEGER,
    id_ubicacion INTEGER,
    numero_integrantes INTEGER NOT NULL,
    
    FOREIGN KEY (id_persona_contacto) REFERENCES persona_contacto(id),
    FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id)


) ENGINE = InnoDB;