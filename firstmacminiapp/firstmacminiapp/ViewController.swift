//
//  ViewController.swift
//  firstmacminiapp
//
//  Created by Muhammad Hasan Asim on 1/23/19.
//  Copyright © 2019 Muhammad Hasan Asim. All rights reserved.
//

import UIKit
import ARKit


class ViewController: UIViewController {

  
    @IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
        sceneView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        let configuration = ARFaceTrackingConfiguration()
        
        // 2
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 1
        sceneView.session.pause()
    }
    
    
    
    func dothis() -> SCNNode{
        var ballshape = SCNCone(topRadius: 0.001, bottomRadius: 0.01, height: 0.3)
        var ballnode = SCNNode(geometry: ballshape)
        
        return ballnode
    }
    
}
// 1
extension ViewController: ARSCNViewDelegate {
    // 2
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        
        // 3
        guard let device = sceneView.device else{
            return nil
        }
        
        // 4
        let faceGeometry = ARSCNFaceGeometry(device: device)
        
        // 5
        let node = SCNNode(geometry: faceGeometry)
        
        // 6
        node.geometry?.firstMaterial?.transparency = 0.0  //0/0
        node.geometry?.firstMaterial?.fillMode = .fill   //lines
        node.addChildNode(dothis())
        
        // 7
        return node
    }
    
    
    func renderer(
        _ renderer: SCNSceneRenderer,
        didUpdate node: SCNNode,
        for anchor: ARAnchor) {

        // 2
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
        }

        // 3
        faceGeometry.update(from: faceAnchor.geometry)
    }
}

