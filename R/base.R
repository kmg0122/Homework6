library("shiny")

shinyUI(pageWithSidebar(
  
  headerPanel("Flexdashboard"),
  
  sidebarPanel(
    selectInput("symbol", "Select your portfolio", 
                choices = c("AAPL","TSLA","SPY","PG","TWTR"), selected = c("TSLA","PG", "TWTR"),
                multiple = TRUE), 
    
    dateRangeInput('dateRange',
                   label = 'Date range input: yyyy-mm-dd',
                   start = '2021-11-01', end = Sys.Date()),
    
    conditionalPanel(
      condition = "input.symbol.indexOf('AAPL') > -1",
      numericInput("var1","weight of the AAPL","0")
    ),
    
    conditionalPanel(
      condition = "input.symbol.indexOf('TSLA') > -1",
      numericInput("var2","weight of the TSLA","0")
    ),
    
    conditionalPanel(
      condition = "input.symbol.indexOf('SPY') > -1",
      numericInput("var3","weight of the SPY","0")
    ),
    
    
    conditionalPanel(
      condition = "input.symbol.indexOf('PG') > -1",
      numericInput("var4","weight of the PG","0")
    ),
    
    conditionalPanel(
      condition = "input.symbol.indexOf('TWTR') > -1",
      numericInput("var5","weight of the TWTR","0")
    )
    
  ),
  
  
  
  mainPanel(
    
    tabsetPanel(
      tabPanel(
        "Portpoilo",
        plotOutput("portfolio")),
      
      tabPanel(
        "Timeseries",
        plotOutput("timeseries")
      )
      
      
    )
  )
  
)
)
