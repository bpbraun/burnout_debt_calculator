
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(scales)

ui <- fluidPage(
    
    themeSelector(),


    titlePanel("Burnout Calculator"),

    sidebarLayout(
        sidebarPanel(
            HTML('Organizations know that burnout is a "problem" but are unprepared for the financial exposure burnout-related-attrition could have on their balance sheet in the next 3-12 months.
                 <br>
                 <br>
                 Use this interactive Something Major Burnout Calculator to illuminate the shadow debt of burnout-related-attrition looming over your books.')),

        # Show a plot of the generated distribution
        mainPanel(
            
            HTML("<center>"),
           
            autonumericInput("number_of_employees",
                        HTML("<b># of Employees</b>"),
                        value = 30,
                        decimalPlaces = 0),
           
            autonumericInput("average_salary",
                        HTML("<b>Average Salary</b>"),
                        value = 100000,
                        currencySymbol = "$",
                        decimalPlaces = 0),
           # autonumericInput("employees_at_risk",
           #              HTML("<b>% at Risk of Burnout-Related Attritions</b>"),
           #              value = 6,
           #              decimalPlaces = 0),
           
           HTML("<b>20% of Employees are at Risk of Burnout-Related Attrition</b>
                <br>
                <small>leaving for an opportunity with better support through benefits,<br>human capital, compensation, or workload</small>
                <br>"),
           
           HTML("<br>
                <b># of Employees at Risk of Burnout-Attrition</b>"),
           textOutput("burnout_employees"),
           
           HTML("<br>
                <b>Cost Per-Employee who Leaves</b>"),
           textOutput("cost_per"),
           
           HTML("<br>
                <b>Total Burnout Financial Risk Looming<br>as Shadow Debt on Your Ballance Sheet</b>"),
           textOutput("total_cost"),
           
           HTML("<center>"),
           
        
           )
    )
)
    



server <- function(input, output) {

    output$burnout_employees <- renderText({
        x = round(input$number_of_employees * .2)
    })
    
    output$cost_per <- renderText({
        dollar(x = input$average_salary/2)
    })
    
    output$total_cost <- renderText({
        dollar(x = input$average_salary/2 * input$number_of_employees * .2)
    })
}


shinyApp(ui = ui, server = server)
