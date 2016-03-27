# https://dataverse.harvard.edu/dataset.xhtml?id=2701204&versionId76395
library(rgdal)
library(rgeos)

## Wards
unzip(zipfile = "data-raw/Election_Wards_2015.zip",
      exdir = "data-raw/",
      overwrite = TRUE)

wards <- rgdal::readOGR(dsn = "data-raw/Election_Wards.shp",
                        layer = "Election_Wards")

file.remove(paste0("data-raw/Election_Wards", c(".dbf", ".prj", ".sbn",
                                                ".sbx", ".shp", ".shp.xml",
                                                ".shx")))

# Check polygons
rgeos::gIsValid(wards)
rgeos::gIsValid(wards, byid = TRUE)
rgeos::gIsSimple(wards, byid = TRUE)

# Clean attribute data
wards$ward <- wards$WARD
wards$n_precincts <- wards$CNT_WARD
wards@data <- wards@data[, c("ward", "n_precincts")]

# Reproject to geographic coordinates
wards <- sp::spTransform(wards, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

# Save
devtools::use_data(wards, overwrite = TRUE, compress = "gzip")

## Precincts
unzip(zipfile = "data-raw/Election_Precincts_2015.zip",
      exdir = "data-raw/",
      overwrite = TRUE)

precincts <- rgdal::readOGR(dsn = "data-raw/Election_Precincts.shp",
                            layer = "Election_Precincts")

file.remove(paste0("data-raw/Election_Precincts", c(".dbf", ".prj", ".sbn",
                                                    ".sbx", ".shp", ".shp.xml",
                                                    ".shx")))

# Check polygons
rgeos::gIsValid(precincts)
rgeos::gIsValid(precincts, byid = TRUE)
rgeos::gIsSimple(precincts, byid = TRUE)

# Clean attribute data
precincts$ward <- as.numeric(substr(precincts$WDPCT, 1, 2))
precincts$precinct <- as.numeric(substr(precincts$WDPCT, 3, nchar(as.character(precincts$WDPCT))))
precincts$id <- precincts$WDPCT
precincts@data <- precincts@data[, c("id", "precinct", "ward")]

# Merge down separated precincts
fix1 <- gUnaryUnion(precincts[as.character(precincts$id) %in% c("0207"), ])
fix1 <- sp::spChFIDs(fix1, "0207")
fix1.data <- precincts@data[as.character(precincts$id) %in% c("0207"), ]
fix1.data <- fix1.data[!duplicated(fix1.data), ]
rownames(fix1.data) <- "0207"
fix1 <- SpatialPolygonsDataFrame(Sr = fix1,
                                 data = fix1.data,
                                 match.ID = TRUE)
fix2 <- gUnaryUnion(precincts[as.character(precincts$id) %in% c("0305"), ])
fix2 <- sp::spChFIDs(fix2, "0305")
fix2.data <- precincts@data[as.character(precincts$id) %in% c("0305"), ]
fix2.data <- fix2.data[!duplicated(fix2.data), ]
rownames(fix2.data) <- "0305"
fix2 <- SpatialPolygonsDataFrame(Sr = fix2,
                                 data = fix2.data,
                                 match.ID = TRUE)

precincts <- precincts[!as.character(precincts$id) %in% c("0207", "0305"), ]
precincts <- rbind(precincts, fix1, fix2)

rm(list = ls()[grepl("^fix*", ls())])

# Set polygon IDs
precincts <- sp::spChFIDs(precincts, as.character(precincts$id))

# Reproject to geographic coordinates
precincts <- sp::spTransform(precincts, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

# Save
devtools::use_data(precincts, overwrite = TRUE, compress = "gzip")

## Check against
## https://www.cityofboston.gov/maps/pdfs/ward_and_precincts.pdf
# plot(precincts)
# plot(wards, border = "red", add = TRUE)
