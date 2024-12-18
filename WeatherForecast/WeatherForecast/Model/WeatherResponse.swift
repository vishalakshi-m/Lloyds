// MARK: - WeatherForecast
struct WeatherForecast: Codable {
    let location: LocationInfo?
    let weather: Weather?
    enum CodingKeys: String, CodingKey {
        case location
        case weather = "current"
    }
}

// MARK: - Location
struct LocationInfo: Codable {
    let name, country, region, latitude: String
    let longitude: String
    enum CodingKeys: String, CodingKey {
    case name, country, region
	case latitude = "lat"
	case longitude = "lon"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let temperature: Int?
    let weatherIcons: [String]?
    let weatherDescription: [String]?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temperature
        case weatherIcons = "weather_icons"
        case weatherDescription = "weather_descriptions"
        case humidity
    }
}
