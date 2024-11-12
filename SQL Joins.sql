List All Films and Their Categories

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
List Top 5 Most Frequently Rented Films and Their Rental Counts

 
 
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 5;
List Each Customer's Most Frequently Rented Category

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
Find All Customers Who Have Rented Films in Multiple Categories

 
 
SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(DISTINCT category.category_id) AS category_count
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT category.category_id) > 1;
List All Films That Were Rented by Each Staff Member

 
 
SELECT staff.first_name AS staff_name, film.title
FROM staff
JOIN rental ON staff.staff_id = rental.staff_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
ORDER BY staff.first_name, film.title;
Find the Total Revenue by Film Category

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











