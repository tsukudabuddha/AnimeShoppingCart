//
//  Show.swift
//  ShoppingCart
//
//  Created by Andrew Tsukuda on 2/7/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import Foundation

struct Show {
    let name: String
    let summary: String
    let imageUrl: String
    let rating: String
    let ageRating: String
    let episodeCount: Int
    let episodeLength: Int
}

extension Show: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case attributes // container
    }
    
    enum AttributeKeys: String, CodingKey {
        case synopsis
        case title = "canonicalTitle"
        case rating = "averageRating"
        case ageRating
        case posterImage // container -> original
        case episodeCount
        case episodeLength
    }
    
    enum ImageKeys: String, CodingKey {
        case original
    }
    
    enum RatingKeys: String, CodingKey {
        case average
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let attributesContainer = try container.nestedContainer(keyedBy: AttributeKeys.self, forKey: .attributes)
        name = try attributesContainer.decodeIfPresent(String.self, forKey: .title) ?? "No Title"
        summary = try attributesContainer.decodeIfPresent(String.self, forKey: .synopsis) ?? "Fake Summary"
        
        let imageContainer = try attributesContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .posterImage)
        imageUrl = try imageContainer.decodeIfPresent(String.self, forKey: .original) ?? ""
        rating = try attributesContainer.decodeIfPresent(String.self, forKey: .rating) ?? ""
        ageRating = try attributesContainer.decodeIfPresent(String.self, forKey: .ageRating) ?? ""
        episodeCount = try attributesContainer.decodeIfPresent(Int.self, forKey: .episodeCount) ?? 0
        episodeLength = try attributesContainer.decodeIfPresent(Int.self, forKey: .episodeLength) ?? 0
    }
}

struct ShowContainer: Decodable {
    let data: [Show]
}

