**List All Films and Their Categories**

 Using the film and category tables.
 
SELECT film.title, category.name AS category_name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id;
List All Films and Their Actors

Using the film, film_actor, and actor tables.
 
 
SELECT film.title, actor.first_name, actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id;
List Customers and Their Addresses

Using the customer and address tables.
 
 
SELECT customer.first_name, customer.last_name, address.address, address.city_id
FROM customer
JOIN address ON customer.address_id = address.address_id;
List All Rentals with Customer and Film Information

Using the rental, customer, and inventory tables.
 
 
SELECT rental.rental_date, customer.first_name, customer.last_name, film.title
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;
Intermediate JOIN Queries
List Each Film and Its Total Number of Rentals

Using film and rental tables through inventory.
 
 
SELECT film.title, COUNT(rental.rental_id) AS total_rentals
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY total_rentals DESC;
List Customers and Their City

Using customer, address, and city tables.
 
 
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;
List Actors Who Have Appeared in More Than 10 Films

Using actor, film_actor, and film tables.
 
 
SELECT actor.first_name, actor.last_name, COUNT(film.film_id) AS film_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id
HAVING COUNT(film.film_id) > 10;
List All Customers Who Rented a Specific Movie (e.g., "Academy Dinosaur")

Using customer, rental, inventory, and film tables.
 
 
SELECT customer.first_name, customer.last_name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Academy Dinosaur';
List Staff Members and Their Stores

Using staff, store, and address tables.
 
 
SELECT staff.first_name AS staff_first_name, staff.last_name AS staff_last_name, store.store_id, address.address
FROM staff
JOIN store ON staff.store_id = store.store_id
JOIN address ON store.address_id = address.address_id;
Advanced JOIN Queries

 
**List Top 5 Most Frequently Rented Films and Their Rental Counts**

 
 
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;


**List Each Customer's Most Frequently Rented Category**

Using customer, rental, inventory, film, film_category, and category tables.
 
 
SELECT customer.first_name, customer.last_name, category.name AS favorite_category, COUNT(rental.rental_id) AS rental_count
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY customer.customer_id, category.category_id
ORDER BY rental_count DESC;

 
**Find All Customers Who Have Rented Films in Multiple Categories**

 
 
SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(DISTINCT category.category_id) AS category_count
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT category.category_id) > 1;

 
**List All Films That Were Rented by Each Staff Member**

SELECT staff.first_name AS staff_name, film.title
FROM staff
JOIN rental ON staff.staff_id = rental.staff_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
ORDER BY staff.first_name, film.title;

 
**Find the Total Revenue by Film Category**

Using payment, rental, inventory, film, film_category, and category tables.
 
 
SELECT category.name AS category_name, SUM(payment.amount) AS total_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_revenue DESC;


 ____LEFT JOIN Queries___
 
**List All Films and Their Categories, Including Films Without a Category**

SELECT film.title, category.name AS category_name
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id;

 
**List All Customers and Their Last Rental, Including Customers Who Have Not Rented**

SELECT customer.first_name, customer.last_name, rental.rental_date
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
ORDER BY customer.last_name, customer.first_name;

 
**List All Categories and the Films in Each, Including Categories with No Films**

SELECT category.name AS category_name, film.title AS film_title
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN film ON film_category.film_id = film.film_id
ORDER BY category_name;
 
**List All Staff Members and Their Rental Transactions, Including Staff Members with No Rentals**

SELECT staff.first_name AS staff_first_name, staff.last_name AS staff_last_name, rental.rental_date
FROM staff
LEFT JOIN rental ON staff.staff_id = rental.staff_id
ORDER BY staff_first_name, staff_last_name;

 
**List All Films and Their Actors, Including Films Without Any Actors**

SELECT film.title AS film_title, actor.first_name AS actor_first_name, actor.last_name AS actor_last_name
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY film_title;
 
____RIGHT JOIN Queries____
 
**List All Films with Their Rental Information, Including Rentals Without a Film Entry**

SELECT rental.rental_id, rental.rental_date, film.title
FROM rental
RIGHT JOIN inventory ON rental.inventory_id = inventory.inventory_id
RIGHT JOIN film ON inventory.film_id = film.film_id;
 
**List All Customers and Their City Information, Including Orphaned Addresses**

SELECT customer.first_name, customer.last_name, address.address, city.city
FROM customer
RIGHT JOIN address ON customer.address_id = address.address_id
RIGHT JOIN city ON address.city_id = city.city_id;
 
**List All Categories and the Films in Each, Including Categories without Films (Reverse of LEFT JOIN)**

SELECT category.name AS category_name, film.title AS film_title
FROM film
RIGHT JOIN film_category ON film.film_id = film_category.film_id
RIGHT JOIN category ON film_category.category_id = category.category_id;
 
**List All Cities and Their Customers, Including Cities with No Customers**

SELECT city.city, customer.first_name, customer.last_name
FROM city
RIGHT JOIN address ON city.city_id = address.city_id
RIGHT JOIN customer ON address.address_id = customer.address_id;
 
**List All Actors and Their Films, Including Actors without Films**

SELECT actor.first_name, actor.last_name, film.title
FROM actor
RIGHT JOIN film_actor ON actor.actor_id = film_actor.actor_id
RIGHT JOIN film ON film_actor.film_id = film.film_id;

 
__Using LEFT JOIN and RIGHT JOIN in Combination___

 
Sometimes you may want to use both LEFT JOIN and RIGHT JOIN together to cover all records across multiple tables. Here’s an example:

**List All Films, Categories, and Actors, Including Films with No Category or Actors and Categories without Films**

SELECT film.title AS film_title, category.name AS category_name, actor.first_name AS actor_first_name, actor.last_name AS actor_last_name
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id 
UNION
SELECT NULL, category.name AS category_name, NULL, NULL
FROM category
RIGHT JOIN film_category ON category.category_id = film_category.category_id
WHERE film_category.film_id IS NULL;

___ IS NULL Queries___

 handles missing values

 
**List All Customers with No Assigned Address**

SELECT first_name, last_name
FROM customer
WHERE address_id IS NULL;

 
**List All Films Without a Category**

SELECT title
FROM film
WHERE film_id NOT IN (SELECT film_id FROM film_category);

 
**List All Rentals Where Return Date is Not Recorded (Ongoing Rentals)**


SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
 
**List All Payments with No Staff Member Assigned**

SELECT payment_id, amount, payment_date
FROM payment
WHERE staff_id IS NULL;
 
**List All Inventory Items Without a Film**


SELECT inventory_id, store_id
FROM inventory
WHERE film_id IS NULL;

 
___ IS NULL Queries with Joins___
 
List All Customers Who Have Not Made Any Rentals

SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
WHERE rental.rental_id IS NULL;

 
**List All Films That Have Never Been Rented**
 
SELECT film.title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;

 
**List All Staff Members Who Haven’t Processed Any Rentals**


SELECT staff.staff_id, staff.first_name, staff.last_name
FROM staff
LEFT JOIN rental ON staff.staff_id = rental.staff_id
WHERE rental.rental_id IS NULL;
 
**List All Films Without Any Actors Assigned**

SELECT film.title
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;
 
**List All Categories Without Any Films**


SELECT category.name
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
WHERE film_category.film_id IS NULL;

 
__Combining IS NULL with Other Conditions__
 
**List All Rentals Without a Return Date and Rented in the Last Month**

SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL
  AND rental_date >= NOW() - INTERVAL '1 month';
 
**List All Films Without a Category and With a Rental Rate Above $2.99**


SELECT title, rental_rate
FROM film
WHERE film_id NOT IN (SELECT film_id FROM film_category)
  AND rental_rate > 2.99;











