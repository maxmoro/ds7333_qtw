
setwd("/Users/bblanchard006/Desktop/SMU/QTW/Week 1")

# Read in the raw "offline" text file
txt = readLines("offline.final.trace.txt")

# Create a function to parse the data
processLine = function(x)
{
  tokens = strsplit(x, "[;=,]")[[1]]
  if (length(tokens) == 10) {
    return(NULL)
  }
  tmp = matrix(tokens[ - (1:10) ], , 4, byrow = TRUE)
  cbind(matrix(tokens[c(2, 4, 6:8, 10)], nrow(tmp), 6,
               byrow = TRUE), tmp)
}

lines = txt[ substr(txt, 1, 1) != "#" ]
tmp = lapply(lines, processLine)

# Convert the offline data to a data frame
offline = as.data.frame(do.call("rbind", tmp),stringsAsFactors = FALSE)

head(offline)

# Assign column names to the offline data frame
names(offline) = c("time", "scanMac", "posX", "posY", "posZ",
                   "orientation", "mac", "signal",
                   "channel", "type")

head(offline)

# Observe one observation from the offline data frame
offline[offline$time==1139643118358,]

library(tidyverse)
library(magrittr)

# View the data frame exclusive of the scanMac, channel, and type columns
select(offline,-c(scanMac,channel,type))

# See if any observations have a posZ-value not equal to 0.0
offline[offline['posZ']!='0.0',]

# Get a full list of mac values and their types (we are interested in type == 3)
macTypeDF <- unique(select(offline, c(mac,type)))
macTypeDF[order(macTypeDF$type),]

# List the unique mac values
vals = data.frame(table(offline['mac']))
vals[order(-vals$Freq),]

valsUpdated <- vals %>% inner_join(macTypeDF, by = c("Var1" = "mac"))
valsUpdated <- valsUpdated[order(valsUpdated$type, -valsUpdated$Freq),]

offline$signal %<>% as.integer

offline <- offline[offline$type != 1, ]

keepMacs <- c('00:0f:a3:39:e1:c0',
              '00:0f:a3:39:dd:cd',
              '00:14:bf:b1:97:8a',
              '00:14:bf:3b:c7:c6',
              '00:14:bf:b1:97:90',
              '00:14:bf:b1:97:8d',
              '00:14:bf:b1:97:81'
              )

offline <- offline[offline$mac %in% keepMacs ,]


# Pivot the data frame (or cast it; make it wider) but putting the mac values and their associated signals in the columns
offlineOut<-select(offline, -c(channel,scanMac,type)) %>% pivot_wider(names_from = mac,values_from = signal, values_fn = list(signal=mean))

offlineOut$nas<-rowSums(is.na(offlineOut))

# View the final data frame
offlineOut

# Process the online data
onlineTxt = readLines("online.final.trace.txt")

onlineLines = onlineTxt[ substr(onlineTxt, 1, 1) != "#" ]
onlineTmp = lapply(onlineLines, processLine)

# Convert the online data to a data frame
online = as.data.frame(do.call("rbind", onlineTmp),stringsAsFactors = FALSE)

head(online)

names(online) = c("time", "scanMac", "posX", "posY", "posZ",
                   "orientation", "mac", "signal",
                   "channel", "type")

head(online)

# View the data frame exclusive of the scanMac, channel, and type columns
select(online,-c(scanMac,channel,type))

# See if any observations have a posZ-value not equal to 0.0
online[online['posZ']!='0.0',]

# List the unique mac values and their frequencies in the offline data frame
onlineVals = data.frame(table(online['mac']))
onlineVals[order(-onlineVals$Freq),]

online$signal %<>% as.integer

online <- online[online$mac %in% keepMacs ,]

# Pivot the data frame (or cast it; make it wider) but putting the mac values and their associated signals in the columns
onlineOut<-select(online, -c(channel,scanMac,type)) %>% pivot_wider(names_from = mac,values_from = signal, values_fn = list(signal=mean))

onlineOut$nas<-rowSums(is.na(onlineOut))

# View the final data frame
onlineOut


offlineOut$posXY <- paste(offlineOut$posX, offlineOut$posY, sep="-")
length(unique(offlineOut$posXY))

onlineOut$posXY <- paste(onlineOut$posX, onlineOut$posY, sep="-")
length(unique(onlineOut$posXY))







