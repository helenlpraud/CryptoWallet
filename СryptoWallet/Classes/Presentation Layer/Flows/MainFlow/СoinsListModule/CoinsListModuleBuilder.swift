//
//  CoinsListModuleBuilder.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import UIKit

final class CoinsListModuleBuilder  {
    
    static func createCoinsListModule() -> CoinsListModule {
        let controller = CoinsListViewController()
        let requests = RequestsFaсtory.createRequests()
        let viewModel = CoinsListViewModel(requests: requests,
                                           networkService: NetworkService())
        let authServise = AuthService()
        authServise.storage = AuthStorage()
        viewModel.authService = authServise
        controller.viewModel = viewModel
        return controller
    }
}

final class RequestsFaсtory {
    
    static func createRequests() -> [CoinRequest] {
        var coinRequests = [CoinRequest]()
        for type in TypeCoin.allCases {
            let request = createRequest(type: type)
            coinRequests.append(request)
        }
        return coinRequests
    }
    
    private static func createRequest(type: TypeCoin) -> CoinRequest {
        return CoinRequest(typeCoin: type)
    }
}
