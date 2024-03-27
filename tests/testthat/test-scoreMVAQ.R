test_that("min check", {
  expect_equal(
    scoreMVAQ(read.table(text = "MIN,0,0,0,0,0,0,0,0,0,0,0,0,0,0", sep = ",")),
    list(
      thetas = structure(
        list(
          ID = "MIN", ARF = -1.19709136673914,
          ACF = -1.32692104685461),
        class = "data.frame",
        row.names = c(NA, -1L)),
      ses = structure(
        list(
          ID = "MIN",
          ARF = 0.534612347127066,
          ACF = 0.613967026527487),
        class = "data.frame",
        row.names = c(NA, -1L))),
    tolerance = 0.001
  )
})

test_that("max check", {
  expect_equal(
    scoreMVAQ(read.table(text = "MAX,3,3,3,3,3,3,3,3,3,3,3,3,3,3", sep = ",")),
    list(
      thetas = structure(
        list(
          ID = "MAX", ARF = 1.63047871157303,
          ACF = 2.6229948564516),
        class = "data.frame",
        row.names = c(NA, -1L)),
      ses = structure(
        list(
          ID = "MAX",
          ARF = 0.485776798716397,
          ACF = 0.474510329099166),
        class = "data.frame",
        row.names = c(NA, -1L))),
    tolerance = 0.001
  )
})

test_that("order check", {
  expect_equal(
    scoreMVAQ(data.frame(ID = sprintf("Q%0.2d", 1:14), diag(14))),
    list(
      thetas = structure(
        list(
          ID = c("Q01", "Q02", "Q03", "Q04", "Q05", "Q06", "Q07", "Q08", "Q09", "Q10", "Q11", "Q12", "Q13", "Q14"),
          ARF = c(-1.19709136673914, -1.19709136673914, -1.19709136673914, -1.19709136673914, -1.19709136673914, -1.19709136673914, -0.686986211511992, -0.679985880582174, -0.46035408852436, -0.430010344941477, -0.509698653797126, -0.516135714956135, -1.19709136673914, -1.19709136673914),
          ACF = c(-0.826634414020105, -0.895549702231255, -0.479243608285295, -0.420453980145881, -0.674636280256222, -0.794447588703655, -1.32692104685461, -1.32692104685461, -1.32692104685461, -1.32692104685461, -1.32692104685461, -1.32692104685461, -0.784159598497498, -0.872733549351309)),
        class = "data.frame",
        row.names = c(NA, -14L)),
      ses = structure(
        list(
          ID = c("Q01", "Q02", "Q03", "Q04", "Q05", "Q06", "Q07", "Q08", "Q09", "Q10", "Q11", "Q12", "Q13", "Q14"),
          ARF = c(0.534612347127066, 0.534612347127066, 0.534612347127066, 0.534612347127066, 0.534612347127066, 0.534612347127066, 0.261695664585036, 0.258108446547535, 0.161687927058931, 0.152676701216919, 0.178278422710643, 0.180970056823718, 0.534612347127066, 0.534612347127066),
          ACF = c(0.48035474913548, 0.493032035153706, 0.396846049457933, 0.382525157760552, 0.440659308992592, 0.466506347503197, 0.613967026527487, 0.613967026527487, 0.613967026527487, 0.613967026527487, 0.613967026527487, 0.613967026527487, 0.470183033974949, 0.494362038935249)),
        class = "data.frame",
        row.names = c(NA, -14L))),
    tolerance = 0.001
  )
})

test_that("error checking", {
  expect_error(
    scoreMVAQ(diag(15)),
    "data.frame")
  expect_error(
    scoreMVAQ(as.data.frame(diag(3))),
    "15 columns")
  expect_error(
    scoreMVAQ(read.table(text = "e,notinteger,0,0,0,0,0,0,0,0,0,0,0,0,0", sep = ",")),
    "numeric")
  expect_error(
    scoreMVAQ(read.table(text = "e,0.5,0,0,0,0,0,0,0,0,0,0,0,0,0", sep = ",")),
    "integer")
  expect_error(
    scoreMVAQ(read.table(text = "e,-1,0,0,0,0,0,0,0,0,0,0,0,0,0", sep = ",")),
    "negative")
})
