# Load necessary packages
install.packages(c('ggplot2', 'readr', 'dplyr', 'tidyverse', 'ggrepel'))
library(ggplot2)
library(readr)
library(dplyr)
library(tidyverse)
library(ggrepel)

# Read the dataset
suicide_data <- read.csv(file.choose())  # Choose the file when prompted

# Preliminary data analysis
# Print dimensions of the dataset
dim(suicide_data)

# Print summary of the dataset
summary(suicide_data)

# Print first and last 50 observations
head(suicide_data, n=50)
tail(suicide_data, n=50)

# Create a contingency table for gender
suicide.gender.tab <- table(suicide=suicide_data$Gender)
addmargins(suicide.gender.tab)

# Select 10 random rows from the dataset
sample_n(suicide_data, 10)

# Data Visualization

# 1. Change in numbers over the time for 11 years
cases_over_11_years <- suicide_data %>%
  select(Year, Total) %>%
  arrange(Year) %>%
  group_by(Year) %>%
  summarize(Total = sum(Total))
options(repr.plot.width = 12, repr.plot.height = 10)# plot dimensions

ggplot(data = cases_over_11_years) +
  geom_step(aes(x = Year, y = Total), stat = "identity", size = 1, color = "red") +
  labs(title = "Change in numbers over the time for 11 years", x = "Year", y = "Cases per year") +
  theme(axis.text = element_text(size = 18)) +
  theme(axis.title = element_text(size = 20)) +
  theme(plot.title = element_text(size=22))
scale_x_continuous(breaks = ~ axisTicks(., log = FALSE))

# 2. State-wise distribution
State_wise_df <- suicide_data %>%
  select(State, Total) %>%
  group_by(State) %>%
  summarize(Total = sum(Total)) %>%
  arrange(State, -Total)

ggplot(data = State_wise_df) +
  geom_col(mapping = aes(x = Total, y = reorder(State, Total), fill = Total)) +
  theme(axis.text = element_text(size = 10, colour = "black")) +
  theme(legend.position = "none") +
  scale_fill_gradient(guide = "colourbar") +
  theme(axis.title = element_blank()) +
  labs(title = "State-wise distribution") +
  theme(plot.title = element_text(size = 23))

# 3. Changes in numbers over the time for different age groups
Cases_by_agegroup <- suicide_data %>%
  select(Age_group, Year, Total) %>%
  group_by(Age_group, Year) %>%
  summarize(Total = sum(Total))
options(scipen=999) # turn off scientific notation like 1e+06
options(repr.plot.width = 20, repr.plot.height = 10) #plot dimensions
ggplot(Cases_by_agegroup) +
  geom_line(mapping = aes(x = Year, y = Total, colour = Age_group), stat = "identity", size = 1.15) +
  facet_wrap(~ Age_group, dir = "h", scales = "free", nrow = 2, strip.position = "top") +
  theme(strip.text.x = element_text(size = 20, colour = "black")) +
  theme(legend.position = "none") +
  labs(title = "Changes in numbers over the time for different age groups", x = "Year", y = "Cases per year")

theme(plot.title = element_text(size=24)) +
theme(axis.text = element_text(size = 20, colour = "black")) +
theme(axis.title = element_text(size = 22)) +
theme(legend.key.size = unit(2, 'cm')) +
theme(legend.text = element_text(size = 18)) +
theme(legend.title = element_text(size = 18)) +
scale_x_continuous(breaks = ~ axisTicks(., log = FALSE))

# 4. Gender-wise distribution over the years
Gender_age_group <- suicide_data %>%
  select(Gender, Year, Total) %>%
  group_by(Gender, Year) %>%
  summarize(Total = sum(Total))

ggplot(Gender_age_group) +
  geom_line(mapping = aes(x = Year, y = Total, color = Gender), size = 1.15) +
  labs(title = "Gender-wise distribution over the years", x = "Year", y = "Cases per year")
geom_bar(position = "dodge", stat = "identity") +
scale_x_continuous(breaks = seq(2001,2012, by = 1))

# 5. Correlation between age group and total cases
correlation_data <- suicide_data %>%
  group_by(Age_group) %>%
  summarize(Total = sum(Total))
Causes_df = data.frame(Causes_df)
options(repr.plot.width = 15, repr.plot.height = 18)
ggplot(correlation_data) +
  geom_point(aes(x = Age_group, y = Total, color = Age_group), size = 4) +
  geom_smooth(aes(x = Age_group, y = Total), method = 'lm', se = FALSE) +
  labs(title = "Correlation between Age group and Total cases", x = "Age Group", y = "Total Cases")

# Load necessary libraries
library(dplyr)
library(ggplot2)
library(ggrepel)

# 6. Visualizing the leading causes of suicides in females
Female_cases <- suicide_data %>%
  select(Type_code, Type, Gender, Total) %>%
  filter(Type_code == "Causes", Gender == 'Female') %>%
  group_by(Type) %>%
  summarize(Total = sum(Total)) %>%
  arrange(desc(Total))

write.csv(Female_cases, "female_cases.csv")

# Leading Causes
leading_causes <- c('Family Problems', 'Causes Not known', 'Other Causes (Please Specify)',
                    'Other Prolonged Illness', 'Insanity/Mental Illness', 'Dowry Dispute',
                    'Love Affairs', 'Failure in Examination', 'Suspected/Illicit Relation',
                    'Poverty')

Top10_df <- Female_cases %>%
  filter(Type %in% leading_causes)

write.csv(Top10_df, "Top10.csv")

# Pie chart for Female cases
Top10_df <- Top10_df %>%
  arrange(desc(Type)) %>%
  mutate(prop = Total / sum(Top10_df$Total) * 100,
         ypos = cumsum(prop) - 0.5 * prop)

mycols <- c('blue', 'cyan', 'orange', 'coral', 'green', 'pink', 'lavender', 'yellow', 'violet', 'beige')

options(ggrepel.max.overlaps = Inf)
ggplot(Top10_df, aes(x = "", y = prop, fill = Type)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  theme_void() +
  theme(legend.position = "none") +
  geom_text_repel(aes(y = ypos, label = Total), color = "black", size = 6) +
  scale_fill_manual(values = mycols)

# 7. Visualizing leading causes of suicides in males
male_cases <- suicide_data %>%
  select(Type_code, Type, Gender, Total) %>%
  filter(Type_code == "Causes", Gender == 'Male') %>%
  group_by(Type) %>%
  summarize(Total = sum(Total)) %>%
  arrange(desc(Total))

write.csv(male_cases, "male_cases.csv")

# Leading Causes
Top10_df <- male_cases %>%
  filter(Type %in% leading_causes)

write.csv(Top10_df, "Top10.csv")

# Pie chart for Male cases
Top10_df <- Top10_df %>%
  arrange(desc(Type)) %>%
  mutate(prop = Total / sum(Top10_df$Total) * 100,
         ypos = cumsum(prop) - 0.5 * prop)

options(ggrepel.max.overlaps = Inf)
ggplot(Top10_df, aes(x = "", y = prop, fill = Type)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  theme_void() +
  theme(legend.position = "none") +
  geom_text_repel(aes(y = ypos, label = Total), color = "black", size = 6) +
  scale_fill_manual(values = mycols)

# 8. Visualizing the major means by which suicides were committed
Means_df <- suicide_data %>%
  select(Type_code, Type, Total) %>%
  filter(Type_code == "Means_adopted") %>%
  group_by(Type) %>%
  summarize(Total = sum(Total)) %>%
  arrange(desc(Total))

write.csv(Means_df, "Means.csv")

ggplot(data = Means_df) +
  geom_col(mapping = aes(x = Total, y = reorder(Type, Total), fill = Total)) +
  theme(axis.text = element_text(size = 10, colour = "black"),
        legend.position = "none") +
  scale_fill_gradient(guide = "colourbar") +
  theme(axis.title = element_blank()) +
  labs(title = "Major Means Taken") +
  theme(plot.title = element_text(size = 23))

# 9. Visualizing suicide cases by education status
education_df <- suicide_data %>%
  select(Type_code, Type, Total) %>%
  filter(Type_code == "Education_Status") %>%
  group_by(Type) %>%
  summarize(Total = sum(Total)) %>%
  arrange(desc(Total))

write.csv(education_df, "education.csv")

ggplot(data = education_df) +
  geom_col(mapping = aes(x = Total, y = reorder(Type, Total), fill = Total)) +
  theme(axis.text = element_text(size = 10, colour = "black"),
        legend.position = "none") +
  scale_fill_gradient(guide = "colourbar") +
  theme(axis.title = element_blank()) +
  labs(title = "Suicide cases by education status") +
  theme(plot.title = element_text(size = 23))

# 10. Visualizing suicide cases by professional status
profession_df <- suicide_data %>%
  select(Type_code, Type, Total) %>%
  filter(Type_code == "Professional_Profile") %>%
  group_by(Type) %>%
  summarize(Total = sum(Total)) %>%
  arrange(desc(Total))

write.csv(profession_df, "profession.csv")

ggplot(data = profession_df) +
  geom_col(mapping = aes(x = Total, y = reorder(Type, Total), fill = Total)) +
  theme(axis.text = element_text(size = 10, colour = "black"),
        legend.position = "none") +
  scale_fill_gradient(guide = "colourbar") +
  theme(axis.title = element_blank()) +
  labs(title = "Suicide cases by profession profiles") +
  theme(plot.title = element_text(size = 23))

# 11. Visualizing suicide cases by social status
social_df <- suicide_data %>%
  select(Type_code, Type, Total) %>%
  filter(Type_code == "Social_Status") %>%
  group_by(Type) %>%
  summarize(Total = sum(Total)) %>%
  arrange(desc(Total))

write.csv(social_df, "social.csv")

ggplot(data = social_df) +
  geom_col(mapping = aes(x = Total, y = reorder(Type, Total), fill = Total)) +
  theme(axis.text = element_text(size = 10, colour = "black"),
        legend.position = "none") +
  scale_fill_gradient(guide = "colourbar") +
  theme(axis.title = element_blank()) +
  labs(title = "Suicide cases by social status") +
  theme(plot.title = element_text(size = 23))

# 12. Visualizing the age-wise distribution for the leading causes of suicide cases
Causes_age_wise_df <- suicide_data %>%
  select(Type_code, Type, Age_group, Total) %>%
  filter(Type_code == "Causes") %>%
  group_by(Type, Age_group) %>%
  summarize(Total = sum(Total)) %>%
  arrange(Age_group, desc(Total))

write.csv(Causes_age_wise_df, "Causes Age Wise.csv")

Leading_causes <- c("Family Problems", "Causes Not known", "Love Affairs", 
                    "Other Prolonged Illness", "Insanity/Mental Illness")

Top5_df <- Causes_age_wise_df %>%
  filter(Type %in% Leading_causes)

write.csv(Top5_df, "Top 5.csv")

# INDIVIDUAL FRAMES FOR EACH AGE GROUP
age_groups <- c("0-14", "15-29", "30-44", "45-59", "60+")
for (age_group in age_groups) {
  Top5_age_group_df <- subset(Top5_df, Age_group == age_group, select = c(Type, Total))
  write.csv(Top5_age_group_df, paste0("Top 5 ", age_group, ".csv"))
}

# INDIVIDUAL GRAPHS FOR AGE-WISE DISTRIBUTION
for (age_group in age_groups) {
  Top5_age_group_df <- subset(Top5_df, Age_group == age_group)
  ggplot(data = Top5_age_group_df) +
    geom_col(mapping = aes(x = reorder(Type, Total), y = Total, fill = Total)) +
    theme(axis.text = element_text(size = 10, colour = "black"),
          legend.position = "none") +
    theme(axis.title = element_blank()) +
    labs(title = paste("Age Group", age_group)) +
    theme(plot.title = element_text(size = 23))
}

# GROUP BAR PLOT REPRESENTATION FOR ALL AGES
ggplot(aes(x = Type, y = Total, group = Age_group, fill = Age_group), data = Top5_df) +
  geom_bar(position = "dodge", stat = "identity")


# Linear Regression

# Drawing a relation between the total deaths and years for the timeline 2001-2012
relation <- lm(Total ~ Year, data = cases_over_11_years)
summary(relation)

# Predicting total deaths for the timeline 2007-2012
predict_years <- data.frame(Year = c(2007, 2008, 2009, 2010, 2011, 2012))
predictions <- predict(relation, newdata = predict_years)

# Create prediction table
years <- seq(2001, 2012, 1)
prediction_table <- data.frame(Year = years, Total = c(rep(NA, 6), predictions))

# Plotting original dataset and predictions
plot(cases_over_11_years$Year, cases_over_11_years$Total, pch = 16, col = "blue")
points(prediction_table$Year, prediction_table$Total, col = "red", pch = 16)
abline(relation)
