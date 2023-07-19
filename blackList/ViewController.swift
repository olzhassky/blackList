import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
      
    }

    private func setupNavigationBar() {
        let openBarButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(openButtonTapped))
        navigationItem.leftBarButtonItem = openBarButton

        navigationItem.title = "Home"
    }

 

    @objc func openButtonTapped() {
        let newViewController = NewViewController()
        if let sheet = newViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(newViewController, animated: true, completion: nil)
    }
}




