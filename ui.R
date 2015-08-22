library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

library(shiny)
shinyUI(
  navbarPage("LEGO Sets Information",
  
  tabPanel("Explore the Data",
  sidebarPanel(
sliderInput("year","YEAR:",min=1950,max=2015,value=c(1970,2000)),  
sliderInput("pieces","Number of Pieces",min=-1,max=5922,value=c(200,2000)),

uiOutput("themesControl"), # the id
actionButton(inputId = "clearAll", 
             label = "Clear selection", 
             icon = icon("square-o")),
actionButton(inputId = "selectAll", 
             label = "Select all", 
             icon = icon("check-square-o"))
    
    
    ),
  mainPanel(
    tabsetPanel(
      tabPanel(p(icon("table"), "Dataset"),
               dataTableOutput(outputId="dTable")
      ),
      tabPanel(p(icon("line-chart"), "Visualize the Data"), 
               h4('Number of Average Pieces by Year', align = "center"),
               showOutput("PiecesByYearAvg", "nvd3"),
               h4('Number of Average Pieces by Theme', align = "center"),
               showOutput("PiecesByThemeAvg", "nvd3")
      ) 
      
    )
    
    
    
    )
  
)  )

)