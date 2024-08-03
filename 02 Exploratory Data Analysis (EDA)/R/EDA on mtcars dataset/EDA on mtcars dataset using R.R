# Exploratory Data Analysis using R
# Author: Masud Rahman (https://masud90.github.io/)
# Dataset: mtcars from R datasets package

# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(GGally)
library(reshape2)

# Load the mtcars dataset
data("mtcars")

# Inspect the first few rows of the dataset
head(mtcars)

# Summary statistics
summary(mtcars)

# Check for missing values in the dataset
missing_values <- sum(is.na(mtcars))
if (missing_values == 0) {
  print("There are no missing values in the dataset.")
} else {
  print(paste("There are", missing_values, "missing values in the dataset."))
}

# Inspect the data types of all columns
str(mtcars)

# Convert 'cyl', 'vs', 'am', 'gear', and 'carb' to factors for categorical analysis
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)

# Check the structure again to confirm data type changes
str(mtcars)

# EDA: Visualizations
# 1. Histogram of 'mpg'
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "black") +
  labs(title = "Distribution of Miles Per Gallon (mpg)", x = "Miles Per Gallon", y = "Frequency")

# 2. Boxplot of 'mpg' by 'cyl'
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_boxplot() +
  labs(title = "Boxplot of MPG by Number of Cylinders", x = "Number of Cylinders", y = "Miles Per Gallon")

# 3. Scatter plot of 'hp' vs 'mpg'
ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Horsepower vs Miles Per Gallon", x = "Horsepower", y = "Miles Per Gallon")

# 4. Pairwise plot for all variables
ggpairs(mtcars, columns = 1:7, ggplot2::aes(color = cyl)) +
  labs(title = "Pairwise Plot of All Variables")

# 5. Correlation heatmap
mtcars_numeric <- mtcars %>%
  select_if(is.numeric)

# Calculate the correlation matrix
cor_matrix <- round(cor(mtcars_numeric), 2)

# Reshape the correlation matrix for plotting
cor_melted <- melt(cor_matrix)

# Plot the correlation heatmap
ggplot(cor_melted, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), space = "Lab", 
                       name = "Pearson\nCorrelation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1)) +
  coord_fixed()