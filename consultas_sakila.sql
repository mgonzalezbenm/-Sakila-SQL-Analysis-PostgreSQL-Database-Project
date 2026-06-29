-- ============================================================
-- DATAPROJECT: LÓGICA CONSULTAS SQL
-- Base de datos: Sakila (PostgreSQL)
-- Herramienta: DBeaver
-- ============================================================


-- ======================================
/*  1. CREA EL ESQUEMA DE LA BBDD */
-- Para mostrar todas las tablas del esquema: 
SELECT table_name AS tabla
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- ==================================
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’ */
SELECT title AS titulo,
       rating AS clasificacion
FROM film
WHERE rating = 'R';

-- ======================================
/* 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40 */
SELECT first_name AS nombre,
       last_name  AS apellido,
       actor_id
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

-- ======================================
/* 4. Obtén las películas cuyo idioma coincide con el idioma original.*/
SELECT title AS titulo,
       language_id AS idioma,
       original_language_id AS "idioma original"
FROM film
WHERE language_id = original_language_id;
/*  Resultado: 0 filas, porque original_language_id es NULL para todas las películas 
(no hay películas marcadas como "versión doblada de otra"),  por lo que la condición nunca se cumple.*/
--Para comprobarlo hacemos lo siguiente: 
SELECT DISTINCT original_language_id 
FROM film;
-- ======================================
/* 5. Ordena las películas por duración de forma ascendente.*/
SELECT title  AS titulo,
       length AS "duracion minutos"
FROM film
ORDER BY length ASC;
-- ======================================
/* 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.*/
SELECT first_name AS nombre, 
	   last_name AS apellido
FROM actor
WHERE last_name = 'ALLEN';
-- ======================================
/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” 
y muestra la clasificación junto con el recuento.*/
SELECT rating AS clasificacion, 
		COUNT(*) AS cantidad
FROM film
GROUP BY rating
ORDER BY cantidad DESC;
-- ======================================
/* 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.*/
SELECT title AS titulo,
       rating AS clasificacion,
       length AS "duracion minutos"
FROM film
WHERE rating = 'PG-13' OR length > 180;
-- ======================================
/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.*/
SELECT ROUND(VARIANCE(replacement_cost)::NUMERIC, 2)  AS varianza,
       ROUND(STDDEV(replacement_cost)::NUMERIC, 2)    AS desviacion_estandar
FROM film;
-- ======================================
/* 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.*/
SELECT MAX(length) AS "duracion maxima",
       MIN(length) AS "duracion_minima"
FROM film;
-- ======================================
/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.*/
SELECT amount AS "coste del alquiler",
       payment_date AS "fecha de pago"
FROM payment
ORDER BY payment_date DESC
OFFSET 2
LIMIT 1;
-- ======================================
/* 12. Encuentra el título de las películas en la tabla “film” que no sean 
ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.*/
SELECT title AS "título",
       rating AS "clasificación"
FROM film
WHERE rating NOT IN ('NC-17', 'G');
-- ======================================
/* 13. Encuentra el promedio de duración de las películas para cada clasificación de 
la tabla film y muestra la clasificación junto con el promedio de duración.*/
SELECT rating AS "clasificacion",
       ROUND(AVG(length), 2) AS "promedio de duración"
FROM film
GROUP BY rating
ORDER BY "promedio de duración" DESC;

-- ======================================
/* 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.*/
SELECT title AS "titulo",
       length AS "duracion"
FROM film
WHERE length > 180
ORDER BY length ASC;
-- ======================================
/* 15. ¿Cuánto dinero ha generado en total la empresa?*/
SELECT SUM(amount) AS "ingresos totales"
FROM payment;
-- ======================================
/* 16. Muestra los 10 clientes con mayor valor de id.*/
SELECT customer_id AS "id del cliente",
       first_name AS "nombre",
       last_name AS "apellido"
FROM customer
ORDER BY customer_id DESC
LIMIT 10;
-- ======================================
/* 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.*/
SELECT a.first_name AS "nombre",
       a.last_name  AS "apellido"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f        ON fa.film_id = f.film_id
WHERE f.title = 'EGG IGBY';
-- ======================================
/* 18. Selecciona todos los nombres de las películas únicos.*/
SELECT DISTINCT title AS "título"
FROM film
ORDER BY title;
-- ======================================
/* 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.*/
SELECT f.title AS "título",
       f.length AS "duración (min)",
       c.name AS "categoría"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy'
  AND f.length > 180;
-- ======================================
/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior 
a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/
SELECT c.name AS "categoría",
       ROUND(AVG(f.length), 2) AS "promedio de duración"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110
ORDER BY "promedio de duración" DESC;
-- ======================================
/* 21. ¿Cuál es la media de duración del alquiler de las películas? */
SELECT ROUND(AVG(rental_duration), 2) AS "media de duración del alquiler"
FROM film;
-- ======================================
/* 22. Crea una columna con el nombre y apellidos de todos los actores y actrices. */
SELECT CONCAT(first_name, ' ', last_name) AS "nombre completo"
FROM actor;
-- ======================================
/* 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.*/
SELECT DATE(rental_date) AS "Dia",
       COUNT(*) AS "Cantidad de alquileres"
FROM rental
GROUP BY DATE(rental_date)
ORDER BY "Cantidad de alquileres" DESC;
-- ======================================
/* 24. Encuentra las películas con una duración superior al promedio.*/
SELECT title  AS "titulo",
       length AS "duracion"
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;
-- ======================================
/* 25. Averigua el número de alquileres registrados por mes.*/
SELECT TO_CHAR(rental_date, 'YYYY-MM') AS "mes",
       COUNT(*) AS "cantidad de alquileres"
FROM rental
GROUP BY TO_CHAR(rental_date, 'YYYY-MM')
ORDER BY "mes";
-- ======================================
/* 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.*/
SELECT ROUND(AVG(amount), 2) AS "promedio de pagos",
       ROUND(STDDEV(amount), 2) AS "desviacion estandar",
       ROUND(VARIANCE(amount), 2) AS "varianza"
FROM payment;
-- ======================================
/* 27. ¿Qué películas se alquilan por encima del precio medio? */
SELECT title AS "titulo",
       rental_rate AS "precio alquiler"
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC;
-- ======================================
/* 28. Muestra el id de los actores que hayan participado en más de 40 películas.*/
SELECT actor_id AS "id del actor",
       COUNT(film_id) AS "número de películas"
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40
ORDER BY "número de películas" DESC;
-- ======================================
/* 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.*/
SELECT f.title AS "titulo",
       COUNT(i.inventory_id) AS "unidades en inventario"
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY "unidades en inventario" DESC;
-- ======================================
/* 30. Obtener los actores y el número de películas en las que ha actuado.*/
SELECT a.actor_id AS "id del actor",
       a.first_name AS "nombre",
       a.last_name AS "apellido",
       COUNT(fa.film_id) AS "número de películas"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY "número de películas" DESC;
-- ======================================
/* 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados. */
SELECT f.title AS "titulo pelicula",
       a.first_name AS "nombre del actor",
       a.last_name AS "apellido del actor"
FROM film f
LEFT JOIN film_actor fa ON f.film_id   = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title;
-- ======================================
/* 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película. */
SELECT a.first_name AS "nombre del actor",
       a.last_name  AS "apellido del actor",
       f.title      AS "título"
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f        ON fa.film_id  = f.film_id
ORDER BY a.last_name, a.first_name;
-- ======================================
/* 33. Obtener todas las películas que tenemos y todos los registros de alquiler.*/
SELECT f.title AS "titulo",
       r.rental_date AS "fecha de alquiler",
       r.return_date AS "fecha de devolucion"
FROM film f
FULL OUTER JOIN inventory i ON f.film_id      = i.film_id
FULL OUTER JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title;
-- ======================================
/* 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.*/
SELECT c.customer_id AS "id del cliente",
       c.first_name AS "nombre",
       c.last_name AS "apellido",
       SUM(p.amount) AS "total gastado"
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "total gastado" DESC
LIMIT 5;
-- ======================================
/* 35. Selecciona todos los actores cuyo primer nombre es ' Johnny'.*/
SELECT first_name AS "nombre",
       last_name AS "apellido"
FROM actor
WHERE first_name = 'JOHNNY';
-- ======================================
/* 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.*/
SELECT first_name AS "Nombre",
       last_name  AS "Apellido"
FROM actor; 
-- ======================================
/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.*/
SELECT MIN(actor_id) AS "id min",
       MAX(actor_id) AS "id max"
FROM actor;
-- ======================================
/* 38. Cuenta cuántos actores hay en la tabla “actor”.*/
SELECT COUNT(*) AS "total de actores"
FROM actor;
-- ======================================
/* 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.*/
SELECT first_name AS "nombre",
       last_name  AS "apellido"
FROM actor
ORDER BY last_name ASC;
-- ======================================
/* 40. Selecciona las primeras 5 películas de la tabla “film”.*/
SELECT title AS "título"
FROM film
LIMIT 5;
-- ======================================
/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido? */
SELECT first_name        AS "nombre",
       COUNT(*) AS "cantidad de actores con ese nombre"
FROM actor
GROUP BY first_name
ORDER BY "cantidad de actores con ese nombre" DESC
LIMIT 1;

-- ======================================
/* 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron. */
SELECT r.rental_id AS "id del alquiler",
       r.rental_date AS "fecha de alquiler",
       c.first_name AS "nombre",
       c.last_name AS "apellido"
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY r.rental_date DESC;
-- ======================================
/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres. */
SELECT c.first_name AS "nombre",
       c.last_name AS "apellido",
       r.rental_id AS "id del alquiler",
       r.rental_date AS "fecha de alquiler"
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
ORDER BY c.last_name;
-- ======================================
/* 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación. */
SELECT f.title  AS "título",
       c.name   AS "categoría"
FROM film f
CROSS JOIN category c;
/*
 ¿APORTA VALOR ESTA CONSULTA?
 NO aporta valor real en este contexto.
 Un CROSS JOIN genera el producto cartesiano: todas las combinaciones
 posibles entre cada película y cada categoría, independientemente de si
 esa película pertenece a esa categoría. Para relacionarlas correctamente 
 habría que usar JOIN con film_category como tabla intermedia. */

-- ======================================
/* 45. Encuentra los actores que han participado en películas de la categoría 'Action'. */
SELECT DISTINCT a.first_name AS "nombre",
                a.last_name AS "apellido"
FROM actor a
JOIN film_actor fa  ON a.actor_id    = fa.actor_id
JOIN film f ON fa.film_id    = f.film_id
JOIN film_category fc ON f.film_id     = fc.film_id
JOIN category c  ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY a.last_name;

-- ======================================
/* 46. Encuentra todos los actores que no han participado en películas.*/
SELECT a.actor_id,
       a.first_name AS nombre,
       a.last_name  AS apellido
FROM actor      a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;
-- ======================================
/* 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.*/
SELECT a.first_name  AS "nombre",
       a.last_name  AS "apellido",
       COUNT(fa.film_id) AS "número de películas"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY "número de películas" DESC;
-- ======================================
/* 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.*/ 
CREATE VIEW actor_num_peliculas AS
SELECT a.first_name  AS "nombre",
       a.last_name  AS "apellido",
       COUNT(fa.film_id) AS "número de películas"
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY "número de películas" DESC;
-- Consulta de verificación:
SELECT * 
FROM actor_num_peliculas 
ORDER BY "número de películas" DESC;

-- ======================================
/* 49. Calcula el número total de alquileres realizados por cada cliente.*/
SELECT c.customer_id AS "id del cliente",
       c.first_name AS "nombre",
       c.last_name AS "apellido",
       COUNT(r.rental_id) AS "total de alquileres"
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "total de alquileres" DESC;
-- ======================================
/* 50. Calcula la duración total de las películas en la categoría 'Action'.*/
SELECT SUM(f.length) AS "duración total"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';
-- ======================================
/* 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.*/
CREATE TEMP TABLE "cliente_rentas_temporal" AS
SELECT c.customer_id       AS "id del cliente",
       c.first_name        AS "nombre",
       c.last_name         AS "apellido",
       COUNT(r.rental_id)  AS "total de alquileres"
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "total de alquileres" DESC;

--Consulta de verificación:
SELECT * FROM "cliente_rentas_temporal";
-- ======================================
/* 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.*/
CREATE TEMP TABLE "peliculas_alquiladas" AS
SELECT f.title          AS "título",
       COUNT(r.rental_id) AS "veces alquilada"
FROM film f
JOIN inventory i  ON f.film_id      = i.film_id
JOIN rental r     ON i.inventory_id = r.inventory_id
GROUP BY f.title
HAVING COUNT(r.rental_id) >= 10
ORDER BY "veces alquilada" DESC;
--Consulta de verificación:
SELECT * FROM "peliculas_alquiladas";
-- ======================================
/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/
SELECT f.title AS "título"
FROM film f
JOIN inventory i  ON f.film_id      = i.film_id
JOIN rental r     ON i.inventory_id = r.inventory_id
JOIN customer c   ON r.customer_id  = c.customer_id
WHERE c.first_name = 'TAMMY'
  AND c.last_name  = 'SANDERS'
  AND r.return_date IS NULL
ORDER BY f.title ASC;
-- ======================================
/*  54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.*/
SELECT DISTINCT a.first_name AS "nombre",
                a.last_name  AS "apellido"
FROM actor a
JOIN film_actor fa    ON a.actor_id     = fa.actor_id
JOIN film_category fc ON fa.film_id     = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name ASC;
-- ======================================
/* 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/
SELECT DISTINCT a.first_name AS "nombre",
                a.last_name  AS "apellido"
FROM actor a
JOIN film_actor fa ON a.actor_id    = fa.actor_id
JOIN film f  ON fa.film_id    = f.film_id
JOIN inventory i ON f.film_id     = i.film_id
JOIN rental r  ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM rental r2
    JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    JOIN film f2      ON i2.film_id       = f2.film_id
    WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name ASC;

-- ======================================
/*  56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’*/
SELECT a.first_name AS "nombre",
       a.last_name  AS "apellido"
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id     = fc.film_id
    JOIN category c       ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
)
ORDER BY a.last_name ASC;
-- ======================================
/* 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días. */
SELECT DISTINCT f.title AS "título"
FROM film f
JOIN inventory i ON f.film_id      = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE (r.return_date - r.rental_date) > INTERVAL '8 days'
ORDER BY f.title;
-- ======================================
/* 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’*/
SELECT f.title AS "título"
FROM film f
JOIN film_category fc ON f.film_id      = fc.film_id
WHERE fc.category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Animation'
)
ORDER BY f.title;
-- ======================================
/* 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película. */
SELECT title AS "título"
FROM film
WHERE length = (
    SELECT length
    FROM film
    WHERE title = 'DANCING FEVER'
)
  AND title != 'DANCING FEVER'
ORDER BY title ASC;
-- ======================================
/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/
SELECT c.first_name AS "nombre",
       c.last_name  AS "apellido",
       COUNT(DISTINCT i.film_id) AS "películas distintas alquiladas"
FROM customer c
JOIN rental r    ON c.customer_id  = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name ASC;
-- ======================================
/* 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/
SELECT c.name  AS "categoria",
       COUNT(r.rental_id) AS "total de alquileres"
FROM category c
JOIN film_category fc ON c.category_id  = fc.category_id
JOIN film f ON fc.film_id     = f.film_id
JOIN inventory i ON f.film_id      = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY "total de alquileres" DESC;
-- ======================================
/* 62. Encuentra el número de películas por categoría estrenadas en 2006. */
SELECT c.name        AS "categoria",
       COUNT(f.film_id) AS "películas en 2006"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id    = f.film_id
WHERE f.release_year = 2006
GROUP BY c.name
ORDER BY "películas en 2006" DESC;
-- ======================================
/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/
SELECT s.first_name AS "nombre del trabajador",
       s.last_name  AS "apellido del trabajador",
       st.store_id  AS "id de la tienda"
FROM staff s
CROSS JOIN store st;
-- ======================================
/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/
SELECT c.customer_id      AS "id del cliente",
       c.first_name       AS "nombre",
       c.last_name        AS "apellido",
       COUNT(r.rental_id) AS "total de películas alquiladas"
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "total de películas alquiladas" DESC;