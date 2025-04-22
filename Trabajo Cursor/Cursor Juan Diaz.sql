DELIMITER //

CREATE PROCEDURE recorrer_facturas()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE nombreProducto VARCHAR(50);
    DECLARE nombreCliente VARCHAR(50);
    DECLARE fecha DATE;

    DECLARE cur CURSOR FOR
        SELECT p.nombreProducto, u.nombre, f.fechaVenta
        FROM factura f
        JOIN productos p ON f.idProducto = p.idProducto
        JOIN usuarios u ON f.idCliente = u.idUsuarios;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DROP TEMPORARY TABLE IF EXISTS tmp_factura_info;

    CREATE TEMPORARY TABLE tmp_factura_info (
        info VARCHAR(500)
    );

    OPEN cur;
    lectura: LOOP
        FETCH cur INTO nombreProducto, nombreCliente, fecha;
        IF done THEN
            LEAVE lectura;
        END IF;

        INSERT INTO tmp_factura_info(info)
        VALUES (
            CONCAT('Producto: ', nombreProducto, ' | Cliente: ', nombreCliente, ' | Fecha: ', fecha)
        );
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL recorrer_facturas();
SELECT * FROM tmp_factura_info;
