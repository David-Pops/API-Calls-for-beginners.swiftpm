//
//  githubUser.swift
//  API Calls for beginners
//
//  Created by David Popowski on 11/17/23.
//

import SwiftUI

struct githubUserView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct githubUser: Codable{
    let login: String
    let avatarUrl: String
    let bio: String
    
}


struct githubUser_Previews: PreviewProvider {
    static var previews: some View {
        githubUserView()
    }
}
