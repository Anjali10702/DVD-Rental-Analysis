# DVD-Rental-Analysis 
The queries performed on the DVD Rental database provide a comprehensive analysis of data completeness, identifying gaps in categorization, rentals, and staff involvement. These insights can be useful for enhancing customer engagement, improving the data integrity of the system, and optimizing business operations.

**Select All Columns from the Film Table**

SELECT * FROM film;

**Select Specific Columns (Title and Release Year)**

SELECT title, release_year FROM film;

**Find films with a rental rate less than 3:**
 
SELECT title, rental_rate FROM film WHERE rental_rate < 3;

**Find films with a rental rate between 2 and 4:**
 
SELECT title, rental_rate FROM film WHERE rental_rate BETWEEN 2 AND 4;

**Sort Films Alphabetically by Title**

SELECT title FROM film ORDER BY title;

**Get the Top 10 Most Expensive Films by Rental Rate**

SELECT title, rental_rate FROM film ORDER BY rental_rate DESC LIMIT 10;

**Count Total Number of Films**

SELECT COUNT(*) AS total_films FROM film;

##Aggregate Functions on Film Table

**Find the average rental rate of all films:**
 
SELECT AVG(rental_rate) AS average_rental_rate FROM film;

**Find the maximum replacement cost of all films:**
 
  
SELECT MAX(replacement_cost) AS max_replacement_cost FROM film;

**Count films per rating:**
 
SELECT rating, COUNT(*) AS film_count FROM film GROUP BY rating;

**Find the average length of films per rating:**
 
  
SELECT rating, AVG(length) AS average_length FROM film GROUP BY rating;

##Filter with LIKE Pattern Matching

**Find all films with titles starting with "A":**
 
SELECT title FROM film WHERE title LIKE 'A%';

**Find films with "love" in the title (case-insensitive):**
 
SELECT title FROM film WHERE title ILIKE '%love%';

##Using WHERE with IN Clause

**Find films with specific ratings (e.g., 'PG' and 'R'):**
 
SELECT title, rating FROM film WHERE rating IN ('PG', 'R');

**Calculate the Total Replacement Cost by Category**

SELECT category_id, SUM(replacement_cost) AS total_replacement_cost
FROM film
GROUP BY category_id;

##Using CASE Statements

**Label films as "Cheap" if the rental rate is less than 2, and "Expensive" otherwise:**
 
SELECT title, rental_rate,
  CASE
    WHEN rental_rate < 2 THEN 'Cheap'
    ELSE 'Expensive'
  END AS price_category
FROM film;


##Using Subqueries

**Find films with a rental rate greater than the average rental rate:**
   
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);
Using Window Functions

**Calculate the cumulative total replacement cost ordered by film title:**
  
SELECT title, replacement_cost,
  SUM(replacement_cost) OVER (ORDER BY title) AS cumulative_replacement_cost
FROM film;

**Rank films by rental rate within each rating category:**
 
SELECT title, rating, rental_rate,
  RANK() OVER (PARTITION BY rating ORDER BY rental_rate DESC) AS rental_rank
FROM film;
Common Table Expressions (CTEs)

**Find the top 5 most rented films (assuming a rental_count column):**
 
  
WITH top_rented_films AS (
  SELECT film_id, title, rental_count
  FROM film
  ORDER BY rental_count DESC
  LIMIT 5
)
SELECT * FROM top_rented_films;

##Advanced Aggregate with ROLLUP

**Generate a summary of rental rates by rating, with a grand total:**
 
  
SELECT rating, SUM(rental_rate) AS total_rental_rate
FROM film
GROUP BY ROLLUP(rating);
Pivoting Data (Film Counts by Rating)

**Show a pivot table where rows are rating values and columns show the count of films for each rental duration range:**
 
  
SELECT
  rating,
  COUNT(CASE WHEN rental_duration = 3 THEN 1 END) AS rental_3_days,
  COUNT(CASE WHEN rental_duration = 5 THEN 1 END) AS rental_5_days,
  COUNT(CASE WHEN rental_duration = 7 THEN 1 END) AS rental_7_days
FROM film
GROUP BY rating;
