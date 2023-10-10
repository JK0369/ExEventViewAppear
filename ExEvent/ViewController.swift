//
//  ViewController.swift
//  ExEvent
//
//  Created by 김종권 on 2023/10/10.
//

import UIKit

class ViewController: UIViewController {
    private let label = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.text = "보이는중"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let scrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let overView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var labels = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(overView)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
        
        NSLayoutConstraint.activate([
            overView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        (0...100)
            .forEach { int in
                let label = {
                    let l = UILabel()
                    l.text = String(int)
                    if int == 70 {
                        l.text = String(int) + " <"
                    }
                    l.textAlignment = .center
                    l.textColor = .black
                    l.font = .systemFont(ofSize: 24)
                    return l
                }()
                labels.append(label)
                stackView.addArrangedSubview(label)
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.delegate = self
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        label.isHidden = !labels[71].visibleInScreen
        
        let bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: overView.frame.minY + labels[71].frame.height)
        label.isHidden = !labels[71].visibleIn(bounds: bounds)
    }
}

extension UIView {
    func visibleIn(bounds: CGRect) -> Bool {
        guard !isHidden, 0 < alpha else { return false }
        let viewFrame = convert(self.bounds, to: nil)
        return viewFrame.intersects(bounds)
    }
    
    var visibleInScreen: Bool {
        guard !isHidden, window != nil, 0 < alpha else { return false }
        let screenBounds = UIScreen.main.bounds
        let viewFrame = convert(bounds, to: nil)
        return viewFrame.intersects(screenBounds)
    }
}
