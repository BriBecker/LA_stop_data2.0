get_min_max_dates <- function(stops) {
  date_pivot <- stops %>%
    group_by(STOP_DT) %>%
    summarize(sunset_time = min(Sunset)) %>%
    arrange(sunset_time)
  
  min_part <- date_pivot %>%
    head(1)
  max_part <- date_pivot %>%
    tail(1)
  return(bind_rows(min_part, max_part))
}

# define intertwilight
# we will only analyze stops that fall within intertwilight range
mutate_intertwilight <- function(stops, min_max_sunsets) {
  stops %>%
    mutate(
      is_intertwilight = ifelse(
        STOP_TM >= min_max_sunsets[[1,2]] & STOP_TM <= min_max_sunsets[[2,2]],
        yes = 'yes', no = 'no'
      )
    )
}

mutate_daylight <- function(stops) {
  stops %>%
    mutate(
      is_daylight = ifelse(
        STOP_TM <= Sunrise, yes = 'light', no = 'dark'
      )
    )
}