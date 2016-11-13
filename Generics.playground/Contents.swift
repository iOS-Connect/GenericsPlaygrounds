import UIKit

protocol Configurable {
    associatedtype U
    func configure(with data:U)
}

class ArrayVC<Cell: UITableViewCell> : UITableViewController where Cell: Configurable {

    var data:[Cell.U] = []

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

class StringTableViewCell : UITableViewCell {}
extension StringTableViewCell: Configurable {
    func configure(with data: String) {
        textLabel?.text = data
    }
}

class StringVC : ArrayVC<StringTableViewCell> {
    override func viewDidLoad() {
        super.viewDidLoad()
        data = ["John","Ben","Alice", "Jay"]
        title = "Array View Controller"
    }
}

class NumberTableViewCell: UITableViewCell { }
extension NumberTableViewCell: Configurable {
    func configure(with data: Int) {
        textLabel?.text = String(data)
    }
}

class NumberVC : ArrayVC<NumberTableViewCell> {

    override func viewDidLoad() {
        super.viewDidLoad()
        data = [1,2,3]
        title = "Numbers View Controller"
    }
}

import PlaygroundSupport

let stringVC = StringVC()
let nav = UINavigationController(rootViewController: stringVC)

let numberVC = NumberVC()

PlaygroundPage.current.liveView = nav



