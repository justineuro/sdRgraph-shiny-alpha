#####
# Created with the help of ChatGPT (2025 July 03)
# Share url: https://chatgpt.com/share/68662781-1afc-8002-b2a4-797d0450d084
#####
library(shiny)

shinyUI(fluidPage(
  titlePanel("Custom Semantic Differential Plot Generator"),

  sidebarLayout(
    sidebarPanel(
      numericInput("nx", "Number of Scale Levels (nx; min of 2):", value = 5, min = 2),
      numericInput("ny", "Number of Descriptors (ny; min of 1):", value = 7, min = 1),
      textInput("sl", "Scale Labels (comma-separated):", value = "SA,A,N,A,SA"),
      textAreaInput("dataInput", "Paste Data Matrix (CSV format):",
"Low,High,Grp1,Grp2,Grp3
Serious,Fun,4.2,3.8,4.5
Slow,Fast,4.6,3.9,4.7
Useless,Useful,4.3,3.7,4.4
Tiring,Light,4.1,4.5,4.2
Old,New,4.5,4.4,4.6
Hard,Easy,4.5,4.3,4.4
Long,Short,4.0,4.4,3.9",
        rows = 12
      ),
      downloadButton("downloadPlot", "Download Plot (PNG)")
    ),

    mainPanel(
      plotOutput("sdPlot")
    )
  )
))
