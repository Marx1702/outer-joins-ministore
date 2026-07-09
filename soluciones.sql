-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs

-- Autor: Juan Marcelo Arteaga

-- Fecha: 9/7/2026

--
-- ══════════════════════════════════════════

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Solución: Traemos todos los productos y filtramos donde no hay venta asociada.

SELECT p.producto_id, 
       p.nombre, 
       p.categoria, 
       v.venta_id, 
       v.fecha_venta
FROM productos p
LEFT JOIN ventas v ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL;


-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos que no figuran en nuestro catálogo?
-- Solución: Traemos todas las ventas y filtramos donde el lado del catálogo está vacío.

SELECT v.venta_id, 
       v.producto_id AS id_buscado_en_venta, 
       p.nombre AS nombre_catalogo, 
       v.cantidad, 
       v.fecha_venta
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL;


-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre todas las filas.

SELECT p.producto_id AS id_catalogo, 
       p.nombre, 
       v.venta_id, 
       v.producto_id AS id_venta, 
       v.cantidad
FROM productos p
LEFT JOIN ventas v ON p.producto_id = v.producto_id

UNION

SELECT p.producto_id AS id_catalogo, 
       p.nombre, 
       v.venta_id, 
       v.producto_id AS id_venta, 
       v.cantidad
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id;