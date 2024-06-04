//
//  ViewController.swift
//  Project1
//
//  Created by Olha Pylypiv on 12.12.2023.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            [weak self] in
//            let fm = FileManager.default
//            let path = Bundle.main.resourcePath!
//            let items = try!fm.contentsOfDirectory(atPath: path)
//            
//            for item in items {
//                if item.hasPrefix("nssl") {
//                    self?.pictures.append(item)
//                }
//            }
//            if var pictures = self?.pictures {
//                pictures = pictures.sorted()
//            }
//        }
//        
//        DispatchQueue.main.async {
//            [weak self] in
//            self?.tableView.reloadData()
//        }
        performSelector(inBackground: #selector(loadPictures), with: nil)
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector (recommendTapped))
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.pictures = pictures
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommendTapped() {
        let vc = UIActivityViewController(activityItems: ["Hey! Try using the \(title ?? "StormViewer") App." ], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func loadPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try!fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures = pictures.sorted()
    }
}

