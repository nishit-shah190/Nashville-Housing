Select * from nashville_housing;

SELECT SaleDate, str_to_date(SaleDate, '%M %d, %Y')
From nashville_housing;

Update nashville_housing
SET SaleDate = str_to_date(SaleDate, '%M %d, %Y');

Update nashville_housing
SET OwnerAddress = null
Where OwnerAddress = '';

Select *
From nashville_housing
Where OwnerSplitCity is null;

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, coalesce(a.PropertyAddress,b.PropertyAddress)
From nashville_housing a
Join nashville_housing b
 on a.ParcelID = b.ParcelID
 AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is null;

UPDATE nashville_housing a 
Join nashville_housing b
 on a.ParcelID = b.ParcelID
 AND a.UniqueID <> b.UniqueID
 SET a.PropertyAddress = coalesce(a.PropertyAddress,b.PropertyAddress)
WHERE a.PropertyAddress is null;


SELECT PropertyAddress
From nashville_housing;

SELECT 
TRIM(SUBSTRING_INDEX(PropertyAddress, ',',1 )) As Address,
TRIM(SUBSTRING_INDEX(PropertyAddress, ',' ,-1)) AS City
FROM nashville_housing;

ALTER TABLE nashville_housing
Add PropertySplitCity varchar(255);

UPDATE nashville_housing
SET PropertySplitAddress = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', 1));

UPDATE nashville_housing
SET PropertySplitCity = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', -1));

SELECT
TRIM(SUBSTRING_INDEX(OwnerAddress, ',',1)) As Address,
TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',' ,2), ',' , -1)) AS City,
TRIM(SUBSTRING_INDEX(OwnerAddress, ',' , -1)) As State
FROM nashville_housing;

ALTER TABLE nashville_housing
Add OwnerSplitState varchar(255);

UPDATE nashville_housing
SET OwnerSplitState = TRIM(SUBSTRING_INDEX(OwnerAddress, ',' , -1));
SET SQL_SAFE_UPDATES =0;