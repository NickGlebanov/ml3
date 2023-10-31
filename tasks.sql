-- Active: 1698681509571@@127.0.0.1@5432@postgres@public


# 1. Напишите запросы к базе данных.
# Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price.
select model, price from printer ORDER BY price DESC limit 10

# Найдите среднюю скорость ПК.
select avg(speed) from pc

# Найдите производителя, продающего ПК, но не ноутбуки.
SELECT maker from
(SELECT maker from product group by "type", maker HAVING ("type"='PC' OR "type"='LAPTOP'))
GROUP BY maker
HAVING count(*) = 1


select * from laptop ORDER BY model desc