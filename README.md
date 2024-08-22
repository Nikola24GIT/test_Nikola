import requests
from datetime import datetime, date
def read_sales_data(file_path):
    response = requests.get(file_path)
    if response.status_code == 200:
        content = response.text.split("\n")
        mydict_data = {'product_name': [], 'quantity': [], 'price': [], 'date': []}
        for i in content:
            c_str = i.rstrip().split(', ')
            mydict_data['product_name'].append(c_str[0])
            mydict_data['quantity'].append(int(c_str[1])) 
            mydict_data['price'].append(float(c_str[2])) 
            mydict_data['date'].append(datetime.strptime(c_str[3], '%Y-%m-%d').date())

        return mydict_data
    # with open(file_path, "r", encoding="utf-8") as file:
    #     content = file.readlines()
    #     mydict_data = {'product_name': [], 'quantity': [], 'price': [], 'date': []}
    #     for i in content:
    #         c_str = i.rstrip().split(', ')
    #         mydict_data['product_name'].append(c_str[0])
    #         mydict_data['quantity'].append(int(c_str[1])) 
    #         mydict_data['price'].append(float(c_str[2])) 
    #         mydict_data['date'].append(datetime.strptime(c_str[3], '%Y-%m-%d'))
    #     return mydict_data


file_path = 'https://raw.githubusercontent.com/Nikola24GIT/test_Nikola/379e4d3712bcac73e9ba82b22dea0bb1b29350c3/%D1%84%D0%B0%D0%B9%D0%BB%20%D0%B4%D0%BB%D1%8F%20%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%203.txt'

sales_data = read_sales_data(file_path)

def total_sales_per_product(sales_data):
    lst_total_sales = [i*j for i, j in zip(sales_data['quantity'], sales_data['price'])]
    mydict_total = dict()
    for i, j in zip(sales_data['product_name'], lst_total_sales):
        mydict_total[i] = mydict_total.setdefault(i, 0)+j 
  
    return mydict_total
    
product_revenue = total_sales_per_product(sales_data)

def sales_over_time(sales_data):
    lst_total_sales = [i*j for i, j in zip(sales_data['quantity'], sales_data['price'])]
    mydict_total = dict()
    for i, j in zip(sales_data['date'], lst_total_sales):
        mydict_total[i] = mydict_total.setdefault(i, 0)+j 

    return mydict_total
    
date_revenue = sales_over_time(sales_data)

# В ходе анализа данных из файла необходимо вывести на экран два значения:
def obj_revenue_max(obj):
    max_total = 0
    res = ""
    for i, j in obj.items():
        if j > max_total:
            max_total = j
            res = i
    return res

def obj_revenue_sorted(obj):
    obj_sorted = sorted(obj.items(), key=lambda item: item[1], reverse=True)
    lst_keys = [i[0] for i in obj_sorted]
    lst_items = [i[1] for i in obj_sorted]
    return  lst_keys, lst_items

# Определить, какой продукт принес наибольшую выручку.
product_revenue_sort = obj_revenue_sorted(product_revenue)
date_revenue_sort = obj_revenue_sorted(date_revenue)
# print(obj_revenue_max(product_revenue))
print("продукт принес наибольшую выручку:", product_revenue_sort[0][0])     
# Определить, в какой день была наибольшая сумма продаж.
#print(obj_revenue_max(date_revenue)) 
print("в какой день была наибольшая сумма продаж:", date_revenue_sort[0][0])  
# В завершении работы вашей программы необходимо построить два графика:
import matplotlib.pyplot as plt
# Построить график общей суммы продаж по каждому продукту.
plt.figure(figsize=(8,4))
plt.bar(product_revenue_sort[0], product_revenue_sort[1], width=0.8)
plt.title('график общей суммы продаж по каждому продукту', color="blue")
plt.show()
# Построить график общей суммы продаж по дням.
plt.figure(figsize=(8,4))
plt.bar(date_revenue_sort[0], date_revenue_sort[1], color="teal", width=0.8)
plt.title('график общей суммы продаж по дням', color="blue")
plt.xticks(rotation=90)
plt.show()
