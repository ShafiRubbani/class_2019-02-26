library(tidyverse)
library(dplyr)
library(ggplot2)
library(gt)
library(readxl)
library(janitor)

download.file("https://registrar.fas.harvard.edu/files/fas-registrar/files/class_enrollment_summary_by_term_03.06.18.xlsx",
              destfile = "spring_2018.xlsx",
              mode = "wb"
              )

download.file("https://registrar.fas.harvard.edu/files/fas-registrar/files/class_enrollment_summary_by_term_2.28.19.xlsx",
              destfile = "spring_2019.xlsx",
              mode = "wb")

spring_2018 <- read_excel("spring_2018.xlsx", skip = 2) %>%
  clean_names() %>% 
  filter(!is.na(course_name)) %>% 
  select(course_id, course_title, course_name, u_grad)

spring_2019 <- read_excel("spring_2019.xlsx", skip = 3) %>% 
  clean_names() %>% 
  filter(!is.na(course_name)) %>% 
  select(course_id, course_title, course_name, u_grad)

spring_enrollment <- spring_2018 %>% 
  inner_join(spring_2019, by = "course_title", suffix = c("_2018", "_2019"))

spring_enrollment %>% 
  filter(u_grad_2018 == 322) %>% 
  select(course_title, u_grad_2018, u_grad_2019)
