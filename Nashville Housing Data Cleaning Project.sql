/* Cleaning Data in SQL Queries */


Select *
From portfolio.dbo.nashvillehousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select saleDateConverted, CONVERT(Date,SaleDate)
From portfolio.dbo.nashvillehousing


Update portfolio.dbo.nashvillehousing
SET saleDateConverted = CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update portfolio.dbo.nashvillehousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select * 
FROM  portfolio.dbo.nashvillehousing
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From portfolio.dbo.nashvillehousing a
JOIN portfolio.dbo.nashvillehousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From portfolio.dbo.nashvillehousing a
JOIN portfolio.dbo.nashvillehousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- Breaking out PropertyAddress into Individual Columns (Address, City)


Select PropertyAddress
From portfolio.dbo.nashvillehousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as City
From portfolio.dbo.nashvillehousing


ALTER TABLE portfolio.dbo.nashvillehousing
Add PropertySplitAddress Nvarchar(255);

Update portfolio.dbo.nashvillehousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE portfolio.dbo.nashvillehousing
Add PropertySplitCity Nvarchar(255);

Update portfolio.dbo.nashvillehousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))




Select *
From portfolio.dbo.nashvillehousing
-------------------------------------------------------------------------------------------------------------------



--Spliting OwnerAddress

Select OwnerAddress
From portfolio.dbo.nashvillehousing


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From portfolio.dbo.nashvillehousing



ALTER TABLE portfolio.dbo.nashvillehousing
Add OwnerSplitAddress Nvarchar(255);

Update portfolio.dbo.nashvillehousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE portfolio.dbo.nashvillehousing
Add OwnerSplitCity Nvarchar(255);

Update portfolio.dbo.nashvillehousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE portfolio.dbo.nashvillehousing
Add OwnerSplitState Nvarchar(255);

Update portfolio.dbo.nashvillehousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From Portfolio.dbo.nashvillehousing




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From portfolio.dbo.nashvillehousing
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From portfolio.dbo.nashvillehousing


Update portfolio.dbo.nashvillehousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Portfolio.dbo.NashvilleHousing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From portfolio.dbo.nashvillehousing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From Portfolio.dbo.nashvillehousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

------------------------------------------------------------------------------------------------------------