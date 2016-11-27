#
#
#

  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV['S3_BUCKET'] 
    config.aws_acl    = :public_read
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
    
    config.aws_credentials = {
        access_key_id:     ENV['S3_ACCESS_KEY'],
        secret_access_key: ENV['S3_SECRET_KEY'] ,
        region:            'us-east-1' # Required
    }
    
  end