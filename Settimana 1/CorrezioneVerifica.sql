-- Conta quante città del database world hanno una popolazione compresa tra 500.000 e 1.000.000 di abitanti e mostra solo quelle appartenenti all’Italia in ordine ascendente.

SELECT COUNT(*)
FROM world.city
WHERE Population BETWEEN 500000 AND 1000000
AND CountryCode = 'ITA'
ORDER BY Population ASC;

-- Sul database world conta il numero totale delle nazioni presenti e calcola la somma totale della loro popolazione.

SELECT COUNT(*) AS TotaleNazioni,
       SUM(Population) AS PopolazioneTotale
FROM country;

-- Conta quante nazioni appartengono ai continenti Asia, North America e South America e raggruppale in base alla loro forma di governo.

SELECT Continent, GovernmentForm, COUNT(*)
FROM country
WHERE Continent = 'Asia'
   OR Continent = 'North America'
   OR Continent = 'South America'
GROUP BY Continent, GovernmentForm;
