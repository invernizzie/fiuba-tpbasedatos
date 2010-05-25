CREATE
    TABLE Cliente
    (
        CUIT_cliente VARCHAR(15) NOT NULL,
        nombre VARCHAR(40),
        direccion VARCHAR(250),
        telefono VARCHAR(20),
        fax VARCHAR(20),
        email VARCHAR(320),
        PRIMARY KEY (CUIT_cliente)
    );

CREATE
    TABLE Pedido
    (
        numero_pedido BIGINT NOT NULL,
        CUIT_cliente VARCHAR(15) NOT NULL,
        fecha_pedido DATE,
        direccion_entrega VARCHAR(250),
        PRIMARY KEY (numero_pedido),
        CONSTRAINT Cliente_pedido
            FOREIGN KEY (CUIT_cliente)
            REFERENCES Cliente (CUIT_cliente)
    );

CREATE
    TABLE Tipo_Componente
    (
        nombre_tipo VARCHAR(40) NOT NULL,
        descripcion VARCHAR(250),
        PRIMARY KEY (nombre_tipo)
    );

CREATE
    TABLE Subtipo_Componente
    (
        nombre_subtipo VARCHAR(40) NOT NULL,
        descripcion VARCHAR(250),
        nombre_tipo VARCHAR(40) NOT NULL,
        stock_minimo INT,
        PRIMARY KEY (nombre_subtipo),
        CONSTRAINT Tipo_Subtipo
            FOREIGN KEY (nombre_tipo)
            REFERENCES Tipo_Componente (nombre_tipo)
    );

CREATE
    TABLE Proveedor
    (
        CUIT_Proveedor VARCHAR(15) NOT NULL,
        nombre VARCHAR(40),
        direccion VARCHAR(250),
        telefono VARCHAR(20),
        fax VARCHAR(20),
        email VARCHAR(320),
        PRIMARY KEY (CUIT_Proveedor)
    );

CREATE
    TABLE Provision
    (
        nombre_subtipo VARCHAR(40) NOT NULL,
        CUIT_proveedor VARCHAR(15) NOT NULL,
        precio_unitario FLOAT,
        PRIMARY KEY (nombre_subtipo, CUIT_proveedor),
        CONSTRAINT Provision_subtipo
            FOREIGN KEY (nombre_subtipo)
            REFERENCES subtipo_componente (nombre_subtipo),
        CONSTRAINT Provision_proveedor
            FOREIGN KEY (CUIT_proveedor)
            REFERENCES proveedor (CUIT_Proveedor)
    );

CREATE
    TABLE Suministro
    (
        numero_suministro BIGINT NOT NULL,
        CUIT_provedor VARCHAR(15) NOT NULL,
        impreso BOOLEAN NOT NULL,
        PRIMARY KEY (numero_suministro),
        CONSTRAINT Suministro_Proveedor 
            FOREIGN KEY (CUIT_provedor)
            REFERENCES proveedor (CUIT_Proveedor)
    );

CREATE
    TABLE Componente
    (
        numero_serie BIGINT NOT NULL,
        nombre_subtipo VARCHAR(40) NOT NULL,
        numero_suministro BIGINT NOT NULL,
        fecha_llegada DATE,
        descripcion VARCHAR(250),
        estado CHAR(8) NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT Componente_subtipo
            FOREIGN KEY (nombre_subtipo)
            REFERENCES subtipo_componente (nombre_subtipo),
        CONSTRAINT Componente_suministro
            FOREIGN KEY (numero_suministro)
            REFERENCES suministro (numero_suministro)
    );

CREATE
    TABLE Reserva
    (
        numero_serie BIGINT NOT NULL,
        numero_ordenproduccion BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT Reserva_Componente
            FOREIGN KEY (numero_serie)
            REFERENCES componente (numero_serie)
        -- Se omite clave foranea hacia Orden de Produccion
        -- pues no se implementa dicha relacion
    );

CREATE
    TABLE Item_Pedido
    (
        codigo_PC BIGINT NOT NULL,
        numero_pedido BIGINT NOT NULL,
        CONSTRAINT Item_de_Pedido
            FOREIGN KEY (numero_pedido)
            REFERENCES pedido (numero_pedido),
        -- Se omite clave foranea hacia PC
        -- pues no se implementa dicha relacion
        PRIMARY KEY (codigo_PC)
    );

CREATE
    TABLE Composicion_PC
    (
        numero_serie BIGINT NOT NULL,
        codigo_pc BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT PC_Componente
            FOREIGN KEY (numero_serie)
            REFERENCES componente (numero_serie)
        -- Se omite clave foranea hacia PC
        -- pues no se implementa dicha relacion
    );

CREATE
    TABLE Zona_Componente
    (
        id_zona BIGINT NOT NULL,
        nombre_tipo VARCHAR(40) NOT NULL,
        PRIMARY KEY (id_zona),
        CONSTRAINT Zona_Tipo_Componente
            FOREIGN KEY (nombre_tipo)
            REFERENCES tipo_componente (nombre_tipo)
    );
    
CREATE
    TABLE Zona_PC
    (
        id_zona BIGINT NOT NULL,
        nombre_configuracion VARCHAR(20),
        PRIMARY KEY (id_zona)
        -- Se omite clave foranea hacia Configuracion
        -- pues no se implementa dicha relacion
    );

CREATE
    TABLE Hueco_PC
    (
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (id_zona, columna, altura),
        CONSTRAINT HuecoPC_Zona
            FOREIGN KEY (id_zona)
            REFERENCES zona_pc (id_zona)
    );

CREATE
    TABLE Hueco_Componente
    (
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (id_zona, columna, altura),
        CONSTRAINT HuecoComponente_Zona
            FOREIGN KEY (id_zona)
            REFERENCES zona_componente (id_zona)
    );

CREATE
    TABLE Ubicacion_Componente
    (
        numero_serie BIGINT NOT NULL,
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (numero_serie),
        CONSTRAINT UbicacionComponente_Zona
            FOREIGN KEY (id_zona)
            REFERENCES zona_componente (id_zona),
        CONSTRAINT UbicacionComponente_Hueco
            FOREIGN KEY (id_zona, columna, altura)
            REFERENCES hueco_componente (id_zona, columna, altura),
        CONSTRAINT UbicacionComponente_Componente
            FOREIGN KEY (numero_serie)
            REFERENCES componente (numero_serie)
    );

CREATE
    TABLE Ubicacion_PC
    (
        codigo_PC BIGINT NOT NULL,
        id_zona BIGINT NOT NULL,
        columna BIGINT NOT NULL,
        altura BIGINT NOT NULL,
        PRIMARY KEY (codigo_PC),
        CONSTRAINT UbicacionPC_Zona
            FOREIGN KEY (id_zona)
            REFERENCES zona_pc (id_zona),
        CONSTRAINT UbicacionPC_Hueco
            FOREIGN KEY (id_zona, columna, altura)
            REFERENCES hueco_pc (id_zona, columna, altura)
        -- Se omite clave foranea hacia PC
        -- pues no se implementa dicha relacion
    );