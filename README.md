# Effect of herbivory and competition on <i>Caulerpa cylindracea</i> abundance

## Article title:
The role of competition and herbivory in biotic resistance against invaders: A synergistic effect.

#### Journal:
Accepted in <i>Ecology</i>

##### Authors:
Jorge Santamaría, Fiona Tomas, Enric Ballesteros, Juan M. Ruiz, Jaime Bernardeau-Esteller, Jorge Terrados, Emma Cebrian

##### Script authors:
J. Santamaría (jorge.santamaria@udg.edu)


## Abstract

Invasive species pose a major threat to global diversity and once they are well established their eradication typically becomes unfeasible. However, certain natural mechanisms can increase the resistance of native communities to invaders and can be used to guide effective management policies. Both competition and herbivory have been identified as potential biotic resistance mechanisms that can limit plant invasiveness but it is still under debate to what extent they might be effective against well-established invaders. Surprisingly, whereas biotic mechanisms are known to strongly interact, most studies up to date have examined single biotic mechanisms separately, which likely influences our understanding of the strength and effectiveness of biotic resistance against invaders. Here we use long-term field data, benthic assemblage sampling and exclusion experiments to assess the effect of native assemblage complexity and herbivory on the invasion dynamics of a successful invasive species, the alga Caulerpa cylindracea. A higher complexity of the native algal assemblage limited C. cylindracea invasion, probably through competition by canopy-forming and erect algae. Additionally, high herbivory pressure by the fish Sarpa salpa reduced C. cylindracea abundance by more than 4 times. However, long-term data of the invasion reflects that biotic resistance strength can vary across the invasion process and it is only where high assemblage complexity is concomitant with high herbivory pressure, that the most significant limitation is observed (synergistic effect). Overall, the findings reported in this study highlight that neglecting the interactions between biotic mechanisms during invasive processes and restricting the studied time scales may lead to underestimations of the true capacity of native assemblages to develop resistance to invaders.

## Methods

1) To assess the role that benthic assemblage complexity might have on <i>C. cylindracea</i> coverage, different assemblages were surveyed in three sites around the Cabrera Archipelago. A shallow assemblage (10 m) and a deep assemblage (30 m) were surveyed at each site to take into account the wide range of benthic assemblage complexities and contrasting herbivory pressures in relation to depth. Assemblages were sampled in 2005, 2006 and 2007. At each site and depth, three random samples measuring 20 x 20 cm2 were collected, with the whole benthic cover removed using a hammer and a chisel. After collection, samples were preserved in 4% formalin in seawater, and once in the laboratory, they were sorted and all algae were identified to species level. Species coverage was calculated by placing the species specimens horizontally over a laboratory tray and measuring the area they covered. Then, each algal species was assigned to a different category (“Canopy-forming”, “Erect”, “Turf” and “Encrusting”) based on their morphological traits. Finally, the percent cover of each category in the sample was calculated. 
The complexity of each sample was defined based on the percentage abundance of the “Canopy-forming” and “Erect” categories. Three levels of complexity were defined for the samples based on the percentage of coverage that comprised canopy-forming and/or erect species: “high complexity” (more than 50%); “medium complexity” (between 15% and 50%) and “low complexity” (lower than 15%).
2) An exclusion experiment was performed to assess whether fish herbivory could act as a biotic resistance mechanism against <i>Caulerpa cylindracea</i> invasion by reducing the abundance of the invasive alga. To this end, in order to obtain a proxy of contrasting herbivory intensities, and bearing in mind that herbivory pressure decreases strongly through the water column, the exclusion experiment was performed at two different depths: 10 m, where herbivory pressure is high, and 30 m, where it is low.
This experiment mainly targeted <i>Sarpa salpa</i>, because it is the only truly herbivorous fish in the western Mediterranean Sea, it plays an important role structuring algal communities and it regularly consumes <i>C. cylindracea</i>. 
The exclusion experiment was set up at the end of June 2011 in Na Foradada, an area where fish communities are well established, sea urchin (<i>Paracentrotus lividus</i> and <i>Arbacia lixula</i>) densities are very low (<0.1 per m2) and the highest densities of the fish <i>S. salpa</i> are found within the National Park, with more than 20 individuals per 250 m2. Furthermore, we chose this area because both the shallow and the deep benthic habitats displayed a similar medium complexity (with coverage of erect and canopy-forming species at between 25-35%) and similar abundances of native species. This meant there was sufficient abundance of <i>C. cylindracea</i> to experimentally assess, in the field, the effect of herbivory pressure on it.
At each depth, 3 treatments were used: “Exclusion”, which consisted of cages of 50 x 50 x 50 cm3 made of plastic netting with a mesh size of 2.5 cm; “Control-Exclusion”, consisting of cages with open sides; and “Control”, consisting of 50 x 50 cm2 quadrats marked permanently on the corners and without a cage. A total of 5 interspersed replicates per treatment were set (15 plots per depth) within an area of <100 m2 to avoid different abiotic conditions between plots. At the beginning (July) and at the end (August) of the experiment, pictures were taken at each plot to subsequently assess C. cylindracea abundance, which was calculated with the computer program photoQuad version 1.4 . In each photograph, 50 random points were placed and then, each of these points was assigned to the category of either “<i>Caulerpa cylindracea</i>” or “other algae”. The proportion of points in each category was then used as a proxy of the percentage abundance for each of those two categories.

## Usage Notes

### Competition_and_Herbivory_Data_Analysis.R
Rcode to: i) Assess the role of assemblage complexity on <i>Caulerpa cylindracea</i> coverage by means of Generalized Mixed Effects Linear Models (GLMM) and to: ii) Assess the role of herbivory on <i>Caulerpa cylindracea</i> abundance by means of Generalized Mixed Effects Linear Models (GLMM).

### Assemblage_Complexity.RData
Dataset with information on benthic assemblage complexity and <i>Caulerpa cylindracea</i> abundance for each of the sampled assemblages (114 assemblages). It is needed to perform the statistical models to assess the role of assemblage complexity on <i>Caulerpa cylindracea</i> coverage.

### Exclusion_Experiment.RData
Dataset with the data from the exclusion experiment. It is needed to perform the statistical models to assess the role of herbivory on <i>Caulerpa cylindracea</i> abundance.
