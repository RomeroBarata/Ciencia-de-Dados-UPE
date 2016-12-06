## Importando os pacotes necessários -------------------------------------------
library(readr)         # Importar/exportar os dados
library(tidyr)         # Organizar os dados
library(dplyr)         # Manipular os dados de forma eficiente
library(ggplot2)       # Geração de gráficos de alta qualidade
library(ggvis)         # Geração de gráficos interativos
library(nycflights13)  # Dados sobre os voos que sairam de NYC em 2013

## Organizar os dados ----------------------------------------------------------
hr <- read_csv("data/heartrate2dose.csv")

tidyhr <- hr %>%
  gather(key = "drugdose", value = "hr", a_10:c_20) %>% 
  separate(drugdose, into = c("drug", "dose"), sep = "_", convert = TRUE)

tidyhr %>% 
  unite("drugdose", drug, dose, sep = "_") %>% 
  spread(key = drugdose, value = hr)

## Analisar os dados -----------------------------------------------------------
gm <- read_csv("data/gapminder.csv")

# filter / slice
# Exibir todos os registros que pertencem à Asia ou a Oceania.
gm %>% 
  filter(continent == "Asia" | continent == "Oceania")
# Equivalentemente
gm %>% 
  filter(continent %in% c("Asia", "Oceania"))

# Para cada continente, exibir os 3 primeiros registros.
gm %>% 
  group_by(continent) %>% 
  slice(1:3)

# select
# Para cada registro, exibir apenas o país, o ano e a população.
gm %>% 
  select(country, year, pop)

# Exibir o nome de todos os países sem repetições.
gm %>%
  select(country) %>% 
  distinct()

# Mover a variável continente para a primeira coluna.
gm %>% 
  select(continent, everything())

# Remover a variável de população
gm %>% 
  select(-pop)

# arrange
# Ordenar os registros em ordem crescente de população.
gm %>% 
  arrange(pop)

# Ordenar os registros em ordem decrescente de ano e ordem crescente 
# de expectativa de vida.
gm %>% 
  arrange(desc(year), lifeExp)

# mutate / transmute
# Criar a variável gdp (Obs.: gdp = gdpPercap * pop) e outra variável que é o 
# log do gdp.
gm %>% 
  mutate(gdp = gdpPercap * pop, logGdp = log(gdp))

# Criar a variável gdp e exibir apenas ela.
gm %>% 
  mutate(gdp = gdpPercap * pop) %>% 
  select(gdp)
# Equivalentemente
gm %>% 
  transmute(gdp = gdpPercap * pop)

# summarise + group_by
# Para cada país, calcule o gdp médio ao longo dos anos.
gm %>% 
  mutate(gdp = gdpPercap * pop) %>% 
  group_by(country) %>% 
  summarise(meangdp = mean(gdp))

## Visualizar os dados ---------------------------------------------------------
# Exemplos

# ggplot2
mtcars %>% 
  ggplot(aes(x = wt, y = mpg)) + 
  geom_point(size = 2, shape = 5, colour = "red")
# ggvis
mtcars %>% 
  ggvis(x = ~wt, y = ~mpg) %>% 
  layer_points(size := 25, shape := "diamond", stroke := "red", fill := NA)

# ggplot2
mtcars %>% 
  ggplot(aes(x = wt, y = mpg)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = TRUE)
# ggvis
mtcars %>% 
  ggvis(x = ~wt, y = ~mpg) %>% 
  layer_points() %>% 
  layer_smooths()

# ggplot2
mtcars %>% 
  ggplot(aes(x = wt, y = mpg)) + 
  geom_point(aes(colour = factor(cyl)))
# ggvis
mtcars %>% 
  ggvis(x = ~wt, y = ~mpg) %>% 
  layer_points(fill = ~factor(cyl))

# ggplot2
mtcars %>% 
  ggplot(aes(x = wt, y = mpg, colour = factor(cyl), group = cyl)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)
# ggvis
mtcars %>% 
  ggvis(x = ~wt, y = ~mpg, fill = ~factor(cyl)) %>% 
  layer_points() %>% 
  group_by(cyl) %>% 
  layer_model_predictions(model = "lm")

# ggvis
mtcars %>% 
  ggvis(x = ~wt) %>% 
  layer_histograms(width = input_slider(0.1, 2, step = 0.1, label = "width"), 
                   center = input_slider(0.1, 2, step = 0.05, label = "center"))

# ggvis
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_smooths(span = input_slider(0.5, 1, value = 1, label = "span")) %>%
  layer_points(size := input_slider(100, 1000, value = 100))

# ggvis
mtcars %>% 
  ggvis(x = ~wt) %>%
  layer_densities(adjust = input_slider(0.1, 2, value = 1, step = 0.1, 
                                        label = "Bandwidth adjustment"),
                  kernel = input_select(c("Gaussian" = "gaussian",
                                          "Epanechnikov" = "epanechnikov",
                                          "Rectangular" = "rectangular",
                                          "Triangular" = "triangular",
                                          "Biweight" = "biweight",
                                          "Cosine" = "cosine",
                                          "Optcosine" = "optcosine"),
                                        label = "Kernel"))
