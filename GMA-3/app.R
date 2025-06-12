library(shiny)
library(smwrGraphs)

# UI
ui <- fluidPage(
  titlePanel("Groundwater Chemistry - Piper Plot"),
  sidebarLayout(
    sidebarPanel(
      h4("This Piper plot uses sample groundwater data"),
      helpText("No file upload is needed for this example.")
    ),
    mainPanel(
      plotOutput("piper_plot", height = "700px")
    )
  )
)

# Server
server <- function(input, output) {
  output$piper_plot <- renderPlot({
    # Dummy example data for three wells
    Ca <- c(40, 60, 80)           # Calcium (mg/L)
    Mg <- c(20, 15, 25)           # Magnesium (mg/L)
    Na <- c(25, 40, 30)           # Sodium (mg/L)
    K <- c(5, 5, 5)               # Potassium (mg/L)
    NaK <- Na + K                 # Combine Na and K
    Cl <- c(35, 40, 30)           # Chloride (mg/L)
    SO4 <- c(20, 25, 15)          # Sulphate (mg/L)
    HCO3 <- c(100, 90, 110)       # Bicarbonate (mg/L)
    
    # Piper plot
    piperPlot(Ca, Mg, NaK, Cl, SO4, HCO3,
              Plot = list(name = c("Well 1", "Well 2", "Well 3")),
              caption = "Piper Diagram - Dummy Groundwater Data")
  })
}

# Run the app
shinyApp(ui = ui, server = server)
