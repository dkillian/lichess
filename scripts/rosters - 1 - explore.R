# lichess rosters explore

dat <- read_csv("data/processed/lichess rosters seasons 1-19.csv") %>%
  arrange(season)

head(dat)
str(dat)

teams <- frq(dat$team) %>% as.data.frame
head(teams)

# players, boards, rating by season

library(dplyr)

bySeason <- dat %>%
  group_by(season) %>%
  dplyr::summarize(players=n(),
                   boards=max(board),
                   rating=mean(rating))

bySeason

write_csv(bySeason, "tables/players, boards, rating by season.csv")

ggplot(bySeason, aes(season, players)) + 
  geom_point(size=2, color="darkblue") + 
  stat_smooth() + 
  scale_x_continuous(breaks=1:19) + 
  scale_y_continuous(breaks=seq(0,250,25))

ggplot(bySeason, aes(season, boards)) + 
  geom_point(size=2, color="darkblue") + 
  geom_line(color="darkblue") + 
  scale_x_continuous(breaks=1:19) + 
  scale_y_continuous(limits=c(1,10),
                     breaks=1:10)

ggplot(bySeason, aes(season, rating)) + 
  geom_point(size=2, color="darkblue") + 
  stat_smooth(method="lm") + 
  scale_x_continuous(breaks=1:19) + 
  scale_y_continuous(limits=c(1000,2500),
                     breaks=seq(1000,2500,500))

# incorporate the number of boards as a variable in the main dataset

dat <- dat %>%
  left_join(bySeason[,c(1,3)])

head(dat)

ggplot(bySeason, aes(season, rating)) + 
  geom_point(size=2, color="darkblue") + 
  stat_smooth(method="lm") + 
  scale_x_continuous(breaks=1:19) + 
  scale_y_continuous(limits=c(1000,2500),
                     breaks=seq(1500,2000,50)) + 
  facet_wrap(~boards, ncol=4, scales="free")



# how often do players keep playing?

player_cnt <- dat %>%
  group_by(name) %>%
  dplyr::summarize(tournaments=n(),
                   rating=mean(rating)) %>%
  arrange(desc(tournaments))

head(player_cnt)

ggplot(player_cnt, aes(tournaments)) + 
  geom_bar(width=.2, fill="cadetblue") + 
  scale_x_continuous(breaks=1:18)

frq(player_cnt$tournaments)

ggplot(player_cnt, aes(rating, tournaments)) + 
  geom_point(size=1, alpha=.6, color="darkblue") + 
  stat_smooth(color="darkgoldenrod3") + 
  scale_y_continuous(breaks=1:18)


