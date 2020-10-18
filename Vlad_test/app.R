#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)
library(ggforce)
library(readr)

d <-  read.csv("Cleaned_Ukraine_data.csv")

# Define UI for application
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # setting up drop downs 
   selectInput("x", "X variable", choices = names(d)),
   selectInput("y", "Y variable", choices = names(d)),
   selectInput("geom", "geom", c("point", "smooth", "column", "jitter")),
   plotOutput("plot")
   
)
   


# Define server logic
server <- function(input, output, session) {
  plot_geom <- reactive({
    switch(input$geom,
           point = geom_point(),
           smooth = geom_smooth(se = TRUE, na.rm = TRUE),
           column = geom_col(),
           jitter = geom_jitter()
    )
  })
  
  output$plot <- renderPlot({
    ggplot(d, aes(.data[[input$x]], .data[[input$y]])) +
      plot_geom()
  }, res = 96)
}


# Run the application 
shinyApp(ui = ui, server = server)

