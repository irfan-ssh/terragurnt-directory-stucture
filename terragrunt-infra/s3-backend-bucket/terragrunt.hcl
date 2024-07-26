terraform {
  source = "git::ssh://git@bitbucket.org/northbay/traveloka.git//modules/s3"
}

include {
  path = find_in_parent_folders()
}


inputs = {
  bucket_name = "bucket-xyz-test-backend001"
}