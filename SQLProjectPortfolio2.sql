SELECT * 
FROM ProjectPortfolio..CovidDeaths


SELECT * 
FROM ProjectPortfolio..CovidVaccines

--Looking at countries with the highest death percentage at a particular time--

SELECT Country, [Total Cases], [Total Deaths], [Death percentage]
FROM ProjectPortfolio..CovidDeaths
WHERE [Death percentage] > 5
ORDER BY Country;


--Looking at Total Cases vs Population--
--Showing what percentage of population is infected in African countries

SELECT Country, Population, Continent, [Total Cases], ([Total Cases]/ Population)*100 AS InfectionPercentage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
FROM ProjectPortfolio..CovidDeaths
WHERE Continent = 'Africa'
ORDER BY Country;



--Looking at Comtries with highest infection rate compared to population in Africa

SELECT Country, Population, Continent, MAX ([Total Cases]) AS HighestInfection, MAX(([Total Cases]/ Population))*100 AS HighestInfectionPercent                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
FROM ProjectPortfolio..CovidDeaths
WHERE Continent = 'Africa'
GROUP BY Continent, Country, Population
ORDER BY HighestInfectionPercent DESC;




--Looking at African countries with highest deaths per population

SELECT Country, Population, Continent, MAX ([Total Deaths]) AS HighestDeathRate, MAX(([Total Deaths]/ Population))*100 AS HighestDeathRatePercent                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
FROM ProjectPortfolio..CovidDeaths
WHERE Continent = 'Africa'
GROUP BY Continent, Country, Population
ORDER BY HighestDeathRatePercent desc;


--Joining Deaths table and Vaccines table

SELECT *
FROM ProjectPortfolio..CovidDeaths d
JOIN ProjectPortfolio..CovidVaccines v
ON d.Country = v.Country;




--Looking at the vaccination rate in African coutries

SELECT d.Continent, d.Country, d.Population, v.Country, v.[Total doses administered], (v.[Total doses administered]/d.Population) AS TotalVaccinesperPopulaition
FROM ProjectPortfolio..CovidDeaths d
JOIN ProjectPortfolio..CovidVaccines v
ON d.Country = v.Country
WHERE  (d.Continent = ('Africa'))
ORDER BY TotalVaccinesperPopulaition DESC;
