# Road Safety in Madrid: a Spatial Analysis 🚦

**Where do traffic accidents cluster in Madrid, and are those areas covered by speed cameras and red-light cameras?**
Final project · Spatial and Spatio-temporal Data · BSc in Business Intelligence & Analytics · University of Valencia (2025)

🇪🇸 [Versión en español](README.es.md)

📄 **[Read the full report (PDF, in Spanish)](informe.pdf)**

---

## Summary

Using open data from Madrid City Council, this project analyses **5,322 traffic accidents** (January–March 2025; 12,506 records, one per person involved), the location of **36 speed cameras** and **37 red-light cameras**, and **traffic intensity from ~4,900 measurement points** (January–April 2025).

The analysis is done in two stages:

1. **Point pattern analysis**: are accidents randomly distributed across the city, or do they cluster?
2. **Areal data analysis by district**: accidents are normalised by each district's average traffic intensity, and spatial autocorrelation is tested to find critical areas and compare them with the number of control devices.

## Key findings

- Accidents are **not randomly distributed** (Complete Spatial Randomness is rejected using G-function envelopes and Ripley's K).
- Accidents relative to traffic show **significant positive spatial autocorrelation** (Moran's I = 0.21, p = 0.007).
- **LISA** identifies four critical districts: Puente de Vallecas, Villaverde and Villa de Vallecas (*High-High* cluster) and Centro (*High-Low*).
- **Bivariate LISA** shows that Villaverde, Villa de Vallecas and Vicálvaro combine a high accident rate with a significantly low number of red-light cameras. Centro, on the other hand, has many speed cameras and still a high accident rate, which suggests that their placement could be improved.

## Methods

| Stage | Techniques | R packages |
|---|---|---|
| Data preparation | Geocoding of missing coordinates (ArcGIS), conversion to `sf` | `tidygeocoder`, `sf` |
| Point patterns | Envelopes of the G-function, Ripley's K, kernel density estimation with optimal bandwidth | `spatstat`, `splancs` |
| Areal data | Spatial weights, global Moran's I, local LISA, bivariate LISA | `spdep`, `rgeoda` |
| Visualisation | Static and interactive maps | `ggplot2`, `ggspatial`, `tmap`, `leaflet` |

## Repository structure

```
├── informe.qmd              # Full analysis (Quarto): code + report
├── informe.pdf              # Report as submitted
├── preparar_trafico.R       # Summarises the raw traffic data (~3 GB) by district and month
├── principales/             # Accidents, speed cameras and red-light cameras (Excel)
├── distritos/               # District boundaries (shapefile)
└── trafico/
    └── trafico_distrito_mes.csv   # Traffic summary used by the report
```

> **About the traffic data:** the raw traffic intensity files take up ~3 GB (4 CSV files of ~750 MB each), so they are not included. `preparar_trafico.R` reduces them to the 84 rows (21 districts × 4 months) the analysis needs, saved in `trafico/trafico_distrito_mes.csv`. The results are identical to processing the raw data.

## How to run it

1. Install [R](https://cran.r-project.org/) and [Quarto](https://quarto.org/) (included in RStudio).
2. Open `informe.qmd` in RStudio and click **Render**. Missing packages are installed automatically the first time.

An internet connection is needed to geocode accidents with missing coordinates and to download the base maps.

### Rebuilding the traffic summary (optional)

Download the traffic intensity data and the traffic measurement points for January–April 2025 from the Madrid open data portal, place them in `intensidad_trafico/` and `pmeds/` (see the header of `preparar_trafico.R`), and run the script.

## Data sources

[Madrid City Council open data portal](https://datos.madrid.es): traffic accidents (2025), speed cameras, red-light cameras, traffic intensity history, traffic measurement points and district boundaries.

## Author

**Miquel Blasco Cantó** · [GitHub](https://github.com/miiquelblasco)
