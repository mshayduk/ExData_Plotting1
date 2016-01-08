wd<-"~/Work/Developer/Coursera/DataScience/Exploratory_Data_Analysis/"

plot4<-function()
{
    require(data.table)
    setwd(wd)
    colClasses <- c("character", "character", "numeric", "numeric", "numeric", 
                    "numeric", "numeric", "numeric", "numeric")
    # fast reading with fread
    powerConsum <- fread(input = "household_power_consumption.txt", sep = ";", 
                         header = TRUE, stringsAsFactors = FALSE, 
                         colClasses = colClasses, na.strings = "?", 
                         data.table = FALSE)
    
    # subsetting and converting date (swapping these two operations elongates execution time by ~1.7)
    powerConsum <- powerConsum[powerConsum$Date %in% c("1/2/2007", "2/2/2007"), ]
    powerConsum[, "Date"] <- as.Date(powerConsum[, "Date"], format = "%d/%m/%Y")
    # adding a column of joined Date and Time
    powerConsum$DateTime <- strptime(paste(powerConsum[, "Date"], powerConsum[, "Time"]), format = "%Y-%m-%d %H:%M:%S")
    
    # make png graphics device with required dimentions (set explicitly, despite being equal to defaults)
    png(file = "plot4.png", width = 480, height = 480, units = "px")
    # split graphic canvas into 4 pads
    par(mfrow=c(2,2))
    # pad 1
    plot(powerConsum$DateTime, powerConsum$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    # pad 2
    plot(powerConsum$DateTime, powerConsum$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    # pad 3
    plot(powerConsum$DateTime, powerConsum$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(powerConsum$DateTime, powerConsum$Sub_metering_2, col = "red")
    lines(powerConsum$DateTime, powerConsum$Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    # pad 4
    plot(powerConsum$DateTime, powerConsum$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    dev.off()
}