library("shiny")
library("shinyTypeahead")


shinyApp(
  ui = fluidPage(
    flowLayout(
      typeaheadInput("sel_car", "Enter a car", row.names(mtcars)),
      div(strong("Your input:"), textOutput("test_output"))
    )
  ),
  server = function(input, output){
    output$test_output <- renderText(input$sel_car)
    }
)
