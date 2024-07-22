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
library(rpart.plot)
library(rpart)

# Create training and testing datasets
set.seed(3333) # Ensure reproducibility
intrain <- createDataPartition(y = d1$outcome, p = 0.7, list = FALSE)
training <- d1[intrain,]
testing <- d1[-intrain,]

# Display dimensions of training and testing datasets
print(dim(training))
print(dim(testing))

# Train the decision tree model using repeated cross-validation
trctrl <- trainControl(method = "repeatedcv", number = 2, repeats = 2)
dtree <- train(outcome ~ ., data = d1, method = "rpart", parms = list(split = "gini"), trControl = trctrl, tuneLength = 10)

# Ensure the outcome variable is correctly named
names(d1)[21] <- "outcome"

# Print updated column names and the dataset
print(names(d1))
print(d1)

# Plot the decision tree
prp(dtree$finalModel)
