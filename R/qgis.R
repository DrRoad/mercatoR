


#' @title QGIS Clip
#'
#' @description This algorithm clips a vector layer using the polygons of an 
#' additional polygons layer. Only the parts of the features in the input layer 
#' that falls within the polygons of the clipping layer will be added to the 
#' resulting layer.
#'
#' @param input Target layer. Use either a string file destination or simple feature dataframe
#' @param overlay Object you will use to clip the target layer. Use either a string file destination or simple feature dataframe
#' @param output string file destination. .geojson or .shp
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples 
#'
qgis_clip <- function(input, overlay, output) {

  param <- get_args_man(alg = "qgis:clip")

  param$INPUT <- input
  param$OVERLAY <- overlay
  param$OUTPUT <- output

  clip <- run_qgis(alg = "qgis:clip", params = param, load_output = TRUE)
}

#' @title Count point in polygons
#' @description 
#'
#' @param polygon Target layer. Use either a string file destination or simple feature dataframe
#' @param points Point layer you are counting. Use either a string file destination or simple feature dataframe
#' @param field Name of new atrribute column. string
#' @param output string file destination. .geojson or .shp
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples
#' 
#' 
qgis_countpointsinpolygon <- function(polygon, points, field = 'Count', output){
  
  param <- get_args_man(alg = 'qgis:countpointsinpolygon')
  
  param$POLYGONS <- polygon
  param$POINTS <- points
  param$FIELD <- field
  param$OUTPUT <- output
  
  countpointsinpolygon <- run_qgis(alg = "qgis:countpointsinpolygon",
                                   params = param,
                                   load_output = TRUE)
}

#' Point Layer from Table
#'
#' @param input csv file location. string
#' @param output string file destination. .geojson or .shp
#' @param xfield csv column containing X coordinate. String
#' @param yfield csv column containing Y coordinate. String
#' @param crs Coordinate reference system. Defualt is 'EPSG:4326'
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples
#' 
#' 
qgis_pointslayerfromtable <- function(input, output, xfield, yfield, crs = 'EPSG:4326'){

  param <- get_args_man(alg = 'qgis:pointslayerfromtable')

  param$INPUT <- input
  param$OUTPUT <- output
  param$XFIELD <- xfield
  param$YFIELD <- yfield
  param$TARGET_CRS <- crs

  pointslayerfromtable <- run_qgis(alg = "qgis:pointslayerfromtable",
                                   params = param,
                                   load_output = TRUE)
}

#' @title Mean Coordinate(s)
#'
#' @description This algorithm computes a point layer with the center of mass of 
#' geometries in an input layer. An attribute can be specified as containing weights 
#' to be applied to each feature when computing the center of mass. If an categorical attribute 
#' is selected in the category field, features will be grouped according to values in 
#' this field. Instead of a single point with the center of mass of the whole layer, 
#' the output layer will contain a center of mass for the features in each category.
#'  
#' @param input Input layer. Must be target source or simple feature
#' @param output Destination of output file
#' @param weight attribute can be specified as containing weights. String
#' @param category attribute can be specified as containing categories
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples
qgis_meancoordinates <- function(input, output, weight = NA, category = NA) {
  
  param <- get_args_man(alg = 'qgis:meancoordinates')
  
  param$POINTS <- input
  param$WEIGHT <- weight 
  param$UID <- category
  param$OUTPUT <- output
    
  
  
  selectbylocation <- run_qgis(alg = "qgis:meancoordinates",
                                   params = param,
                                   load_output = TRUE)
  
}

#' @title Create Voronoi Polygons
#'
#' @param input Input point layer. Must be target source or simple feature
#' @param output destination of output file
#' @param buffer Buffer setting. Defult is 0
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples qgis_voronoipolygons(input = 'C://Documents/Spatial/Points.geojson',
#'                                output = 'C://Documents/Spatial/Voronoi.geojson', 
#'                                buffer = 0)
#'                                
#' qgis_voronoipolygons(input = Points,
#'                      output = 'C://Documents/Spatial/Voronoi.geojson', 
#'                      buffer = 0)                    
#' 
#' 
#' 
qgis_voronoipolygons <- function(input, output, buffer = 0) {

  param <- get_args_man("qgis:voronoipolygons")

  param$INPUT <- input
  param$BUFFER <- buffer
  param$OUTPUT <- output


  voronoipolygons <- run_qgis(alg = "qgis:voronoipolygons",
    params = param, load_output = TRUE)
}
