# Pizza Sales Analysis Project

## Project Overview

This project aims to uncover insights from a pizza sales dataset, providing a clear picture of customer preferences and revenue drivers. By analyzing orders, pizza types, ingredients, sizes, and pricing, we can make informed decisions to optimize menus, pricing strategies, and operations, ultimately maximizing profitability and customer satisfaction in a competitive market.

## Objectives

- Determine total orders, total revenue, and total pizza quantity sold.
- Calculate average order amount and average order quantity per transaction.
- Identify unique pizza types, sizes, and categories.
- Analyze category-wise distribution of pizzas.
- Identify highest and lowest priced pizzas.
- Calculate average quantity sold per day and average revenue generated per day.
- Analyze distribution of orders by hour, day of the week, and month.
- Evaluate distribution of orders, quantity, and revenue by size, category, and type.
- Determine the percentage contribution of each pizza type/category to total revenue.
- Track cumulative revenue generated over time.

## Dataset Overview

**Dataset Credit**: [Maven Analytics](https://www.mavenanalytics.io/data-playground?order=date_added%2Cdesc&search=Pizza)

### Tables and Columns

1. **orders**
   - `order_id`: Unique identifier for each order.
   - `date`: Date the order was placed.
   - `time`: Time the order was placed.

2. **pizza_types**
   - `pizza_type_id`: Unique identifier for each pizza type.
   - `name`: Name of the pizza as shown on the menu.
   - `category`: Pizza category.
   - `ingredients`: Ingredients used in the pizza.

3. **order_details**
   - `order_details_id`: Unique identifier for each pizza placed within each order.
   - `order_id`: Unique identifier for each order.
   - `pizza_id`: Unique identifier tying the pizza to its details (size and price).
   - `quantity`: Quantity ordered for each pizza.

4. **pizzas_price**
   - `pizza_id`: Unique identifier tying the pizza to its details (size and price).
   - `pizza_type_id`: Unique identifier for each pizza type.
   - `size`: Size of the pizza (S, M, L, XL, XXL).
   - `price`: Price of the pizza in USD.

## Key Findings

- **Total Orders**: 21,350
- **Total Revenue**: $817,860.05
- **Total Pizza Quantity Sold**: 49,574
- **Average Order Quantity**: 2.32
- **Average Order Amount**: $38
- **Unique Pizza Types**: 32
- **Unique Pizza Sizes**: 5 (S, M, L, XL, XXL)
- **Unique Pizza Categories**: 4 (Chicken, Classic, Supreme, Veggie)
- **Highest Priced Pizza**: The Greek Pizza ($35.95)
- **Lowest Priced Pizza**: The Pepperoni Pizza ($9.75)
- **Average Quantity Sold Per Day**: 138
- **Average Revenue Per Day**: $2,285

## Analysis Summary

### Size-Wise Analysis
- **Large (L)**: 45.9% of revenue
- **Medium (M)**: 30.5% of revenue
- **Small (S)**: 21.8% of revenue
- **Extra Large (XL)**: 1.7% of revenue
- **Double Extra Large (XXL)**: 0.1% of revenue

### Category-Wise Analysis
- **Classic**: 26.9% of revenue
- **Supreme**: 25.5% of revenue
- **Chicken**: 24% of revenue
- **Veggie**: 23.7% of revenue

### Time-Based Analysis
- **Hour**: Peak hours are 11 AM - 1 PM.
- **Day**: Highest orders on Fridays.
- **Month**: Consistent sales throughout the year with slight peaks and troughs.

### Top 3 Pizzas by Category
- **Chicken**: The Thai Chicken Pizza, The Barbecue Chicken Pizza, The California Chicken Pizza
- **Classic**: The Classic Deluxe Pizza, The Hawaiian Pizza, The Pepperoni Pizza
- **Supreme**: The Spicy Italian Pizza, The Italian Supreme Pizza, The Sicilian Pizza
- **Veggie**: The Four Cheese Pizza, The Mexicana Pizza, The Five Cheese Pizza

## Conclusion

The analysis highlights key customer preferences, indicating a strong demand for larger-sized pizzas and specific popular varieties. This information can be leveraged to optimize the menu, enhance marketing strategies, and improve overall customer satisfaction and profitability.

## Recommendations

1. **Optimize Menu Offerings**
   - Focus on promoting top-selling pizzas.
   - Expand the variety of large-sized pizzas.

2. **Enhance Marketing Strategies**
   - Increase promotions during peak hours and high-traffic days.
   - Develop targeted promotions for slower days.

3. **Pricing Strategy**
   - Evaluate and potentially increase prices for popular pizzas.
   - Offer bundle deals to encourage larger transactions.

4. **Customer Engagement**
   - Introduce loyalty programs focused on top categories.
   - Gather customer feedback for new variants or limited-time offers.

5. **Operational Efficiency**
   - Streamline operations during peak hours.
   - Offer advance order options or time-slot reservations.

By following these recommendations, the business can further enhance its appeal, improve customer satisfaction, and drive sustained revenue growth.

## Future Scope

Further analysis could include:
- Studying customer demographics and preferences.
- Exploring the impact of seasonal promotions.
- Analyzing the effectiveness of marketing campaigns.
- Expanding the dataset to include additional variables such as delivery times and customer feedback.

## Contact 

- **LinkedIn:** [Binoy Patra](https://www.linkedin.com/in/binoy-patra-b9277b1b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app)
- **GitHub:** [Binoy Patra](https://github.com/binoy-patra)
- **Gmail:** [Mail](binoypatra20@gmail.com)
