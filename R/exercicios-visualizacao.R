## Os próximos exercícios utilizam o conjunto de dados gapminder.csv
## Exercício 01 ----------------------------------------------------------------
# Exiba em um gráfico a expectativa média de vida ao longo dos anos para cada 
# continente.
gm %>% 
  group_by(continent, year) %>% 
  summarise(meanlife = mean(lifeExp)) %>% 
  ggplot(aes(x = year, y = meanlife, colour = continent)) + 
  geom_line(lwd = 1) + labs(x = "Year", y = "Mean Life Expectancy") + 
  theme_minimal()
