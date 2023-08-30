

--(learning Data in SQL Queries

Select *
From PortfolioProject.dbo.Nashvillehousing

--Standard date format

Select SaleDateConverted,CONVERT(Date,SaleDate)
From PortfolioProject.dbo.Nashvillehousing

UPDATE PortfolioProject.dbo.Nashvillehousing
SET SaleDate =  CONVERT(Date,SaleDate)

ALTER TABLE PortfolioProject.dbo.Nashvillehousing
Add SaleDateConverted Date

UPDATE Nashvillehousing
SET SaleDateConverted =  CONVERT(Date,SaleDate)

--Populate Property Address date

Select *
From PortfolioProject.dbo.Nashvillehousing
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.Propertyaddress, ISNULL (a.PropertyAddress,b.Propertyaddress)
From PortfolioProject.dbo.Nashvillehousing a
join PortfolioProject.dbo.Nashvillehousing b
	on a.ParcelID = b. ParcelID
	AND a. [uniqueID] <> b.[uniqueID] 
where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL (a.PropertyAddress,b.Propertyaddress)
From PortfolioProject.dbo.Nashvillehousing a
join PortfolioProject.dbo.Nashvillehousing b
	on a.ParcelID = b. ParcelID
	AND a. [uniqueID] <> b.[uniqueID] 



--breaking out address into individual columns (Address, city, state)

Select PropertyAddress
From PortfolioProject.dbo.Nashvillehousing
--Where PropertyAddress is null
--order by ParcelID

SELECt
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1), LEN(PropertAddress)) as Address

From PortfolioProject.dbo.Nashvillehousing


ALTER TABLE PortfolioProject.dbo.Nashvillehousing
Add PropertySplitAddress Nvarchar(255)

UPDATE PortfolioProject.dbo.Nashvillehousing
SET  PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)



ALTER TABLE PortfolioProject.dbo.Nashvillehousing
Add PropertySplitCity Nvarchar(255)

UPDATE PortfolioProject.dbo.Nashvillehousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1), LEN(PropertAddress)



select *
From PortfolioProject.dbo.Nashvillehousing



Select OwnerAddress
From PortfolioProject.dbo.Nashvillehousing

Select
PARSENAME(REPLACE (OwnerAddress,  ',', '.') ,3)
,PARSENAME(REPLACE (OwnerAddress, ',', '.') ,2)
,PARSENAME(REPLACE (OwnerAddress, ',', '.') ,1)
From PortfolioProject.dbo.Nashvillehousing


ALTER TABLE PortfolioProject.dbo.Nashvillehousing
Add OwnerSplitAddress Nvarchar(255)

UPDATE PortfolioProject.dbo.Nashvillehousing
SET  OwnerSplitAddress = PARSENAME(REPLACE (OwnerAddress,  ',', '.') ,3)




ALTER TABLE PortfolioProject.dbo.Nashvillehousing
Add OwnerSplitCity Nvarchar(255)

UPDATE PortfolioProject.dbo.Nashvillehousing
SET OwnerSplitCity = PARSENAME(REPLACE (OwnerAddress, ',', '.') ,2)

ALTER TABLE PortfolioProject.dbo.Nashvillehousing
Add OwnerSplitState Nvarchar(255)

UPDATE PortfolioProject.dbo.Nashvillehousing
SET OwnerSplitState = PARSENAME(REPLACE (OwnerAddress, ',', '.') ,1)


select *
From PortfolioProject.dbo.Nashvillehousing



--change Y and N to yes and no in "Sold as Vacant"

Select Distinct(SoldasVacant), Count(SoldasVacant)
From PortfolioProject.dbo.Nashvillehousing
Group by SoldasVacant
order by 2


Select SoldasVacant
, CASE when SoldasVacant = 'Y' THEN 'Yes'
	   when SoldasVAcant = 'N' THEN 'No'
	   ELSE SoldasVacant
	   END
From PortfolioProject.dbo.Nashvillehousing


UPDATE PortfolioProject.dbo.Nashvillehousing
SET Soldasvacant = CASE when SoldasVacant = 'Y' THEN 'Yes'
	   when SoldasVAcant = 'N' THEN 'No'
	   ELSE SoldasVacant
	   END

--Remove Duplicate

WITH Row_NumCTE AS(
Select*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.Nashvillehousing
--order by ParcelID
)
Select*
From Row_NumCTE
where row_num >1
--Order by PropertyAddress



--Delete Unused Columns


Select*
From PortfolioProject.dbo.Nashvillehousing

ALTER TABLE PortfolioProject.dbo.Nashvillehousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject.dbo.Nashvillehousing
DROP COLUMN SaleDate


