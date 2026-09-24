--ES 1

SELECT DISTINCT Region
FROM world.country
WHERE Continent = 'Europe';


--ES 2

SELECT Name, Population
FROM world.city
WHERE CountryCode = 'USA'
AND Population > 1000000
ORDER BY Population DESC;

--ES 3

SELECT Continent,
       COUNT(*) AS NumeroPaesi,
       SUM(Population) AS PopolazioneTotale
FROM world.country
GROUP BY Continent
ORDER BY PopolazioneTotale DESC;
