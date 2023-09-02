#' @importFrom shiny registerInputHandler
#' @import lubridate
#' @noRd
.onLoad <- function(...){

  shiny::registerInputHandler("DateTimeRangePicker.date", function(data, ...){
    from <- data[["from"]]
    to   <- data[["to"]]
    dt1 <- Sys.time()
    year(dt1)   <- from[["date"]][["year"]]
    month(dt1)  <- from[["date"]][["month"]]
    day(dt1)    <- from[["date"]][["date"]]
    hour(dt1)   <- from[["time"]][["hour"]]
    minute(dt1) <- from[["time"]][["minute"]]
    sec <- from[["time"]][["second"]]
    second(dt1) <- if(is.null(sec)) 0 else sec
    dt2 <- Sys.time()
    year(dt2)   <- to[["date"]][["year"]]
    month(dt2)  <- to[["date"]][["month"]]
    day(dt2)    <- to[["date"]][["date"]]
    hour(dt2)   <- to[["time"]][["hour"]]
    minute(dt2) <- to[["time"]][["minute"]]
    sec <- to[["time"]][["second"]]
    second(dt2) <- if(is.null(sec)) 0 else sec
    c(from = dt1, to = dt2)
  }, force = TRUE)

}
