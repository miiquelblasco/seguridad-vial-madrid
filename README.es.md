# Seguridad vial en Madrid: un análisis espacial 🚦

**¿Dónde se concentran los accidentes de tráfico en Madrid y están esas zonas cubiertas por radares y semáforos con foto-rojo?**
Proyecto final · Datos Espaciales y Espaciotemporales · Grado en Business Intelligence & Analytics · Universitat de València (2025)

🇬🇧 [English version](README.md)

📄 **[Leer el informe completo (PDF)](informe.pdf)**

---

## Resumen

Con datos abiertos del Ayuntamiento de Madrid, el proyecto analiza **5.322 accidentes de tráfico** (enero-marzo de 2025; 12.506 registros, uno por persona implicada), la ubicación de **36 radares** y **37 semáforos con foto-rojo**, y la **intensidad de tráfico de unos 4.900 puntos de medida** (enero-abril de 2025).

El análisis tiene dos partes:

1. **Patrones de puntos**: ¿los accidentes se distribuyen al azar por la ciudad o se agrupan?
2. **Datos regionales por distrito**: los accidentes se relativizan por la intensidad media de tráfico de cada distrito y se contrasta la autocorrelación espacial para detectar zonas críticas y compararlas con el número de dispositivos de control.

## Resultados principales

- Los accidentes **no se distribuyen al azar**: se rechaza la aleatoriedad espacial completa (CSR) con envolventes de la función G y la K de Ripley.
- Los accidentes relativos al tráfico presentan **autocorrelación espacial positiva y significativa** (I de Moran = 0,21; p = 0,007).
- El **LISA** identifica cuatro distritos críticos: Puente de Vallecas, Villaverde y Villa de Vallecas (clúster *High-High*) y Centro (*High-Low*).
- El **LISA bivariado** muestra que Villaverde, Villa de Vallecas y Vicálvaro combinan una tasa alta de accidentes con un número significativamente bajo de semáforos con foto-rojo. En cambio, Centro tiene muchos radares y aun así una tasa alta, lo que sugiere que su ubicación podría mejorarse.

## Métodos

| Fase | Técnicas | Paquetes de R |
|---|---|---|
| Preparación de datos | Geocodificación de coordenadas ausentes (ArcGIS), conversión a `sf` | `tidygeocoder`, `sf` |
| Patrones de puntos | Envolventes de la función G, K de Ripley, estimación de densidad kernel con suavizado óptimo | `spatstat`, `splancs` |
| Datos regionales | Matriz de pesos espaciales, I de Moran global, LISA local, LISA bivariado | `spdep`, `rgeoda` |
| Visualización | Mapas estáticos e interactivos | `ggplot2`, `ggspatial`, `tmap`, `leaflet` |

## Estructura del repositorio

```
├── informe.qmd              # Análisis completo (Quarto): código + informe
├── informe.pdf              # Informe entregado
├── preparar_trafico.R       # Resume los datos brutos de tráfico (~3 GB) por distrito y mes
├── principales/             # Accidentes, radares y semáforos con foto-rojo (Excel)
├── distritos/               # Límites de los distritos (shapefile)
└── trafico/
    └── trafico_distrito_mes.csv   # Resumen de tráfico que usa el informe
```

> **Sobre los datos de tráfico:** los archivos brutos de intensidad de tráfico ocupan unos 3 GB (4 CSV de ~750 MB), así que no se incluyen. `preparar_trafico.R` los reduce a las 84 filas (21 distritos × 4 meses) que necesita el análisis, guardadas en `trafico/trafico_distrito_mes.csv`. Los resultados son idénticos a procesar los datos brutos.

## Cómo ejecutarlo

1. Instala [R](https://cran.r-project.org/) y [Quarto](https://quarto.org/) (viene incluido con RStudio).
2. Abre `informe.qmd` en RStudio y pulsa **Render**. La primera vez se instalan automáticamente los paquetes que falten.

Hace falta conexión a internet para geocodificar los accidentes sin coordenadas y descargar los mapas de fondo.

### Regenerar el resumen de tráfico (opcional)

Descarga del portal de datos abiertos de Madrid la intensidad de tráfico y los puntos de medida de enero a abril de 2025, colócalos en `intensidad_trafico/` y `pmeds/` (ver la cabecera de `preparar_trafico.R`) y ejecuta el script.

## Fuentes de datos

[Portal de datos abiertos del Ayuntamiento de Madrid](https://datos.madrid.es): accidentes de tráfico (2025), radares, semáforos con foto-rojo, histórico de intensidad de tráfico, puntos de medida y límites de distritos.

## Autor

**Miquel Blasco Cantó** · [GitHub](https://github.com/miiquelblasco)
