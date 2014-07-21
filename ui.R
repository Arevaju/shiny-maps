library(shiny)
library(rCharts)
library(rMaps)


  ui = pageWithSidebar(
    headerPanel("Shiny, rCharts and DataMaps"),
    sidebarPanel(
      selectInput("pal", 'Select Palette', c('Blues', 'PuRd', 'Greens', 'YlOrRd', 'PuBu')), 
      numericInput("ncuts", 'Select Number of Breaks', value = 5, min = 4, max = 9)
    ),
    mainPanel(
      chartOutput("myplot", 'datamaps')       
    )
  )
