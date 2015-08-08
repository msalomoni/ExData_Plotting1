#  Plot3.R - Plot 3 for Assignment 1 of Data Exploration class
#  Show 3 Energy sub metering with legend in upper right corner

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
xLabel <- ""
yLabel <- "Energy sub metering"

# set attributes for plot file
plotFileName <- "plot3.png"
plotFileWidth <- 480
plotFileHeight <- 480
plotFileBgColor <- "white"

#   Open the png file to write to
png(filename=plotFileName, width=plotFileWidth, height=plotFileHeight, bg=plotFileBgColor)

#   create plot
#     Display plot with no axes and the first set of data
plot(plot1DF$Sub_metering_1,  axes=FALSE, ylab=yLabel, xlab=xLabel, type="l", col="black")
#     Add the next set of data
lines(plot1DF$Sub_metering_2, type="l", col="red")
#     And the next set of data
lines(plot1DF$Sub_metering_3, type="l", col="blue")
#     add the bottom x axis with days of the week at day start values (1440 readings per day)
axis(1, at=c(1,1441,2880),lab=c("Thu", "Fri", "Sat"))
#     add the y axis with default settings
axis(2)
#     add a box around the chart
box()
#     add the legend 
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1)

#   close output device
dev.off()
