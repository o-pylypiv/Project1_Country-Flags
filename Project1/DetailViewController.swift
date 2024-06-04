//
//  DetailViewController.swift
//  Project1
//
//  Created by Olha Pylypiv on 14.12.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \((pictures.firstIndex(of: selectedImage ?? "not found") ?? 0) + 1) of \(pictures.count)"
        navigationItem.largeTitleDisplayMode = .never

        assert(selectedImage != nil, "Selected image has no value.")
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
