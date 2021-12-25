//
//  UITableViewExtension.swift
//  SwifterKit
//
//  Created by sky on 2021/12/25.
//

import UIKit

public extension UITableView {
    
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func register<T: UITableViewCell>(cellWithClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(T.self, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }

        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

 
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: name)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError(
                "Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type, identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: name)
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError(
                "Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }
}
