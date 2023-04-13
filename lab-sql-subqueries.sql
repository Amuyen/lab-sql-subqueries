use sakila;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
select count(*) as copies from inventory 
where film_id IN (
		SELECT film_id FROM film
        WHERE title="Hunchback Impossible");

-- List all films whose length is longer than the average of all the films.
select title, length from film f
WHERE length > (select avg(length) as average from film);


SELECT concat(first_name,' ',last_name) as 'Actors in "Alone Trip"' from actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
    WHERE film_id IN (
		SELECT film_id FROM film 
        WHERE TITLE ='Alone Trip'));


-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title AS 'Family Movies' FROM film 
WHERE film_id IN (
	SELECT	film_id FROM film_category
    WHERE category_id IN (
		SELECT category_id FROM category
        WHERE name='Family'));
        
-- Get name and email from customers from Canada using subqueries. 

SELECT concat(first_name,' ',last_name) as name, email FROM customer
WHERE address_id IN (
	SELECT address_id from address
		where city_id IN (
			SELECT city_id FROM city 
            WHERE country_id IN (
				SELECT country_id FROM country
                WHERE country='Canada')));


-- Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT concat(c.first_name,' ',c.last_name) as name, email FROM customer c
JOIN address a
ON c.address_id=a.address_id
JOIN city ci
ON a.city_id=ci.city_id
JOIN country co
ON ci.country_id=co.country_id
WHERE co.country="Canada";

-- Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor that has acted in the most number of films
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT f.Title FROM Film f
join film_actor fa
on f.film_id=fa.film_id
join (SELECT actor_id, count(*) as count from film_actor 
    GROUP BY actor_id order by count desc limit 1) a
on fa.actor_id=a.actor_id
    
    
