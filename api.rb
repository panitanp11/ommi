class API

  #params is a hash containing other necessary parameters
  def initialize(api_key, format='json', params)
    @api_key = api_key
    @format = format
    other_params params
  end

  def api_key
    @api_key
  end

  def other_params
  end

end
