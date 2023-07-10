select * from pizza_sales$
/*total revnue*/
select cast(sum(total_price) as decimal(10,2)) as total_revnue from pizza_sales$
/*average order per value*/
select cast(sum(total_price)/count(distinct order_id) as decimal(10,2)) as average_order_value from pizza_sales$
/*total pizza sold*/
select sum(quantity) as total_sold from pizza_sales$
/*total orders*/
select sum(distinct order_id) as total_order from pizza_sales$
/*average pizza per order*/
select cast(sum(quantity)/count(distinct order_id)as decimal(10,2)) as average_pizza_per_order from pizza_sales$

/*daily trend for total order*/
select datename(dw,order_date) as order_day,count(distinct order_id) as total_order from pizza_sales$
group by datename(dw,order_date)
/*monthly trend for total order*/
select datename(MONTH,order_date) as order_day,count(distinct order_id) as total_order from pizza_sales$
group by datename(MONTH,order_date)
/*hourly trend per order*/
select datepart(hour,order_time) as order_hour,count(distinct order_id) as total_order
from pizza_sales$
group by datepart(hour,order_time)
order by datepart(hour,order_time)
/*% sales per pizza category*/
/*to filter total sales per months 
month(order_date)=1
*/
select pizza_category ,cast(sum(total_price) as decimal(10,2)) as total_revenu,
cast(sum(total_price)*100 /(select sum(total_price) from pizza_sales$) as decimal(10,2)) as percentage from pizza_sales$
group by pizza_category
order by percentage desc
/*sales per pizza size*/
select pizza_size ,cast(sum(total_price) as decimal(10,2)) as total_revenu,
cast(sum(total_price)*100 /(select sum(total_price) from pizza_sales$) as decimal(10,2)) as percentage from pizza_sales$
group by pizza_size
order by percentage desc
/*total pizza sold per category*/
select pizza_category,sum(quantity) as pizza_sold from pizza_sales$
group by pizza_category
order by pizza_sold desc
/*5 top sellers by total pizza sold*/
select top 5 pizza_name,sum(quantity) as quantity from pizza_sales$
group by pizza_name
order by quantity desc
/*bottom 5 worst sellers by total pizza*/
select top 5 pizza_name,sum(quantity) as quantity from pizza_sales$
group by pizza_name
order by quantity 