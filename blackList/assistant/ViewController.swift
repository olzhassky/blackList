import UIKit
import SnapKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    var balls: [UIView] = []
    var animator: UIDynamicAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubview(imageView)
        setupImage()
        makeConstraints()
        setupBalls()
    }

    func setupImage() {
        if let image = UIImage(named: "image2") {
            imageView.image = image
        }
    }

    func setupNavigationBar() {
        let openBarButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(openButtonTapped))
        navigationItem.leftBarButtonItem = openBarButton
        navigationItem.title = "Home"
    }

    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalTo(400)
            $0.height.equalTo(200)
        }
    }

    @objc func openButtonTapped() {
        let newViewController = NewViewController()
        if let sheet = newViewController.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
            sheet.detents = [.medium()]
        }
        present(newViewController, animated: true, completion: nil)
    }

    func setupBalls() {
        let colors: [UIColor] = [.systemGray6, .orange, .white, .gray, .orange, .systemGray6]
        for (index, color) in colors.enumerated() {
            let ball = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            ball.backgroundColor = color
            ball.layer.cornerRadius = ball.frame.width / 2
            view.addSubview(ball)
            balls.append(ball)

            let xPosition = view.bounds.midX + CGFloat(index * 60 - 150)
            ball.center = CGPoint(x: xPosition, y: view.bounds.midY)
        }

        startCoolAnimation()
    }

    func startCoolAnimation() {
        animator = UIDynamicAnimator(referenceView: view)

        let gravityBehavior = UIGravityBehavior(items: balls)
        animator.addBehavior(gravityBehavior)

        let collisionBehavior = UICollisionBehavior(items: balls)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
        
        let dynamicItemBehavior = UIDynamicItemBehavior(items: balls)
        dynamicItemBehavior.elasticity = 1
        animator.addBehavior(dynamicItemBehavior)
    }
}
