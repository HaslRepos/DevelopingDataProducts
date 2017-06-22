library(quantmod)

shinyServer(function(input, output) {

  # Retrieving timeseries data based on ticker symbol and date range
  getSeries <- reactive({
                  getSymbols(input$symbol, 
                             src = "google", 
                             from = input$dateRange[1],
                             to = input$dateRange[2],
                             auto.assign = FALSE
                            )
  })

  output$chart <- renderPlot({

    # Get the timeseries object
    series <- getSeries()

    # Display chart based on timeseries, chart type and indicators
    # Not selected indicators require different notation
    if (!is.null(input$indicator)) {
      chartSeries(series, name = input$symbol, theme = chartTheme('white'), type = input$chartType, TA = paste(input$indicator, collapse = ";"))
    } else {
      chartSeries(series, name = input$symbol, theme = chartTheme('white'), type = input$chartType, TA = NULL)
    }
    
  })

  output$data <- renderTable({

    # Get the timeseries object
    series <- getSeries()

    # Format the index of the timeseries object as Date
    dates <- format(index(series),"%Y-%m-%d")

    # Display the timeseries object and the converted index
    data.frame(Date=dates, series)

  })

})
