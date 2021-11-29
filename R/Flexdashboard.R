library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Flexdashboard"),
  
  sidebarPanel(
     selectInput("symbol", "Select your portfolio", 
                choices = c("AAPL","FB","JPM","MRNA","WMT"), selected = c("AAPL","FB"),
                multiple = TRUE), 
     
     dateRangeInput('dateRange',
                     label = 'Date range input: yyyy-mm-dd',
                     start = '2021-11-15', end = Sys.Date()),
     
     conditionalPanel(
       condition = "input.symbol.indexOf('AAPL') > -1",
       numericInput("var1","Enter the weightage of the AAPL","10")
     ),
     
     conditionalPanel(
       condition = "input.symbol.indexOf('FB') > -1",
       numericInput("var2","Enter the weightage of the FB","10")
     ),

     conditionalPanel(
       condition = "input.symbol.indexOf('JPM') > -1",
       numericInput("var3","Enter the weightage of the JPM","10")
     ),
     

     conditionalPanel(
       condition = "input.symbol.indexOf('MRNA') > -1",
       numericInput("var4","Enter the weightage of the MRNA","10")
     ),
     
     conditionalPanel(
       condition = "input.symbol.indexOf('WMT') > -1",
       numericInput("var5","Enter the weightage of the WMT","10")
     )
     
      ),
  
  
   
    mainPanel(
      
      tabsetPanel(
        tabPanel(
          "Portfolio Worth",
          plotOutput("portfolio"),
          plotOutput("piechart")),
          
        tabPanel(
          "Timeseries",
          plotOutput("timeseries")
        )
        

        )
      )
      
    )
)
