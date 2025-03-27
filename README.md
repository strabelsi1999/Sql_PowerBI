# Project Overview:
This project analyzes real estate transactions using SQL for data cleaning and modeling, and Power BI for data visualization. It provides insights into property sales trends, valuation patterns and ownership distribution.
Tools & Skills Used:

SQL: Joins, CTEs, Temp Tables, Window Functions, Data Cleaning, Data Transformation, Data Modeling, Views<br>
Power BI: Interactive Dashboard Design, Data Visualization, DAX Calculations, Filtering


# SQL Analysis Breakdown:
## Data Cleaning:
Standardized Date Format:<br>
Converted SaleDate into a Date format using CONVERT(Date, SaleDate).

Filled Missing Property Addresses:<br>
Used Self-JOIN and ISNULL() to populate missing Property Addresses based on matching ParcelID.

Split Address into Separate Columns:<br>
Extracted Street Address and City from PropertyAddress and OwnerAddress using SUBSTRING() and PARSENAME().

Normalized "Sold As Vacant" Field:<br>
Replaced 'Y' and 'N' values with "Yes" and "No" using a CASE statement.

Removed Duplicate Records:<br>
Used ROW_NUMBER() with CTE (Common Table Expressions) to identify and remove duplicates.

Deleted Unused Columns:<br>
Dropped OwnerAddress, PropertyAddress, and LegalReference to improve data efficiency.

Created a Cleaned Dataset:<br>
Exported the cleaned data to a new table NashvilleHousing_Cleaned for further analysis.


## Data Modeling & Analysis:
Sales Trend Analysis:<br>
Aggregated total sales, revenue, and average sale price per date.

Property Type Distribution:<br>
Counted properties by LandUse to identify the most common property types.

Tax District Analysis:<br>
Calculated average land value, building value, and total property value per TaxDistrict.

Owner Type Classification:<br>
Used a CASE statement to classify individual vs. company ownership based on OwnerName.


# Power BI Dashboard & Visualizations:
## Key Metrics (Top KPI Cards)<br>
Total Sales (56K):<br>
Displays the total number of property transactions recorded.<br>
Total Revenue ($18bn):<br>
Represents the cumulative revenue generated from all property sales.<br>
Total Parcels (49K):<br>
Indicates the total number of unique property parcels in the dataset.


## Dashboard
### Graph Over Time
Total Revenue:<br>
Shows revenue trends over time, identifying sales peaks and market fluctuations.

Total Sales:<br>
Displays the number of property transactions per date, highlighting volume trends.

Average Price:<br>
Breaks down average sale price trends, differentiating vacant vs. non-vacant properties.<br>

### Pie Chart
Revenue by Land Use:<br>
Breakdown of property sales by land use category:<br>
Single-Family Homes (53.88%) dominate the market.<br>
Residential Condos (34.55%) form the second-largest category.<br>
Vacant Land (7.48%) represents a smaller portion of transactions.

### Bar Chart
Comparison of total revenue by city:<br>
Nashville generates the highest revenue (~$15bn), dominating the market.<br>
Other cities like Antioch, Hermitage, and Brentwood contribute smaller revenue shares.

### Date Filter
Interactive Date Filter<br>
Users can select a specific date range using the slider to dynamically adjust the analysis period.

# Conclusion:

This project successfully combines SQL's data transformation capabilities with Power BI’s interactive visualization tools to provide a comprehensive analysis of the real estate market. The insights gained help in understanding market trends, property valuation, ownership patterns, and regional differences, making it valuable for investors, property managers, and real estate analysts.
