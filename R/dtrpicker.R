#' @title Datetime range picker
#' @description A datetime range picker for a Shiny UI.
#'
#' @param inputId the input slot that will be used to access the value
#' @param from,to initial values, either \code{POSIXct} objects, or objects
#'   coercible to \code{POSIXct} objects;
#'   if \code{NULL}, then \code{from} is set to the current time and \code{to}
#'   is set to the next day at the same time
#' @param style inline CSS for the container
#'
#' @return xxx
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
#'
#' @examples
#' library(DateTimeRangePicker)
#' library(shiny)
#'
#' ui <- fluidPage(
#'   br(),
#'   sidebarLayout(
#'     sidebarPanel(
#'       width = 5,
#'       tags$fieldset(
#'         tags$legend("Click to change time"),
#'         dtrpickerInput(
#'           "dtrpicker",
#'           style = paste0(
#'             "background-color: chartreuse; ",
#'             "box-shadow: 0 30px 40px 0 rgba(16, 36, 94, 0.2);"
#'           )
#'         )
#'       )
#'     ),
#'     mainPanel(
#'       width = 7,
#'       verbatimTextOutput("dtrpicker")
#'     )
#'   )
#' )
#'
#' server <- function(input, output){
#'   output[["dtrpicker"]] <- renderPrint({
#'     input[["dtrpicker"]]
#'   })
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
dtrpickerInput <- function(inputId, from = NULL, to = NULL, style = NULL){
  from <- if(is.null(from)) Sys.time() else as.POSIXct(from)
  to   <- if(is.null(to)) Sys.time()+86400 else as.POSIXct(to)
  stopifnot(from < to)
  style <- paste0("width: max-content; ", style)
  createReactShinyInput(
    inputId,
    "dtrpicker",
    htmlDependency(
      name    = "dtrpicker-input",
      version = "1.0.0",
      src     = "www/DateTimeRangePicker/dtrpicker",
      package = "DateTimeRangePicker",
      script  = "dtrpicker.js"
    ),
    NULL,
    list(
      from = datetime2list(from, sec = TRUE),
      to   = datetime2list(to, sec = TRUE)
    ),
    container = function(...) tags$div(..., style = style)
  )
}

#' <Add Title>
#'
#' <Add Description>
#'
#' @export
updateDtrpickerInput <- function(session, inputId, value){
  message <- list(value = value)
  session$sendInputMessage(inputId, message);
}
