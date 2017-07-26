#' @title QGIS Clip
#'
#' @description This algorithm clips a vector layer using the polygons of an
#' additional polygons layer. Only the parts of the features in the input layer
#' that falls within the polygons of the clipping layer will be added to the
#' resulting layer.
#'
#' @param input <chr> or simple feature object
#' Target layer. Use either a file destination or simple feature dataframe
#' @param overlay <chr> or object
#' Object you will use to clip the target layer. Use either a file destination or simple feature dataframe
#' @param output <chr>
#' file destination. .geojson or .shp
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples
#' qgis_clip(input = US_Roads,
#'           overlay = Maryland,
#'           output = 'C://Documents/Spatial/maryland_roads.shp')
#'
#' qgis_clip(input = 'C://Documents/Spatial/US_Roads.shp',
#'           overlay = 'C://Documents/Spatial/Maryland.shp',
#'           output = 'C://Documents/Spatial/maryland_roads.shp')
#'
qgis_clip <- function(input, overlay, output) {

  param <- RQGIS::get_args_man(alg = "qgis:clip")

  param$INPUT <- input
  param$OVERLAY <- overlay
  param$OUTPUT <- output

  clip <- RQGIS::run_qgis(alg = "qgis:clip",
                          params = param,
                          load_output = TRUE)
}

#' @title Count point in polygons
#' @description This algorithm takes a points layer and a polygon layer and counts
#' the number of points from the first one in each polygons of the second one.
#'
#' A new polygons layer is generated, with the exact same content as the input
#' polygons layer, but containing an additional field with the points count corresponding
#' to each polygon.
#'
#' @param polygon <chr> or simple feature object
#' Target layer. Use either a file destination or simple feature dataframe
#' @param points <chr> or simple feature object
#' Point layer you are counting. Use either a string file destination or simple feature dataframe
#' @param field <chr>
#' Name of new atrribute column
#' @param output <chr>
#' file destination. .geojson or .shp
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples
#' qgis_countpointsinpolygon(polygon = Census_Tracts,
#'                           points = Gunshots,
#'                           field = 'Count',
#'                           output = 'C://Documents/Spatial/shots_per_tract.shp')
#'
#'
qgis_countpointsinpolygon <- function(polygon, points, field = 'Count', output){

  param <- RQGIS::get_args_man(alg = 'qgis:countpointsinpolygon')

  param$POLYGONS <- polygon
  param$POINTS <- points
  param$FIELD <- field
  param$OUTPUT <- output

  countpointsinpolygon <- RQGIS::run_qgis(alg = "qgis:countpointsinpolygon",
                                   params = param,
                                   load_output = TRUE)
}

#' @title Fixed distance buffer
#'
#' @description This algorithm computes a buffer area for all the features in an input layer, using a fixed distance.
#'
#' @param input <chr> or simple feature object
#' Target layer. Use either a file destination or simple feature dataframe
#' @param output <chr>
#' Use a string file destination
#' @param distance <num>
#' Distance units are equivelent to coordinate system units of input shapefile/geojson/sf
#' @param segments <num>
#' Numeric value which determines how many segments are used to draw each section of the buffer. A higher value gives a smoother shape
#' @param dissolve <boolean>
#' TRUE or FALSE. TRUE dissolves all buffers into one continous polygon
#'
#' @return simple feature, geojson, or shapefile(.shp)
#' @export
#'
#' @examples
#' qgis_fixeddistancebuffer(input = 'G:/DC Policy Center/DC_One/Data/Spatial/Metro_GIS_shapefiles/Line.shp',
#'                          output = 'G:/DC Policy Center/DC_One/Data/Spatial/Metro_GIS_shapefiles/buffer.shp',
#'                          distance = 1000)
#'
#' qgis_fixeddistancebuffer(input = Lines,
#'                          output = 'G:/DC Policy Center/DC_One/Data/Spatial/Metro_GIS_shapefiles/buffer.shp',
#'                          distance = 1000)
#'
#'
qgis_fixeddistancebuffer <- function(input, output, distance, segments = 5, dissolve = FALSE) {

  param <- RQGIS::get_args_man('qgis:fixeddistancebuffer')

  param$INPUT <- input
  param$OUTPUT <- output
  param$DISTANCE <- distance
  param$SEGMENTS <- segments
  param$DISSOLVE <- dissolve

  fixeddistancebuffer <- RQGIS::run_qgis(alg = 'qgis:fixeddistancebuffer',
                                         params = param,
                                         load_output = TRUE)
}

#' @title Point Layer from Table
#'
#' @description This algorithm generates a points layer based on the values from an
#' input table.
#'
#' The table must contain a field with the X coordinate of each point
#' and another one with the Y coordinate. A CRS for the output layer has to be specified,
#' and the coordinates in the table are assumed to be expressed in the units used
#' by that CRS.
#'
#' The attributes table of the resulting layer will be the input table.
#'
#' @param input <chr>
#' csv file location. string
#' @param output <chr>
#' string file destination. .geojson or .shp
#' @param xfield <chr>
#' csv column containing X coordinate. String
#' @param yfield <chr>
#' csv column containing Y coordinate. String
#' @param crs <chr>
#' Coordinate reference system. Defualt is 'EPSG:4326'.
#'
#' @return simple feature, geojson, or shapefile(.shp)
#' @export
#'
#' @examples
#' qgis_pointslayerfromtable(input = 'C://Documents/Spatial/cities.csv',
#'                           output = 'C://Documents/Spatial/cities.shp',
#'                           xfield = 'mE',
#'                           yfield = 'mN',
#'                           crs = 'EPSG:102285')
#'
#'
qgis_pointslayerfromtable <- function(input, output, xfield, yfield, crs = 'EPSG:4326'){

  param <- RQGIS::get_args_man(alg = 'qgis:pointslayerfromtable')

  param$INPUT <- input
  param$OUTPUT <- output
  param$XFIELD <- xfield
  param$YFIELD <- yfield
  param$TARGET_CRS <- crs

  pointslayerfromtable <- RQGIS::run_qgis(alg = "qgis:pointslayerfromtable",
                                   params = param,
                                   load_output = TRUE)
}

#' @title Polygon centroids
#' @description This algorithm creates a new point layer, with points
#' representing the centroid of polygons of an input layer.
#'
#' The attributes associated to each point in the output layer are the
#'  same ones associated to the original polygon.
#'
#' @param input <chr> or simple feature object
#' Target layer. Use either a file destination or simple feature dataframe
#' @param output <chr>
#' Destination of output file
#'
#'
#' @return
#' simple feature, geojson, or shapefile
#'
#' @export
#'
#' @examples
#'
#' qgis_polygoncentroids(census_tracts,
#'                       'C://Documents/Spatial/centroid.geojson')
#'
#' qgis_polygoncentroids('C://Documents/Spatial/census_tracts.geojson',
#'                       'C://Documents/Spatial/centroid.geojson')
#'
#'
qgis_polygoncentroids <- function(input, output) {
  param <- get_args_man('qgis:polygoncentroids')

  param$INPUT_LAYER <- input
  param$OUTPUT_LAYER <- output

  polygoncentroids <- RQGIS::run_qgis(alg = "qgis:polygoncentroids",
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
#' @param input <chr> or simple feature object
#' Input layer. Must be target source or simple feature
#' @param output <chr>
#' Destination of output file
#' @param weight <chr>
#' attribute can be specified as containing weights. String
#' @param category <chr>
#' attribute can be specified as containing categories
#'
#' @return simple feature, geojson, or shapefile
#' @export
#'
#' @examples
#' qgis_meancoordinates(input = 'C://Documents/Spatial/cities.geojson',
#'                      output = 'C://Documents/Spatial/meancoordinate.geojson',
#'                      weight = 'Population')
#'
#' qgis_meancoordinates(input = 'C://Documents/Spatial/Counties.geojson',
#'                      output = 'C://Documents/Spatial/meancoordinate.geojson',
#'                      category = 'COUNTY_NAME')
#'
qgis_meancoordinates <- function(input, output, weight = NA, category = NA) {

  param <- RQGIS::get_args_man(alg = 'qgis:meancoordinates')

  param$POINTS <- input
  param$WEIGHT <- weight
  param$UID <- category
  param$OUTPUT <- output



  selectbylocation <- RQGIS::run_qgis(alg = "qgis:meancoordinates",
                                   params = param,
                                   load_output = TRUE)

}

#' @title Create Voronoi Polygons
#' @description This algorithm takes a points layer and generates a polygon layer containing
#'  the voronoi polygons corresponding to those input points.
#'
#' @param input <chr> or simple feature object
#' Input point layer. Must be desination file or simple feature
#' @param output <chr>
#' destination of output file
#' @param buffer <Num>
#' Buffer setting. Defult is 0
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

  param <- RQGIS::get_args_man("qgis:voronoipolygons")

  param$INPUT <- input
  param$BUFFER <- buffer
  param$OUTPUT <- output


  voronoipolygons <- RQGIS::run_qgis(alg = "qgis:voronoipolygons",
    params = param, load_output = TRUE)
}
