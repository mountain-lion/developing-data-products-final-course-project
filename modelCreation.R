library(caret)
library(randomForest)

#
# Creating Random Forest predictor for UI model-view.
#

# Initializing data. 
data("mtcars")

# To show structure in UI
dataStructure <- capture.output(str(mtcars))

# Setting up the random generator seed.
set.seed(441977) 

# Defining custom training controls with cross-validation.
mtcarsTrainControl <- trainControl(method = "cv", number = 10)

# Building Random Forest model function. 
# For rebuilding the model when the user change any slider parameters in the UI sidebar.
# The goal of this model is to predict 'mpg' (miles per gallon) using all other
# variables.
mtcarsRandomForestModelBuilder <- function() {
  
  return(
    train(
      mpg ~ ., 
      data = mtcars,
      method = "rf",
      trControl = mtcarsTrainControl
    )
  )
  
}

# Predictor function.  This is invoked 'lazily' to handle an event from the view-controller (sidebar widgets).
randomForestPredictor <- function(model, parameters) {
  
  prediction <- predict(
    model,
    newdata = parameters
  )
  
  return(prediction)
  
}