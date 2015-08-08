#  Plot1.R - Create plots for Assignment 1 of Data Exploration class
#   Histogram of Global Active Power


# ---------  Add data loader function  ---------
loadData <- function() {
  
  # Load file
  fileName <- "./data/household_power_consumption.txt"
  
  #  create the character to Date convertor called myDate
  setClass("myDate")
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
  
  #  Read in the file
  powerDF <- read.table(fileName, sep=";",na.strings=c("NA","?"), stringsAsFactors=FALSE,
                        colClasses=c('myDate', 'character','numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'), 
                        header=TRUE)
  
  # filter the data to only the days we are interested in 
  plotDF <- powerDF[powerDF$Date >= as.Date("2007/2/1") & powerDF$Date <= as.Date("2007/2/2"),]
  
  # return the data frame containing the data
  return (plotDF)
}


#    Load the data
plot1DF <- loadData()
# set attributes for the plot
barcolor <- c("brown1") # looks orangish to me
mainTitle <- "Global Active Power"
xLabel <- "Global Active Power (kilowatts)"
# set attributes for plot file
plotFileName <- "plot1.png"
plotFileWidth <- 480
plotFileHeight <- 480
plotFileBgColor <- "white"

#   Open the png file to write to
png(filename=plotFileName, width=plotFileWidth, height=plotFileHeight, bg=plotFileBgColor)
#   create plot
hist(plot1DF$Global_active_power, main=mainTitle, col=barcolor, xlab=xLabel)
#   close output device
dev.off()
