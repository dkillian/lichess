# Lichess Season 19

setwd("C:/Users/Dan/Dropbox/personal/My Chess Database/lichess season 19")

dat2 <- read_excel("lichess s19 roster.xlsx", sheet="teams") %>% 
  mutate(team_num = 1:37)

dat2
names(dat2)

?pivot_wider
?pivot_longer

dat <- dat2 %>%
  pivot_longer(cols = (board_1:rating_8),
               names_to=c("board","rating"),
               values_to="value",
               names_pattern = "(*)_(*)")

?gather

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
  select(team_num, team, board, rating) %>% 
  mutate(board=as.numeric(board))

dat
str(dat)

library(ggridges)

ggplot(dat, aes(rating, team)) + geom_density_ridges(color="darkgrey", fill="cadetblue1")

ggplot(dat, aes(rating, fct_rev(as.factor(board)))) + 
  geom_density_ridges(color="darkgrey", fill="cadetblue1", alpha=.4) +
  scale_x_continuous(breaks=seq(1000,2500,100)) +
  labs(x="",
       y="Board",
       title="Distribution of ratings by board\nLichess Season 19")

       caption="Lichess 4545\nSeason 19")

ggsave("viz/Ratings by board, s19.png",
       type="cairo",
       device="png",
       height=6,
       width=12)
       
+ 
  facet_wrap(~board)

names(who)

?extract

df <- data.frame(x = c(NA, "a-b", "a-d", "b-c", "d-e"))
df


a <- df %>% extract(x, "A")

df %>% extract(x, c("A", "B"), "([[:alnum:]]+)-([[:alnum:]]+)")

# If no match, NA:
df %>% extract(x, c("A", "B"), "([a-d]+)-([a-d]+)")





