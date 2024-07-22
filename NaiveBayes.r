# Set the working directory
setwd("C:/Users/Personal/Documents")

# Read the data from the file
d1 <- read.table("climate.dat", header = TRUE)

# Set options for maximum print
options(max.print = 540)

# Display the dataset and its column names
print(d1)
print(names(d1))

# Check for missing values
print(is.na(d1))
print(table(is.na(d1)))

# Load required libraries
library(caTools)
library(caret)
library(e1071) # For Naive Bayes

# Create training and testing datasets
set.seed(3333) # Ensure reproducibility
intrain <- createDataPartition(y = d1$outcome, p = 0.7, list = FALSE)
training <- d1[intrain,]
testing <- d1[-intrain,]

# Display dimensions of training and testing datasets
print(dim(training))
print(dim(testing))

# Train the Naive Bayes model
nb_model <- naiveBayes(outcome ~ ., data = training)

# Predict on the testing dataset
nb_predictions <- predict(nb_model, testing)

# Evaluate the model
conf_matrix <- confusionMatrix(nb_predictions, testing$outcome)
print(conf_matrix)

# Plotting is not relevant for Naive Bayes as it is for decision trees
