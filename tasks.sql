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


# Загрязните специально датасет (вставьте новые значения с уникальным кодом, но всеми остальными дублирующими полями). (смотреть файл fill_dbs.py)
# Напишите оконную функцию, которая поможет вам обнаружить эти строки-редиски.
select code from
(select code, model ,ROW_NUMBER() over  (partition by model, speed,ram,hd,cd,price) as rcount from pc)
WHERE rcount > 1;

select code from
(select code, model ,ROW_NUMBER() over  (partition by model, speed,ram,hd,price,screen) as rcount from laptop)
WHERE rcount > 1;


# Обновите название колонки в таблице printer с color на color_type и поменяйте тип поля.
ALTER TABLE printer RENAME COLUMN color TO color_type;
ALTER TABLE printer ALTER COLUMN color_type TYPE VARCHAR(100);

# В последнем пункте выполните слияние двух запросов из таблиц PC и Laptop, выбрав только те значения, у которых цена больше 500, а ram = 64.
select * from
(select code, ram, price from laptop
UNION
select code, ram, price from pc)
where price > 500 and ram = 64