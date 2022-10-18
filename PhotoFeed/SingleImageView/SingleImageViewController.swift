import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }

    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
}
