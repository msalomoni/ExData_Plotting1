#  Plot2.R - Plot 2 for Assignment 1 of Data Exploration class
#  Line chart of Global Active Power

#    Add data loader function
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
mainTitle <- ""
xLabel <- ""
yLabel <- "Global Active Power (kilowatts)"
# set attributes for plot file
plotFileName <- "plot2.png"
plotFileWidth <- 480
plotFileHeight <- 480
plotFileBgColor <- "white"

#   Open the png file to write to
png(filename=plotFileName, width=plotFileWidth, height=plotFileHeight, bg=plotFileBgColor)

#   create plot
#      draw the graph of Global Active power, l=line chart, no axes (added later), set y and x labels
plot(plot1DF$Global_active_power, type="l", axes=FALSE, ylab="Global Active Power (kilowatts)", xlab="")
#      add the bottom axis with days of the week at day start values (1440 readings per day)
axis(1, at=c(1,1441,2880),lab=c("Thu", "Fri", "Sat"))
#      add value axis with default settings
axis(2)
#     put a box around the plot
box()

#   close output device
dev.off()
