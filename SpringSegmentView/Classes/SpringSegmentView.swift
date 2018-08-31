import UIKit

protocol SpringSegmentViewDelegate: class {
    func springSegmentViewValueChanged(_ index: Int, title: String?)
}

final class SpringSegmentView: UIStackView {
    
    struct Configurations {
        let titles: [String]
        let activeFont: UIFont
        let passiveFont: UIFont
    }
    
    @IBInspectable var activeFontColor: UIColor!
    @IBInspectable var passiveFontColor: UIColor!
    @IBInspectable var indicatorColor: UIColor!
    @IBInspectable var indicatorHeight: CGFloat = 0
    
    private var passiveFont: UIFont = .systemFont(ofSize: 17)
    private var activeFont: UIFont = .boldSystemFont(ofSize: 19)
    private weak var indicatorView: UIView?
    
    weak var delegate: SpringSegmentViewDelegate?
    
    func cofigure(with configurations: Configurations) {
        passiveFont = configurations.passiveFont
        activeFont = configurations.activeFont
        
        let titles = configurations.titles
        let buttonWidth = bounds.width / CGFloat(titles.count)
        addButtons(withWidth: buttonWidth, titles: titles)
    }
    
    // MARK: Lyfe cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStackView()
        addIndicatorView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resizeIndicetorIfNeeded()
    }
    
    // MARK: Private methods
    private func configureStackView() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 0
    }
    
    private func addIndicatorView() {
        let buttonWidth = bounds.width / CGFloat(arrangedSubviews.count)
        let indicator = UIView(frame: CGRect(x: 0, y: bounds.height - indicatorHeight, width: buttonWidth, height: indicatorHeight))
        addSubview(indicator)
        indicator.backgroundColor = indicatorColor
        indicatorView = indicator
    }
    
    private func resizeIndicetorIfNeeded() {
        if arrangedSubviews.first?.bounds.width != indicatorView?.frame.width,
            let pointX = arrangedSubviews.first(where: { isButtonActive(($0 as? UIButton)) })?.frame.origin.x {
            let expectedButtonWidth = bounds.width / CGFloat(arrangedSubviews.count)
            indicatorView?.frame = CGRect(x: pointX, y: bounds.height - indicatorHeight, width: expectedButtonWidth, height: indicatorHeight)
        }
    }
    
    private func addButtons(withWidth width: CGFloat, titles: [String]) {
        for (index, title) in titles.enumerated() {
            let originX = CGFloat(index) * width
            let rect = CGRect(x: originX, y: 0, width: width, height: bounds.height)
            let button = UIButton(frame: rect)
            button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
            let isDefaultActive = index == 0
            button.setTitle(title, for: .normal)
            decorate(button: button, isActive: isDefaultActive)
            button.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(button)
        }
    }
    
    private func isButtonActive(_ button: UIButton?) -> Bool {
        return button?.titleLabel?.font == activeFont
    }
    
    @objc func buttonDidTap(_ sender: UIButton) {
        guard let index = arrangedSubviews.index(of: sender) else {
            print("SpringSegmentView : buttonDidTap sender is not in subviews")
            return
        }
        
        if isButtonActive(sender) {
            return
        }
        
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: [], animations: { [weak self] in
            self?.arrangedSubviews.forEach({ view in
                if let passiveButton = view as? UIButton {
                    self?.decorate(button: passiveButton, isActive: false)
                }
            })
            self?.indicatorView?.frame.origin.x = sender.frame.origin.x
            self?.decorate(button: sender, isActive: true)
            }, completion: { [weak self] _ in
                self?.isUserInteractionEnabled = true
        })
        
        delegate?.springSegmentViewValueChanged(index, title: sender.title(for: .normal))
    }
    
    private func decorate(button: UIButton, isActive: Bool) {
        button.titleLabel?.font = isActive ? activeFont : passiveFont
        button.setTitleColor(isActive ? activeFontColor : passiveFontColor, for: .normal)
    }
}
