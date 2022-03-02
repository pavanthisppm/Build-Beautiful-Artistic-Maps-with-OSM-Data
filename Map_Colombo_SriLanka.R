library(tidyverse)
library(osmdata)
library(sf)
library(showtext)


streets = getbb("Colombo Sri Lanka")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()


small_streets = getbb("Colombo Sri Lanka")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "service", "footway")) %>%
  osmdata_sf()

trains = getbb("Colombo Sri Lanka")%>%
  opq()%>%
  add_osm_feature(key = "railway", 
                  value = c("rail")) %>%
  osmdata_sf()


background_color = '#1E212B'
street_color = '#8f5703'
small_street_color = '#D4B483'
trains_color = '#000000'
font_color = '#FFFFFF'


map = ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = street_color,
          size = .5,
          alpha = .6) +
  
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = small_street_color,
          size = .3,
          alpha = .6) +
  
  geom_sf(data = trains$osm_lines,
          inherit.aes = FALSE,
          color = trains_color,
          size = .3,
          alpha = .6) +
  
  theme_void() +
  theme(plot.title = element_text(family = 'sans',
                                  color=font_color,
                                  size = 18, face="bold", hjust=.5,
                                  vjust=2.5),
        panel.border = element_rect(colour = "white", fill=NA, size=3),
        plot.margin=unit(c(0.6,1.6,1,1.6),"cm"),
        plot.subtitle = element_text(color=font_color,
                                     family = 'sans',
                                     vjust=0.1,
                                     size = 12, hjust=.5, margin=margin(2, 0, 5, 0)),
        plot.background = element_rect(fill = "#282828")) +
  coord_sf(ylim = c(6.86, 6.98), 
           xlim = c(79.82, 79.90), 
           expand = FALSE) +
  
  labs(title = "Colombo, SRI LANKA", 
       subtitle = '6.9271° N, 79.8612° E')

map
