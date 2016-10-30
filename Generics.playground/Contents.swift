import UIKit

protocol Configurable {
    associatedtype U
    func configure(with data:U)
}

class ArrayVC<Cell: UITableViewCell> : UITableViewController where Cell:Configurable {
    var data:[Configurable.associatedtype] = []

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
    typealias U = String

    func configure(with data: UITableViewCell.U) {
        textLabel?.text = data
    }
}


class MyVC : ArrayVC<UITableViewCell> {

    override func viewDidLoad() {
        super.viewDidLoad()
        data = ["John", "Ben", "Alice"]
        title = "Array View Controller"
    }

}

import PlaygroundSupport

let vc = MyVC()

let nav = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = nav



