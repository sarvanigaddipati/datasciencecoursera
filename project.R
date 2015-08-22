require(data.table)
library(dplyr)
library(DT)
library(rCharts)
data<-fread("sets.csv")
head(data)
setnames(data,"t1","theme")
setnames(data,"set_id","setId")
sum(is.na(data))
length(unique(data$setId))#10418
length(unique(data$year))#64
years<-sort(unique(data$year))
length(unique(data$theme))#101
themes <- sort(unique(data$theme))

groupbyYearPiece<-function(data1,minYear,maxYear,minPiece,maxPiece, themes){
  
  result<-data1%>%filter(year>=minYear,year<=maxYear,pieces>=minPiece,pieces<=maxPiece,
                         theme %in% themes)
  return(result)

}



groupbytheme<-function(data1,minYear,maxYear,minPiece,maxPiece,themes){
  
  data1<-groupbyYearPiece(data1,minYear,maxYear,minPiece,maxPiece,themes)
  result<-datatable(data1,options=list(iDisplayLength = 50))
  return(result)
  
}


groupbyYearAgg<-function(data1,minYear,maxYear,minPiece,maxPiece,themes){
  data1<-groupbyYearPiece(data1,minYear,maxYear,minPiece,maxPiece,themes)
  result<- data1%>% group_by(year) %>% summarise(count=n())%>%arrange(year)
  return(result)
  }


groupbyPieceAvg<-function(data1,minYear,maxYear,minPiece,maxPiece,themes){
  data1<-groupbyYearPiece(data1,minYear,maxYear,minPiece,maxPiece,themes)
  result<-data1%>% group_by(year) %>% summarise(avg=mean(pieces)) %>% arrange(year)
  return(result)
  
}


groupbyPieceThemeAvg<-function(data1,minYear,maxYear,minPiece,maxPiece,themes){
  
  data1<-groupbyYearPiece(data1,minYear,maxYear,minPiece,maxPiece,themes)
  result<-data1%>% group_by(theme) %>% summarise(avgPieces=mean(pieces)) %>% arrange(theme)
  return(result)
  
}



plotThemesCountByYear<-function(data1,dom="themesByYear",
                          xAxisLabel="Year",
                          yAxisLabel="Number of themes") {
  themesByYear<-nPlot(
    count~year,
    data=data1,
    type="multiBarChart",
    dom=dom,
    widht=650
    
    
    )
  themesByYear$chart(margin=list(left=100))
  themesByYear$yAxis(axislabel=yAxisLabel,width=80)
  themesByYear$xAxis(axislabel=xAxisLabel,width=70)
  return(themesByYear)
}


plotPiecesByYearAvg<-function(data1,dom="piecesByYearAvg",
                           xAxisLabel="Year",
                           yAxisLabel="Number of pieces"
                           ){
  
  piecesByYearAvg <- nPlot(
    avg ~ year,
    data = data1,
    type = "lineChart",
    dom = dom, width = 650
  )
  
  piecesByYearAvg$chart(margin=list(left=100))
  piecesByYearAvg$chart(color=c('red','green','blue'))
  piecesByYearAvg$yAxis(axisLabel=yAxisLabel,width=80)
  piecesByYearAvg$xAxis(axisLabel=xAxisLabel,width=70)
  return(piecesByYearAvg)
  
}
  
plotPiecesByThemeAvg <- function(data1, dom = "piecesByThemeAvg", 
                                 xAxisLabel = "Themes", 
                                 yAxisLabel = "Number of Pieces") {
  piecesByThemeAvg <- nPlot(
    avgPieces ~ theme,
    data = data1,
    type = "multiBarChart",
    dom = dom, width = 650
  )
  piecesByThemeAvg$chart(margin = list(left = 100))
  piecesByThemeAvg$chart(color = c('red', 'blue', 'green'))
  piecesByThemeAvg$yAxis(axisLabel = yAxisLabel, width = 80)
  piecesByThemeAvg$xAxis(axisLabel = xAxisLabel, width = 200,
                         rotateLabels = -20, height = 200)
  return(piecesByThemeAvg)
  
}




