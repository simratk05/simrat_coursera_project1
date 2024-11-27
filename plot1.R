##############################################################################
#
# FILE
#   plot1.R
#
# OVERVIEW
#
#   Using data collected from the UC Irvine Machine Learning Repository,  
#   to generate a histogram of global active power(kilowatts)  
#
#   See README.md for details.
#
#
##############################################################################


##############################################################################
# STEP 1 - Get data
##############################################################################

data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")


##############################################################################
# STEP 2 - Subsetting the data
##############################################################################

data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

##############################################################################
# STEP 3 - Converting dates
##############################################################################
 
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

##############################################################################
# STEP 4 - Generate the histogram
##############################################################################

hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

	 
##############################################################################
# STEP 5 - Saving to file
##############################################################################	 

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
