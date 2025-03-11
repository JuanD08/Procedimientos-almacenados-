
USE recovery_documents;

DELIMITER //

CREATE FUNCTION Cantidad_Entregas_Por_Tipo_Documento(nombre_tipo_doc VARCHAR(255)) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE cantidad_entregas INT;

    SELECT COUNT(e.ID_entrega) INTO cantidad_entregas
    FROM entrega e
    JOIN documentos d ON e.ID_Documento = d.ID_Documento
    JOIN tipo_documento td ON d.ID_TipoDoc = td.ID_TipoDoc
    WHERE td.Nombre = nombre_tipo_doc;

    RETURN cantidad_entregas;
END //

DELIMITER ;

SELECT Cantidad_Entregas_Por_Tipo_Documento('Tarjeta de identidad') AS Cantidad_Entregas;	