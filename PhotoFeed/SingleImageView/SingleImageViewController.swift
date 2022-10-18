import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
            rescaleScrollViewForPerfectView(image: image)
        }
    }

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!

    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapShareButton(_ sender: UIButton) {
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        rescaleScrollViewForPerfectView(image: image)
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
    }

    private func rescaleScrollViewForPerfectView(image: UIImage) {
        let containerSize = view.bounds.size
        let imageSize = image.size
        let hScale = containerSize.width / imageSize.width
        let vScale = containerSize.height / imageSize.height
        let scale = max(hScale, vScale)
        let expectedContentSize = CGSize(
            width: imageSize.width * scale,
            height: imageSize.height * scale
        )
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.scrollView.setZoomScale(scale, animated: false)
            let x = (expectedContentSize.width - containerSize.width) / 2
            let y = (expectedContentSize.height - containerSize.height) / 2
            self.scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
        } completion: { _ in }
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
