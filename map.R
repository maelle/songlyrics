library("dplyr")
library("leaflet")
library("tidyr")
library("htmlwidgets")
load("song_lyrics.RData")

unnested_lyrics <- unnest(song_lyrics, .out)
m <- unnested_lyrics %>%
  group_by(name, longitude, latitude, type) %>%
  summarize(n = n(), song = toString(Song)) %>%
  group_by(name) %>%
  mutate(popup = paste(name, type, n, song, sep = ",")) %>%
  ungroup() %>%
  filter(! type %in% c("continent")) %>%
  leaflet() %>%
  addTiles %>%
  addCircleMarkers(lng = ~longitude,
                   lat = ~latitude,
                   popup = ~popup)

saveWidget(m, "map.html")
