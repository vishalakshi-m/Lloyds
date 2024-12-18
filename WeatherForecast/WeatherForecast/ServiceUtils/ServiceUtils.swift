import Foundation

class APIClient {
    static let shared = APIClient()
    
    private init() {} // Singleton pattern

    func request<T: Decodable>(
        url: URL,
        method: String = "GET",
        headers: [String: String]? = nil,
        body: Data? = nil, responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.cachePolicy = .reloadIgnoringCacheData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }

            do {
                let response = String(data: data, encoding: .utf8)
                print("Response:\n\(response)")
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum APIEndpoints {
    static let baseURL = "https://api.weatherstack.com"
    
    case getCurrent(location: String)    
    var url: URL? {
        switch self {
        case .getCurrent(let location):
            var components = URLComponents(string: "\(APIEndpoints.baseURL)/current")
            components?.queryItems = [URLQueryItem(name: "access_key", value: "be431d1db9b16a6ececf8fa6c9fce837"),URLQueryItem(name: "query", value: location)]
            let url = components?.url?.absoluteString ?? ""
            return URL(string: url)
        }
    }
}

