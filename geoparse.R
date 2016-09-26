library("dplyr")
library("readr")
library("purrr")
library("geoparser")
library("tidyr")
song_lyrics <- read_csv("./billboard_lyrics_1964-2015.csv")

Encoding(song_lyrics$Lyrics) <- "latin1"  # (just to make sure)
song_lyrics$Lyrics <- iconv(song_lyrics$Lyrics, "latin1", "ASCII", sub="")

song_lyrics <- song_lyrics %>%
  filter(!is.na(Lyrics)) %>%
  by_row(function(x){
  print(x$Song)
  lala <- geoparser_q(x$Lyrics)
  lala$results
})

save(song_lyrics, file = "song_lyrics.RData")

