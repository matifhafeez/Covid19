use Portfolio
--***Total Cases Vs Total Deaths***

--***Likelihood of dying***
select A.location,
A.date
,A.total_cases
,A.total_deaths
,(A.total_deaths/A.total_cases)*100 as [DeathPercentage]
from CovidDeaths A
order by A.location,A.date

--***Total cases vs population for Pakistan***
select A.location,
A.date
,A.total_cases
,A.population
,(A.total_cases/A.population)*100 as [InfectionPercentage]
from CovidDeaths A
where A.location like '%Pakistan%'
order by A.location,A.date

--***Highest infection rate compared to population***
select A.location
,A.population
,MAX((A.total_cases/A.population)*100) as [InfectionPercentage]
from CovidDeaths A
where A.continent is not null
group by A.location,A.population
order by [InfectionPercentage] desc

--***Highest death count per population***
select A.location
,A.population
,MAX(cast(A.total_deaths as int)) as [Total Deaths]
from CovidDeaths A
where A.continent is not null
group by A.location,A.population
order by [Total Deaths] desc

--***Total Jabs Administered till date 7th Jan 2022***
;with A as
(select D.continent, D.location, D.date, D.population, V.new_vaccinations,
sum(cast(V.new_vaccinations as bigint)) over(partition by D.location order by D.location, D.date) as [Running Total]
from CovidVaccinations V
inner join CovidDeaths D on D.location = V.location
and D.date = V.date
where D.continent is not null
--and D.location like '%Pakistan%'
) 
select A.location
,MAX(A.[Running Total]) as [Total Jabs Till Date]
from A
group by A.location




















