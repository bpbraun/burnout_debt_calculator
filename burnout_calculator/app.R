
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(scales)

turnover_rate <- .15

ui <- fluidPage(
    
    theme = shinytheme("superhero"),

    titlePanel(
        HTML(
            "<h3>Burnout Calculator</h3>
            Use this interactive <a href='https://www.somethingmajorcoaching.com/'>Something 
            Major</a> Burnout Calculator to illuminate the shadow debt of 
            burnout-related-attrition looming over your books
            <br>
            <br>")),

    sidebarLayout(
        sidebarPanel(
            
            width = 5,
            
            HTML(
            'Organizations know that burnout is a "problem" but are unprepared for the financial exposure 
            that burnout-related-attrition could have on their balance sheet in the next 3-12 months.
            <br>
            <br>
            <b>How to use this calculator</b>: Enter the number of employees in any population your are 
            analyzing (e.g. total headcount, a specific team or department, number of working parents) and 
            the average salary for that employee population. The calculator will do the math based on the 
            following assumptions.
            <br>
            <br>
            Methodology and Assumptions:
            <br>
            <br>
            1. <b>Turnover Rate</b>: According to the U.S. Bureau of Statistics, the turnover rate in the 
            United States is 12-15%. Combining the pressure of burnout with the prevalence of a 
            K-shaped recovery, highly-educated professionals continue to vote with feet—in some 
            cases more than ever before—a year into the pandemic. For that reasons, this calculator 
            assumes a conservative value at 15%. For some populations, like working parents, this number 
            could be much higher. 
            <br>
            <br>
            2. <b>Prevalence of Burnout</b>: A year into the pandemic, research shows a workforce in 
            crisis. CNBC reports that 70% of American workers are burned out or have experienced burn out
            during the pandemic, while the CDC reports spiking anxiety, depression, and addiction rates. 
            McKinsey reports that an estimated 2,000,000+ working women have left the workforce as 
            parenting begins untenable amidst school closures, while the World Economic Forum reports 
            that working fathers are quietly leaving in greater numbers as well.
            <br>
            <br>
            3. <b>Cost of Turnover</b>: The Society for Human Resource Management (SHRM) estimates the 
            average replacement cost of a salaried employee to be six to nine months’ salary. For the 
            purposes of this calculator, this formula computes with the assumption of six months.  
            According to insurer, USI, some studies have estimated this figure to be significantly 
            higher — as much as twice the employee’s annual salary, especially for high-earners or 
            executives.')),

        # Show a plot of the generated distribution
        mainPanel(
            
            width = 6,
            
            HTML("<center>"),
           
            autonumericInput("number_of_employees",
                        HTML("<b># of Employees</b>"),
                        value = 30,
                        decimalPlaces = 0),
           
            autonumericInput("average_salary",
                        HTML("<b>Average Employee Salary</b>"),
                        value = 100000,
                        currencySymbol = "$",
                        decimalPlaces = 0),

           
           HTML("<br>
                <b>15% of Employees are at Risk of Burnout-Related Attrition</b>
                <br>
                <small>Who leave for an opportunity with “better support” whether that’s better
                <br>perceived compensation, benefits, workload, staffing, or flexibility </small>
                <br>"),
           
           HTML("<br>
                <b># of Employees at Risk of Burnout-Attrition</b>"),
           textOutput("burnout_employees"),
           
           HTML("<br>
                <b>Cost Per-Employee who Leaves</b>"),
           textOutput("cost_per"),
           
           HTML("<br>
                <b>Total Burnout Financial Risk Looming<br>as Shadow Debt on Your Balance Sheet</b>"),
           HTML("<big><big>"), 
           textOutput("total_cost"),
           HTML("</big></big>"),
           HTML("<center>"),
           
        
           )
    )
)
    



server <- function(input, output) {

    output$burnout_employees <- renderText({
        x = round(input$number_of_employees * turnover_rate)
    })
    
    output$cost_per <- renderText({
        dollar(x = input$average_salary/2)
    })
    
    output$total_cost <- renderText({
        dollar(x = input$average_salary/2 * input$number_of_employees * turnover_rate)
    })
}


shinyApp(ui = ui, server = server)
