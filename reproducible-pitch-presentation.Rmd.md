Reproducible Pitch - Developing Data Products
========================================================
author: "SS (Mountain Lion)"
date: "December 21, 2017"
autosize: true

Introduction
========================================================

- This presentation is for the assignemnt of Week 4, ***Developing Data Products course from Coursera*** (<https://www.coursera.org/learn/data-products>). 
 
- The presentation is meant to show the salient features and design principles applied for the development of the said application.

- The presentation was generated using ***RStudio***(<https://www.rstudio.com>) and ***R Studio Presenter***(<https://support.rstudio.com/hc/en-us/sections/200130218-R-Presentations>) framework.


Application
========================================================

- This application demonstrates Model-View-Controller (MVC) pattern as supported through Shiny Web App framework.An instance is up & running at  <https://mountain-lion.shinyapps.io/Course-Project/> and the source code can be found at <https://github.com/mountain-lion/developing-data-products-final-course-project>. 
      
- The Model is coded in order to lazily re-initialize while handling user event at the view-controller (sidebar widgets). Furthermore, the UI (view-controller) paramerters directly map to the underlying variables of the dataset/table.

- In the application, an user can freely play with the UI values in order to simulate the parameters (side-bar widgets) of an hypothetical car and predict its MPG consumption.


Dataset
========================================================

Dataset used by the application is the [Motor Trend Car Road Tests](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html) (from now on *'mtcars'*). The data was extracted from the ***1974 Motor Trend*** US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models).


```
'data.frame':	32 obs. of  11 variables:
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
 $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
 $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
 $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

Prediction
========================================================

The said Random Forest prediction model is generated and trained using the *'mtcars'* dataset. 


- Example of Prediction using the Random Forest model


```r
hypotheticalCar <- data.frame(
  cyl = 5, disp = 100, hp = 80, drat = 4.1, wt = 1.8, qsec = 24, vs = 1, am = 1, gear = 4, carb = 2)
```
- Predicted MPG (Miles-Per-Gallon) for the above hypothetical Car using Random Forest Model is: 






```
[1] 29.39747
```
- The above value of MPG has been predicted using the same callback to Random Forest model builder function that got used in the Shiny Web App described in this presentation. 
