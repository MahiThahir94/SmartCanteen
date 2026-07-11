library(shiny)
library(DT)
library(bslib)
library(readr)

# Menu data read pannradhu
menu <- read.csv("menu.csv")

# Orders file read pannradhu
orders <- read.csv("orders.csv")
ui <- fluidPage(
  
  theme = bs_theme(bootswatch = "flatly"),
  
  titlePanel("🍽 Smart College Canteen Pre-Order System"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      textInput("name", "Student Name"),
      
      textInput("dept", "Department"),
      
      selectInput("food",
                  "Select Food",
                  choices = menu$Food),
      
      numericInput("qty",
                   "Quantity",
                   value = 1,
                   min = 1),
      
      actionButton("order",
                   "Place Order",
                   class = "btn-success")
      
    ),
    
    mainPanel(
      
      h3("Order Summary"),
      
      textOutput("bill"),
      
      br(),
      
      DTOutput("menu_table")
      
    )
    
  )
  
)
server <- function(input, output, session) {
  
  # Menu table display
  output$menu_table <- renderDT({
    menu
  })
  
  # Bill calculate
  output$bill <- renderText({
    
    price <- menu$Price[menu$Food == input$food]
    
    total <- price * input$qty
    
    paste("Total Bill: ₹", total)
    
  })
  
}
shinyApp(ui = ui, server = server)
