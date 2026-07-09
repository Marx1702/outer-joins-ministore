# outer-joins-ministore

1. ¿Por qué usaste LEFT JOIN para la Consulta 1 y no INNER JOIN? ¿Qué se perdería si usaras INNER JOIN?

Utilicé LEFT JOIN porque mi objetivo principal era retener todos los registros de la tabla base (la tabla de la izquierda, productos), independientemente de si tenían o no coincidencias en la tabla de ventas. Si hubiera utilizado un INNER JOIN, el motor de la base de datos habría descartado automáticamente los productos 108 (Hub USB-C) y 109 (Parlante Bluetooth) porque no existen en la tabla de transacciones. El INNER JOIN habría ocultado exactamente la información que el equipo de operaciones necesitaba encontrar: el stock muerto.

2. ¿Por qué usaste RIGHT JOIN para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha en tu consulta?

Usé RIGHT JOIN porque necesitaba priorizar la integridad de las transacciones sobre el catálogo. Quería traer el 100% de los registros de ventas, incluso si el ID del producto ingresado no era válido. En mi consulta (FROM productos p RIGHT JOIN ventas v), la tabla productos está a la izquierda y ventas está a la derecha. Al hacer un JOIN "hacia la derecha", le indico a SQL que no me importa si el producto_id existe en el catálogo; quiero ver la venta igual.

3. ¿Qué representan los valores NULL en cada resultado?

Los valores NULL en estos contextos no son "errores", sino la confirmación de una ausencia de coincidencia:

En la Consulta 1 (venta_id es NULL): Significa que el producto existe físicamente en el catálogo de MiniStore, pero al cruzarlo con el historial de ventas, no se encontró ninguna transacción. Es decir, nunca se vendió.

En la Consulta 2 (producto_id de productos es NULL): Significa que se registró una transacción (la venta_id 10), pero el código de producto cargado en esa venta (999) no hace match con la llave primaria de ningún producto en nuestra base maestra. Es un registro huérfano causado por un error de tipeo o un problema de sincronización.

4. ¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio?

Se utiliza para tareas de reconciliación total o auditoría de sistemas. Por ejemplo, si una empresa migra de un sistema de facturación viejo a uno nuevo, o si integra una pasarela de pagos externa con su propia base de datos. Un FULL OUTER JOIN permite ver en una sola pantalla los tres escenarios:

Las operaciones perfectas (coinciden en ambos lados).

Los pagos que están en el sistema externo pero no en el nuestro (pagos perdidos).

Las facturas en nuestro sistema que no tienen registro de pago en el externo (posibles fraudes o errores de cobro).