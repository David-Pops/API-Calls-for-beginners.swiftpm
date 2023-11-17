//
//  UserView.swift
//  API Calls for beginners
//
//  Created by David Popowski on 11/17/23.
//

import SwiftUI

struct UserView: View {
    
    @State private var user: githubUser?
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                
            }placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)
            
            Text(user?.login ?? "login placeholder")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "bio placeholder")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            do{
                user = try await getUser()
            } catch GHError.invalidURL {
                print("invalid URL")
            }catch GHError.invalidData {
                print("invalid Data")
            }catch GHError.invalidResponce {
                print("invalid Responce")
            }catch{
                print("unknown Error")
            }
        }
    }
}

func getUser() async throws -> githubUser{
    
    let endpoint = "https://api.github.com/users/moncheeta"
    
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        throw GHError.invalidResponce
    }
    
    do{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(githubUser.self, from: data)
    } catch {
        throw GHError.invalidData
    }
}

enum GHError :Error{
    case invalidURL
    case invalidResponce
    case invalidData
    
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
