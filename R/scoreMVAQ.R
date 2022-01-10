#' Score the Michigan Vision-related Anxiety Questionnaire
#'
#' @param dat data.frame with N rows and 15 columns.  First column is patient ID and the remaining columns are responses to the 14 items.  Responses should be integers from 0 to 4.
#' @param verbose A number indicating the amount of printing during function execution. 0 (default) is none. Higher numbers may result in more printing.
#'
#' @return A list with two components, each an N by 2 matrix. The first, named thetas, contains the 2 domain scores for each patient.  The second, named ses, contains the standard errors of the thetas.
#' @export
#'
#' @examples
#' justme <- read.table(
#'   text = "Me,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1",
#'   sep = ",")
#' scoreMVAQ(justme)
scoreMVAQ <- function(dat, verbose = 0) {
  # Score MVAQ v 1.1
  # Chris Andrews
  # 2021 11 28

  # INPUT
  # Load Data data.frame/tibble
  #   with 1+14 columns and N rows (1 per participant)
  #   subject IDs stored in first column
  #   14 responses stored in remaining columns

  # OUTPUT
  # list with two components, each an N by 2 matrix
  #   thetas = 2 Domain Scores for each of N participants
  #   ses = 2 Standard Errors for each of N participants

  # load model object
  # attach("./R/MVAQ_deid_objects.RData", pos=2, name = "MRDQscales")
  scalevec <- c("ARF", "ACF")

  # create storage
  theta_se_ARF <- theta_se_ACF <- matrix(NA_real_, nrow = nrow(dat), ncol = 2)

  # score patients one at a time
  for (i in seq(nrow(dat))) {
    if (verbose>0) cat("i = ", i, "\n")

    mat <- data.matrix(dat[i, -1, drop = FALSE])
    rownames(mat) <- dat[i, 1]
    # dimnames(mat)

    mat_ARF <- mat[, 7:12, drop = FALSE]
    mat_ACF <- mat[, c(1:6, 13:14), drop = FALSE]

    # compute disabilities and standard errors
    theta_se_ARF[i, ] <- mirt::fscores(model3_ARF, response.pattern = mat_ARF, append_response.pattern = FALSE)
    theta_se_ACF[i, ] <- mirt::fscores(model3_ACF, response.pattern = mat_ACF, append_response.pattern = FALSE)
  }

  # build report from 2 thetas
  thetas <- data.frame(
    ID =dat[[1]],
    ARF=theta_se_ARF[,1],
    ACF=theta_se_ACF[,1])

  # standard errors
  ses <- data.frame(
    ID =dat[[1]],
    ARF=theta_se_ARF[,2],
    ACF=theta_se_ACF[,2])

  return(list(thetas = thetas, ses = ses))
}
