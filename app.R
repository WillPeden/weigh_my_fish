library(shiny)

# Define UI for slider demo app ----
ui <- fluidPage(
  theme = "bootstrap.css",
  includeCSS("www/styles.css"),
  
  # App title ----
  #titlePanel("Sliders"),
  navbarPage(
    "Weigh my fish",
    id = "main_navbar",
    
    tabPanel(
      "salmon",
      fluidRow(
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      # Input: Simple integer interval ----
      numericInput("length_cm", "Length (cm):",
                  min = 0, max = 200,
                  value = 0),
      
      # Input: Decimal interval with step value ----
      numericInput("girth_cm", "Girth (cm):",
                   min = 0, max = 150,
                   value = 0)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Table summarizing the values entered ----
      tableOutput("values")
      
    )
  )
)
)
)
)

# Define server logic for slider examples ----
server <- function(input, output) {
  
  # Reactive expression to create data frame of all input values ----
  sliderValues <- reactive({
    
    data.frame(
      Name = c("Integer",
               "Decimal",
               "Range",
               "Custom Format",
               "Animation"),
      Value = as.character(c(input$integer,
                             input$decimal,
                             paste(input$range, collapse = " "),
                             input$format,
                             input$animation)),
      stringsAsFactors = FALSE)
    
  })
  
  # Show the values in an HTML table ----
  output$values <- renderTable({
    sliderValues()
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
