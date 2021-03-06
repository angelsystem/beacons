import UIKit
import CoreLocation

class ItemCell: UITableViewCell {
  @IBOutlet weak var valueTextView: UITextView!
    deinit {
        item?.removeObserver(self, forKeyPath: "lastSeenBeacon")
    }
    
  var item: Item? {
    didSet {
        item?.addObserver(self, forKeyPath: "lastSeenBeacon", options: .New, context: nil)
      textLabel!.text = item?.name
    }
    
    willSet {
        if let thisItem = item {
            thisItem.removeObserver(self, forKeyPath: "lastSeenBeacon")
        }
    }
  }
    
    func nameForProximity(proximity: CLProximity) -> String {
        switch proximity {
        case .Unknown:
            return "Unknown"
        case .Immediate:
            return "Immediate"
        case .Near:
            return "Near"
        case .Far:
            return "Far"
        }
    }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
  }
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if let anItem = object as? Item where anItem == item && keyPath == "lastSeenBeacon" {
            let proximity = nameForProximity(anItem.lastSeenBeacon!.proximity)
            let accuracy = String(format: "%.2f", anItem.lastSeenBeacon!.accuracy)
            detailTextLabel!.text = "Location: \(proximity) (approx. \(accuracy)m)"
        }
    }
  
}
