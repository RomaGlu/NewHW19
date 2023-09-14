import Foundation
import CryptoKit

// Получение данных или ошибки
func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    
    guard let url = urlRequest else {
        print("Invalid URL.")
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(String(describing: error.localizedDescription))")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Response code: \(response.statusCode)")
            
            if let data = data, let dataAsString = String(data: data, encoding: .utf8) {
                print("Cat fact: \(dataAsString)")
            } else {
                print("No data receieved from server.")
            }
        }
    } .resume()
}

// Сборка ссылки
public func getMarvelUrl(_ publicKey: String, _ hash: String) -> String {
    let marvelServerUrl = "https://gateway.marvel.com:443"
    return marvelServerUrl + "/v1/public/characters/1009472?" + "ts=1&apikey=" + publicKey + "&hash=" + MD5(string: md5Hash)
}

// Конвертация в хэщ
func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(string.utf8))

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

let publicKey = "16596237e1bf6fc297f8eab4120eea12"
let privateKey = "91889d2786f498a2518813ba0a8ae0cfe5237767"
let md5Hash = ("1" + privateKey + publicKey)

let urlAdress = "https://meowfacts.herokuapp.com/?count=3"

getData(urlRequest: getMarvelUrl(publicKey, MD5(string: md5Hash)))
