library(tidyverse)

stop_coltypes <- cols(
  STOP_NBR = 'c',
  FORM_REF_NBR = 'c',
  PERSN_GENDER_CD = 'c',
  PERSN_DESCENT_CD = 'c',
  STOP_DT = col_date(format = '%m/%d/%Y'),
  STOP_TM = col_time(),
  OFCR1_SERL_NBR = 'c',
  DIV1_DESC = 'c',
  OFCR2_SERL_NBR = 'c',
  OFCR2_DIV_NBR = 'c',
  DIV2_DESC = 'c',
  RPT_DIST_NBR = 'c',
  STOP_TYPE = 'c',
  POST_STOP_ACTV_IND = 'c'
)

stops <- read_csv(
  'raw_data/Stop_Data_Open_Data-2015.zip',
  col_types = stop_coltypes
)

sunsets <- read_rds('processed_data/sunset_times.rds')

# join in sunrise/sunset times by data
stops_with_sun <- left_join(
  stops, sunsets,
  by = c('STOP_DT' = 'Date')
)

write_rds(stops_with_sun, 'processed_data/stops_with_sun.rds')
