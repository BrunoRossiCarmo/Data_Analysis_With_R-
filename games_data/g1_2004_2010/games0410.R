#Directory:
dir.main <- "C:\\Users\\bruno\\Desktop\\Usp\\CODES\\analytics\\games_2004_2010" #Meu
setwd(dir.main)

#Library:
library(ggplot2)
library(plotly)
library(ggpubr)

#Load Data:
games <- read.csv("data/video_games.csv",header = T)
games <- data.frame(games$Title,games$Features.Max.Players,games$Metadata.Genres,games$Metrics.Review.Score,games$Metrics.Sales,games$Release.Rating)
names(games) <- c("Title","Max_P","Genres","Score","Sales","Mature_Rating")
games$Score <- as.numeric(games$Score)
games$Sales <- as.numeric(games$Sales)

#General Summary:
summary(games$Score)
summary(games$Sales)
table(games$Mature_Rating)

#Division:
games_E <- games[games$Mature_Rating == "E",]
games_M <- games[games$Mature_Rating == "M",]
games_T <- games[games$Mature_Rating == "T",]

#Changes:
games$Mature_Rating[games$Mature_Rating=="E"] <- "Everyone"
games$Mature_Rating[games$Mature_Rating=="M"] <- "Mature"
games$Mature_Rating[games$Mature_Rating=="T"] <- "Teen"

#Plots: 
png(paste0(dir.main, "\\images\\_boxplot_rating.png"),
    width = 1500,
    height = 1500,
    res = 300,
    pointsize = 8)
ggplot(games, aes(Mature_Rating,Score,fill = Mature_Rating)) + geom_boxplot(outlier.colour="red", outlier.shape=8,outlier.size=4) + labs(title="   Games Scores by Rating (2004-2010)",x="Rating", y = "Score")+ theme_classic()
dev.off()

#HTML:
p<-ggplot(games, aes(Mature_Rating,Score,fill = Mature_Rating)) + geom_boxplot(outlier.colour="red", outlier.shape=8,outlier.size=4) + 
theme(legend.position="bottom") + labs(title="Games Scores by Rating (2004-2010)",x="Rating", y = "Score")
ggplotly(p)

#Frequency:
png(paste0(dir.main, "\\images\\_frequency_rating.png"),
    width = 1500,
    height = 1500,
    res = 300,
    pointsize = 8)
ggplot(games, aes(Mature_Rating)) + geom_bar(fill = "#0073C2FF") + theme_pubclean() + labs(title="             Games Rating Frequency (2004-2010)",x="Type of Rating", y = "Frequency")+ theme_classic()
dev.off()

#HTML:
p<-ggplot(games, aes(Mature_Rating)) + geom_bar(fill = "#0073C2FF") + theme_pubclean() + labs(title="             Games Rating Frequency (2004-2010)",x="Type of Rating", y = "Frequency")+ theme_classic()
ggplotly(p)
