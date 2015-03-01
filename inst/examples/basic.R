library("shiny")
library("shinyTypeahead")


shinyApp(
  ui = fluidPage(
    flowLayout(
      typeaheadInput("sel_car", "Enter a car", row.names(mtcars)),
      #selectizeInput("sel_car2", "Enter a car", c("", row.names(mtcars)), options = list(create = TRUE, maxItems = "1", placeholder = "Pick a car", persist = FALSE)),
      div(strong("Your input:"), textOutput("test_output"))
    )
  ),
  server = function(input, output){
    output$test_output <- renderText(input$sel_car)
    }
)
