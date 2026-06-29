# 🎬 Sakila SQL Analysis | PostgreSQL Database Project

## 📖 Descripción del Proyecto

Este proyecto forma parte del Máster en Análisis de Datos y consiste en la resolución de un conjunto de consultas SQL sobre la base de datos **Sakila**, utilizando **PostgreSQL** como sistema gestor de bases de datos y **DBeaver** como entorno de desarrollo.

El objetivo principal ha sido comprender el funcionamiento de una base de datos relacional, analizar las relaciones entre sus tablas y aplicar consultas SQL de distinta complejidad siguiendo buenas prácticas de programación.

Además de resolver las consultas propuestas, el proyecto incluye la configuración del entorno de trabajo, la importación de la base de datos y la documentación completa del proceso mediante GitHub.

---

# 🎯 Objetivos

- Comprender la estructura de una base de datos relacional.
- Resolver consultas SQL utilizando buenas prácticas.
- Aplicar funciones de agregación, agrupaciones y filtros.
- Utilizar correctamente distintos tipos de JOIN.
- Trabajar con subconsultas, vistas y tablas temporales.
- Interpretar y validar los resultados obtenidos.
- Documentar el proyecto de forma clara y profesional.

---

# 📂 Estructura del Repositorio

```
sakila-sql-analysis/
│
├── README.md
├── sql/
│   └── consultas_sakila.sql
├── docs/
│   └── sakila_diagram.png
└── resources/
    └── BBDD_Proyecto_shakila_sinuser.sql
```

---

# 🛠️ Tecnologías Utilizadas

| Herramienta | Uso |
|-------------|-----|
| PostgreSQL 17 | Motor de base de datos |
| DBeaver | Desarrollo y ejecución de consultas |
| Git | Control de versiones |
| GitHub | Documentación del proyecto |
| macOS | Entorno de desarrollo |

---

# ⚙️ Configuración del Entorno

Durante la importación inicial de la base de datos apareció el siguiente error:

```sql
ERROR: role "postgres" does not exist
```

El script proporcionado estaba configurado para un usuario diferente al existente en la instalación local de PostgreSQL.

Para solucionarlo fue necesario:

- Crear la base de datos **sakila**.
- Adaptar el propietario del script SQL.
- Importar correctamente la base de datos.
- Asignar permisos al usuario local.
- Configurar una nueva conexión en DBeaver.

Con ello se obtuvo un entorno completamente funcional para el desarrollo del proyecto.

---

# 🗄️ Base de Datos

Se ha utilizado la base de datos **Sakila**, un modelo relacional diseñado para representar el funcionamiento de una empresa de alquiler de películas.

Entre las tablas principales destacan:

| Tabla | Descripción |
|--------|-------------|
| film | Catálogo de películas |
| actor | Información de actores |
| customer | Clientes |
| rental | Alquileres |
| payment | Pagos |
| inventory | Inventario |
| category | Categorías |
| language | Idiomas |

---

# 🧩 Modelo Relacional

Antes de comenzar a desarrollar las consultas se analizó la estructura de la base de datos para comprender las relaciones existentes entre las diferentes tablas.

Este análisis permitió identificar correctamente las claves primarias y foráneas, facilitando el uso adecuado de los distintos tipos de `JOIN` empleados durante el proyecto.

![Modelo Relacional de la Base de Datos Sakila](docs/sakila_diagram.png)

---

# 📊 Consultas Realizadas

El proyecto incluye la resolución completa de las **64 consultas** propuestas.

Las consultas se encuentran organizadas y comentadas dentro del archivo `sql/consultas_sakila.sql`:

```
sql/consultas_sakila.sql
```

Durante el proyecto se trabajó con los siguientes conceptos:

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Funciones de agregación
- INNER JOIN
- LEFT JOIN
- FULL OUTER JOIN
- CROSS JOIN
- Subconsultas
- Views
- Tablas temporales

Cada consulta incluye su número correspondiente y el enunciado original como comentario para facilitar su comprensión.

---
# 🔍 Resultados y Conclusiones

El desarrollo de este proyecto ha permitido comprender en profundidad el funcionamiento de una base de datos relacional y la importancia de diseñar consultas SQL eficientes y legibles.

A través de las diferentes consultas se analizaron las relaciones entre películas, actores, clientes, alquileres y pagos, comprobando cómo la información puede combinarse mediante claves primarias y foráneas para responder a distintas necesidades de negocio.

Entre los principales resultados obtenidos destacan:

- Comprensión del modelo relacional de la base de datos Sakila.
- Uso de consultas de agregación para resumir información relevante.
- Aplicación de distintos tipos de JOIN según el objetivo de cada consulta.
- Utilización de subconsultas para resolver problemas de mayor complejidad.
- Creación de vistas y tablas temporales para reutilizar información y simplificar consultas.

Además, durante todo el proyecto se verificó que los resultados obtenidos fueran coherentes con los datos almacenados en la base de datos, priorizando siempre la correcta interpretación de la información frente a la simple ejecución de consultas.

---

# 💡 Dificultades Encontradas

**Configuración del entorno:** El script SQL proporcionado estaba preparado para un usuario diferente al existente en la instalación local de PostgreSQL, por lo que fue necesario adaptar el proceso de importación, crear la base de datos, asignar permisos y configurar una nueva conexión en DBeaver.

**Selección del tipo de JOIN:** Fue necesario analizar las relaciones entre tablas antes de escribir cada consulta para evitar resultados incorrectos o duplicados, especialmente en relaciones de muchos a muchos como la existente entre `actor` y `film` a través de `film_actor`.

**Interpretación de resultados vacíos:** Algunas consultas devolvían conjuntos de datos reducidos o vacíos. Por ejemplo, la consulta sobre películas cuyo idioma coincide con el idioma original devuelve 0 filas porque en Sakila el campo `original_language_id` es `NULL` para todas las películas. En estos casos se revisó y documentó el comportamiento para confirmar que el resultado era correcto.

**Tablas temporales:** Las tablas temporales solo existen durante la sesión activa. Al cerrar la conexión en DBeaver desaparecen automáticamente, por lo que fue necesario ejecutar siempre `CREATE TEMP TABLE` y su consulta de verificación en el mismo bloque.

---

# ✅ Buenas Prácticas Aplicadas

Durante todo el proyecto se siguieron buenas prácticas de programación SQL con el objetivo de mejorar la calidad y legibilidad del código:

- Uso de palabras clave SQL en mayúsculas (`SELECT`, `FROM`, `WHERE`, etc.).
- Alias descriptivos para tablas y columnas.
- Sangrado e indentación uniforme.
- Comentarios explicativos en las consultas más complejas.
- Organización de las consultas siguiendo la numeración del enunciado.
- Validación de los resultados antes de considerar finalizada cada consulta.

---

# 🎓 Competencias Desarrolladas

Este proyecto ha permitido reforzar conocimientos relacionados con:

### SQL

- Consultas básicas y avanzadas.
- Funciones de agregación.
- Agrupaciones.
- JOINs.
- Subconsultas escalares y correlacionadas.
- Vistas y tablas temporales.
  
### Bases de Datos

- Modelo relacional.
- Claves primarias y foráneas.
- Relaciones 1:N y N:M.
- Integridad referencial.

### PostgreSQL

- Creación e importación de bases de datos.
- Gestión de usuarios y permisos.
- Configuración del entorno de trabajo.
- Administración básica mediante DBeaver.

---

# 🚀 Próximos Pasos

Como posibles mejoras futuras del proyecto se plantean las siguientes líneas de trabajo:

- Analizar el rendimiento de las consultas mediante `EXPLAIN`.
- Optimizar consultas utilizando índices.
- Crear procedimientos almacenados y triggers.
- Desarrollar consultas analíticas más complejas.
- Conectar la base de datos con herramientas de visualización como Power BI o Tableau para generar dashboards interactivos.


# 👩‍💻 Autora

**María González**
🔗 https://github.com/mgonzalezbenm

