# ******************************************************************************
#
#  In this code the fast preprocessing of raw data with system commands is made 
#  (i.e. subsetting by dates, keeping header)
#  It makes much sense if subset is small compare to all data.
#   
#  The system commands used below are NOT platform independent and should be 
#  replaced by equivalent code for Windows.
#  
#  Buffering is made to be versatile if the data is not sorted by date. 
#
#  system.time(expr = replicate(10,  plot1())) gives ~4 times gain in user time
#  compared to plot1() implementation in plot1.R
#  
#  Same preprocessing can be done for all other scripts plot2.R, plot3.R, plot4.R 
#
# ******************************************************************************

wd<-"~/Work/Developer/Coursera/DataScience/Exploratory_Data_Analysis/"

plot1<-function()
{
    require(data.table)
    setwd(wd)

    # Preprocessing data with system commands
    # extract header to file
    system("grep '^Date' household_power_consumption.txt >> header.txt")
    # extract data to file (data need not to be sorted! that is good!)
    system("grep '^[1,2]/2/2007' household_power_consumption.txt >> buffer.txt")
    # concatenate header and data to subset.txt
    system("cat header.txt buffer.txt >> subset.txt")

    # fast reading of subset.txt with fread
    colClasses <- c("character", "character", "numeric", "numeric", "numeric", 
                    "numeric", "numeric", "numeric", "numeric")
    powerConsum <- fread(input = "subset.txt", sep = ";", 
                         header = TRUE, stringsAsFactors = FALSE, 
                         colClasses = colClasses, na.strings = "?", 
                         data.table = FALSE)
    # removing buffer files
    system("rm ./header.txt ./buffer.txt ./subset.txt")

    # making png graphics device (setting dimentions explicitly, despite defaults are correct) 
    png(file = "plot1.png", width = 480, height = 480, units = "px")
    hist(powerConsum$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power [kilowatts]")
    dev.off()
}