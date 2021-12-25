//
//  UICollectionViewExtension.swift
//  SwifterKit
//
//  Created by sky on 2021/12/25.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }

    func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func register<T: UICollectionViewCell>(cellWithClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(T.self, forCellWithReuseIdentifier: identifier)
    }

    func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String,
                                               withClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }

    func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError(
                "Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type,
                                                                       for indexPath: IndexPath, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath) as? T else {
            fatalError(
                "Couldn't find UICollectionReusableView for \(String(describing: name)), make sure the view is registered with collection view")
        }
        return cell
    }
}
