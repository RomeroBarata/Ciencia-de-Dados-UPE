## Os próximos exercícios utilizam o conjunto de dados gapminder.csv
## Exercício 01 ----------------------------------------------------------------
# Quantos países possuem cada continente?
gm %>% 
  group_by(continent) %>% 
  summarise(count = n_distinct(country))

## Exercício 02 ----------------------------------------------------------------
# Que país Europeu tinha o menor GDP per capita em 1997?
gm %>% 
  filter(continent == "Europe" & year == 1997) %>% 
  arrange(gdpPercap) %>% 
  slice(1)

## Exercício 03 ----------------------------------------------------------------
# Qual era a expectativa média de vida nos anos 80 de cada continente?
gm %>% 
  filter(between(year, 1980, 1989)) %>% 
  group_by(continent) %>% 
  summarise(mean_life_exp = mean(lifeExp))

## Exercício 04 ----------------------------------------------------------------
# Quais os 5 países com o maior GDP total ao longo dos anos?
gm %>% 
  mutate(gdp = gdpPercap * pop) %>% 
  group_by(country) %>% 
  summarise(total_gdp = sum(gdp)) %>% 
  arrange(desc(total_gdp)) %>% 
  slice(1:5)

## Exercício 05 ----------------------------------------------------------------
# Quais países e anos possuem expectativa de vida de pelo menos 80 anos? Exiba 
# apenas as colunas de interesse.
gm %>% 
  group_by(country, year) %>% 
  filter(lifeExp >= 80) %>% 
  select(country, year, lifeExp) %>% 
  print(n = Inf)

## Exercício 06 ----------------------------------------------------------------
# Quais os 10 países que possuem a maior correlação (em qualquer direção) entre 
# expectativa de vida e GDP per capita?
gm %>% 
  group_by(country) %>% 
  summarise(r = abs(cor(lifeExp, gdpPercap))) %>% 
  arrange(desc(r)) %>% 
  slice(1:10)

## Exercício 07 ----------------------------------------------------------------
# Que combinações de continente e ano (excluindo a Ásia) possuem a maior 
# população média considerando todos os seus países? Exiba os resultados em 
# ordem decrescente de população média.
gm %>% 
  filter(continent != "Asia") %>% 
  group_by(continent, year) %>% 
  summarise(meanpop = mean(pop)) %>% 
  arrange(desc(meanpop)) %>% 
  print(n = Inf)

## Exercício 08 ----------------------------------------------------------------
# Quais os 3 países que tiveram as estimativas de população mais consistentes 
# (menor desvio padrão) ao longo dos anos?
gm %>% 
  group_by(country) %>% 
  summarise(pop_sd = sd(pop)) %>% 
  arrange(pop_sd) %>% 
  slice(1:3)

## Exercício 09 ----------------------------------------------------------------
# Que registros indicam que a população de um país diminuiu em relação ao ano
# anterior e a expectativa de vida aumentou em relação ao ano anterior? 
# Dica: Pesquisar sobre 'Window' functions.
gm %>% 
  arrange(country, year) %>% 
  group_by(country) %>% 
  filter(pop < lag(pop) & lifeExp > lag(lifeExp)) %>% 
  print(n = Inf)

## Exercício 10 ----------------------------------------------------------------
# Qual a expectativa média de vida de cada ano para o continente Africano?
gm %>% 
  filter(continent == "Africa") %>% 
  group_by(year) %>% 
  summarise(mean_life_exp = mean(lifeExp))

## Os próximos exercícios utilizam o conjunto de dados Melbourne_housing.csv
## Descrição das variáveis: 
## https://www.kaggle.com/anthonypino/melbourne-housing-market
mh <- read_csv("data/Melbourne_housing.csv")

## Exercício 11 ----------------------------------------------------------------
# Exiba a média e a mediana do preço de um imóvel baseado no número de quartos, 
# mostrando apenas os resultados onde existem pelo menos 50 observações para o 
# número de quartos.
mh %>% 
  drop_na(Price) %>% 
  group_by(Rooms) %>% 
  summarise(mean_price = mean(Price), median_price = median(Price), n = n()) %>% 
  filter(n >= 50)

## Exercício 12 ----------------------------------------------------------------
# Para imóveis com 2 quartos, exiba o preço médio por bairro. Ordene os 
# resultados pelos bairros mais caros.
mh %>% 
  drop_na(Price) %>% 
  filter(Rooms == 2) %>% 
  group_by(Suburb) %>% 
  summarise(mean_price = mean(Price)) %>% 
  arrange(desc(mean_price))

## Exercício 13 ----------------------------------------------------------------
# No mês de Maio, qual foi o bairro com as casas mais caras?
mh %>% 
  drop_na(Price) %>% 
  separate(Date, into = c("Day", "Month", "Year"), sep = "-", convert = TRUE) %>% 
  filter(Month == 5) %>% 
  group_by(Suburb) %>% 
  summarise(mean_price = mean(Price)) %>% 
  arrange(desc(mean_price)) %>% 
  slice(1)

## Os próximos exercícios utilizam o conjunto de dados "flights" presente no 
## pacote "nycflights13".
## Exercício 14 ----------------------------------------------------------------
# Para cada dia do ano, calcule o atraso médio de decolagem dos voos.
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean_dep_delay = mean(dep_delay, na.rm = TRUE))

## Exercício 15 ----------------------------------------------------------------
# Para os voos que partiram de JFK ou LGA, calcule o número de voos que 
# chegaram dentro do tempo esperado.
flights %>% 
  filter(origin %in% c("JFK", "LGA"), arr_delay <= 0) %>% 
  summarise(n = n())

## Exercício 16 ----------------------------------------------------------------
# Qual a companhia aérea mais pontual quanto ao horário de decolagem? E quanto  
# ao horário de chegada?
flights %>% 
  group_by(carrier) %>% 
  summarise(mean_dep_delay = mean(dep_delay, na.rm = TRUE), 
            mean_arr_delay = mean(arr_delay, na.rm = TRUE), 
            n = n()) %>% 
  arrange(mean_dep_delay)  # mean_arr_delay para a segunda pergunta

# Obs.: Resposta pode variar dependendo de como se define pontualidade.

## Exercício 17 ----------------------------------------------------------------
# Qual o destino que recebe mais voos no mês de Junho?
flights %>% 
  filter(month == 6) %>% 
  group_by(dest) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

# Obs.: Essa é uma solução simples que não leva em conta os voos que foram 
# cancelados.

## Exercício 18 ----------------------------------------------------------------
# Na primeira quinzena de Março, quantos voos foram operados pela American 
# Airlines saindo do aeroporto JFK?
flights %>% 
  filter(month == 3, between(day, 1, 15), carrier == "AA", origin == "JFK") %>% 
  summarise(n = n())
