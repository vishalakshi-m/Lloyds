protocol WeatherDataProtocol {
    func fetchWeatherFor(currentLocation: String, completionHandler: @escaping (Result<WeatherForecast, Error>) -> Void)
}

class WeatherDataService: WeatherDataProtocol {
    func fetchWeatherFor(currentLocation: String, completionHandler: @escaping (Result<WeatherForecast, Error>) -> Void) {
        guard let url = APIEndpoints.getCurrent(location: currentLocation).url else { return }
        APIClient.shared.request(url: url,responseType: WeatherForecast.self) { result in
            switch result {
            case .success(let weatherInfo):
                completionHandler(.success(weatherInfo))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
