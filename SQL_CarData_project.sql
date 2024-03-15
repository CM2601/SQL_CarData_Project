use Cardata;

#Retrieve all columns for all cars in the dataset.

select * from Car;


#Select unique fuel types present in the dataset.

select distinct fuel_type from car;

#Find the total number of records in the dataset.

select count(*) as Total_records from car;

#Calculate the average selling price and present price.

select avg(Selling_price) as Avg_selling_price,avg(Present_price) as Avg_Present_Price
from car;

#Determine the maximum and minimum values for the kilometers driven.

select max(Kms_driven) as Maximum_KM_Driven, min(Kms_driven) as Minimum_KM_Driven 
from car;

#Group the data by fuel type and find the average selling price for each fuel type.

select fuel_type, avg(selling_price) as Avg_Selling_price
from Car
group by fuel_type;

#Group the data by transmission type and calculate the total number of cars for each transmission.

select transmission, count(*) as Total_Cars
from Car
group by transmission;

#Retrieve data for cars manufactured after 2010.

select * from car
where year >2010;

#Display records for cars with a selling price above 5, sorted in descending order.

select * from car
where selling_price>5
order by selling_price desc ;

#Use a subquery to find cars with a selling price higher than the average selling price.

select * from car
where selling_price>(select avg(selling_price) from car);

#Write a subquery to find the oldest car in the dataset.

select * from Car
where year =(select min(year) from car);

#Apply a CASE statement to categorize cars based on their selling prices (e.g., low, medium, high)


SELECT Car_Name,
       Selling_Price,
       CASE
           WHEN Selling_Price < 10 THEN 'Low'
           WHEN Selling_Price >= 10 AND Selling_Price < 30 THEN 'Medium'
           WHEN Selling_Price >= 30 THEN 'High'
           ELSE 'Unknown'  
       END AS Price_Category
FROM car;

#Use the WHERE clause to filter cars with a specific fuel type and transmission.

select *
from car
where fuel_type="Petrol" and Transmission="Automatic";

#Update the dataset to mark cars with more than one owner as 'Multiple Owners.'
alter table car
modify column owner varchar(400);
update car
set owner="Multiple Owners"
where CAST(Owner AS SIGNED) > 1;

#Retrieve cars with a selling price above the average but below the maximum selling price

select *
from car
where Selling_Price > (select  avg(Selling_Price) from car) 
and Selling_Price <(select max(Selling_Price) from car);

#Find the car(s) with the highest present price.

select Car_name,max(Present_price) as Highest_Present_price
from car
group by Car_Name 
order by Highest_Present_price desc ;

SELECT *
FROM car
WHERE Present_Price = (SELECT MAX(Present_Price) FROM car);

#List all cars that have a selling price higher than the average selling price of cars manufactured in 2015.

select car_name, Year , Selling_Price 
from car
where Selling_Price >(select avg(Selling_Price) from car)
and Year = 2015;

#Calculate the total number of cars for each fuel type.
select car_name, Fuel_Type, count(*) as Total 
from car
group by Car_Name, Fuel_Type  ;

#Find the average selling price for cars with more than two owners.

select car_name, avg(Seller_Type)
from car
where owner >2
group by Car_Name;

#Retrieve cars with a selling price within 10% of the maximum selling price.

SELECT *
FROM car
WHERE Selling_Price >= (SELECT MAX(Selling_Price) * 0.9 FROM car)
  AND Selling_Price <= (SELECT MAX(Selling_Price) FROM car);
 
#Display records for cars that are not petrol-fueled and have a manual transmission.
 
 select car_name,Fuel_Type ,Transmission 
 from car
 where Fuel_Type <> 'Petrol' and Transmission ='Manual' ;

#Retrieve cars with a present price higher than the average present price and a selling price higher than the median selling price.

select *
from car
where Present_Price >(select avg(present_Price) from car)
 and Selling_Price >(select percentile_cont(0.5) within group( order by Selling_Price)  from car);

#Find the cars with the oldest and newest manufacturing years in the dataset

select *
from car
where year = (select min(year) from car)
or year = (select max(year) from car);


#Calculate the average selling price for each year, and identify the year with the highest average selling price.

select year, avg( Selling_Price ) as avg_selling_price
from car
group by year 
order by avg_selling_price desc;

#Calculate the total selling price and present price for each fuel type.

select fuel_type,
sum(selling_price) as Total_selling_price,
sum(Present_price) as Total_present_price
from car
group by Fuel_Type ;

#Find the fuel type with the highest total selling price.

select fuel_type,sum(selling_price) as Total_selling_price 
from car
group by Fuel_Type 
order by Total_selling_price desc
limit 1;

#Identify cars with a selling price higher than the average selling price for their respective fuel types.

select car_name, Fuel_type, Selling_Price 
from car
where Selling_Price > (select avg(Selling_Price) from car);

#Retrieve cars with a corolla word in their name 

select *
from car
where Car_Name like "%corolla%";

#Find cars with a selling price ending with 5

select car_name,Selling_Price 
from car
where Selling_Price like "%5";

#Calculate the standard deviation of the selling prices to measure the variability in prices.

select stddev(selling_price) as SellingPriceStandardDeviation
from car;

#-- Rank cars based on selling prices, handling ties by giving them the same rank
SELECT 
  Car_Name,
  Selling_Price,
  DENSE_RANK() OVER (ORDER BY Selling_Price) AS SellingPriceRank
FROM car;


