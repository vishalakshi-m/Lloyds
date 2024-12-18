import SwiftUI
import Foundation

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherManager(weatherService: WeatherDataService())
    @State var cityName: String = ""

    var body: some View {
            VStack(spacing: 20) {
                TextField("Enter city name", text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    viewModel.loadWeatherForecast(currentCity: cityName)
                }) {
                    Text("Fetch Weather")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Display Weather Info 
                if let weatherInfo = viewModel.currentWeatherData {
                    VStack(spacing: 10) {
                        Text(cityName)
                            .font(.largeTitle)
                            .foregroundColor(.brown)
                        
                        Text("Today's Temperature ")
                            .font(.system(size: 20))
                    
                        Text("\(weatherInfo.temperature ?? 0)˚C")
                            .font(.system(size: 40))
                            .foregroundColor(.blue.opacity(0.8))
                            .bold()
                        
                        Text(weatherInfo.weatherDescription?.first ?? "")
                            .font(.system(size: 20))
                    }
                    .padding()
                }
                Spacer()
            }
            .padding()
    }
}
