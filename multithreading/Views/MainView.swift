//
//  MainView.swift
//  multithreading
//
//  Created by Damir Rakhmatullin on 21.11.24.
//

import UIKit

class MainView: UIView {
    
    private final var segmentControlLeftText = "Последовательно"
    private final var segmentControlRightText = "Параллельно"
    private final var buttonTitleText = "Начать вычисления"
    private final var buttonCancelTitleText = "Отменить"
    weak var mainViewController: MainViewController?

    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var buttonCancel: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.mainViewController?.stopEval()
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle(buttonCancelTitleText, for: .normal)
        return button
    }()
    
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)

        
        return collectionView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [segmentControlLeftText, segmentControlRightText])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let action = UIAction { [weak self] _ in
            self?.mainViewController?.handleSegmentedControlSelection(selectedIndex: segmentedControl.selectedSegmentIndex)
        }
        
        segmentedControl.addAction(action, for: .valueChanged)
        return segmentedControl
    }()

    
    private lazy var button: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.mainViewController?.startEval()
        }
        let button = UIButton(type: .system, primaryAction: action)
        button.setTitle(buttonTitleText, for: .normal)
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            segmentedControl,
            collectionView,
            button,
            buttonCancel,
            label,
            progressView
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()

        //setupData
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configureDataSource(dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
}
