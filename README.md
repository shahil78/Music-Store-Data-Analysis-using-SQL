# Music-Store-Data-Analysis-using-SQL

Project Overview

This project involves an in-depth analysis of a music store database to uncover actionable insights. Advanced SQL techniques are utilized to analyze sales, listeners, and trends across various dimensions like artists, albums, genres, and countries. By leveraging functions such as Common Table Expressions (CTE), Window Functions, and Recursive Queries, the analysis highlights the store's top performers and identifies areas for business growth.

Key Objectives

Identify the top 5 selling artists.
Determine the top 5 countries with the highest album sales.
Pinpoint the top 5 most sold music albums.
Analyze which genres and countries have the most listeners.
Tools and Techniques Used

SQL Functions:

Joins: Combined multiple tables to extract meaningful insights from the dataset.
Common Table Expressions (CTEs): Organized complex queries for better readability and performance.
Window Functions: Performed calculations over partitions to rank and aggregate data efficiently.
Recursive Functions: Implemented hierarchical queries for advanced data exploration.
Database Management System (DBMS): SQL-based relational database.

Key Insights

Top 5 Selling Artists:
Identified using recursive queries and aggregated sales data.

Top 5 Selling Countries:
Evaluated by summing album sales and ranking the results.

Top 5 Sold Albums:
Highlighted using window functions for ranking album sales data.

Genres and Countries with Most Listeners:
Derived using advanced join queries and aggregation to match listeners with genres and locations.

SQL Queries Used

Joins:
Combined tables like sales, albums, artists, and listeners for consolidated data.

Common Table Expressions (CTEs):
Simplified complex subqueries, e.g., for calculating sales by genre and country.

Window Functions:
Utilized ROW_NUMBER() and RANK() for ranking artists, albums, and countries.

Recursive Queries:
Explored hierarchical relationships in the dataset, such as genre trees or artist collaborations.
Project Workflow

Data Exploration:
Examined the structure and content of tables to identify key relationships.

Data Cleaning:
Ensured data consistency and handled missing values.

SQL Query Design:
Created modular queries for each objective.

Visualization:
Exported results for potential dashboard integration using tools like PowerBI or Tableau.

Documentation:
Summarized insights and technical approach for future reference.

Results
The analysis provided valuable insights into sales and listening trends, helping the music store prioritize top-performing artists, albums, and genres. These insights can guide marketing strategies and inventory decisions.
