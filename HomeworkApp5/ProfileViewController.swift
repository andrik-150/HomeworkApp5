//
//  ProfileViewController.swift
//  HomeworkApp5
//
//  Created by testing on 12.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController{
    private var networkService = NetworkService()
    private var profileImageView = UIImageView()
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        networkService.getProfileInfo { [weak self] user in self?.updateData(model: user)
            
        }
    }
    func updateData(model: User?) {
        guard let model = model else { return }
        DispatchQueue.global().async {
            if let url = URL(string: model.photo ?? ""), let data = try?
                Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
        DispatchQueue.main.async {
            self.nameLabel.text = (model.firstName ?? "") + " " +
            (model.lastName ?? "")
        }
    }
    private func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        setupConstraints()
    }
    private func setupConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
        
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50)
        ])
    }
}
