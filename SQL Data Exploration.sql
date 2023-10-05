--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

SELECT *
FROM PortfolioProject..CovidDeaths
where continent is not null  
ORDER BY 3,4


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
where continent is not null  
ORDER BY 1,2

--Looking at Total cases vs Total Deaths

select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
and continent is not null  
order by 1,2 

-- Looking  at Total Case vs Population
-- shows what percentage of population got covid

select Location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
-- where location like '%states%'
order by 1,2 

-- Looking at Countries with Highest Infection Rate compared to Populations

select Location, population, MAX (total_cases) as HighestInfectionCount, Max (total_cases/population)* 100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
-- where location like '%states%'
Group by Location, population 
order by PercentagePopulationInfected desc

--Showing Countries with HIghest Death Count per population

select Location, MAX(cast(total_deaths as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
-- where location like '%states%'
where continent is not null  
Group by location
order by TotalDeathCount desc

-- BREAK THINGS DWON BY CONTINENT



-- showing continents with the highest death count per population

select continent, MAX(cast(total_deaths as int))as TotalDeathCount
from PortfolioProject..CovidDeaths
-- where location like '%states%'
where continent is not null  
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBER

select date, SUM(new_cases) as total_case, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/ SUM (new_cases)* 100 as DeathPercentage
from PortfolioProject..CovidDeaths
-- where location like '%states%'
where continent is not null  
Group by date
order by 1,2 

-- TOTAL CASES AND TOTAL DEATHS ACROSS THE WORLD

select SUM(new_cases) as total_case, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/ SUM (new_cases)* 100 as DeathPercentage
from PortfolioProject..CovidDeaths
-- where location like '%states%'
where continent is not null  
-- Group by date
order by 1,2 


-- Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date)

from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
     on dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null 
order by 2,3



-- USE CTE

with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinationed)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date)
as RollingPeopleVacinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
     on dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null 
-- order by 2,3

)
select *
from PopvsVac


-- TEMP TABLE

DROP Table if exists  #PercentPopulationVaccinated
create Table #PercentPopulationVaccinated
(
continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date)
as RollingPeopleVacinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
     on dea.location = vac.location
	 and dea.date = vac.date
--where dea.continent is not null 
-- order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


-- Creating View to store data for visualizations

create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.Date)
as RollingPeopleVacinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
     on dea.location = vac.location
	 and dea.date = vac.date
--where dea.continent is not null 
-- order by 2,3

select *
from PercentPopulationVaccinated