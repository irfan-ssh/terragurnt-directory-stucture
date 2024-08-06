terraform {
  source = find_in_parent_folders("module/s3")
}

# include {
#   path = find_in_parent_folders()
# }


inputs = {
  bucket_name = "bucket-xyz-test-backend2222222"
}