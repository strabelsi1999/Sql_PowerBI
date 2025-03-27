SELECT * FROM NashvilleHousing_Cleaned

SELECT 
    SaleDate,
    COUNT(*) AS TotalSales,
    SUM(SalePrice) AS TotalRevenue,
    AVG(SalePrice) AS AvgSalePrice
FROM CleaningSQL.dbo.NashvilleHousing_Cleaned
WHERE SalePrice > 0 -- Ignore missing/incorrect data
GROUP BY SaleDate
ORDER BY SaleDate;


SELECT 
    LandUse, COUNT(*) AS PropertyCount
FROM CleaningSQL.dbo.NashvilleHousing_Cleaned
GROUP BY LandUse
ORDER BY PropertyCount DESC;


SELECT 
    TaxDistrict,
    AVG(CAST(LandValue AS float)) AS AvgLandValue,
    AVG(CAST(BuildingValue as float)) AS AvgBuildingValue,
    AVG(cast(TotalValue as float)) AS AvgTotalValue
FROM CleaningSQL.dbo.NashvilleHousing_Cleaned
GROUP BY TaxDistrict
ORDER BY AvgTotalValue DESC;



SELECT 
    *,
    CASE 
        WHEN OwnerName is null then null
		WHEN CHARINDEX('LLC', OwnerName) > 0 THEN 'Company'
        ELSE 'Individual'
    END AS OwnerType
FROM CleaningSQL.dbo.NashvilleHousing_Cleaned;

