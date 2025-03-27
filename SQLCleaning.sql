-- Standardize Date Format

Select saleDate, CONVERT(Date,SaleDate)
From CleaningSQL.dbo.NashvilleHousing

Update CleaningSQL.dbo.NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data
Select *
From CleaningSQL.dbo.NashvilleHousing
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From CleaningSQL.dbo.NashvilleHousing a
JOIN CleaningSQL.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From CleaningSQL.dbo.NashvilleHousing a
JOIN CleaningSQL.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From CleaningSQL.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
From CleaningSQL.dbo.NashvilleHousing


ALTER TABLE CleaningSQL.dbo.NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update CleaningSQL.dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )



ALTER TABLE CleaningSQL.dbo.NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update CleaningSQL.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))





Select OwnerAddress
From CleaningSQL.dbo.NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From CleaningSQL.dbo.NashvilleHousing



ALTER TABLE CleaningSQL.dbo.NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update CleaningSQL.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE CleaningSQL.dbo.NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update CleaningSQL.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE CleaningSQL.dbo.NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update CleaningSQL.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



Select *
From CleaningSQL.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From CleaningSQL.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From CleaningSQL.dbo.NashvilleHousing


Update NashvilleHousing
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

From CleaningSQL.dbo.NashvilleHousing
--order by ParcelID
)
SELECT *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

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

From CleaningSQL.dbo.NashvilleHousing
--order by ParcelID
)
DELETE
From RowNumCTE
Where row_num > 1



---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

DELETE FROM CleaningSQL.dbo.NashvilleHousing
WHERE SaleDate IN ('2019-05-16', '2019-12-13');



-- Delete Unused Columns


ALTER TABLE CleaningSQL.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress, LegalReference















-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS CleaningSQL.dbo.NashvilleHousing_Cleaned;
SELECT * 
INTO CleaningSQL.dbo.NashvilleHousing_Cleaned
FROM CleaningSQL.dbo.NashvilleHousing;



SELECT * FROM CleaningSQL.dbo.NashvilleHousing;


--- Importing Data using OPENROWSET and BULK INSERT	

sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO


USE CleaningSQL 

GO 

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

GO 

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

GO 


---- Using BULK INSERT

USE CleaningSQL;
GO
BULK INSERT dbo.NashvilleHousing FROM 'C:\Users\SAMI\Nashville_Cleaned.csv'
   WITH (
      FIELDTERMINATOR = ',',
      ROWTERMINATOR = '\n'
);
GO	

















