# Analysis of Indian Suicide Cases

## Objectives and Motivation
The primary aim of this project is to conduct a comprehensive analysis of suicide cases in India, focusing on the various factors contributing to this critical issue. With a staggering 164,033 reported suicides in 2021, as per the National Crime Records Bureau (NCRB), the project seeks to educate the public and raise awareness about the societal implications of these statistics. By exploring the data, we hope to highlight significant patterns and trends, fostering a better understanding of the issue and contributing to potential intervention strategies.

## Dataset Description
The dataset used in this analysis comprises detailed yearly suicide statistics collected from all states and Union Territories of India. Key parameters included in the dataset are:
- *State:* Geographical location where the suicide occurred.
- *Year:* The year the data was collected.
- *Gender:* Gender of the individuals involved in the cases.
- *Age Group:* Classification of individuals by age brackets.
- *Causes of Suicide:* Categorized reasons for the suicides reported.
- *Education Status:* The educational background of the individuals.
- *Means Adopted:* Methods employed in carrying out the suicides.
- *Professional Profile:* The occupational status of the individuals.
- *Social Status:* Social classifications relevant to the cases.

This data is publicly available on Kaggle and is released under a Creative Commons license, ensuring accessibility for further research and analysis.

## List of Packages
To facilitate our analysis, we employed several R packages, each serving a specific purpose:
- *ggplot2:* A powerful package for creating static and interactive data visualizations, allowing us to depict trends and distributions effectively.
- *readr:* This package simplifies the process of reading rectangular data from various delimited file formats, ensuring seamless data import.
- *dplyr:* Utilized for data manipulation, it enables efficient filtering, summarizing, and transforming of data frames.
- *tidyverse:* A collection of R packages designed for data science, it helps in tidying data and streamlining the analysis process.
- *ggrepel:* This package enhances the readability of visualizations by preventing overlap in text labels, ensuring that all relevant information is clear and accessible.

## Experimentation

### Preliminary Data Analysis
We began by installing the necessary packages and importing the dataset into R. Initial analyses involved checking the dataset's structure, identifying data types, and exploring summary statistics. This step was crucial for understanding the distribution of data and spotting any inconsistencies or missing values.

### Data Visualization
To convey the insights gained from our analysis, we created a series of visualizations. These included:
- *Trends Over Time:* Analyzing how suicide rates have changed over the years.
- *State-wise Distributions:* Examining the geographical spread of suicides across India.
- *Age Group Analysis:* Investigating which age groups are most affected.
- *Causes of Suicides:* Highlighting prevalent reasons for suicide cases.

### Linear Regression
We applied linear regression techniques to model the relationship between years and suicide rates. This statistical approach enabled us to predict future trends and better understand the underlying factors contributing to changes in suicide rates over time.

## Conclusions
Through the course of this project, we successfully visualized and interpreted multiple dimensions of suicide cases in India. The analytical process not only enhanced our coding skills in R and familiarity with RStudio but also deepened our understanding of how to apply statistical concepts to real-world data. This project emphasizes the urgent need for awareness and proactive intervention strategies to address the complexities surrounding suicide cases.

## Acknowledgements
We would like to acknowledge the following team members for their contributions to this project:
- *Akhil Vanapalli* (Project Lead)
- Anushka Dodla
- Varshita Pokala
- Yarramshetty Charitha Sri
- Ali Hasan

## References
- National Crime Records Bureau (NCRB) Reports
- Kaggle Dataset: Suicides in India
- R Documentation for ggplot2, dplyr, and other utilized packages

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
