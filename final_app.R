library(shiny)
library(rCharts)
library(rMaps)

runApp(list(
  ui = pageWithSidebar(
    headerPanel("Shiny, rCharts and DataMaps"),
    sidebarPanel(
      selectInput("pal", 'Select Palette', c('Blues', 'PuRd', 'Greens', 'YlOrRd', 'PuBu')), 
      numericInput("ncuts", 'Select Number of Breaks', value = 5, min = 4, max = 9)
    ),
    mainPanel(
      chartOutput("myplot", 'datamaps')       
    )
  ),
  server = function(input, output, session){
    output$myplot<- renderChart2({
      d1 <-  ichoropleth(
        Population ~ name, 
        labels = TRUE,   
        data = info1,
        pal = input$pal,
        ncuts = input$ncuts,
        legend = TRUE,
        #       animate = 'year',
        #       play = TRUE,
      )
      d1$set(  
        geographyConfig = list(
          dataUrl = "https://dl.dropboxusercontent.com/u/13661419/states2.json",
          highlightFillColor = 'orange',
          highlightBorderColor = 'white',
          highlightBorderWidth = 1.5,
          popupOnHover = TRUE,
          popupTemplate = "#! function(geography, data){
          return '<div class=hoverinfo>' + geography.properties.name + 
          ': ' + data.Population+ '</div>';
    } !#"        
        ),
        scope = 'nuts2wgs2',
        height = 1050,
        legend = TRUE,
        setProjection = '#! function( element, options ) {
        var projection, path;
        projection = d3.geo.mercator()  
        .scale(480)
        .center([29.34034978813841, 65.012062015793])
        path = d3.geo.path().projection( projection );
        return {path: path, projection: projection};
  } !#'
      )
      d1
  })       
  }
))