wd<-"~/Work/Developer/Coursera/DataScience/Exploratory_Data_Analysis/"

plot1<-function()
{
    require(data.table)
    setwd(wd)
    colClasses <- c("character", "character", "numeric", "numeric", "numeric", 
                    "numeric", "numeric", "numeric", "numeric")
    # fast reading of all data with fread (file fits to memory easily)
    powerConsum <- fread(input = "household_power_consumption.txt", sep = ";", 
                         header = TRUE, stringsAsFactors = FALSE, 
                         colClasses = colClasses, na.strings = "?", 
                         data.table = FALSE)
    # subsetting
    powerConsum <- powerConsum[powerConsum$Date %in% c("1/2/2007", "2/2/2007"), ]
    
    # making png graphics device (setting dimentions explicitly, despite defaults are correct) 
    png(file = "plot1.png", width = 480, height = 480, units = "px")
    hist(powerConsum$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power [kilowatts]")
    dev.off()
}