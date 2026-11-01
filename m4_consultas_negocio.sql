---------- RESUMEN EJECUTIVO MENSUAL--------------

SELECT
YEAR(Fecha_Venta) AS AÑO_VENTA,
MONTH(Fecha_Venta) AS MES_VENTA,
SUM(Cantidad * Precio_unitario) AS TOTAL_FACTURADO,
COUNT(Id_Venta) AS CANTIDAD_PEDIDOS,
AVG(Cantidad * Precio_unitario) AS PROMEDIO_TICKET
FROM Ventas
GROUP BY YEAR(Fecha_Venta), MONTH(Fecha_Venta);


----------- RANKING DE PRODUCTOS -------------

SELECT TOP 5 id_producto,
SUM (Cantidad) AS TOTAL_UNIDADES_VENDIDAS,
SUM (Cantidad * Precio_unitario) AS TOTAL_FACTURADO
FROM Ventas
GROUP BY (Id_Producto)
ORDER BY (TOTAL_FACTURADO) DESC;

------------ CLIENTES RECURRENTES ------------

SELECT id_cliente,
COUNT (id_venta) AS PEDIDOS,
SUM (Cantidad * Precio_unitario) AS TOTAL_GASTADO
FROM Ventas
GROUP BY (id_cliente)
HAVING COUNT (*) > 1
ORDER BY (TOTAL_GASTADO) DESC;



---------- MESES POR ENCIMA/MESES POR DEBAJO DEL PROMEDIO-----

WITH FacturacionPorProducto AS (
    SELECT 
        id_producto,
        SUM(Cantidad*Precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT 
    id_producto,
    total_facturado,
    CASE 
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM FacturacionPorProducto) 
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS Comparativa
FROM FacturacionPorProducto
ORDER BY total_facturado DESC;




----COMENTARIOS----------
1. EL PRODUCTO ID 1 CONCENTRA LAS MAYORES VENTAS EN MONTO (EL 81,30%)
2. EL PRODUCTO ID 2 CONCENTRA LAS MAYORES UNIDADES VENDIDAS (EL 40,62%)
3. El PRODUCTO ID 1 TUVO UNA FACTURACION POR ENCIMA DEL PROMEDIO