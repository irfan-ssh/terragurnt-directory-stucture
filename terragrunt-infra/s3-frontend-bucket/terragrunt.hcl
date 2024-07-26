terraform {
  source = "../../module/s3"
}

include {
  path = find_in_parent_folders()
}


inputs = {
  bucket_name = "bucket-xyz-test-01-frontend212"
}