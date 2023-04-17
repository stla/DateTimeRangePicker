library(DateTimeRangePicker)
library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(
      HTML("pre {font-size: 18px;}")
    )
  ),
  br(),
  sidebarLayout(
    sidebarPanel(
      width = 5,
      tags$fieldset(
        tags$legend("Click to change time"),
        dtrpickerInput(
          "dtrpicker",
          style = paste0(
            "background-color: chartreuse; ",
            "box-shadow: 0 30px 40px 0 rgba(16, 36, 94, 0.2);"
          )
        )
      )
    ),
    mainPanel(
      width = 7,
      tags$fieldset(
        tags$legend("Selection:"),
        verbatimTextOutput("dtrpicker")
      )
    )
  )
)

server <- function(input, output){
  output[["dtrpicker"]] <- renderPrint({
    input[["dtrpicker"]]
  })
}

shinyApp(ui, server)
