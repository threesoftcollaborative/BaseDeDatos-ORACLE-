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

	
INSERT INTO sga_categoria VALUES (1,'mercado',1);
INSERT INTO sga_categoria VALUES (2,'velduleria',1);
INSERT INTO sga_categoria VALUES (3,'mascotas',1);
INSERT INTO sga_categoria VALUES (4,'vestuario',1);
INSERT INTO sga_categoria VALUES (5,'deportes',1);

   INSERT INTO sga_comuna VALUES (1, 'Cerrillos' 	       ,1);
   INSERT INTO sga_comuna VALUES (2, 'Cerro Navia' 	       ,1);
   INSERT INTO sga_comuna VALUES (3, 'Conchalí' 	       ,1);
   INSERT INTO sga_comuna VALUES (4, 'El Bosque' 	       ,1);
   INSERT INTO sga_comuna VALUES (5, 'Estación Central'    ,1);
   INSERT INTO sga_comuna VALUES (6, 'Huechuraba' 	       ,1);
   INSERT INTO sga_comuna VALUES (7, 'Independencia' 	   ,1);
   INSERT INTO sga_comuna VALUES (8, 'La Cisterna' 	       ,1);
   INSERT INTO sga_comuna VALUES (9, 'La Florida' 	       ,1);
   INSERT INTO sga_comuna VALUES (10, 'La Pintana' 	       ,1);
   INSERT INTO sga_comuna VALUES (11, 'La Granja'          ,1);
   INSERT INTO sga_comuna VALUES (12, 'La Reina' 	       ,1);
   INSERT INTO sga_comuna VALUES (13, 'Las Condes'         ,1);
   INSERT INTO sga_comuna VALUES (14, 'Lo Barnechea' 	   ,1);
   INSERT INTO sga_comuna VALUES (15, 'Lo Espejo' 	       ,1);
   INSERT INTO sga_comuna VALUES (16, 'Lo Prado'           ,1);
   INSERT INTO sga_comuna VALUES (17, 'Macul' 	           ,1);
   INSERT INTO sga_comuna VALUES (18, 'Maipú' 	           ,1);
   INSERT INTO sga_comuna VALUES (19, 'Ñuñoa' 	           ,1);
   INSERT INTO sga_comuna VALUES (20, 'Pedro Aguirre Cerda',1); 	     
   INSERT INTO sga_comuna VALUES (21, 'Peñalolén' 	       ,1);
   INSERT INTO sga_comuna VALUES (22, 'Pudahuel'           ,1);
   INSERT INTO sga_comuna VALUES (23, 'Quilicura'          ,1);
   INSERT INTO sga_comuna VALUES (24, 'Quinta Normal'      ,1);
   INSERT INTO sga_comuna VALUES (25, 'Recoleta'           ,1);
   INSERT INTO sga_comuna VALUES (26, 'Renca'              ,1);
   INSERT INTO sga_comuna VALUES (27, 'San Miguel'         ,1);
   INSERT INTO sga_comuna VALUES (28, 'San Joaquín'        ,1);
   INSERT INTO sga_comuna VALUES (29, 'San Ramón'          ,1);
   INSERT INTO sga_comuna VALUES (30, 'Santiago'           ,1);
   INSERT INTO sga_comuna VALUES (31, 'Vitacura'           ,1);
	
	
CREATE SEQUENCE seq_id_almacen
INCREMENT BY 1
START WITH 1;	

CREATE OR REPLACE PACKAGE  pkg_app_escritorio_almacen AS	
PROCEDURE prc_add_almacen ( p_nombre        IN sga_almacen.nombre%TYPE,
                            p_id_categoria  IN sga_almacen.id_categoria%TYPE,
                            p_direccion     IN sga_almacen.direccion%TYPE,
                            p_id_comuna     IN sga_almacen.id_comuna%TYPE);
PROCEDURE prc_del_almacen (p_id_almacen     IN sga_almacen.id_almacen%TYPE);        
END pkg_app_escritorio_almacen;

/
CREATE OR REPLACE PACKAGE BODY pkg_app_escritorio_almacen AS
PROCEDURE prc_add_almacen ( p_nombre        IN sga_almacen.nombre%TYPE,
                            p_id_categoria  IN sga_almacen.id_categoria%TYPE,
                            p_direccion     IN sga_almacen.direccion%TYPE,
                            p_id_comuna     IN sga_almacen.id_comuna%TYPE) AS
BEGIN 
    INSERT INTO sga_almacen
    VALUES(seq_id_almacen.NEXTVAL,
            p_nombre,
            p_id_categoria,
            p_direccion,
            p_id_comuna,
            1);
END prc_add_almacen;
PROCEDURE prc_del_almacen (p_id_almacen     IN sga_almacen.id_almacen%TYPE) AS
BEGIN
    UPDATE sga_almacen 
    SET estado = 0
    WHERE id_almacen = p_id_almacen;
END prc_del_almacen;
END pkg_app_escritorio_almacen;
/

EXEC PKG_APP_ESCRITORIO_ALMACEN.PRC_ADD_ALMACEN('YUYITOS',1,'Las flores 1212',11); 
EXEC PKG_APP_ESCRITORIO_ALMACEN.PRC_ADD_ALMACEN('ZAPALLITOS',2,'Arturo Prat 134',20); 
EXEC PKG_APP_ESCRITORIO_ALMACEN.PRC_ADD_ALMACEN('PATITAS',3,'Los leones 1612',2);
EXEC PKG_APP_ESCRITORIO_ALMACEN.PRC_ADD_ALMACEN('TRAPOS',4,'el bosque 123',5);
EXEC PKG_APP_ESCRITORIO_ALMACEN.PRC_ADD_ALMACEN('FITSTORE',5,'lota 2546',8); 


CREATE SEQUENCE seq_id_proveedor
INCREMENT BY 1
START WITH 1;

CREATE OR REPLACE PACKAGE pkg_app_web_proveedor AS 
PROCEDURE prc_add_proveedor (p_nombre       IN  sga_proveedor.nombre%TYPE,
                             p_rut          IN  sga_proveedor.rut%TYPE,
                             p_fono         IN  sga_proveedor.fono%TYPE,
                             p_email        IN  sga_proveedor.email%TYPE,
                             p_direccion    IN  sga_proveedor.direccion%TYPE,
                             p_id_comuna    IN  sga_proveedor.id_comuna%TYPE,
                             p_id_almacen   IN  sga_proveedor.id_almacen%TYPE);
PROCEDURE prc_upd_proveedor (p_id_proveedor IN  sga_proveedor.id_proveedor%TYPE,
                             p_nombre       IN  sga_proveedor.nombre%TYPE,
                             p_rut          IN  sga_proveedor.rut%TYPE,
                             p_fono         IN  sga_proveedor.fono%TYPE,
                             p_email        IN  sga_proveedor.email%TYPE,
                             p_direccion    IN  sga_proveedor.direccion%TYPE,
                             p_id_comuna    IN  sga_proveedor.id_comuna%TYPE);
PROCEDURE prc_del_proveedor (p_id_proveedor IN  sga_proveedor.id_proveedor%TYPE);
PROCEDURE prc_lst_proveedor (p_id_almacen        IN sga_almacen.id_almacen%TYPE,
                            p_recordset         OUT SYS_REFCURSOR);
END pkg_app_web_proveedor;
/
CREATE OR REPLACE PACKAGE BODY pkg_app_web_proveedor AS
PROCEDURE prc_add_proveedor (p_nombre       IN  sga_proveedor.nombre%TYPE,
                             p_rut          IN  sga_proveedor.rut%TYPE,
                             p_fono         IN  sga_proveedor.fono%TYPE,
                             p_email        IN  sga_proveedor.email%TYPE,
                             p_direccion    IN  sga_proveedor.direccion%TYPE,
                             p_id_comuna    IN  sga_proveedor.id_comuna%TYPE,
                             p_id_almacen   IN  sga_proveedor.id_almacen%TYPE) AS
BEGIN
    INSERT INTO sga_proveedor
    VALUES (seq_id_proveedor.nextval,
            p_nombre,
            p_rut,
            p_fono,
            p_email,
            p_direccion,
            1,
            p_id_comuna,
            p_id_almacen);
END prc_add_proveedor;
PROCEDURE prc_upd_proveedor (p_id_proveedor IN  sga_proveedor.id_proveedor%TYPE,
                             p_nombre       IN  sga_proveedor.nombre%TYPE,
                             p_rut          IN  sga_proveedor.rut%TYPE,
                             p_fono         IN  sga_proveedor.fono%TYPE,
                             p_email        IN  sga_proveedor.email%TYPE,
                             p_direccion    IN  sga_proveedor.direccion%TYPE,
                             p_id_comuna    IN  sga_proveedor.id_comuna%TYPE) AS 
BEGIN
    UPDATE sga_proveedor
    SET nombre = p_nombre,
        rut = p_rut,
        fono = p_fono,
        email = p_email,
        direccion = p_direccion,
        id_comuna = p_id_comuna
    WHERE id_proveedor=p_id_proveedor;
END prc_upd_proveedor;    
PROCEDURE prc_del_proveedor (p_id_proveedor IN  sga_proveedor.id_proveedor%TYPE) AS
BEGIN
UPDATE sga_proveedor
    SET estado = 0
    WHERE id_proveedor=p_id_proveedor;
END prc_del_proveedor;
PROCEDURE prc_del_producto (p_id_producto     IN sga_producto.id_producto%TYPE) AS
BEGIN
    UPDATE sga_producto
    SET estado = 0
    WHERE id_producto = p_id_producto;
END prc_del_producto;
PROCEDURE prc_lst_proveedor (p_id_almacen        IN sga_almacen.id_almacen%TYPE,
                            p_recordset         OUT SYS_REFCURSOR) AS
BEGIN
    OPEN p_recordset FOR
    SELECT NOMBRE,
           RUT,
           ID_PROVEEDOR,
           ID_COMUNA,
           FONO,
           EMAIL,
           DIRECCION
    FROM sga_proveedor 
    WHERE id_almacen = p_id_almacen
    AND estado = 1;
END prc_lst_proveedor;
END pkg_app_web_proveedor;

EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('NESTLE','11111111-1',11111111,'NESTLE@ESFALSO.CL','las lilas 1313',1,1);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('CCU','11111111-1',11111112,'CCU@ESFALSO.CL','las escondida 656',4,1);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('LA VEGA','11111111-1',11111113,'LA VEGA@ESFALSO.CL','carahue 2345',7,2);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('EL DORADO','11111111-1',11111114,'EL DORADO@ESFALSO.CL','maipu 123',16,2);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('MASCOSAS','11111111-1',11111115,'MASCOSAS@ESFALSO.CL','milan 1492',8,3);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('PURINA','11111111-1',11111116,'PURINA@ESFALSO.CL','rio claro 1423',14,3);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('HYM','11111111-1',11111117,'HYM@ESFALSO.CL','el aguilucho 2354',21,4);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('AMERICANINO','11111111-1',11111118,'AMERICANINO@ESFALSO.CL','el morado 2154',3,4);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('NIKE','11111111-1',11111119,'NIKE@ESFALSO.CL','uno 1111',11,5);
EXEC PKG_APP_WEB_PROVEEDOR.PRC_ADD_PROVEEDOR ('SPARTA','11111111-1',11111120,'SPARTA@ESFALSO.CL','sol 567',9,5);

INSERT INTO sga_marca VALUES (1,'Nescafe',1,1,1);
INSERT INTO sga_marca VALUES (2,'Sahne nuss',1,1,1);
INSERT INTO sga_marca VALUES (3,'Pepsi',1,1,2);
INSERT INTO sga_marca VALUES (4,'Bilz y pap',1,1,2);
INSERT INTO sga_marca VALUES (5,'Huerta organica',1,2,3);
INSERT INTO sga_marca VALUES (6,'Chiquita',1,2,3);
INSERT INTO sga_marca VALUES (7,'Del monte',1,2,4);
INSERT INTO sga_marca VALUES (8,'Vitavega',1,2,4);
INSERT INTO sga_marca VALUES (9,'Woof',1,3,5);
INSERT INTO sga_marca VALUES (10,'Safiri',1,3,5);
INSERT INTO sga_marca VALUES (11,'Doko',1,3,6);
INSERT INTO sga_marca VALUES (12,'Whiskas',1,3,6);
INSERT INTO sga_marca VALUES (13,'Cos',1,4,7);
INSERT INTO sga_marca VALUES (14,'Monki',1,4,7);
INSERT INTO sga_marca VALUES (15,'Americanin',1,4,8);
INSERT INTO sga_marca VALUES (16,'Sybilla',1,4,8);
INSERT INTO sga_marca VALUES (17,'Air Max',1,5,9);
INSERT INTO sga_marca VALUES (18,'Clothes',1,5,9);
INSERT INTO sga_marca VALUES (19,'Trek',1,5,10);
INSERT INTO sga_marca VALUES (20,'Lippi',1,5,10);

CREATE SEQUENCE seq_id_producto
INCREMENT BY 1
START WITH 1;


CREATE OR REPLACE PACKAGE pkg_app_web_producto AS
PROCEDURE prc_add_producto (p_nombre          IN sga_producto.nombre%TYPE,
                            p_precio_compra   IN sga_producto.precio_compra%TYPE,
                            p_precio_venta    IN sga_producto.precio_venta%TYPE,
                            p_stock           IN sga_producto.stock%TYPE,
                            p_id_marca        IN sga_producto.id_marca%TYPE);                            
PROCEDURE prc_upd_producto (p_id_producto     IN sga_producto.id_producto%TYPE,
                            p_nombre          IN sga_producto.nombre%TYPE,
                            p_precio_compra   IN sga_producto.precio_compra%TYPE,
                            p_precio_venta    IN sga_producto.precio_venta%TYPE);
PROCEDURE prc_del_producto (p_id_producto     IN sga_producto.id_producto%TYPE);
PROCEDURE prc_lst_producto (p_id_almacen        IN sga_almacen.id_almacen%TYPE,
                            p_recordset         OUT SYS_REFCURSOR);
END pkg_app_web_producto;
/
CREATE OR REPLACE PACKAGE BODY pkg_app_web_producto AS
PROCEDURE prc_add_producto (p_nombre          IN sga_producto.nombre%TYPE,
                            p_precio_compra   IN sga_producto.precio_compra%TYPE,
                            p_precio_venta    IN sga_producto.precio_venta%TYPE,
                            p_stock           IN sga_producto.stock%TYPE,
                            p_id_marca        IN sga_producto.id_marca%TYPE) AS 
    BEGIN
    INSERT INTO  sga_producto 
    VALUES      (seq_id_producto.NEXTVAL,                             
                 p_nombre,
                 p_precio_compra,
                 p_precio_venta,
                 p_stock,
                 1,
                 p_id_marca);
END prc_add_producto;
PROCEDURE prc_upd_producto (p_id_producto     IN sga_producto.id_producto%TYPE,
                            p_nombre          IN sga_producto.nombre%TYPE,
                            p_precio_compra   IN sga_producto.precio_compra%TYPE,
                            p_precio_venta    IN sga_producto.precio_venta%TYPE) AS
BEGIN
    UPDATE sga_producto
    SET nombre = p_nombre,
        precio_compra = p_precio_compra,
        precio_venta = p_precio_venta
    WHERE id_producto = p_id_producto;
END prc_upd_producto;
PROCEDURE prc_del_producto (p_id_producto     IN sga_producto.id_producto%TYPE) AS
BEGIN
    UPDATE sga_producto
    SET estado = 0
    WHERE id_producto = p_id_producto;
END prc_del_producto;
PROCEDURE prc_lst_producto (p_id_almacen        IN sga_almacen.id_almacen%TYPE,
                            p_recordset         OUT SYS_REFCURSOR) AS
BEGIN
    OPEN p_recordset FOR
    SELECT produ.ID_MARCA,
           produ.ID_PRODUCTO,
           produ.NOMBRE,
           produ.PRECIO_COMPRA,
           produ.PRECIO_VENTA,
           produ.STOCK
    FROM sga_producto produ
    JOIN sga_marca marca
    ON produ.ID_MARCA= marca.ID_MARCA
    JOIN sga_proveedor provee
    ON marca.ID_PROVEEDOR = provee.ID_PROVEEDOR
    WHERE provee.ID_ALMACEN = p_id_almacen 
    AND produ.ESTADO = 1;
END prc_lst_producto;
END pkg_app_web_producto;
/



EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Dolca 500mg',900,1500,10,1);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Tradicional 500mg',700,1300,20,1);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Clasico 160g',1000,2000,15,2);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Sin azucar 160g',1200,2500,10,2);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Clasica 1lt',400,900,12,3);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Zero 1lt',400,900,6,3);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Bilz 2lt',450,950,12,4);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Pap 2lt',450,950,12,4);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Lechuga',300,500,5,5);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Apio',600,1000,5,5);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Banana Grande',100,200,10,6);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Banana Mediana',80,170,10,6);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Arandanos 500g',1000,2000,6,7);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Mora 500g',1000,2000,6,7);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Infusion matcha 100g',3000,5000,10,8);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Sesamo 200g',2000,4000,10,8);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Collar metalico M',8000,10000,10,9);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Correa cuerda S',7000,9000,10,9);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Cama perro S',15000,20000,5,10);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Cepillo gato',7000,10000,10,10);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Alimento cachorro 1k',5000,7000,6,11);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Alimento adulto 1k',4000,6000,6,11);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Alimento cachorro 1k',5000,7000,6,12);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Alimento adulto 1k',4000,6000,6,12);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Polera estampada S',5000,10000,5,13);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Polera estampada M',5000,10000,5,13);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Pantalon Strech S',10000,15000,6,14);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Pantalon Strech M',10000,15000,6,14);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Chaqueta cuero S',40000,70000,4,15);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Chaqueta cuero M',40000,70000,4,15);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Chaleco estampado S',10000,15000,7,16);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Chaleco estampado M',10000,15000,7,16);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Niño T25',30000,45000,4,17);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Adulto T38',40000,55000,4,17);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Calzas deportivas S',15000,20000,6,18);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Calzas deportivas M',15000,20000,6,18);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Carbonate T36',450000,600000,3,19);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Space T38',550000,700000,4,19);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Banano M',15000,25000,10,20);
EXEC PKG_APP_WEB_PRODUCTO.PRC_ADD_PRODUCTO('Camellback 10lt',30000,50000,10,20);


