//
//  HeaderUIView.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 10.11.2022.
//

import UIKit

final class HeaderUIView: UITableViewHeaderFooterView,
                          Configurable {
    
    //MARK: Constants
    
    enum Constants {
        
        static var heightSortButton: Double {
            return 50.0
        }
        
        static var widthSortButton: Double {
            return 200.0
        }
    }
    
    // MARK: ViewModel
    
    typealias ViewModel = HeaderUIViewModelProtocol
    
    // MARK: Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSortButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Subviews
    
    private let sortButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringsHeader.sortButtonInitialTitle, for: .normal)
        button.setTitleColor(Colors.placeholderAuth, for: .normal)
        button.tintColor = Colors.placeholderAuth
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Add Subviews
    
    private func addSortButton() {
        addSubview(sortButton)
        
        NSLayoutConstraint.activate([
            sortButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortButton.heightAnchor.constraint(equalToConstant: Constants.heightSortButton),
            sortButton.widthAnchor.constraint(equalToConstant: Constants.widthSortButton),
        ])
    }
    
    // MARK: Configure
    
    func configure(with model: ViewModel) {
        var menuItems = [UIAction]()
        for item in model.actionsModel {
            let title = item.title
            let handler = item.handler
            guard let handler = handler else { return }
            let action = UIAction(title: title, handler: handler)
            menuItems.append(action)
        }
        let menu = UIMenu(title: model.menuModel.title, image: nil, identifier: nil, options: .displayInline, children: menuItems)
        sortButton.menu = menu
    }
    
    func changeState(stateHeader: StateHeader) {
        sortButton.setTitle(StringsHeader.sortButtonSortedTitle, for: .normal)
        switch stateHeader {
        case .sortFromLow:
            sortButton.setImage(Images.sortButtonSortedUp, for: .normal)
            sortButton.setImage(Images.sortButtonSortedUp.withTintColor(.white), for: .highlighted)
        case .sortFromHigh:
            sortButton.setImage(Images.sortButtonSortedDown, for: .normal)
            sortButton.setImage(Images.sortButtonSortedDown.withTintColor(.white), for: .highlighted)
        }
    }
}
