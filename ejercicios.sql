-- Borrar registros:

-- SIEMPRE WHERE 

-- borrar los registros que tengan mas de 2 hijos:
-- DELETE FROM alumnos WHERE cantidad_hijos > 2;

-- cambiar registros:
-- cambiar el luigar de residencia de Chile a Santiago

-- UPDATE alumnos set lugar_de_residencia = 'Santiago' WHERE lugar_de_residencia = 'Chile';

-- modificar la edad a 30 de los que tienen lugar de residencia en Santiago
-- UPDATE alumnos set edad = 30 WHERE lugar_de_residencia = 'Santiago';

-- agregar A TODOS 1 año mas a la edad
-- UPDATE alumnos set edad = edad + 1;



-- comandos extras:

-- los que tengan correo null ahora tengan empresa@gmail.com
-- UPDATE alumnos SET correo='empresa@gmail.com' WHERE correo is NULL;


-- al que tenga id 2 tenga un año mas
-- UPDATE alumnos set edad = edad + 1 where id = 2; 

-- -----------------------------------------------------------
-- Tomando en cuenta la base de datos creada ayer, llamada gestion_estudiantes. 
-- quiero que:
-- -modifiquen todos los nombres por 'Juan'
-- -agreguen un correo a el id 1 
-- -la edad de todos sea = 18
-- -borrar los datos del id 1

-- si no la tienen creada, utilicen una que tengan creada.

--------------------------------------------------------------------

--SESION 5 - transacciones

BEGIN, COMMIT Y ROLLBACK 

Ejemplo con Saldos cuenta bancaria



BEGIN;
UPDATE cuentas SET saldo = saldo - 100 WHERE cuenta_id = 1; -- Cuenta A
UPDATE cuentas SET saldo = saldo + 100 WHERE cuenta_id = 2; -- Cuenta B
COMMIT; -- Se confirma la transacción y los cambios son permanentes



BEGIN;
UPDATE cuentas SET saldo = saldo - 100 WHERE cuenta_id = 1;
-- Error en la segunda operación
ROLLBACK; -- Se deshacen los cambios


-- insertar varios productos dentro de una transacción y luego confirmar los cambios con COMMIT.
BEGIN;
INSERT INTO productos (nombre, precio) VALUES ('taladro', 1200.00);
INSERT INTO productos (nombre, precio) VALUES ('sierra', 25.00);
INSERT INTO productos (nombre, precio) VALUES ('caja herramientas', 45.00);
COMMIT; 

--agregaremos un vaor nulo donde sea not null para que salte un error

BEGIN;
INSERT INTO productos (nombre, precio) VALUES ('Esta bien', 300.00);
INSERT INTO productos (nombre, precio) VALUES ('Esta mal', NULL);
ROLLBACK;

----------------------------------------------------------------

-- Ejercicios individuales

-- Ejercicio 1: Insertar Múltiples Registros con BEGIN y COMMIT

-- Supongamos que estás gestionando una tienda y necesitas agregar nuevos productos a la base de datos. Debes insertar tres productos en una única transacción y confirmar los cambios solo si todas las inserciones son exitosas.

-- Inicia una transacción con BEGIN.
BEGIN;

-- Inserta tres nuevos productos con sus respectivos precios.
INSERT INTO productos (nombre, precio) VALUES ('Impresora', 150.00);
INSERT INTO productos (nombre, precio) VALUES ('Escáner', 200.00);
INSERT INTO productos (nombre, precio) VALUES ('Tablet', 300.00);

-- Confirma la transacción con COMMIT.
COMMIT;

-- Verifica que los productos han sido agregados correctamente.
SELECT * FROM productos;


----------------------------------------

-- Ejercicio 2: Simular un Error en la Inserción y Revertir con ROLLBACK

-- Continuando con la tienda, esta vez debes insertar varios productos en la base de datos, pero simularás un error en uno de ellos para utilizar ROLLBACK y revertir toda la transacción.

-- Inicia una transacción con BEGIN.
BEGIN;

-- Inserta dos productos válidos.
INSERT INTO productos (nombre, precio) VALUES ('Proyector', 500.00);
INSERT INTO productos (nombre, precio) VALUES ('Parlantes', 100.00);

-- Inserta un tercer producto con un nombre nulo, lo cual provocará un error.
INSERT INTO productos (nombre, precio) VALUES (NULL, 150.00);

-- Utiliza ROLLBACK para deshacer toda la transacción.
ROLLBACK;

-- Verifica que no se han insertado productos nuevos.
SELECT * FROM productos;

---------------------
--Presenta un pequeño error de sintaxis

-- Ejercicio 3: Actualizar Registros y Revertir Cambios Según Condición

-- En este ejercicio, actualizarás los precios de algunos productos en la base de datos. Si la suma de los precios actualizados supera un determinado monto, deberás utilizar ROLLBACK para deshacer los cambios. De lo contrario, confirma la transacción con COMMIT.

-- Inicia una transacción con BEGIN.
BEGIN;

-- Actualiza los precios de al menos tres productos incrementando su valor en un 10%.
UPDATE productos SET precio = precio * 1.10 WHERE nombre = 'Laptop';
UPDATE productos SET precio = precio * 1.10 WHERE nombre = 'Mouse';
UPDATE productos SET precio = precio * 1.10 WHERE nombre = 'Teclado';

-- Calcula la suma de los precios actualizados.
SELECT SUM(precio) INTO total_precio FROM productos WHERE nombre IN ('Laptop', 'Mouse', 'Teclado');

-- Si la suma supera $2,000, realiza un ROLLBACK para revertir la transacción.
-- Si la suma es menor o igual a $2,000, utiliza COMMIT para confirmar los cambios.
IF total_precio > 2000 THEN
    -- Si la suma es mayor a $2000, revertir los cambios
    ROLLBACK;
ELSE
    -- Si la suma es menor o igual a $2000, confirmar los cambios
    COMMIT;
END IF;

-- Verifica el estado de los productos.
SELECT * FROM productos;


