CREATE
    TABLE Cliente
    (
        CUIT VARCHAR(15) NOT NULL,
        PRIMARY KEY (CUIT)
    ) ENGINE=InnoDB;

CREATE
    TABLE Pedido
    (
        numero_pedido BIGINT NOT NULL,
        CUIT_cliente VARCHAR(15) NOT NULL,
        PRIMARY KEY (numero_pedido),
        CONSTRAINT Cliente_pedido FOREIGN KEY (CUIT_cliente) REFERENCES Cliente (CUIT)
    ) ENGINE=InnoDB;

CREATE
    TABLE Tipo_Componente
    (
        nombre_tipo VARCHAR(40) NOT NULL,
        PRIMARY KEY (nombre_tipo)
    ) ENGINE=InnoDB;

CREATE
    TABLE Subtipo_Componente
    (
        nombre_subtipo VARCHAR(40) NOT NULL,
        descripcion VARCHAR(255),
        nombre_tipo VARCHAR(40) NOT NULL,
        PRIMARY KEY (nombre_subtipo),
        CONSTRAINT Tipo_Subtipo FOREIGN KEY (nombre_tipo) REFERENCES Tipo_Componente (nombre_tipo)
    ) ENGINE=InnoDB;

CREATE
    TABLE Proveedor
    (
        CUIT_Proveedor VARCHAR(15) NOT NULL,
        PRIMARY KEY (CUIT_Proveedor)
    ) ENGINE=InnoDB;

CREATE
    TABLE Provision
    (
        nombre_subtipo VARCHAR(40) NOT NULL,
        CUIT_proveedor VARCHAR(15) NOT NULL,
        precio_unitario FLOAT,
        PRIMARY KEY (nombre_subtipo, CUIT_proveedor),
        CONSTRAINT Provision_subtipo FOREIGN KEY (nombre_subtipo) REFERENCES subtipo_componente (nombre_subtipo),
        CONSTRAINT Provision_proveedor FOREIGN KEY (CUIT_proveedor) REFERENCES proveedor (CUIT_Proveedor)
    ) ENGINE=InnoDB;

CREATE
    TABLE Suministro
    (
        numero_suministro BIGINT NOT NULL,
        cuit_provedor VARCHAR(15) NOT NULL,
        PRIMARY KEY (numero_suministro),
        CONSTRAINT Suministro_Proveedor FOREIGN KEY (cuit_provedor) REFERENCES proveedor (CUIT_Proveedor)
    ) ENGINE=InnoDB;

CREATE
    TABLE Componente
    (
        numero_serie BIGINT NOT NULL,
        nombre_subtipo VARCHAR(40) NOT NULL,
        numero_suministro BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT Componente_subtipo FOREIGN KEY (nombre_subtipo) REFERENCES subtipo_componente (nombre_subtipo),
        CONSTRAINT Componente_suministro FOREIGN KEY (numero_suministro) REFERENCES suministro (numero_suministro)
    ) ENGINE=InnoDB;

CREATE
    TABLE Reserva
    (
        numero_serie BIGINT NOT NULL,
        numero_operario BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT Reserva_Componente FOREIGN KEY (numero_serie) REFERENCES componente (numero_serie)
    ) ENGINE=InnoDB;

CREATE
    TABLE Item_Pedido
    (
        codigo_PC BIGINT NOT NULL,
        numero_pedido BIGINT NOT NULL,
        CONSTRAINT Item_de_Pedido FOREIGN KEY (numero_pedido) REFERENCES pedido (numero_pedido),
        PRIMARY KEY (codigo_PC)
    ) ENGINE=InnoDB;

CREATE
    TABLE Composicion_PC
    (
        numero_serie BIGINT NOT NULL,
        codigo_pc BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT PC_Componente FOREIGN KEY (numero_serie) REFERENCES componente (
        numero_serie)
    ) ENGINE=InnoDB;

CREATE
    TABLE Zona_Componente
    (
        id_zona BIGINT NOT NULL,
        nombre_tipo VARCHAR(40) NOT NULL,
        PRIMARY KEY (id_zona),
        CONSTRAINT Zona_Tipo_Componente FOREIGN KEY (nombre_tipo) REFERENCES tipo_componente (nombre_tipo)
    ) ENGINE=InnoDB;
	
CREATE
    TABLE Zona_PC
    (
        id_zona BIGINT NOT NULL,
        nombre_configuracion VARCHAR(20),
        PRIMARY KEY (id_zona)
    ) ENGINE=InnoDB;

CREATE
    TABLE Hueco_PC
    (
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (id_zona, columna, altura),
        CONSTRAINT HuecoPC_Zona FOREIGN KEY (id_zona) REFERENCES zona_pc (id_zona)
    ) ENGINE=InnoDB;

CREATE
    TABLE Hueco_Componente
    (
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (id_zona, columna, altura),
        CONSTRAINT HuecoComponente_Zona FOREIGN KEY (id_zona) REFERENCES zona_componente (id_zona)
    ) ENGINE=InnoDB;

CREATE
    TABLE Ubicacion_Componente
    (
        numero_serie BIGINT NOT NULL,
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT UbicacionComponente_Zona FOREIGN KEY (id_zona) REFERENCES zona_componente (id_zona),
        CONSTRAINT UbicacionComponente_Hueco FOREIGN KEY (id_zona, columna, altura) REFERENCES hueco_componente (id_zona, columna, altura),
        CONSTRAINT UbicacionComponente_Componente FOREIGN KEY (numero_serie) REFERENCES componente (numero_serie)
    ) ENGINE=InnoDB;

CREATE
    TABLE Ubicacion_PC
    (
        codigo_PC BIGINT NOT NULL,
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (codigo_PC),
        CONSTRAINT UbicacionPC_Zona FOREIGN KEY (id_zona) REFERENCES zona_pc (id_zona),
        CONSTRAINT UbicacionPC_Hueco FOREIGN KEY (id_zona, columna, altura) REFERENCES hueco_pc (id_zona, columna, altura)
    ) ENGINE=InnoDB;