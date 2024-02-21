# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)



# Data Import
citations <- stri_read_lines("../docs/citations.txt", encoding = 'Windows-1252')
citations_txt <- citations[!stri_isempty(citations)]
length(citations) - length(citations_txt)
mean(str_length(citations_txt))

# Data Cleaning


citations_tbl <- tibble(line = 1:length(citations_txt), cite = citations_txt) %>%
  mutate(cite = str_replace_all(cite, pattern = "[\'\"]", replacement = "")) %>%
  mutate(year = str_extract(cite, pattern = "\\d{4}")) %>%
  mutate(page_start = str_extract(cite, pattern = "\\d+(?=-\\d+)"))
