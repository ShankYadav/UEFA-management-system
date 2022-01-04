\c soccer;

--SIMPLE QUERIES :-

--1st query
--Count the total number of countries from which the players are taking part in the tournament.

SELECT count(DISTINCT nationality) FROM player;

--2nd query
--List the Firstname, Lastname, Position and the Jersey numbers of the players who are from French nationality.

SELECT first_name, last_name, position, jersey_number FROM player
WHERE nationality = 'FRA';

--3rd query
--Display the Maximum and Minimum stadium capacities and their deviation from the Average capacity.

SELECT MAX(capacity),MIN(capacity),
(MAX(capacity)-AVG(capacity))::numeric(10,2) AS max_deviation, 
(AVG(capacity)-MIN(capacity))::numeric(10,2) AS min_deviation 
FROM stadium;

--4th query
--Display the number of sponsors who sponsored the amount greater than or equal to the average amount sponsored.

SELECT count(*) FROM sponsor 
WHERE 
sponsored_amount >= (SELECT AVG(sponsored_amount) FROM sponsor);

--5th query
-- Display the Firstname, Lastname, Experience and Team of managers who have more than or equal to 10 years of experience.

SELECT first_name, last_name, experience, name AS team_name FROM
( manager JOIN team ON manager.employee_id = team.employee_id )
WHERE experience >= 10;
 

--COMPLEX QUERIES :-
--1st query
--Display the team short forms along with the league and country they are from and also display their corresponding position in their league in a increasing order of position.

SELECT logo AS team_name, lname as league_name, country, position FROM
team JOIN league on team.lname = league.name
ORDER BY position;

--2nd query
--Display the winner of the matches which did not end in draw along with the date when the match occured and also display the referee/referees who monitered the match along with their employee_license and also display the staddium in which the match took place.

SELECT winner, date, first_name, last_name, license_id,stadium_name FROM
((match JOIN referee ON match.match_number=referee.match_number) JOIN stadium ON match.match_number = stadium.match_number) WHERE draw = 'N';

--3rd query
-- Displaying Firstname, Lastname, Nubmer of goals and the Team of a player who has scored more goals than the average number of goals scored by the Center Forwards ( CF ) of each team in an increasing order of goals.

SELECT first_name, last_name, goals, name AS team_name FROM player
WHERE
goals > (SELECT AVG ( goals ) FROM player WHERE position = 'CF')
ORDER BY goals;

--4th query
--Display the team which emerged as the winner of the tournament along with the total amount of sponsorship recieved by that team.

SELECT name AS tournament_winner, SUM(sponsored_amount) AS total_sponsorship FROM
sponsor JOIN sponsored ON sponsor.sponsor_name= sponsored.sponsor_name WHERE
name = (SELECT winner FROM tournament) 
GROUP BY name;



	





















