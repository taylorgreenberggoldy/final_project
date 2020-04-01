#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(ggplot2)
library(tidyverse)



ui <- fluidPage(theme = shinytheme("flatly"),

# Define UI (user interface) for application, which is the
# formating/way the interface will look to users
                
#used navbarpage to create a navbar shiny app set up, used tab panel to create
#the tabs within my shiny app, within the first tab map I called imageoutput
#referencing map, which I then specified in the server section below, inside the
#second tab, about I used h4 to set a header and p to specify a paragraph of
#text that I entered
                
        navbarPage("Exploring Sales and Customer Interaction
                    on an E-commerce site",
            tabPanel("Are people buying?",
#used tabset panel to create a panel within my overall panel 
            tabsetPanel(
            tabPanel("TITLE",
                                                 

#used sidebar panel to separate the sidebar from the main panel                                 
                sidebarPanel(
                                        
                selectInput("action", "Select an customer action:",
                            choices = c("Visits site" = "total_sessions",
                                        "Put item in cart" = "total_carts",
                                        "Continue to checkout screen" = "total_checkouts",
                                        "Order placed" = "total_orders_placed",
                                        "Conversion rate" = "total_conversion")
                ))))),

                mainPanel(
                    h2("Exploring Sales and Customer Interaction"),
                    plotOutput("plot_1")
                )),
    
            tabPanel("About", 
                    titlePanel("About"),
                    h3("Project Background and Motivations"),
                    p("Hello, this is where I talk about my project."),
                    h3("About Me"),
                    p("My name is Taylor Greenberg Goldy and I study Design Engineering in the Graduate School of Design and School of Engineering and Applied Sciences. This is the link for my repo:
https://github.com/taylorgreenberggoldy/final_project.git

The data I am using for this project is looking at the behavior of customers and interactions they have on a shopping website that I have access to.  In this data, I'll be able to see how often people are shopping, what are they shopping for as well as what are they searching on the website for.  Through this study, I can hopefully be able to make suggestions to how to improve the overal UX of the site to let people navigate it more thoroughly.  I am slowly getting access to more of the data and will be able to add more files into this project however for now, these two provide sufficient data to get started.

To pull this data, I'm looking at shopify as well as google analytics that pulls basic measurements off of the website of the e-commerce site.

             You can reach me at taylorgg@mde.harvard.edu")))

server <- function(input, output) {
    datareact <- reactive({
      visits %>%
        filter(day == "2019-01-01"| day == "2019-02-01" | day == "2019-03-01" |  day == "2019-04-01" |
                   day == "2019-05-01" | day == "2019-06-01" | day == "2019-07-01" | day == "2019-08-01" | 
                   day == "2019-09-01" |  day == "2019-10-01" |  day == "2019-11-01" |  day == "2019-12-01") %>% 
        pivot_longer(cols = c(total_sessions, total_carts, total_checkouts, total_orders_placed, 
                              total_conversion), names_to = "action")
    })
    
    output$plot_1 <- renderPlot({
        # generate type based on input$plot_type from ui
      purchases %>%
        filter(action == input$action) %>%
      ggplot(aes(x = day, y = value, fill = input$action))+
                geom_bar(stat = "identity", position = "dodge") +
                labs(title = "Shopping Turnover for Online Shop",
                     y= "Actions", x = "Month")+
                theme(axis.text.x=element_text(angle=45, hjust=1))
    })

}

# Run the application
shinyApp(ui = ui, server = server)
