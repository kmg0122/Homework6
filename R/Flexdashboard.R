library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  
  githubURL<-("C:/Users/Mingang Kim/Downloads/StockPrice.RDS")
  data<-readRDS(githubURL)
  
  weight<-reactive({
    
    weight<-data.frame(symbol=character(),weights=numeric())
    
    if(!is.null(input$var1)){
      weight<-weight%>%add_row(symbol='AAPL',weights=input$var1)
    }
    if(!is.null(input$var2)){
      weight<-weight%>%add_row(symbol='TSLA',weights=input$var2)
    }
    if(!is.null(input$var3)){
      weight<-weight%>%add_row(symbol='SPY',weights=input$var3)
    }
    if(!is.null(input$var4)){
      weight<-weight%>%add_row(symbol='PG',weights=input$var4)
    }
    if(!is.null(input$var5)){
      weight<-weight%>%add_row(symbol='TWTR',weights=input$var5)
    }
    weight$weights<-weight$weights/sum(weight$weights)
    return(weight)
  })
  
  reactive_data <- reactive({
    data %>%
      filter(symbol %in% input$symbol) %>%
      filter(date >= input$dateRange[1] & date<= input$dateRange[2]) %>%
      left_join(weight(),by = "symbol")
  }) 
  
  
  output$timeseries <- renderPlot({
    
    ggplot(reactive_data(),aes(x=date,y=adjusted,color=symbol))+
      geom_point()+geom_line()+xlab('Date')+ylab('Adjusted price')+theme_bw()+
      ggtitle("Plot of Adjusted price")
    
  })
  
  
 
  
  output$portfolio <- renderPlot({
    
    portfoliodata<-reactive_data()%>%
      mutate(returns=adjusted/lag(adjusted,1)-1) %>%
      mutate(weighted.returns=returns*weights) %>%
      filter(date>min(date))
    
    ggplot(portfoliodata,aes(x=date,y=weighted.returns,fill=symbol))+
      geom_bar(stat='identity')
  })
  
})
