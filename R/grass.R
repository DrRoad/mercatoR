#' @title Slope
#' @description Generates raster maps of slope, aspect, curvatures and partial derivatives from an elevation raster map
#'
#' @param input raster object or <chr>. Input file source or raster object type
#' @param output tif. Input file destination
#' @param format Format for reporting the slope. 0 - degrees, 1 - percent
#' @param precision Type of output aspect and slope maps. 0 - float, 1 - double, 2 - int
#' @param z_factor multiplicative factor to convert elevation units to meters
#' @param min_slope can be used to specify the minimum slope which is computed
#'
#' @return RasterLayer
#' @export
#'
#' @examples
#' slope <- grass_slope(input = 'Spatial/DEM/DEM.tif',
#'                      output = 'Spatial/DEM/new.tif',
#'                      z_factor = 0.3048)
#'
#' slope <- grass_slope(input = DEM,
#'                      output = 'Spatial/DEM/new.tif',
#'                      z_factor = 1)
#'
grass_slope <- function(input, output, format = 1, precision = 0, z_factor = 1, min_slope = 0) {

  param <- RQGIS::get_args_man('grass:r.slope')

  param$elevation <- input
  param$format <- format
  param$prec <- precision
  param$zfactor <- z_factor
  param$min_slp_allowed <- min_slope
  param$slope <- output

  param[c("-a")] <- NULL

  slope <- RQGIS::run_qgis(alg = 'grass:r.slope',
                                     params = param, load_output = TRUE)
}
