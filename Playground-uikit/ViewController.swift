import UIKit

class ViewController: UIViewController {

    // Example: A background view that should cover the entire screen
    let fullScreenBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray // Just to make it visible
        return view
    }()

    // Example: A label that should still respect the safe area
    let myLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true

        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .center
        
        label.minimumContentSizeCategory = .small
        label.maximumContentSizeCategory = .small
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        applyItalicFont()

        // 1. Add the full-screen background view
        view.addSubview(fullScreenBackgroundView)

        // 2. Add the label (which will be placed *on top* of the background view)
        view.addSubview(myLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            // Constraints for the fullScreenBackgroundView to be truly full screen
            fullScreenBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            fullScreenBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullScreenBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fullScreenBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Constraints for myLabel, respecting the safe area (as an example)
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func font() -> UIFont {
        var font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        font = font.with(.traitItalic) // we need to apply the italic before creating scaled font
        return UIFontMetrics.default.scaledFont(for: font)
    }
    
    private func applyItalicFont() {
        var font = font()
        // uncomment this to see the font no longer respects the minimum and maximum content size category
//        font = font.with(.traitItalic)
        myLabel.attributedText = attributedString(with: "Hello World", font: font, color: .white)
    }
}

func attributedString(with text: String, font: UIFont, color: UIColor) -> NSAttributedString {
    return NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: color])
}


extension UIFont {
    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let combinedTraits = UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(combinedTraits) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0) // Use the descriptor size
    }
}
