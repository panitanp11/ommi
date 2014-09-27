require 'httparty'
require_relative 'api'

class AllelicVariantList < API

  def other_params(params)
    if params[:mim_numbers] && params[:mim_numbers].is_a?(Array)
      @mim_numbers = params[:mim_numbers]
    else
      raise ArgumentError, "a parameter mim numbers (an Array type) is required!"
    end
  end

  def call
    @mim_numbers.inject({}) do |responses, mim_number|
      p "http://api.omim.org/api/entry/allelicVariantList?mimNumber=#{mim_number}&apiKey=#{@api_key}&format=#{@format}"
      response = HTTParty.get("http://api.omim.org/api/entry/allelicVariantList?mimNumber=#{mim_number}&apiKey=#{@api_key}&format=#{@format}")
      responses.merge!({ mim_number.to_s => response.parsed_response }) if response.response.is_a?(Net::HTTPOK)
    end
  end

end
