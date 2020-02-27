#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- navbarPage(
    "Final Project Title",
    tabPanel("Model",
             fluidPage(
                 titlePanel("Model Title"),
                 sidebarLayout(
                     sidebarPanel(
                         selectInput(
                             "plot_type",
                             "Plot Type",
                             c("Option A" = "a", "Option B" = "b")
                         )),
                     mainPanel(plotOutput("line_plot")))
             )),
    tabPanel("Discussion",
             titlePanel("Discussion Title"),
             p("Tour of the modeling choices you made and 
              an explanation of why you made them")),
    tabPanel("About", 
             titlePanel("About"),
             h3("Project Background and Motivations"),
             p("Hello, this is where I talk about my project."),
             h3("About Me"),
             p("My name is Taylor Greenberg Goldy and I study Design Engineering in the Graduate School of Design and School of Engineering and Applied Sciences. This is the link for my repo:
https://github.com/taylorgreenberggoldy/final_project.git

The data I am using for this project is all of the interactions that students do on our syllabus and Preceptors textbook.  One datasource will be DavidKane.info for the syllabus as well as the textbook website that is found on David Kane's github.  From this, we will hopefully be able to analyze how long people are spending on the sites, what are they looking at mostly, and when are peak times of use?

             You can reach me at taylorgg@mde.harvard.edu")))

server <- function(input, output) {
    output$line_plot <- renderPlot({
        # generate type based on input$plot_type from ui
        ifelse(
            input$plot_type == "a",
            # if input$plot_type is "a", plot histogram of "waiting" column 
            # from the faithful dataframe
            x   <- faithful[, 2],
            # if input$plot_type is "b", plot histogram of "eruptions" column
            # from the faithful dataframe
            x   <- faithful[, 1]
        )
        # draw the histogram with the specified number of bins
        hist(x, col = 'darkgray', border = 'white')
    })
}

