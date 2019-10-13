//
//  HolidayRequest.swift
//  HolidaysUsingAPIs
//
//  Created by Kinney Kare on 10/12/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import Foundation


enum HolidayError: Error{
    case noDataAvailable
    case canNotProcessData
}

//This is how we will access the response from the API.

//In here we need to configure all that we would like to access.

struct HolidayRequest {
    
var resourceURL: URL
    
let API_KEY = "94ffa6444ff25d17d5e7b2bd66e279b564ef2fb9"
    
    init(countryCode : String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat  = "2019"
        let currentYear = format.string(from: date)
        
        let destinationURL = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: destinationURL) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }


    func getHolidays (compleation: @escaping(Result<[HolidayDetails], HolidayError>) ->Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in

            guard let jsonData = data else {
                compleation(.failure(.noDataAvailable))
                return
            }

            do{
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                compleation(.success(holidayDetails))
            }catch{
                compleation(.failure(.canNotProcessData))
            }

        }
        dataTask.resume()
    }
}
    

    
    
    
    
    
//    //We need to define what URL we need to access
//    let resourceURL: URL
//
//    //We need our API Key - Note we will define below
//    let API_KEY = "94ffa6444ff25d17d5e7b2bd66e279b564ef2fb9"
//
//    init(countryCode: String) {
//
//        let date = Date()
//        let format = DateFormatter()
//        format.dateFormat = "yyyy"
//        let currentYear = format.string(from: date)
//
//        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
//
//
//        //Now we need URL
//
//        guard let resourceURL = URL(string: resourceString) else {fatalError()}
//
//        self.resourceURL = resourceURL
//
//   }
//
//}
 // this will be our API request
//    //We are creating a data task using a URL session to actually get the info. Once we have the information from the web we are going to have a completion handler(or completion closure).
//
//
//    func getHolidays (completion: @escaping(Result<[HolidayDetails], HolidayError>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
//
//            //if we don't receive JSON data this guard statement will catch it.
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//
//            // if we have JSON data this will be carried out
//            do {
//                let decoder = JSONDecoder()
//                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
//                let holidayDetails = holidaysResponse.response.holidays
//                completion(.success(holidayDetails))
//            }catch{
//                completion(.failure(.canNotProcessData))
//            }
//
//        }
//
//        dataTask.resume()
//
//}
//}
//
