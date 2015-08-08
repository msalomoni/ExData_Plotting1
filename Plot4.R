#  Plot4.R - Plot 4 for Assignment 1 of Data Exploration class
#  Show multiple plots in one output

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

# ------------  Plots --------------------------

# Plot 1 - Global Active Power
plotGAC <- function() {
  #   create plot
  #      draw the graph of Global Active power, l=line chart, no axes (added later), set y and x labels
  plot(plot1DF$Global_active_power, type="l", axes=FALSE, ylab="Global Active Power", xlab="")
  #      add the bottom axis with days of the week at day start values (1440 readings per day)
  axis(1, at=c(1,1441,2880),lab=c("Thu", "Fri", "Sat"))
  #      add value axis with default settings
  axis(2)
  #     put a box around the plot
  box()
}

#  Plot 2 - Voltage (240 V nominal)
plotVoltage <- function() {
  #   create plot
  #      draw the graph of Global Active power, l=line chart, no axes (added later), set y and x labels
  plot(plot1DF$Voltage, type="l", axes=FALSE, ylab="Voltage", xlab="datetime")
  #      add the bottom axis with days of the week at day start values (1440 readings per day)
  axis(1, at=c(1,1441,2880),lab=c("Thu", "Fri", "Sat"))
  #      add value axis with default settings
  axis(2)
  #     put a box around the plot
  box()  
}

#  Plot3 - Energy sub Metering
plotEnergySubMetering <- function() {
  #   create plot
  #     Display plot with no axes and the first set of data
  plot(plot1DF$Sub_metering_1,  axes=FALSE, ylab="Energy sub metering", xlab = "", type="l", col="black")
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
  legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         bty="n", bg="white", lty=1, lwd=1)
}

# Plot4 - Global Reactive Power
plotGRC <- function() {
  #   create plot
  #      draw the graph of Global Active power, l=line chart, no axes (added later), set y and x labels
  plot(plot1DF$Global_reactive_power, type="l", axes=FALSE, ylab="Global_reactive_power", xlab="datetime")
  #      add the bottom axis with days of the week at day start values (1440 readings per day)
  axis(1, at=c(1,1441,2880),lab=c("Thu", "Fri", "Sat"))
  #      add value axis with default settings
  axis(2)
  #     put a box around the plot
  box()  
}


# -----------  Generate the plot  ----------------
#    Load the data
plot1DF <- loadData()
#   set attributes for plot file
plotFileName <- "plot4.png"
plotFileWidth <- 480
plotFileHeight <- 480
plotFileBgColor <- "white"

#   Open the png file to write to
png(filename=plotFileName, width=plotFileWidth, height=plotFileHeight, bg=plotFileBgColor)

#   layout 2 X 2 grid for plots, row-major
par(mfrow = c(2,2))

#   put plots on grid
plotGAC()
plotVoltage()
plotEnergySubMetering()
plotGRC()

#   close output device
dev.off()
