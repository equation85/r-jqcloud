#PACKAGE.DIR <- '/Users/frank/Projects/codebase/jqcloud'

#' @export
jQCloud <- setRefClass(
  'jQCloud',
  fields = list(opt='list'),
  methods = list(
    initialize = function(x = NULL) {
      opt <<- if (is.null(x)) list() else x
#      opt$id <<- NULL
      opt$data <<- NULL
      opt$height <<- 200L
      opt$width <<- 200L
    },
#    id = function(x) {
#      opt$id <<- x
#    },
    data = function(x) {
      opt$data <<- x
    },
    height = function(x) {
      if (x < 0) {
        stop('"x" must >= 0')
      }
      opt$height <<- as.integer(x)
    },
    width = function(x) {
      if (x < 0) {
        stop('"x" must >= 0')
      }
      opt$width <<- as.integer(x)
    },
    html = function(id=NULL) {
      if (is.null(id)) {
        id <- tempfile(tmpdir='', pattern='id')
        id <- substr(id, 2, nchar(id))
      }
      html.str <- sprintf('
        <div id="%1$s"></div>
        <script type="text/javascript">
          (function($) {
            $(function() {
              $("#%s").height("%dpx").width("%dpx").jQCloud(%s);
            });
          })(jQuery);
        </script>', id, opt$height, opt$width, RJSONIO::toJSON(opt$data))
      return(html.str)
    },
    show = function() {
      assign('.jQCloud.object', .self$copy(), envir=.GlobalEnv)
      #shiny::runApp(file.path(PACKAGE.DIR, 'shiny'))
      shiny::runApp(system.file('shiny', package='rJQCloud'))
    })
)

#' @export
jQCloudOutput <- function(outputId) {
  #singleton(addResourcePath('jqcloud', file.path(PACKAGE.DIR, 'inst')))
  singleton(addResourcePath('jqcloud', system.file(package='rJQCloud')))
  div(class='jQCloud',
      tagList(singleton(tags$head(
          tags$script(src='jqcloud/js/jquery-1.11.0.min.js', type='text/javascript'),
          tags$script(src='jqcloud/js/jqcloud-1.0.4.min.js', type='text/javascript'),
          tags$link(rel='stylesheet', type='text/css', href='jqcloud/css/jqcloud.css')
        ))),
      htmlOutput(outputId)
  )
}

#' @export
renderJQCloud <- function(expr, env=parent.frame(), quoted=FALSE) {
  func <- shiny::exprToFunction(expr, env, quoted)

  function() {
    g <- func()
    g$html()
  }
}
