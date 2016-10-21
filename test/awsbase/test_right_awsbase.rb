require File.dirname(File.expand_path(__FILE__)) + '/test_helper.rb'
require 'date'

class TestAwsbase < Test::Unit::TestCase

  def setup
    @date = DateTime.strptime('20150830T123600Z', '%Y%m%dT%H%M%SZ')
    @aws_access_key_id = 'AKIDEXAMPLE'
    @aws_secret_access_key = 'wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY'
    @http_verb = 'GET'
    @host = 'example.amazonaws.com'
    @region = 'us-east-1'
    @service_name = 'service'
    @timeout = 60
  end
  
  def test_01_create_describe_key_pairs
  end

  def test_02_create_sign_key_v4
    dd = DateTime.strptime('20150830', '%Y%m%d')
    res = RightAws::AwsUtils.signature_key_v4('wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY', dd,
                                              'us-east-1', 'iam')
    assert_equal(%w(196 175 177 204 87 113 216 113 118 58 57 62 68 183 3 87 27 85 204 40 66 77 26 94 134 218 110 211 193 84 164 185),
                 res.bytes.map(&:to_s))
  end

  def test_03_signature_v4
    service_hash = { 'Param2' => 'value2', 'Param1' => 'value1' }
    uri = '/'

    res = RightAws::AwsUtils.sign_request_v4(@aws_access_key_id, @aws_secret_access_key,
                                             service_hash, @http_verb,
                                             @host, uri, @region, @service_name, @timeout, @date)
    assert_equal('Signature=b97d918cfa904a5beff61c982a1b6f458b799221646efd99d3219ec94cdf2500',
                 res.last['Authorization'].split.last)
  end

  def test_04_signature_v4
    service_hash = {}
    uri = '/'

    res = RightAws::AwsUtils.sign_request_v4(@aws_access_key_id, @aws_secret_access_key,
                                             service_hash, @http_verb,
                                             @host, uri, @region, @service_name, @timeout, @date)
    assert_equal('Signature=5fa00fa31553b73ebf1942676e86291e8372ff2a2260956d9b8aae1d763fbf31',
                 res.last['Authorization'].split.last)
  end
end
