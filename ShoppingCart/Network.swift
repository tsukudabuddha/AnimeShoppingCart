//
//  Network.swift
//  ShoppingCart
//
//  Created by Andrew Tsukuda on 2/7/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    
    func getTrending(completion: @escaping ([Show]) -> Void) {
        let trendingUrl: URL = URL(string: "https://kitsu.io/api/edge/trending/anime")!
        Alamofire.request(trendingUrl).responseJSON { (response) in
            if let data = response.data {
                let trendingShowsContainer = try? JSONDecoder().decode(ShowContainer.self, from: data)
                
                if let shows = trendingShowsContainer?.data {
                    completion(shows)
                } else {
                    print("Status code: \(response.response?.statusCode)")
                }
            }
        }
            
        
    }
}
