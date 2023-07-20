//
//  settings.swift
//  blackList
//
//  Created by Olzhas Zhakan on 20.07.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    let animatedView = UIView()
    let myLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupAnimatedView()
        startCoolAnimation()
    }
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Настройки"
    }
    private func setupAnimatedView() {
        animatedView.backgroundColor = .white
        view.addSubview(animatedView)
        animatedView.layer.cornerRadius = 14
        animatedView.addSubview(myLabel)
        myLabel.text = "Совсем скоро мы вернемся сюда"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        animatedView.snp.makeConstraints {
                  $0.center.equalToSuperview()
                  $0.width.equalTo(200)
                  $0.height.equalTo(100)
              }

              myLabel.snp.makeConstraints {
                  $0.edges.equalToSuperview()
              }    }
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    private func startCoolAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.animatedView.backgroundColor = .black
            
            self.animatedView.transform = CGAffineTransform(scaleX: 2.6, y: 2.6)
        }, completion: nil)
    }
}
