import psycopg2
import random

conn = psycopg2.connect(
    dbname="postgres", user="postgres", password="pass", host="localhost"
)
cursor = conn.cursor()


def insert_laptop(model, speed, ram, hd, price, screen):
    sql = f"""
            insert into 
              laptop (
                code, 
                model, 
                speed, 
                ram, 
                hd, 
                price, 
                screen
              )
            values
              (
                nextval('laptop_sequence'),
                {model}, 
                {speed}, 
                {ram}, 
                {hd}, 
                {price}, 
                {screen}
              );
            """
    cursor.execute(sql)


def insert_pc(model, speed, ram, hd, cd, price):
    sql = f"""
            insert into 
                pc (
                  code,
                  model, 
                  speed, 
                  ram, 
                  hd, 
                  cd, 
                  price
                )
              values
                (
                  nextval('pc_sequence'),
                  {model}, 
                  {speed}, 
                  {ram}, 
                  {hd}, 
                  {cd}, 
                  {price}
                );
            """
    print(sql)
    cursor.execute(sql)


def insert_printer(model, color, type, price):
    sql = f"""
            insert into 
              printer (
                code, 
                model, 
                color, 
                "type", 
                price
              )
            values
              (
                nextval('printer_sequence'),
                {model}, 
                {color}, 
                {type}, 
                {price}
              );
            """
    cursor.execute(sql)


def insert_product(maker, model, type):
    sql = f"""
              insert into 
                product (
                  maker, 
                  model, 
                  "type"
                )
              values
                (
                  {maker}, 
                  {model}, 
                  {type}
                );
            """
    cursor.execute(sql)


class MockDataGenerator:
    maker_list = ["'Acer'", "'Asus'", "'HP'"]
    pc_model_list = range(1500, 1700)
    laptop_model_list = range(1100, 1300)
    printer_model_list = range(2000, 2200)
    printer_color_list = ["'y'", "'n'"]
    printer_type_list = ["'LASER'", "'COMMON'"]
    product_types = ["'PC'", "'LAPTOP'", "'PRINTER'"]
    ram_list = [8, 16, 24, 32, 64, 128, 512]
    hd_list = range(10, 128)
    cd_list = ["'2x'", "'4x'", "'8x'", "'16x'"]
    price_list = range(500, 4000)
    screen_list = range(50,100)

    def rand_pc(self,model):
        return [
            model,
            random.choice(range(300, 1200)),
            random.choice(MockDataGenerator.ram_list),
            random.choice(MockDataGenerator.hd_list),
            random.choice(MockDataGenerator.cd_list),
            random.choice(MockDataGenerator.price_list),
        ]

    def rand_laptop(self,model):
        return [
            model,
            random.choice(range(300, 1200)),
            random.choice(MockDataGenerator.ram_list),
            random.choice(MockDataGenerator.hd_list),
            random.choice(MockDataGenerator.price_list),
            random.choice(MockDataGenerator.screen_list)
        ]
    

    def rand_printer(self,model):
      return [
        model,
        random.choice(MockDataGenerator.printer_color_list),
        random.choice(MockDataGenerator.printer_type_list),
        random.choice(MockDataGenerator.price_list),
    ]

    def rand_product():
        return [random.choice(MockDataGenerator.maker_list), random.choice(MockDataGenerator.product_types)]
    



for printer in MockDataGenerator.printer_model_list:
    insert_product(random.choice(MockDataGenerator.maker_list), printer, "'PRINTER'")
    insert_printer(*MockDataGenerator().rand_printer(printer))

for pc in MockDataGenerator.pc_model_list:
    insert_product(random.choice(MockDataGenerator.maker_list), pc, "'PC'")
    insert_pc(*MockDataGenerator().rand_pc(pc))

for laptop in MockDataGenerator.laptop_model_list:
    insert_product(random.choice(MockDataGenerator.maker_list), laptop, "'LAPTOP'")
    insert_laptop(*MockDataGenerator().rand_laptop(laptop))


for only_pc in range(3100,3140):
    insert_product("'TECNO'", only_pc, "'PC'")
    insert_pc(*MockDataGenerator().rand_pc(pc))


insert_product("'TECNO'", 7777, "'PC'")
duplicate_pc = MockDataGenerator().rand_pc(7777)
for duplicate in range(4100, 4150):
    insert_pc(*duplicate_pc)

insert_product("'HP'", 9999, "'LAPTOP'")
duplicate_laptop = MockDataGenerator().rand_laptop(9999)
for duplicate in range(4300, 4350):
    insert_laptop(*duplicate_laptop)
    
    
conn.commit()
pass
