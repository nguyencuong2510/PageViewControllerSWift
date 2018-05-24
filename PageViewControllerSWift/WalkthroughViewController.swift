
import UIKit

class WalkthroughViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
    
    
    // The custom UIPageControl
    @IBOutlet weak var pageControl: UIPageControl!
    
    // The UIPageViewController
    var pageContainer: UIPageViewController!
    
    // The pages it contains
     fileprivate lazy var pages: [UIViewController] = {
        return [ self.loadData(color: "Green"),
                 self.loadData(color: "Blue"),
                 self.loadData(color: "Red") ]
    }()
    
    // Track the current index
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the page container
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([pages[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        // Add it to the view
        view.addSubview(pageContainer.view)
        
        // Configure our custom pageControl
        view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    func loadData(color: String) -> UIViewController {
        let storyBosrd = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBosrd.instantiateViewController(withIdentifier: "\(color)ViewController")
       return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == 0 {
            return pages.last
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == pages.count-1 {
            return pages.first
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    // MARK: - UIPageViewController delegates
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.index(of: pendingViewControllers.first!)
    }
    
}
