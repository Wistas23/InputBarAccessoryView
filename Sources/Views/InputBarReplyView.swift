//
//  InputBarReplyView.swift
//  InputBarAccessoryView
//
//  Copyright © 2017-2019 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 8/18/17.
//

import UIKit

class InputBarReplyView: InputStackView, InputItem {

    typealias InputBarReplyViewAction = ((InputBarReplyView) -> Void)

    // MARK: - Properties

    /// A weak reference to the InputBarAccessoryView that the InputBarButtonItem used in
    weak var inputBarAccessoryView: InputBarAccessoryView?

    /// A reference to the stack view position that the InputBarButtonItem is held in
    var parentStackViewPosition: InputStackView.Position?

    enum Spacing {
        case fixed(CGFloat)
        case flexible
        case none
    }

    var spacingBorder: Spacing = .none {
        didSet {
            switch spacingBorder {
            case .flexible:
                setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
            case .fixed:
                setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
            case .none:
                setContentHuggingPriority(UILayoutPriority(rawValue: 500), for: .horizontal)
            }
        }
    }
    
    private var size: CGSize? = CGSize(width: 20, height: 20) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    let author: String?
    let message: String

    var authorLabel = UILabel()
    var messageLabel = UILabel()


    // MARK: - Initialization

    convenience init(author: String?, message: String) {
        self.init(authorT: author, messageT: message)
    }

    private init(authorT: String?, messageT: String) {
        self.author = authorT
        self.message = messageT
        super.init(frame: .zero)
        super.axis = .vertical
        super.spacing = 4
        super.alignment = .leading
        super.distribution = .fill
        if #available(iOS 11.0, *) {
            self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
            self.isLayoutMarginsRelativeArrangement = true
        }
        setupSubviews()
    }

    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        authorLabel.text = author
        authorLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        messageLabel.text = message
        messageLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        messageLabel.numberOfLines = 3
        addArrangedSubview(authorLabel)
        addArrangedSubview(messageLabel)
    }

    open func setSize(_ newValue: CGSize?, animated: Bool) {
        size = newValue
        if animated, let position = parentStackViewPosition {
            inputBarAccessoryView?.performLayout(animated) { [weak self] in
                self?.inputBarAccessoryView?.layoutStackViews([position])
            }
        }
    }

    @discardableResult
    open func configure(_ item: InputBarReplyViewAction) -> Self {
        item(self)
        return self
    }

    func textViewDidChangeAction(with textView: InputTextView) {
        return
    }

    func keyboardSwipeGestureAction(with gesture: UISwipeGestureRecognizer) {
        return
    }

    func keyboardEditingEndsAction() {
        return
    }

    func keyboardEditingBeginsAction() {
        return
    }

}
