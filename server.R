#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(caret)
library(randomForest)

#
# Defines the Random Forest model and predictor for 'mpg' in the 'mtcars' dataset.
#
source(file = "modelCreation.R")

#
# Setting up Shiny Server
#
shinyServer(
  
  function(input, output, session) {
    
    # To show new lines in the browser
    decoratedDataStructure <- paste0(dataStructure, collapse = "<br/>")
    output$dataStructure <- renderText({decoratedDataStructure})
    
    # Builds "reactively" the prediction.
    predictMpg <- reactive({
      
      carToPredict <- data.frame(
        cyl = input$cyl, 
        disp = input$disp, 
        hp = input$hp, 
        drat = input$drat, 
        wt = input$wt, 
        qsec = input$qsec, 
        vs = as.numeric(input$vs), 
        am = as.numeric(input$am), 
        gear = input$gear, 
        carb = input$carb)
      
      randomForestPredictor(mtcarsRandomForestModelBuilder(), carToPredict)
      
    })
    
    output$prediction <- renderTable({
      predictMpg()
    })
    
  }
  
)
