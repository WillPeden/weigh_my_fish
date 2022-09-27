

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
            numericInput("length_inch_s", "Length (inches):",
                         min = 0, max = 200,
                         value = NULL),
            
            # Input: Decimal interval with step value ----
            numericInput("girth_inch_s", "Girth (inches):",
                         min = 0, max = 150,
                         value = NULL)
            
          ),
          
          # Main panel for displaying outputs ----
          mainPanel(
            
            # Output: Table summarizing the values entered ----
            tableOutput("values_s")
            
          )
        )
      )
    ),
    tabPanel(
      "sea trout",
      fluidRow(
        
        # Sidebar layout with input and output definitions ----
        sidebarLayout(
          
          # Sidebar to demonstrate various slider options ----
          sidebarPanel(
            
            # Input: Simple integer interval ----
            numericInput("length_inch_st", "Length (inches):",
                         min = 0, max = 200,
                         value = 0),
            
            # Input: Decimal interval with step value ----
            numericInput("girth_inch_st", "Girth (inches):",
                         min = 0, max = 150,
                         value = 0)
            
          ),
          
          # Main panel for displaying outputs ----
          mainPanel(
            
            # Output: Table summarizing the values entered ----
            tableOutput("values_st")
            
          )
        )
      )
    )
)
)

# Define server logic for slider examples ----
server <- function(input, output) {
  
  # Reactive expression to create data frame of all input values ----
  length_input <- reactive({input$length_inch_s})
  girth_input <- reactive({input$girth_inch_s})
  sliderValues_s <- reactive({
    req(length_input())
    #incorporate the Sturdy scale: https://www.richarddonkin.com/Archive/Source%20Material/Sturdy_Scale.pdf
    length = as.numeric(length_input())
    if(!isTruthy(girth_input())){
      girth = length/1.965 # This is unproven but seems to be the approximate estimate used for girth. Need to check.
    } else {
      girth = girth_input()
    }
      
    weight = ((length *1.33333) * (girth^2))/800
    units = "lbs"
    if(units == "lbs"){paste0(floor(weight), "lbs ", round((weight - trunc(weight))*16, digits = 0), "ozs" )}
    
    
  })
  
  sliderValues_st <- reactive({
    
    "in development"
  })
  
  # Show the values in an HTML table ----
  output$values_s <- renderText({
    paste0( "Sturdy scale  = ", sliderValues_s())
  })
  
  # Show the values in an HTML table ----
  output$values_st <- renderText({
    sliderValues_st()
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
