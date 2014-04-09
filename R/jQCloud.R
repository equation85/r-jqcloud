#' @export
jQCloud <- setRefClass(
  'jQCloud',
  fields = list(wordOptions='list', cloudOptions='list'),
  methods = list(
    initialize = function(word.options=list(), cloud.options=list(width=500, height=500)) {
      wordOptions <<- word.options
      cloudOptions <<- cloud.options
    },
    setWordOptions = function(word.options) {
      wordOptions <<- word.options
    },
    setCloudOptions = function(cloud.options) {
      cloudOptions <<- cloud.options
    }
  )
)

#' @export
jQCloudOutput <- function(outputId) {
  singleton(addResourcePath('jqcloud', system.file(package='rJQCloud')))
  tags$div(id=outputId, class='jqcloud-output',
    tagList(singleton(tags$head(
      tags$script(src='jqcloud/js/jquery-1.11.0.min.js', type='text/javascript'),
      tags$script(src='jqcloud/js/jqcloud-1.0.4.min.js', type='text/javascript'),
      tags$script(src='jqcloud/js/jqcloud_binding.js', type='text/javascript'),
      tags$link(href='jqcloud/css/jqcloud.css', type='text/css', rel='stylesheet')
    )))
  )
}

#' @export
renderJQCloud <- function(expr, env=parent.frame(), quoted=FALSE) {
  func <- shiny::exprToFunction(expr, env, quoted)

  function() {
    g <- func()
    if (!inherits(g, 'jQCloud')) {
      stop('renderJQCloud() need a return value of class "jQCloud"!')
    }
    word.options <- g$wordOptions
    cloud.options <- if (length(g$cloudOptions) == 0L) emptyNamedList else g$cloudOptions
    list(wordOptions=word.options, cloudOptions=cloud.options)
  }
}

#' @export
print.jQCloud <- function(x) {
  if (!require(shiny)) {
    stop('"shiny" package not found!')
  }

  runApp(
    list(
      ui = bootstrapPage(jQCloudOutput('show')),
      server = function(input, output) {
        output$show <- renderJQCloud({
          x
        })
      }
    )
  )
}
