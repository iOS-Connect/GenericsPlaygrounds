import UIKit

protocol Configurable {
    associatedtype U
    mutating func configure(with data:U)
}

struct Element : Configurable {
    typealias U = String
    
    var name: String?
    
    internal mutating func configure(with data: String) {
        name = data
    }
}

class ArrayVC<Cell: UITableViewCell> : UITableViewController where Cell:Configurable {
    
    var data = [Element]()
    
    let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Cell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
}

extension UITableViewCell: Configurable {
    typealias U = Element
    
    func configure(with data: Element) {
        textLabel?.text = data.name
    }
}

class MyVC : ArrayVC<UITableViewCell> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [Element(name: "John"), Element(name: "Ben"), Element(name: "Alice")]
        title = "Array View Controller"
    }
}

import PlaygroundSupport

let vc = MyVC()

let nav = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = nav



