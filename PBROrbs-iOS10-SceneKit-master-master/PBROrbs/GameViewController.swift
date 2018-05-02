//
//  GameViewController.swift
//  PBROrbs
//
//  Created by Avihay Assouline on 23/07/2016.
//  Copyright © 2016 MediumBlog. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        // select the sphere node - As we know we only loaded one object
        // we select the first item on the children list
        
        
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        
        let sphereNode = SCNNode()
        let sphere = SCNSphere()
        sphere.firstMaterial?.diffuse.contents = UIImage(named: "bamboo-wood-semigloss-albedo.png")
        sphereNode.geometry=sphere
        sphereNode.position = SCNVector3Zero
        scene.rootNode.addChildNode(sphereNode)
        let sphereShape = SCNPhysicsShape(geometry: sphere, options: nil)
        let sphereBody = SCNPhysicsBody(type: .kinematic, shape: sphereShape)
        sphereNode.physicsBody = sphereBody
        scene.physicsWorld.gravity = SCNVector3Make(0, 0, 0)
        let gravityField = SCNPhysicsField.radialGravity()
        gravityField.strength = 9.8
        sphereNode.physicsField = gravityField
        
        
        
        let orbitingSphereNode = SCNNode()
        let orbitingSphere = SCNSphere()
        orbitingSphere.firstMaterial?.diffuse.contents = UIImage(named: "rustediron-streaks-albedo.png")
        orbitingSphereNode.geometry=orbitingSphere
        orbitingSphereNode.position = SCNVector3(x: 3, y: 0, z:0)
        scene.rootNode.addChildNode(orbitingSphereNode)
        let orbitingSphereShape = SCNPhysicsShape(geometry: orbitingSphere, options: nil)
        let orbitingSphereBody = SCNPhysicsBody(type: .dynamic, shape: orbitingSphereShape)
        orbitingSphereNode.physicsBody = orbitingSphereBody
        orbitingSphereNode.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: 2.5), asImpulse: true)
        //let orbitingGravityField = SCNPhysicsField.radialGravity()
        //orbitingGravityField.strength = 9.8
        //orbitingSphereNode.physicsField = orbitingGravityField
        
        //let material = sphereNode.geometry?.firstMaterial
        
        // Declare that you intend to work in PBR shading mode
        // Note that this requires iOS 10 and up
        //material?.lightingModel = SCNMaterial.LightingModel.physicallyBased
        
        // Setup the material maps for your object
        //let materialFilePrefix = materialPrefixes[1];
        //material?.diffuse.contents = UIImage(named: "\(materialFilePrefix)-albedo.png")
        //material?.roughness.contents = UIImage(named: "\(materialFilePrefix)-roughness.png")
        //material?.metalness.contents = UIImage(named: "\(materialFilePrefix)-metal.png")
        //material?.normal.contents = UIImage(named: "\(materialFilePrefix)-normal.png")
        
        // Setup background - This will be the beautiful blurred background
        // that assist the user understand the 3D envirnoment
        let bg = UIImage(named: "sphericalBlurred.png")
        scene.background.contents = bg;
        
        // Setup Image Based Lighting (IBL) map
        let env = UIImage(named: "spherical.jpg")
        scene.lightingEnvironment.contents = env
        scene.lightingEnvironment.intensity = 2.0
        
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        
        /*
         * The following was not a part of my blog post but are pretty easy to understand:
         * To make the Orb cool, we'll add rotation animation to it
         */
        
        sphereNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 10)))
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
