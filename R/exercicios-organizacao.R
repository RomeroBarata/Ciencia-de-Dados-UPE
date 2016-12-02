## Exercício 01 ----------------------------------------------------------------
# Identifique as variáveis no seguinte data frame e o transforme em um   
# data frame "tidy". Retorne ao data frame original usando a função spread.
ex01 <- data_frame(country = c("FR", "DE", "US"), 
                   `2011` = c(7000, 5800, 15000), 
                   `2012` = c(6900, 6000, 14000), 
                   `2013` = c(7000, 6200, 13000))

## Exercício 02 ----------------------------------------------------------------
# Identifique as variáveis no seguinte data frame e o transforme em um   
# data frame "tidy". Retorne ao data frame original usando as funções unite e 
# spread.
set.seed(10)
ex02 <- data_frame(id = 1:4,
                   trt = sample(rep(c('control', 'treatment'), each = 2)),
                   work.T1 = runif(4),
                   home.T1 = runif(4),
                   work.T2 = runif(4),
                   home.T2 = runif(4))

## Exercício 03 ----------------------------------------------------------------
# Leia a documentação das funções drop_na e replace_na. Para o seguinte data 
# frame, faça:
# 1. Remova todas as linhas que possuem valores NA.
# 2. Remova todas as linhas que possuem valores NA nas variáveis x e y.
# 3. Substitua os valores NA nas colunas x e z pelos valores 1 e 3, 
# respectivamente.
ex03 <- data_frame(x = c(1, NA, 3, 4), 
                   y = c(7, 7, NA, 8), 
                   z = c(NA, 1, 1, 3))

## Exercício 04 ----------------------------------------------------------------
# Verifique o seguinte data frame. O que há de estranho nele? 
# Leia a documentação da função separate_rows e resolva o problema.
ex04 <- data_frame(ID = 1:4, 
                   Weight = c("55,58", "48,49,52", "60,58,63", "70"), 
                   Month = c("3,4", "5,7,8", "6,7,8", "1"))
