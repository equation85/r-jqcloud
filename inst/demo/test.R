library(rJQCloud)

dat <- list(
  list(text='Lorem', weight=15),
  list(text='Ipsum', weight=9, link='http://jquery.com/'),
  list(text='Dolor', weight=6, html=list(title='I can have any html attribute')),
  list(text='Sit', weight=7),
  list(text='Amet', weight=5),
  list(text='新闻', weight=12, html=list(class='news', title='新闻标题'), link='http://weibo.com')
)
opt <- list(width=500, height=500)
a <- rJQCloud:::jQCloud$new(dat, opt)
print(a)


