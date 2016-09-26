library("dplyr")
library("leaflet")
library("tidyr")
load("song_lyrics.RData")

unnested_lyrics <- unnest(song_lyrics, .out)
unnested_lyrics %>%
  group_by(name, longitude, latitude, type) %>%
  summarize(n = n()) %>%
  group_by(name) %>%
  mutate(popup = paste(name, type, n)) %>%
  ungroup() %>%
  filter(! type %in% c("continent")) %>%
  leaflet() %>%
  addTiles %>%
  addCircleMarkers(lng = ~longitude,
                   lat = ~latitude,
                   popup = ~popup)