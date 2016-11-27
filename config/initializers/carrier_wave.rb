#ENV['S3_BUCKET'] 
#ENV['S3_ACCESS_KEY']
#ENV['S3_SECRET_KEY']

  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = 'micropost-images-us-standard'
    config.aws_acl    = :public_read
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
    
    config.asset_host = 'http://awesomeapp-env.8pmmyucsp2.us-west-2.elasticbeanstalk.com/'

    config.aws_credentials = {
        access_key_id:     'AKIAIW5JWKEYUYTZZMDA',
        secret_access_key: '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' ,
        region:            'us-east-1' # Required
    }
    
  end