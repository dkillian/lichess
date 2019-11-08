# lichess prepare

path <- "data/raw/lichess rosters s1-19.xlsx"

sheets <- excel_sheets(path=path)

dat_ls <- lapply(sheets, function(x) read_excel(path=path, sheet=x))

dat2 <- do.call(rbind, dat_ls)

head(dat2)

board <- dat2 %>%
  select(team, 2,4,6,8,10,12,14,16,18) %>%
  pivot_longer(cols=2:9,
               names_to="board",
               values_to="name") %>%
  mutate(board=str_sub(board, start=-1))

board


rating <- dat2 %>%
  select(team, 3,5,7,9,11,13,15,17,18) %>%
  pivot_longer(cols=2:9,
               names_to="board",
               values_to="rating") %>%
  mutate(board=str_sub(board, start=-1))

rating

dat <- merge(board, rating) %>%
  select(team, board, name, rating, season) %>% 
  mutate(board=as.numeric(board)) %>%
  na.omit

write_csv(dat, "data/processed/lichess rosters seasons 1-19.csv")


