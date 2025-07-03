#####
# Created with the help of ChatGPT (2025 July 03)
# Share url: https://chatgpt.com/share/68662781-1afc-8002-b2a4-797d0450d084
#####
library(shiny)

# Reuse the same sdRplot function you provided
sdRplot <- function(nx, sl, ny, x){
  NSCALE <- nx
  NLAB <- ny
  NRW <- nrow(x)
  NCL <- ncol(x)
  NGRP <- ncol(x)-2
  GRPNMS <- dimnames(x)[[2]][3:NCL]
  yval <- NLAB:1
  labvaln <- x[,1]
  labvalp <- x[,2]
  
  plot(as.numeric(x[,3]), yval, axes=F, pch=1, col=1, type="b",
       xlab="Mean SD Scale Value", ylab="Descriptor",
       cex.lab=1.0,
       xlim=c(0.30, NSCALE+0.95),
       lab=c(NSCALE, NLAB+2, 1), mgp=c(3,1,0), xaxs="r",
       mar=c(7,7,1,1))
  
  title(main="SD Response Profiles", sub="", cex.sub=0.50)
  axis(1, tck=1, at=1:NSCALE, labels=sl, cex.axis=0.60)
  
  legend(1.25, NLAB-0.5, title="Legend:", GRPNMS,
         title.col="black",
         text.col=1:NGRP,
         pch=1:NGRP, lty=1:NGRP,
         col=1:NGRP, cex=0.60, bg="white")
  
  if(NGRP > 1){
    for(i in 2:NGRP){
      points(as.numeric(x[,i+2]), yval, pch=i, col=i)
      lines(as.numeric(x[,i+2]), yval, pch=i, col=i, lty=i)
    }
  }
  
  for (i in 1:NLAB) {
    text(0.90, yval[i], label=labvaln[i], adj=1, cex=0.70)
    text(NSCALE+0.10, yval[i], label=labvalp[i], adj=0, cex=0.70)
  }
}

shinyServer(function(input, output) {

  # Parse the data input as a reactive expression
  inputData <- reactive({
    req(input$dataInput)
    read.csv(text = input$dataInput, stringsAsFactors = FALSE)
  })

  scaleLabels <- reactive({
    strsplit(input$sl, ",")[[1]]
  })

  output$sdPlot <- renderPlot({
    x <- inputData()
    nx <- input$nx
    ny <- input$ny
    sl <- scaleLabels()

    sdRplot(nx, sl, ny, x)
  })

  output$downloadPlot <- downloadHandler(
    filename = function() { "sd_plot.png" },
    content = function(file) {
      png(file, width = 800, height = 600)
      sdRplot(input$nx, scaleLabels(), input$ny, inputData())
      dev.off()
    }
  )
})
