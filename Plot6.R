#Read inout data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- data.frame(emission = numeric(),year = integer(), type = character())
SCC_list <- SCC$SCC[grep("Mobile - On-Road",SCC$EI.Sector)]

new_data <- subset(NEI,NEI$fips == "24510")
for (i in unique(new_data$year)){
  total_emission <- vector()
  for (j in SCC_list){
    SCC_data <- subset(new_data,new_data$year == i & new_data$SCC == j)
    total_emission <- c(total_emission,sum(SCC_data$Emissions))
  }
  df <- rbind(df,data.frame(emission = sum(total_emission),year = i,type = "Baltimore"))
}

new_data <- subset(NEI,NEI$fips == "06037")
for (i in unique(new_data$year)){
  total_emission <- vector()
  for (j in SCC_list){
    SCC_data <- subset(new_data,new_data$year == i & new_data$SCC == j)
    total_emission <- c(total_emission,sum(SCC_data$Emissions))
  }
  df <- rbind(df,data.frame(emission = sum(total_emission),year = i,type = "Los Angeles"))
}

png('plot6.png')
g <- ggplot(df, aes(x = df$year,y = df$emission,color=df$type,group=df$type)) 
g <- g + geom_point() 
g <- g + geom_line() 
g <- g + labs(x= "Year")
g <- g + labs(y = "Emission(Tonnes)") 
g <- g + labs(color = "Place") 
g <- g + labs(title="Change in Emission for cities over years")
print(g)

dev.off()
