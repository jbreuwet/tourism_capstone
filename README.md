My name is Joshua Breuwet and this is my final capstone project for the Nashville Software School Data Analytics bootcamp. For this project, I used Excel, Python, SQL, and Tableau to analyze the global tourism industry and answer some key data questions to gain insights about the data. 

All of the data sets were found online mostly from .org websites (sources listed below). The main challenge during this project was getting the raw data sets into a workable format. Almost all  the CSVs downloaded for this project contained lots of unwanted data, formatting, and orientation. A minor amount of cleaning was performed simply using Excel to trim all of the data sets down to only the data that was desired. The data sets were then cleaned further in Jupyter notebooks using Python and the Pandas library. A majority of the cleaning involved writing a function that transposed the data for each unique country and merged the results into tables that were ready for analysis. 

The last bit of data cleaning involved loading my mostly cleaned tables into Postgresql and using SQL queries to find the differences in country names for each data set that I had. I used my data sets from the UN world tourism database as my standard as this was the source for most of my data sets and had the same designation for each country. After finding the differences in country names for my remaining data sets, I went back to Python to rename and normalize country names for all of my data sets. Using SQL, the desired columns from each data set were then joined into one main table that would be ready to perform analysis and generate graphics. 

SQL was used to perform analysis on the main data table that was created. Some of the main data questions that I wanted to answer were:
    1. What were the largest tourism markets globally based on total number of tourist arrivals?
        a. From 2000-2022?
        b. From 2010-2022?
        c. From 2020-2022?
    2. What were the largest cruise markets based on the total number of cruise passengers entering a specific country?
        a. From 2000-2022?
        b. From 2010-2022?
        c. From 2020-2022?
    3. What were some of the fastest growing tourism markets based on total tourism expenditure in USD?
    4. What were the fastest recovering tourism markets following the global pandemic?
Other exploratory questions were answered about the data set but did not make it into the final presnetation. 

After answering my main data questions, the main table was again loaded into Jupyter notebooks. Python and the Matplotlib library was used to create graphics visualizing the results of the analysis that was performed. These graphics were used in a PowerPoint that will be the main focus of the presentation. 

The final aspect of the project that I wanted to include was an interactive dashboard that anyone working for or with a travel agency could use to quickly and efficiently perform similar analysis on global tourism markets. I wanted this dashboard to have the functionality to filter down to any set of countries desired and instantly recieve the key factors and KPIs discussed previously. This dashboard includes information such as total arrivals into the country, total number of cruise passengers, total tourism expenditure, as well as averages for these statistics based on the desired range of years selected. I also included a crime and safety index for the countries where it was available and a graphic showing region of origin for tourists entering the selected countries. 

There were some limitations to the data sets that were used for this project. Most of the tourism data taken from the UN only included up to the year 2022. I would like to see how this data would be different once the tourism statistics are reported for 2023 and 2024. Another limitation is that not every country reports their tourism statistics the same way. Many countries do not distinguish between air travel tourists and cruise passengers and lump them together as one statistic. Further work would be necessary to fill in the missing data such as this for each and every country. 

Listed below are the sources for all data sets used in this project as well as the links to my published PowerPoint presentation and Tableau dashboard. Thank you for your time and I hope you enjoy the project!

Tableau Dashboard: https://public.tableau.com/views/capstone_dashboard_17237726468850/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

# Dashboard meant to be viewed in presentation mode. Orientation and formatting on other machines or not in presentation mode may have visuals overlapping. 

Data Sources: 
UN Global Tourism Statistics = https://www.unwto.org/tourism-statistics/key-tourism-statistics
% Tourism GDP vs. Overall GDP = https://www.unwto.org/tourism-statistics/economic-contribution-SDG
UN Population Data = https://population.un.org/wpp/Download/Standard/MostUsed/
GDP Data = https://www.imf.org/external/datamapper/NGDPD@WEO/OEMDC/ADVEC/WEOWORLD
GDP Per Capita Data = https://www.imf.org/external/datamapper/NGDPDPC@WEO/OEMDC/ADVEC/WEOWORLD
Crime Rates Data = https://worldpopulationreview.com/country-rankings/crime-rate-by-country
