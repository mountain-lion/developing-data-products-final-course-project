#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Adding support for graphical tooltips and pop-overs; added to beutify the UI.
library(shinyBS) 
# Adding Bootstrap themes to a Shiny app.
library(shinythemes)

dataset <- diamonds

# 'mtcars' dataset, used for setting up limits in UI widgets (view-controller)
data("mtcars")
minCylinders = min(mtcars$cyl)
maxCylinders = max(mtcars$cyl)

minDisp = min(mtcars$disp)
maxDisp = max(mtcars$disp)

minHp = min(mtcars$hp)
maxHp = max(mtcars$hp)

minDrat = min(mtcars$drat)
maxDrat = max(mtcars$drat)

minWt = min(mtcars$wt)
maxWt = max(mtcars$wt)

minQsec = min(mtcars$qsec)
maxQsec = max(mtcars$qsec)

minGear = min(mtcars$gear)
maxGear = max(mtcars$gear)

minCarb = min(mtcars$carb)
maxCarb = max(mtcars$carb)


# Default hypothetical car, in order to initialize th UI widgets.
defaultCar <- data.frame(
  cyl = 5, 
  disp = 100, 
  hp = 80, 
  drat = 4.1, 
  wt = 1.8, 
  qsec = 24, 
  vs = 1, 
  am = 1, 
  gear = 4, 
  carb = 2)

shinyUI(
  
  navbarPage(
    
    "Miles-Per-Gallon (MPG) Prediction",
    
    theme = shinytheme("slate"),
    
    tabPanel(
      
      "Prediction",
      
      sidebarPanel(
        
        width = 4,
        
        sliderInput("cyl", "Cylinders", min = minCylinders, max = maxCylinders, value = defaultCar$cyl, step = 1),
        bsTooltip(id = "cyl", title = "Number of cylinders in the engine", placement = "right", options = list(container = "body")),
        
        sliderInput("disp", "Displacement", min = minDisp, max = maxDisp, value = defaultCar$disp, step = 1),
        bsTooltip(id = "disp", title = "Engine displacement (in cu.in.)", placement = "right", options = list(container = "body")),
        
        sliderInput("hp", "Power", min = minHp, max = maxHp, value = defaultCar$hp, step = 1),
        bsTooltip(id = "hp", title = "Engine's gross horsepower in HP", placement = "right", options = list(container = "body")),
        
        sliderInput("drat", "Rear axle ratio", min = minDrat, max = maxDrat, value = defaultCar$drat, step = 0.01),
        bsTooltip(id = "drat", title = "Rear axle ratio", placement = "right", options = list(container = "body")),
        
        sliderInput("wt", "Weight", min = minWt, max = maxWt, value = defaultCar$wt, step = 1),
        bsTooltip(id = "wt", title = "Weight in 1000 lbs", placement = "right", options = list(container = "body")),
        
        sliderInput("qsec", "1/4 mile time", min = minQsec, max = maxQsec, value = defaultCar$qsec, step = 0.1),
        bsTooltip(id = "qsec", title = "1/4 mile time in seconds", placement = "right", options = list(container = "body")),
        
        radioButtons("vs", label = "Engine shape", choices = list("V-Shape" = 0, "Straight" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "vs", title = "Engine cylinder configuration (V-shape or straight)", placement = "right", options = list(container = "body")),
        
        radioButtons("am", label = "Transmission", choices = list("Automatic" = 0, "Manual" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "am", title = "Transmission type (automatic or manual)", placement = "right", options = list(container = "body")),
        
        sliderInput("gear", "Gears", min = minGear, max = maxGear, value = defaultCar$gear, step = 1),
        bsTooltip(id = "gear", title = "Number of forward gears in the transmission", placement = "right", options = list(container = "body")),
        
        sliderInput("carb", "Carburetors", min = minCarb, max = maxCarb, value = defaultCar$carb, step = 1),
        bsTooltip(id = "carb", title = "Number of carburetor barrels", placement = "right", options = list(container = "body"))
        
      ),
      
      mainPanel(
        
        width = 8,
        
        h3("MPG Prediction Report"),
        
        br(),
        
        h4("Prediction of MPG Based Upon Your Inputs"),
        
        hr(),
        
        p("Consumption as in Miles-Per-Gallon (MPG) will be (approx.): "),
        
        tableOutput("prediction")
        
      )
      
    ),
    
    tabPanel(
      
      "Help",
      
      p("This application demonstrates Model-View-Controller (MVC) pattern as supported through Shiny Web App framework."),
      
      p("The Model is coded in order to lazily re-initialize while handling user event at the view-controller (sidebar widgets).
        Furthermore, the UI (view-controller) paramerters directly map to the underlying variables of the dataset/table."),
      
      p("A Random Forest prediction model is (re)generated, trained and rendered for a specific dataset of cars (see below)."),
      
      p("One can freely change the various values in the sidebar panel to simulate the parameters of an hypothetical car and the application 
         will predict its corresponding MPG consumption in the main panel on the right."),
      
      
      hr(),
      
      p("Dataset used by the application is the ",
        a(href = "https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "Motor Trend Car Road Tests"),
        "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."
      ),
      
      
      tags$div("Overview of the Dataset used:",
               tags$ul(
                 tags$li(strong("mpg"), "Miles/(US) gallon"),
                 tags$li(strong("cyl"), "Number of cylinders"),
                 tags$li(strong("disp"), "Displacement (cu.in.)"),
                 tags$li(strong("hp"), "Gross horsepower"),
                 tags$li(strong("drat", "Rear axle ratio"),
                         tags$li(strong("wt"), "Weight (1000 lbs)"),
                         tags$li(strong("qsec"), "1/4 mile time"),
                         tags$li(strong("vs"), "V/S (V-shape or straight engine)"),
                         tags$li(strong("am"), "Transmission (0 = automatic, 1 = manual)"),
                         tags$li(strong("gear"), "Number of forward gears"),
                         tags$li(strong("carb"), "Number of carburetor"))
               ),
               
               tableOutput("dataStructure")
               
      )
      
    ),
    
    tabPanel(
      
      "About",
      
      h3("Developing Data Products - Course Project - Shiny Application with Reproducible Pitch"),
      
      h3("Author: SS (Mountain Lion), Date of Creation: Dec 22, 2017"),
      
      br(),
      
      p("This application demonstrates a working MVC based web application using R and ",
        a(href = "https://shiny.rstudio.com/", "Shiny library"),
        "as specified in Assignment for Week 4,",
        a(href = "https://www.coursera.org/learn/data-products", "Developing Data Products course from Coursera")
      ),
      
      br(),
      
      p("Source code of this application is available at",
        a(href = "https://github.com/mountain-lion/developing-data-products-final-course-project",
          "https://github.com/mountain-lion/developing-data-products-final-course-project")
      ),
      
      hr(),
      
      p("Disclaimer: This application and supporting documentation is purely for a demo project pertaining to
        an educational course. Hence, there is absolutely NO WARRANTY and/or support from the creator/author.")
      
    )
    
    
  )
  
)