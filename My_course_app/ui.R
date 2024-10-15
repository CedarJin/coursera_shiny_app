
library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Plot of mtcars dataset"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
                textInput(inputId = "title","The title of the analysis"),
                checkboxInput("structure", "Show data structure", TRUE),
                checkboxInput("log", "Apply log transformation", TRUE),
                br(), # br() element to introduce extra vertical spacing ----
                numericInput("obs", "Number of observations to view:", 10),
                helpText("Note: y value is set as miles per gallon as default so you don't have to select y values."),
                selectInput(inputId = "x",
                            label = "x values",
                            choices = names(mtcars[,-1])),
                submitButton("Update View", icon("refresh")),
                 ),
    # Show a plot of the generated distribution
         mainPanel(
            h4(textOutput("title", container = span)),
            verbatimTextOutput("summary"),
            h4("Observations"),
            tableOutput("view"),
            h4("My plot"),
            plotOutput("lmplot")
                  )
        )
)


