require 'faraday'
require 'pry'

describe "Edmunds API" do
  before do
    @api_key = "utkfw8fb2nvwtpy4n3kck3vt"
    @make = "honda"
    @model = "s2000"
    @year = 2005
  end

  conn = Faraday.new(:url => "https://api.edmunds.com/api/vehicle/v2") do |faraday|
    faraday.response :logger
    faraday.adapter  Faraday.default_adapter
  end

  it 'returns a searched vehicle' do
    response = conn.get "/#{@make}/#{@model}/#{@year}?view=full&fmt=json&api_key=#{@api_key}"
    expect(response.status).to eql 200
    expect(@response).to eql {
      id: 100505007,
      make: {
        id: 200001444,
        name: "Honda",
        niceName: "honda"
      },
      model: {
        id: "Honda_S2000",
        name: "S2000",
        niceName: "s2000"
      },
      year: 2005,
      styles: [{
        id: 100454267,
        name: "2dr Roadster (2.2L 4cyl 6M)",
        submodel: {
          body: "Convertible",
          modelName: "S2000 Convertible",
          niceName: "convertible"
        },
        trim: "Base",
        states: ["USED"]
      }],
      states: ["USED"]
    }
  end
end

