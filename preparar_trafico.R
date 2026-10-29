# =====================================================================
# Preparación de los datos de intensidad de tráfico
# ---------------------------------------------------------------------
# Los CSV brutos de intensidad de tráfico (~3 GB, enero-abril 2025) no se
# incluyen en el repositorio. Este script los resume en una tabla pequeña
# (tráfico por distrito y mes) que es la que utiliza informe.qmd.
#
# Para reproducirlo, descarga del Portal de datos abiertos del Ayuntamiento
# de Madrid los datos de "Tráfico. Histórico de datos del tráfico" y
# "Tráfico. Ubicación de los puntos de medida" (enero-abril 2025) y colócalos en:
#   ./intensidad_trafico/01-2025.csv ... 04-2025.csv
#   ./pmeds/pmed_ubicacion_01-2025.xlsx ... pmed_ubicacion_04-2025.xlsx
#
# Resultado: ./trafico/trafico_distrito_mes.csv
# =====================================================================

library(readxl)
library(readr)
library(dplyr)

meses <- c("01", "02", "03", "04")

resumen <- lapply(meses, function(mes) {
  # Puntos de medida (id y distrito) e intensidad de tráfico del mes
  pmed <- read_xlsx(paste0("./pmeds/pmed_ubicacion_", mes, "-2025.xlsx"))
  tra  <- read_delim(paste0("./intensidad_trafico/", mes, "-2025.csv"), delim = ";")

  tra <- left_join(tra, pmed, by = c("id" = "id"))

  # Tráfico medio durante 15 minutos por punto de medida
  med <- tra %>%
    select(id, distrito, intensidad) %>%
    group_by(id, distrito) %>%
    summarise(total = mean(intensidad, na.rm = TRUE), .groups = "drop")

  # Suma del tráfico medio en 15 minutos de los puntos de medida de cada distrito
  med_distrito <- med %>% select(distrito, total) %>%
    group_by(distrito) %>%
    summarise(total = sum(total)) %>% filter(!is.na(distrito))

  rm(tra, med); gc()
  mutate(med_distrito, mes = mes, .before = 1)
})

trafico_distrito_mes <- bind_rows(resumen)

dir.create("trafico", showWarnings = FALSE)
write_csv(trafico_distrito_mes, "./trafico/trafico_distrito_mes.csv")
