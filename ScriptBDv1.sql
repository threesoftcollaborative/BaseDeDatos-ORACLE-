CREATE TABLE sga_almacen (
    id_almacen   	NUMBER NOT NULL,
    nombre      	VARCHAR2(50),
	id_categoria 	NUMBER NOT NULL,
	direccion 		VARCHAR2(50),
	id_comuna		NUMBER NOT NULL,
    estado      	CHAR(1),
	CONSTRAINT almacen_pk PRIMARY KEY (id_almacen)
);

CREATE TABLE sga_usuario (
    id_usuario       NUMBER NOT NULL,
    usuario          VARCHAR2(50),
    pass             VARCHAR2(50),
    email            VARCHAR2(50),
    estado           CHAR(1),
    id_perfil        NUMBER NOT NULL,
    id_almacen       NUMBER NOT NULL,
	CONSTRAINT usuario_pk PRIMARY KEY (id_usuario)

);

CREATE TABLE sga_perfil (
    id_perfil        NUMBER NOT NULL,
    descripcion      VARCHAR2(50),
    estado           CHAR(1),
    id_menu          NUMBER NOT NULL,
	CONSTRAINT perfil_pk PRIMARY KEY (id_perfil)
);

CREATE TABLE sga_menu (
    id_menu      	NUMBER NOT NULL,
    descripcion  	VARCHAR2(50),
    padre_menu   	NUMBER,
    destino      	NUMBER,
    estado      	CHAR(1),
	CONSTRAINT menu_pk PRIMARY KEY (id_menu)
);

CREATE TABLE sga_comuna (
    id_comuna   NUMBER NOT NULL,
    comuna      VARCHAR2(50),
    estado     	CHAR(1),
	CONSTRAINT comuna_pk PRIMARY KEY (id_comuna)
);


CREATE TABLE sga_cliente (
    id_cliente    			NUMBER NOT NULL,
    rut                     VARCHAR2(10),
    nombre                  VARCHAR2(50),
    apellido                VARCHAR2(50),
    telefono                NUMBER,
    email                   VARCHAR2(50),
    fecha_nacimiento        DATE,
	direccion				VARCHAR2(50),
    estado                	CHAR(1),
    id_almacen             	NUMBER NOT NULL,
    id_comuna               NUMBER NOT NULL,
	CONSTRAINT cliente_pk PRIMARY KEY (id_cliente)
);

CREATE TABLE sga_categoria (
    id_categoria     NUMBER NOT NULL,
    descripcion      VARCHAR2(50),
    estado           CHAR(1),
	CONSTRAINT categoria_pk PRIMARY KEY (id_categoria)
);


CREATE TABLE sga_marca (
    id_marca   		NUMBER NOT NULL,
    marca      		VARCHAR2(50),
    estado     		CHAR(1),
	id_categoria 	NUMBER,
	id_proveedor 	NUMBER,
	CONSTRAINT marca_pk PRIMARY KEY (id_marca)

);

CREATE TABLE sga_proveedor (
    id_proveedor           NUMBER NOT NULL,
    nombre                 VARCHAR2(50),
    rut                    VARCHAR2(10),
    fono                   NUMBER,
    email                  VARCHAR2(50),
    direccion              VARCHAR2(50),
    estado                 CHAR(1),
    id_comuna 	           NUMBER NOT NULL,
	id_almacen			   NUMBER NOT NULL,
	CONSTRAINT proveedor_pk PRIMARY KEY (id_proveedor)

);


CREATE TABLE sga_producto (
    id_producto          NUMBER NOT NULL,
    nombre               VARCHAR2(50),
    precio_compra        NUMBER,
    precio_venta         NUMBER,
    stock                NUMBER,
    estado               CHAR(1),
    id_marca             NUMBER NOT NULL,
	CONSTRAINT producto_pk PRIMARY KEY (id_producto)

);

CREATE TABLE sga_detalle_producto (
    cod_barra            VARCHAR2(100),
	id_producto			 NUMBER,
    fecha_caducidad      DATE,
    estado               CHAR(1),
	CONSTRAINT detalle_producto_pk PRIMARY KEY (cod_barra)
);


CREATE TABLE sga_boleta (
    id_boleta                NUMBER NOT NULL,
    fecha_boleta             DATE,
    total                    NUMBER,
    estado                   CHAR(1),
    id_usuario             	NUMBER NOT NULL,
    id_cliente             	NUMBER,
	id_almacen				NUMBER NOT NULL,
	CONSTRAINT id_boleta_pk PRIMARY KEY (id_boleta)

);


CREATE TABLE sga_detalle_boleta (
    id_detalle_boleta          NUMBER NOT NULL,
	id_boleta				   NUMBER NOT NULL,
	cod_barra				   VARCHAR2(100),
	precio_venta			  NUMBER,
	CONSTRAINT detalle_boleta PRIMARY KEY (id_detalle_boleta)

);


CREATE TABLE sga_orden_compra (
    id_orden_compra          NUMBER NOT NULL,
    fecha_orden_compra       DATE,
	fecha_recepcion			 DATE,
    total                    NUMBER,
    estado                   CHAR(1),
    id_usuario             	NUMBER NOT NULL,
    id_proveedor            NUMBER,
	id_almacen				NUMBER NOT NULL,
	CONSTRAINT orden_compra_pk PRIMARY KEY (id_orden_compra)

);

CREATE TABLE sga_detalle_orden_compra (
    id_detalle_orden_compra     NUMBER NOT NULL,
	id_orden_compra				NUMBER NOT NULL,
	id_producto					NUMBER NOT NULL,
	cantidad				    NUMBER NOT NULL,
	precio_compra			    NUMBER,
	CONSTRAINT detalle_orden_compra PRIMARY KEY (id_detalle_orden_compra)
);



ALTER TABLE SGA_ALMACEN
ADD CONSTRAINT sga_categoria_sga_almacen_fk
    FOREIGN KEY (id_categoria)
    REFERENCES sga_categoria (id_categoria);
ALTER TABLE SGA_ALMACEN
ADD CONSTRAINT  sga_comuna_fk_sga_almacen_fk
    FOREIGN KEY (id_comuna)
    REFERENCES sga_comuna(id_comuna);

ALTER TABLE sga_usuario
ADD	CONSTRAINT sga_perfil_sga_usuario_fk
    FOREIGN KEY (id_perfil)
    REFERENCES sga_perfil(id_perfil);
ALTER TABLE sga_usuario 
ADD	CONSTRAINT sga_almacen_sga_usuario_fk
    FOREIGN KEY (id_almacen)
    REFERENCES sga_almacen(id_almacen);


ALTER TABLE sga_perfil
ADD	CONSTRAINT sga_menu_sga_perfil_fk
    FOREIGN KEY (id_menu)
    REFERENCES sga_menu(id_menu);
	
	
ALTER TABLE sga_cliente
ADD	CONSTRAINT sga_almacen_sga_cliente_fk
    FOREIGN KEY (id_almacen)
    REFERENCES sga_almacen(id_almacen);
	
	
	
ALTER TABLE sga_marca
ADD	CONSTRAINT sga_categoria_sga_marca_fk
    FOREIGN KEY (id_categoria)
    REFERENCES sga_categoria(id_categoria);
ALTER TABLE sga_marca   
ADD	CONSTRAINT sga_proveedor_sga_marca_fk
    FOREIGN KEY (id_proveedor)
    REFERENCES sga_proveedor(id_proveedor);
	
ALTER TABLE sga_proveedor
ADD	CONSTRAINT sga_comuna_sga_proveedor_fk
    FOREIGN KEY (id_comuna)
    REFERENCES sga_comuna(id_comuna);
ALTER TABLE sga_proveedor
ADD	CONSTRAINT sga_almacen_sga_proveedor_fk
    FOREIGN KEY (id_almacen)
    REFERENCES sga_almacen(id_almacen);
	
	
ALTER TABLE	sga_producto
ADD	CONSTRAINT sga_marca_sga_producto_fk
    FOREIGN KEY (id_marca)
    REFERENCES sga_marca(id_marca);
	
	
ALTER TABLE	sga_detalle_producto
ADD	CONSTRAINT sga_prod_sga_det_prod_fk
    FOREIGN KEY (id_producto)
    REFERENCES sga_producto(id_producto);
	
	
	
ALTER TABLE	sga_boleta 
ADD	CONSTRAINT sga_usuario_sga_boleta_fk
    FOREIGN KEY (id_usuario)
    REFERENCES sga_usuario(id_usuario);
ALTER TABLE	sga_boleta 
ADD	CONSTRAINT sga_cliente_sga_boleta_fk
    FOREIGN KEY (id_cliente)
    REFERENCES sga_cliente(id_cliente);
ALTER TABLE	sga_boleta 
ADD	CONSTRAINT sga_almacen_sga_boleta_fk
    FOREIGN KEY (id_almacen)
    REFERENCES sga_almacen(id_almacen);
	
	
	
ALTER TABLE	sga_detalle_boleta
ADD	CONSTRAINT sga_boleta_sga_det_bol_fk
    FOREIGN KEY (id_boleta)
    REFERENCES sga_boleta(id_boleta);
ALTER TABLE	sga_detalle_boleta  
ADD  CONSTRAINT sga_det_prod_sga_det_bol_fk
    FOREIGN KEY (cod_barra)
    REFERENCES sga_detalle_producto(cod_barra);
		
	
ALTER TABLE	sga_orden_compra
ADD	CONSTRAINT sga_usu_sga_ord_comp_fk
    FOREIGN KEY (id_usuario)
    REFERENCES sga_usuario(id_usuario);
ALTER TABLE	sga_orden_compra
ADD	CONSTRAINT sga_prove_sga_ord_comp_fk
    FOREIGN KEY (id_proveedor)
    REFERENCES sga_proveedor(id_proveedor);
ALTER TABLE	sga_orden_compra
ADD	CONSTRAINT sga_alm_sga_ord_comp_fk
    FOREIGN KEY (id_almacen)
    REFERENCES sga_almacen(id_almacen);
	
	
ALTER TABLE	sga_detalle_orden_compra
ADD	CONSTRAINT sga_o_comp_sga_det_o_comp_fk
    FOREIGN KEY (id_orden_compra)
    REFERENCES sga_orden_compra(id_orden_compra);
ALTER TABLE	sga_detalle_orden_compra
ADD  CONSTRAINT sga_prod_sga_det_o_comp_fk
    FOREIGN KEY (id_producto)
    REFERENCES sga_producto(id_producto);
	
	
CREATE SEQUENCE seq_id_producto
INCREMENT BY 1
START WITH 1;
