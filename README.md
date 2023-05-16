# Mini-Project
### IMDB Top 250 Movies Data Analysis

## Table of Contents
Description
Installation
Usage
Data Analysis
SQL Queries
Contributing
License
Contact

* Description
This project aims to retrieve data from the IMDB Top 250 Movies list, perform data analysis, and generate insights based on the collected data. The code is written in Python and utilizes libraries such as requests, BeautifulSoup, pandas, re, and matplotlib.

The project starts by scraping the IMDB website to retrieve the top 250 movies' data, including the movie title, year, rating, director, cast, genre, and links. The retrieved data is then stored in a CSV file named top_250_movies.csv.

* Installation
To run this project locally, follow these steps:

Clone the repository: git clone https://github.com/your_username/your_repository.git
Navigate to the project directory: cd your_repository
Install the required dependencies: pip install requests beautifulsoup4 pandas matplotlib

* Usage
After completing the installation steps, you can execute the code by running the Python script. The main file is named imdb_top_250_movies.py. Open the file in your preferred Python editor, such as Visual Studio Code or PyCharm, and run it.

The script will scrape the IMDB Top 250 Movies list, retrieve the necessary data, perform data analysis, and generate visualizations using matplotlib.

* Data Analysis
The project includes two data analysis sections with corresponding visualizations:

Year vs. Rating Scatter Plot: This plot shows the relationship between the release year of movies and their ratings. It helps analyze any trends or patterns in movie ratings over time.

Users Rating vs. Rating Scatter Plot: This plot compares the users' ratings and the IMDb ratings for each movie. It aims to determine the credibility of ratings based on their alignment.

* SQL Queries
The project includes several SQL queries to perform data manipulations and retrieve insightful information from the top_250_movies table. The queries cover different aspects such as counting the occurrence of each genre and cast, finding directors with the most high-rating movies, and more.

Please refer to the code provided to view the complete SQL queries and their descriptions.

* Contributing
Contributions to this project are welcome. If you have any suggestions, bug reports, or feature requests, please submit them through the issue tracker of the GitHub repository.

* License
The project is licensed under the MIT License.

* Contact
For any inquiries or questions, please contact @ChrisBach.
