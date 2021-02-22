# -------------------------------------------------------------------------------------------- #
# - FILE NAME:   HerbivoryComplexity.R         
# - DATE:        22/02/2021
# - TITLE: Biotic resistance against an invasive marine macroalga depends on competition, herbivory and their interaction
# - AUTHORS: Jorge Santamaría, Fiona Tomas, Enric Ballesteros, Juan M. Ruiz, Jaime Bernardeau-Esteller, Jorge Terrados, Emma Cebrian
# - SCRIPT: J. Santamaría (jorge.santamaria@udg.edu)
# - JOURNAL: Under review
# -------------------------------------------------------------------------------------------- #

# DISCLAMER: This script has been developed by an ecologist, not a programer, 
# so please take into account that the code may have room to be omptimized. 
# Positive feedback will always be more than welcome.


# Script Content------------------------------------------------ 
# 1. Load libraries and data
# 2. Assemblage complexity analysis
# 3. Exclusion experiment analysis



#########################################################
######## 1. Load libraries and data #####################
#########################################################

### Load required packages
library(dplyr)
library(ggplot2)
library(car)
library(emmeans)
library(visreg)
library(lme4)

### Set workind directory to the place where you have the data stored
setwd("DataPath")


#########################################################
######## 2. Assemblage complexity analysis ##############
#########################################################

### Load the data
load("Assemblage_Complexity.RData")
summary(Assemblage_Complexity)

## Group data and get the summarized information
# 1) By Complexity
Complex_pair_overall <- group_by(Assemblage_Complexity,Complexity) %>%
  summarise(mean_caulerpa=mean(Per_Caul_Cover), sd=sd(Per_Caul_Cover), se=sd(Per_Caul_Cover)/sqrt(length(Complexity)), n=length(Complexity))
Complex_pair_overall

Complex_pair_overall$Complexity <- factor(Complex_pair_overall$Complexity, levels=c("H","M","L"))

ggplot(Complex_pair_overall, aes(x=Complexity, y=mean_caulerpa, fill=Complexity)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=mean_caulerpa-se, ymax=mean_caulerpa+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) +
  ggtitle("Abundance of Caulerpa per Habitat Complexity") +
  scale_y_continuous(limit=c(0,43), breaks=seq(0,40,10), name = "Mean cover ± S.E (%)") +
  theme(axis.line = element_line(colour = "black"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y =element_line(size = 0.5, linetype = 'solid',colour = "grey90"),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(size=14, face="bold.italic", hjust=0.5),
        legend.title = element_text(size=13, face="bold"),
        legend.text = element_text(size = 11),
        axis.title = element_text(face = "bold"),
        axis.title.y = element_text(vjust= -1.5, size=13),
        axis.title.x = element_text(vjust= -0.5, size=13),
        axis.text.y = element_text(size=11, face="bold"),
        axis.text.x = element_text(size=11, face="bold"))


# 2) By Depth and Complexity
Complex_pair <- group_by(Assemblage_Complexity, Depth_factor, Complexity) %>%
  summarise(mean_caulerpa=mean(Per_Caul_Cover), sd=sd(Per_Caul_Cover), se=sd(Per_Caul_Cover)/sqrt(length(interaction(Depth_factor,Complexity))), n=length(interaction(Depth_factor,Complexity)))
Complex_pair


Complex_pair$Complexity <- factor(Complex_pair$Complexity, levels=c("H","M","L"))
Complex_pair$Depth_factor <- factor(Complex_pair$Depth_factor, levels=c("Shallow","Deep"))


ggplot(Complex_pair, aes(x=Depth_factor, y=mean_caulerpa, fill=Complexity)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=mean_caulerpa-se, ymax=mean_caulerpa+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) +
  ggtitle("Abundance of Caulerpa per Depth and Habitat Complexity") +
  scale_y_continuous(limit=c(0,43), breaks=seq(0,40,10), name = "Mean cover ± S.E (%)") +
  theme(axis.line = element_line(colour = "black"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y =element_line(size = 0.5, linetype = 'solid',colour = "grey90"),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(size=14, face="bold.italic", hjust=0.5),
        legend.title = element_text(size=13, face="bold"),
        legend.text = element_text(size = 11),
        axis.title = element_text(face = "bold"),
        axis.title.y = element_text(vjust= -1.5, size=13),
        axis.title.x = element_text(vjust= -0.5, size=13),
        axis.text.y = element_text(size=11, face="bold"),
        axis.text.x = element_text(size=11, face="bold"))




############################################################################
###################### GENERALIZED LINEAR MODELS ###########################

# Create "No Caulerpa" variable for binomial models
Assemblage_Complexity$Caulerpa <- as.integer(round(Assemblage_Complexity$Per_Caul_Cover))
Assemblage_Complexity$No_Caulerpa <- 100-Assemblage_Complexity$Caulerpa


#################################################################################
###################### Model without depth ######################################
model_complex <- glm(cbind(Caulerpa, No_Caulerpa)~Complexity, family="binomial", data=Assemblage_Complexity)
summary(model_complex)
Anova(model_complex)

qqPlot(residuals(model_complex))

plot(fitted(model_complex), residuals(model_complex), xlab="Fitted Values", ylab="Residuals")
abline(h=0, lty=2)
lines(lowess(fitted(model_complex), residuals(model_complex)))


#### Tukey post-hoc comparisons
pairs(emmeans(model_complex, ~ Complexity))


visreg(model_complex, "Complexity", overlay=T, scale="response")



#################################################################################
###################### Model with depth ######################################
model_complex_depth <- glm(cbind(Caulerpa, No_Caulerpa)~Depth_factor*Complexity, family="binomial", data=Assemblage_Complexity)
summary(model_complex_depth)
Anova(model_complex_depth)

qqPlot(residuals(model_complex_depth))

plot(fitted(model_complex_depth), residuals(model_complex_depth), xlab="Fitted Values", ylab="Residuals")
abline(h=0, lty=2)
lines(smooth.spline(fitted(model_complex_depth), residuals(model_complex_depth)))


#### Tukey post-hoc comparisons
pairs(emmeans(model_complex_depth, ~ Depth_factor|Complexity))
pairs(emmeans(model_complex_depth, ~ Complexity|Depth_factor))


visreg(model_complex_depth, "Complexity", by="Depth_factor", overlay=T, scale="response")
visreg(model_complex_depth, "Depth_factor", by="Complexity", overlay=T, scale="response")




#########################################################
#########################################################
######## 3. Exclusion experiment analysis ###############
#########################################################

### Load the data
load("Exclusion_Experiment.RData")
summary(exclusion)

## Group data and get the summarized information
# 1) By Treatment and Time
exclusion_pair <- group_by(exclusion, Treatment, Time, Depth) %>%
  summarise(Caulerpa=mean(Per_Caul), sd=sd(Per_Caul), se=sd(Per_Caul)/sqrt(length(Replicate)), n=length(Replicate))
exclusion_pair

exclusion_pair$Time <- factor(exclusion_pair$Time, levels=c("July", "August"))
exclusion_pair$Treatment <- factor(exclusion_pair$Treatment, levels=c("Control", "Control_Cage", "Cage"))

# At 10m
ggplot(subset(exclusion_pair, Depth=="10"), aes(x=Time, y=Caulerpa, fill=Treatment)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Caulerpa-se, ymax=Caulerpa+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) +
  ggtitle("Cover of Caulerpa per Treatment and Time at 10m") +
  scale_y_continuous(limit=c(0,40), breaks=seq(0,40,10), name = "Mean cover ± S.E (%)") +
  theme(axis.line = element_line(colour = "black"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y =element_line(size = 0.5, linetype = 'solid',colour = "grey90"),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(size=14, face="bold.italic", hjust=0.5),
        legend.title = element_text(size=13, face="bold"),
        legend.text = element_text(size = 11),
        axis.title = element_text(face = "bold"),
        axis.title.y = element_text(vjust= -1.5, size=13),
        axis.title.x = element_text(vjust= -0.5, size=13),
        axis.text.y = element_text(size=11, face="bold"),
        axis.text.x = element_text(size=11, face="bold"))


# At 30m
ggplot(subset(exclusion_pair, Depth=="30"), aes(x=Time, y=Caulerpa, fill=Treatment)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  geom_errorbar(aes(ymin=Caulerpa-se, ymax=Caulerpa+se),
                width=.2,                    # Width of the error bars
                position=position_dodge(.9)) +
  ggtitle("Cover of Caulerpa per Treatment and Time at 30m") +
  scale_y_continuous(limit=c(0,40), breaks=seq(0,40,10), name = "Mean cover ± S.E (%)") +
  theme(axis.line = element_line(colour = "black"),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y =element_line(size = 0.5, linetype = 'solid',colour = "grey90"),
        panel.grid.minor.x = element_blank(),
        plot.title = element_text(size=14, face="bold.italic", hjust=0.5),
        legend.title = element_text(size=13, face="bold"),
        legend.text = element_text(size = 11),
        axis.title = element_text(face = "bold"),
        axis.title.y = element_text(vjust= -1.5, size=13),
        axis.title.x = element_text(vjust= -0.5, size=13),
        axis.text.y = element_text(size=11, face="bold"),
        axis.text.x = element_text(size=11, face="bold"))


#############################################################################
###################### GENERALIZED LINEAR MIXED EFFECTS MODELS ##############

# Create "No Caulerpa" variable for binomial models
exclusion$No_Caul <- 100-exclusion$Per_Caul
summary(exclusion)


###################### Caulerpa at 10m ######################################
#### Model with random structure to account for repeated measures
Cal10_binom<-glmer(cbind(Per_Caul, No_Caul)~Treatment*Time+(1|Quadrat), family=binomial, data=subset(exclusion, Depth=="10"))
summary(Cal10_binom)
Anova(Cal10_binom)

qqPlot(residuals(Cal10_binom))
## Seems ok

plot(fitted(Cal10_binom), residuals(Cal10_binom), xlab="Fitted Values", ylab="Residuals")


#### Tukey post-hoc comparisons
pairs(emmeans(Cal10_binom, ~ Treatment | Time)) ## Significant differences at the end between the 3 treatments
pairs(emmeans(Cal10_binom, ~ Time | Treatment)) ## Significant differences between times except than for the treatment cage


## Understand the source of the interaction
library(visreg)
visreg(Cal10_binom, "Treatment", by="Time", overlay=T)
visreg(Cal10_binom, "Treatment", by="Time", overlay=T, scale="response")
visreg(Cal10_binom, "Time", by="Treatment", overlay=T)
visreg(Cal10_binom, "Time", by="Treatment", overlay=T, scale="response")



###################### Caulerpa at 30m ######################################

#### Model with random structure to account for repeated measures
Cal30_binom<-glmer(cbind(Per_Caul, No_Caul)~Treatment+Time+(1|Quadrat), family=binomial, data=subset(exclusion, Depth=="30"))
summary(Cal30_binom)
Anova(Cal30_binom)

qqPlot(residuals(Cal30_binom))
## Seems ok

plot(fitted(Cal30_binom), residuals(Cal30_binom), xlab="Fitted Values", ylab="Residuals")


#### Tukey post-hoc comparisons
pairs(emmeans(Cal30_binom, ~ Treatment | Time)) ## No significant differences 
pairs(emmeans(Cal30_binom, ~ Time | Treatment)) ## Significant differences between times except or all treatments


library(visreg)
visreg(Cal30_binom, "Treatment", overlay=T, scale="response")
visreg(Cal30_binom,"Time", overlay=T, scale="response")
