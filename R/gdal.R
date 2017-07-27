#' @title Warp(Reproject)
#' @description The gdalwarp utility is an image mosaicing, reprojection and warping utility. The program can
#' reproject to any supported projection, and can also apply GCPs stored with the image if the image is "raw"
#' with control information.
#'
#' @param input raster object or <chr>. Input file source or raster object type
#' @param output tif. Input file destination
#' @param crs <chr>. Input coordinate reference system formated as 'EPSG:xxxx'
#'
#' @return RasterLayer
#' @export
#'
#' @examples
#' gdal_warp_reproject(input = raster,
#'                     output = 'Data/Spatial/Landclass/NLCD1992/LC9240591483.tif',
#'                     crs = 'EPSG:4326')
#'
#' gdal_warp_reproject(input = 'Data/Spatial/Landclass/NLCD1992/Original.tif',
#'                     output = 'Data/Spatial/Landclass/NLCD1992/Warped.tif',
#'                     crs = 'EPSG:4326')
#'
#'
gdal_warp_reproject <- function(input, output, crs) {

param <- RQGIS::get_args_man(alg = "gdalogr:warpreproject")

r <- raster::raster(input)

r_ext <- paste(raster::xmin(r), raster::ymin(r), raster::xmax(r), raster::ymax(r), sep = ", ")

param$INPUT <- input
param$OUTPUT <- output
param$DEST_SRS <- crs
param$USE_RASTER_EXTENT <- TRUE
param$RASTER_EXTENT <- r_ext


warp_reproject <- RQGIS::run_qgis(alg = "gdalogr:warpreproject",
                params = param,
                load_output = TRUE)

}
