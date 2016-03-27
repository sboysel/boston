#' Election Wards of the City of Boston
#'
#'  Spatial boundaries of the 22 election wards for Boston.
#'
#' @format A \code{SpatialPolygonsDataFrame} with 22 features and 2 attributes:
#' \describe{
#' \item{\code{ward}}{integer ward number.}
#' \item{\code{n_precincts}}{integer number of police precincts in ward.}
#' }
#'
#' See
#'  \url{https://www.cityofboston.gov/maps/pdfs/ward_and_precincts.pdf} for details.
"wards"

#' Election Precincts of the City of Boston
#'
#'  Spatial boundaries of the 253 election precincts for Boston.
#'
#' @format A \code{SpatialPolygonsDataFrame} with 253 features and 3 attributes:
#' \describe{
#' \item{\code{precinct}}{integer precinct number.}
#' \item{\code{ward}}{integer number of ward in which precinct resides.}
#' \item{\code{id}}{factor unique identifier for each precinct.  Combines
#' \code{ward} and \code{precinct}.}
#' }
#'
#' See
#'  \url{https://www.cityofboston.gov/maps/pdfs/ward_and_precincts.pdf} for details.
"precincts"
