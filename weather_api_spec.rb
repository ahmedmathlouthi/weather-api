
# require File.join(File.dirname(__FILE__), "weather_api.thor")

require "weather_api"

RSpec.describe WeatherApi do 
  subject! { described_class.new }

  describe '#get weather' do 
    it 'returns a puts' do 
      expect(subject).to receive(:api_response).with('Warsaw').and_return(
        {
          "lat": 52.2297,
          "lon": 21.0122,
          "timezone": "Europe/Warsaw",
          "timezone_offset": 3600,
          "data": [
            {
              "dt": 1645888976,
              "sunrise": 1645853361,
              "sunset": 1645891727,
              "temp": 279.13,
              "feels_like": 276.44,
              "pressure": 1029,
              "humidity": 64,
              "dew_point": 272.88,
              "uvi": 0.06,
              "clouds": 0,
              "visibility": 10000,
              "wind_speed": 3.6,
              "wind_deg": 340,
              "weather": [
                {
                  "id": 800,
                  "main": "Clear",
                  "description": "clear sky",
                  "icon": "01d"
                }
              ]
            }
          ]
        }
      )
      expect { subject.get_weather('Warsaw') }.to eq "The weather tommorw in Warsaw will be mainly Clear with clear sky"
    end
  end
end