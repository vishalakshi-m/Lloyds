import Foundation
class WeatherManager: ObservableObject {
    @Published var currentWeatherData: Weather?
    
    private let weatherService: WeatherDataProtocol
    
    init(weatherService: WeatherDataService) {
        self.weatherService = weatherService
    }
    
    func loadWeatherForecast(currentCity: String) {
        self.weatherService.fetchWeatherFor(currentLocation: currentCity) { result in
            switch result {
            case .success(let weatherData):
                if let data = weatherData.weather {
                    self.currentWeatherData = data
                }
            case .failure(let error):
                debugPrint("Loading weather Forecast failed: \(error.localizedDescription)")
            }
        }
    }
}
