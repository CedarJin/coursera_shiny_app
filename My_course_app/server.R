library(shiny)
library(ggplot2)
library(here)
# Define server logic required to draw a histogram
function(input, output, session) {
        
        # Reactive expression to get the data based on log transformation
        data <- reactive({
                if (input$log) {
                        mtcars$mpg <- log10(mtcars$mpg + 1)
                }
                mtcars
        })
        
        # Reactive expression to store the plot
        plot_data <- reactive({
                input$action  # Ensure the plot is updated only when the action button is clicked
                
                x_var <- input$x  # Get the x variable input
                y_var <- "mpg"  # Set y to mpg
                
                # Generate the plot using ggplot2
                ggplot(data = data(), aes_string(x = x_var, y = y_var)) + 
                        geom_point() +
                        geom_smooth(method = "lm", se = FALSE) 
                        
        })
        
        # Render the plot title dynamically
        output$title <- renderText({
                input$title
        })
        
        # Show summary of mtcars if checkbox is TRUE
        output$summary <- renderPrint({
                if (input$structure) {
                        summary(data())
                } else {
                        ""
                }
        })
        
        # Show observations based on the input$obs value
        output$view <- renderTable({
                head(data(), input$obs)
        })
        
        # Render the plot conditionally
               output$lmplot <- renderPlot({
                       plot_data()
               })


}