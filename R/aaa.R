#' @importFrom shiny registerInputHandler
#' @import lubridate
#' @noRd
.onLoad <- function(...){

  shiny::registerInputHandler("DateTimeRangePicker.date", function(data, ...){
    from <- data[["from"]]
    to   <- data[["to"]]
    dt1 <- Sys.time()
    day(dt1)    <- from[["date"]][["date"]]
    month(dt1)  <- from[["date"]][["month"]]
    year(dt1)   <- from[["date"]][["year"]]
    hour(dt1)   <- from[["time"]][["hour"]]
    minute(dt1) <- from[["time"]][["minute"]]
    sec <- from[["time"]][["second"]]
    second(dt1) <- if(is.null(sec)) 0 else sec
    dt2 <- Sys.time()
    day(dt2)    <- to[["date"]][["date"]]
    month(dt2)  <- to[["date"]][["month"]]
    year(dt2)   <- to[["date"]][["year"]]
    hour(dt2)   <- to[["time"]][["hour"]]
    minute(dt2) <- to[["time"]][["minute"]]
    sec <- to[["time"]][["second"]]
    second(dt2) <- if(is.null(sec)) 0 else sec
    c(from = dt1, to = dt2)
  }, force = TRUE)

}
