## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(AISanalyze)
library(dplyr)
library(lubridate)

## -----------------------------------------------------------------------------
data("ais")
data("point_to_extract")

## -----------------------------------------------------------------------------
ais$timestamp <- as.numeric(lubridate::ymd_hms(ais$datetime))
point_to_extract$timestamp <- as.numeric(lubridate::ymd_hm(point_to_extract$datetime))

## -----------------------------------------------------------------------------
ais <- AIStravel(ais_data = ais, crs = 3035)

## -----------------------------------------------------------------------------
ais <- AISidentify_stations_aircraft(ais_data = ais, crs = 3035)

## -----------------------------------------------------------------------------
ais <- AIScorrect_speed(ais_data = ais, crs = 3035)

## ----eval=FALSE---------------------------------------------------------------
# ais_interpolated_60sec <- AISinterpolate(
#   ais_data = ais,
#   type_interpolation = "maximum_time_interval",
#   maximum_gap_seconds = 60,
#   crs = 3035
# )

## ----eval=FALSE---------------------------------------------------------------
# ais_interpolated_exact_timestamps <- AISinterpolate(
#   ais_data = ais,
#   type_interpolation = "exact_timestamp",
#   exact_timestamp = list(
#     timestamp_to_interpolate = point_to_extract$timestamp,
#     locations_of_interest = point_to_extract[c("lon", "lat")],
#     radius = 200000
#   ),
#   crs = 3035
# )

## ----eval=FALSE---------------------------------------------------------------
# ais_interpolated_60sec$datetime <- lubridate::as_datetime(ais_interpolated_60sec$timestamp)
# 
# ais_interpolated_exact_timestamps$datetime <- lubridate::as_datetime(ais_interpolated_exact_timestamps$timestamp)
# 

## ----eval=FALSE---------------------------------------------------------------
# AISextract(
#   ais_data = ais_interpolated_60sec,
#   data = point_to_extract,
#   return_all_vessel_locations = TRUE,
#   search_into_radius_m = 50000,
#   interval_time_before = 5 * 60,
#   interval_time_after = 5 * 60,
#   crs = 3035
# )

## ----eval=FALSE---------------------------------------------------------------
# AISextract(
#   ais_data = ais_interpolated_exact_timestamps,
#   data = point_to_extract,
#   return_all_vessel_locations = FALSE,
#   search_into_radius_m = 50000,
#   interval_time_before = 5 * 60,
#   interval_time_after = 5 * 60,
#   crs = 3035
# )

## ----eval=FALSE---------------------------------------------------------------
# AISextract(
#   ais_data = ais_interpolated_exact_timestamps,
#   data = point_to_extract,
#   return_all_vessel_locations = FALSE, # or TRUE
#   search_into_radius_m = 50000,
#   search_shape = "square",
#   interval_time_before = 5 * 60,
#   interval_time_after = 5 * 60,
#   crs = 3035
# )

## ----eval=FALSE---------------------------------------------------------------
# infos <- AISinfos(ais)
# 
# summary_values <- infos$summary
# estimated_values <- infos$estimated_values

