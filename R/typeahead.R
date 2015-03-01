#' Typeahead input
#' @export
typeaheadInput <- function (inputId, label, choices, value = NULL, options = NULL){

  #For testing: inputId = "states"; label = "States"; choices = ""; value = NULL; options = NULL

  typeahead_path <- function() system.file("www", package = "shinyTypeahead")

  deps <-
    htmltools::htmlDependency(
      name = "shinyTypeahead",
      version = as.character(packageVersion("shinyTypeahead")),
      src = typeahead_path(),
      stylesheet = c("typeahead.js/typeaheadjs.css"),
      script = c("typeahead.js/dist/typeahead.bundle.min.js")
    )

  typeahead_tag <- div(class = "form-group shiny-input-container", label %AND%
        tags$label(label, `for` = inputId), tags$div(tags$input(id = inputId,
        type = "text", class = "typeahead form-control", value = value)))

  #Attach dependencies
  htmltools::htmlDependencies(typeahead_tag) <- deps

  init_script <- tags$script(paste0(
    "var choices = ", jsonlite::toJSON(as.character(choices)) ,"

    var states = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: $.map(choices, function(choice) { return { value: choice }; })
    });

    // kicks off the loading/processing of `local` and `prefetch`
    states.initialize();

    $('#",inputId,"').typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: 'states',
      displayKey: 'value',
      source: states.ttAdapter()
    });"
    ))

  # return list
  list(typeahead_tag, init_script)

}

# AND function
"%AND%" <- function (x, y)
{
  if (!is.null(x) && !is.na(x))
    if (!is.null(y) && !is.na(y))
      return(y)
  return(NULL)
}

