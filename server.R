library(shiny)
source("project.R")
themes<-sort(unique(data$theme))

shinyServer(
function(input, output,session) {
  
  values <- reactiveValues()
  values$themes <- themes
 
 output$themesControl <- renderUI({
   checkboxGroupInput('themes', 'LEGO Themes:', 
                      themes, selected = values$themes)
 })
  
 observe({
   if(input$selectAll == 0) return()
   values$themes <- themes
 })
 
 observe({
   if(input$clearAll == 0) return()
   values$themes <- c() # empty list
 })

dataTable<-reactive({
  groupbytheme(data,input$year[1],input$year[2],input$pieces[1],input$pieces[2],input$themes)
  
  
})

dataTableByYear<-reactive({
  groupbyYearAgg(data,input$year[1],input$year[2],input$pieces[1],input$pieces[2],input$themes)
  
  
})

dataTableByPieceAvg<-reactive({
  groupbyPieceAvg(data,input$year[1],input$year[2],input$pieces[1],input$pieces[2],input$themes)
  
  
})


dataTableByPieceThemeAvg<-reactive({
  groupbyPieceThemeAvg(data,input$year[1],input$year[2],input$pieces[1],input$pieces[2],input$themes)
  
  
})

output$dTable <- renderDataTable({
  dataTable()
} 
)




output$PiecesByYearAvg <- renderChart2({
  plotPiecesByYearAvg(dataTableByPieceAvg())
})

output$PiecesByThemeAvg <- renderChart2({
  plotPiecesByThemeAvg(dataTableByPieceThemeAvg())
})

}

)