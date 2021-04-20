-- Interrogations avancées
-- 1. Afficher tout les emprunt ayant été réalisé en 2006. Le mois doit être écrit en toute lettre et le résultat doit s’afficher dans une seul colonne.
SELECT rental_id, date_format(rental_date, "%Y-%M-%d %H:%i:%s") FROM sakila.rental where rental_date like '2006%';

-- 2. Afficher la colonne qui donne la durée de location des films en jour
select datediff(rental_date, return_date)
from rental;

-- 3. Afficher les emprunts réalisés avant 1h du matin en 2005. Afficher la date dans un format lisible.
SELECT * FROM sakila.rental 
where rental_date like '2005%' 
and hour(rental_date) <1;

-- 4. Afficher les emprunts réalisé entre le mois d’avril et le moi de mai. La liste doit être trié du plus ancien au plus récent.
select * from rental 
where month(rental_date) in (4, 5);

-- 5. Lister les film dont le nom ne commence pas par le « Le ».
select * from film
where title like 'Le%';

-- 6. Lister les films ayant la mention « PG-13 » ou « NC-17 ». Ajouter une colonne qui affichera « oui » si « NC-17 » et « non » Sinon.
select * from film
where rating in("PG-13","NC-17");

-- 7. Fournir la liste des catégorie qui commence par un ‘A’ ou un ‘C’. (Utiliser LEFT)
select * from category
where left(name, 1) in('A', 'C');

-- 8. Lister les trois premiers caractères des noms des catégorie.
select left(name, 3) from category;

-- 9. Lister les premiers acteurs en remplaçant dans leur prenom les E par des A.
select replace(first_name, 'E', 'A') from actor limit 10;

-- Les jointures
-- 1. Lister les 10 premiers films ainsi que leur langues.
Select * from film
inner join language on film.language_id=language.language_id
limit 10 ;

-- 2. Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.
Select * from film
inner join film_actor on film.film_id=film_actor.film_id
inner join actor on actor.actor_id=film_actor.actor_id
where actor.first_name="JENNIFER" and actor.last_name="DAVIS" and release_year=2006;

-- 3. Afficher le noms des client ayant emprunté « ALABAMA DEVIL ».
select * from customer
inner join rental on rental.customer_id=customer.customer_id
inner join inventory on inventory.inventory_id=rental.inventory_id
inner join film on film.film_id=inventory.film_id
where title="ALABAMA DEVIL";

-- 4. Afficher les films louer par des personne habitant à « Woodridge ». Vérifié s’il y a des films qui n’ont jamais été emprunté.
select * from customer
inner join rental on rental.customer_id=customer.customer_id
inner join inventory on inventory.inventory_id=rental.inventory_id
inner join film on film.film_id=inventory.film_id
inner join address on address.address_id=customer.address_id
inner join city on address.city_id=city.city_id
where city="Woodridge";

-- 5. Quel sont les 10 films dont la durée d’emprunt à été la plus courte ?
select title, sum(datediff(rental_date, return_date)) as rentdur from film
join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
group by title
limit 10;

-- 6. Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.
select * from film
join film_category on film_category.film_id=film.film_id
join category on category.category_id=film_category.category_id
where name="Action";

-- 7. Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?
select * from film
join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
where (datediff(rental_date, return_date))<2;