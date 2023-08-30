
Select *
From PortfolioProject..[covid-death]
Where continent is not null
Order by 3,4


Select *
From PortfolioProject..[covid-Vaccination]
Order by 3,4

Select Location,date, new_cases, total_deaths,(new_cases/total_deaths)*100 as DeathPercentage
From PortfolioProject..[covid-death]
Where location like '%States&'
Order by 1,2

Select Location,date, new_cases,Population,(new_cases/population)*100 as DeathPercentage
From PortfolioProject..[covid-death]
Where location like '%SAsia&'
Order by 1,2

Select Location,date,Population,MAX(new_cases) as HighestInfectionCount, Max((New_cases/population))*100 as DeathPercentage
From PortfolioProject..[covid-death]
--Where location like '%SAsia&'
Group by location, population
Order by PercentPopulationInfected desc

Select Location, MAX(Total_deaths) as TotalDeathCount
From PortfolioProject..[covid-death]
--Where location like '%SAsia&'
Where continent is not null
Group by location
Order by TotalDeathCount desc

Select location, MAX(Total_deaths) as TotalDeathCount
From PortfolioProject..[covid-death]
--Where location like '%SAsia&'
Where continent is null
Group by location
Order by TotalDeathCount desc

Select date, SUM new_cases; as (new_deaths as int)/SUM as new_deaths as int))/SUM
	SUM AS new_cases))*100 as DeathPercentage
From PortfolioProject..[covid-death]
--Where location like '%SAsia&'
Where continent is not null
--Group by date
Order by 1, 2

Select dea.continent, dea.location, dea.date, dea.population, vac.

From PortfolioProject..[covid-death] dea
Join PortfolioProject..[covid-Vaccination] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

with PopvsVac (continent, location, Date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated)
--, ( RollingPeopleVaccinated/population)*100
From PortfolioProject..[covid-death] dea
Join PortfolioProject..[covid-Vaccination] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3
)
Select*,
from PopvsVac