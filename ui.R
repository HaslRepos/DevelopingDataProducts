library(shiny)

shinyUI(fluidPage(

  titlePanel("Stock Price Analyzer"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Insert a stock symbol according to Google Finance (https://www.google.com/finance)."),

      # Read stock symbol (Default symbol: Google)
      textInput("symbol", "Stock symbol", "GOOG"),

      helpText("Define the required date range by moving the slider."),

      # Read date range (Default range: Last 180 days, with maximum history of 1825 days)
      sliderInput("dateRange",
                  "Date range:",
                  min = Sys.Date()-1825,
                  max = Sys.Date(),
                  value=c(Sys.Date()-180,Sys.Date()),
                  timeFormat="%Y-%m-%d"),

      helpText("Select the chart type."),

      # Get chart type (Default type: Candlestick chart)      
      radioButtons('chartType', "Chart type:", choices=c("Candlestick" = "candlesticks",
                                                         "Matchstick" = "matchsticks", 
                                                         "Bar" = "bars", 
                                                         "Line" = "line"), selected = "candlesticks"),
      
      helpText("Select the technical indicator. Multiple selection possible."),
      
      # Get technical indicator (Default indicator: None)
      checkboxGroupInput("indicator", "Indicator:", c("Volume" = "addVo()", 
                                                      "Bollinger Bands" = "addBBands()",
                                                      "Moving Average Convergence Divergence" = "addMACD()",
                                                      "Simple Moving Average" = "addSMA()"
                                                     ), selected = NULL)

    ),
    
    mainPanel(
      helpText("The Stock Price Analyzer provides graphical and tabular information on financial 
               instruments utilizing Google Finance. It is fully configurable by selecting the ticker 
               for the stock of interest (eg GOOG, MSFT, GE), defining a date range, the chart type 
               and optionally include some indicators for technical analysis. Click on the tabs to 
               switch between the raw timeseries data and the chart."),

      br(),

      tabsetPanel(type = "tabs", 
                          tabPanel("Timeseries Chart", plotOutput("chart")),
                          tabPanel("Timeseries Data", tableOutput("data"))
      )
  )
)))