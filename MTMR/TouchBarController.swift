//
//  TouchBar.swift
//  MTMR
//
//  Created by Anton Palgunov on 18/03/2018.
//  Copyright © 2018 Anton Palgunov. All rights reserved.
//

import Cocoa

class TouchBarController: NSObject, NSTouchBarDelegate {

    static let shared = TouchBarController()
    
    let touchBar = NSTouchBar()
    
    private override init() {
        super.init()
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = [
            .escButton,
            .dismissButton,
            
            .brightDown,
            .brightUp,
            
            .flexibleSpace,
            
            .prev,
            .play,
            .next,
            
            .sleep,
            .weather,
            
            .volumeDown,
            .volumeUp,
            .battery,
            .time,
        ]
        self.presentTouchBar()
    }

    func setupControlStripPresence() {
        DFRSystemModalShowsCloseBoxWhenFrontMost(false)
        let item = NSCustomTouchBarItem(identifier: .controlStripItem)
        item.view = NSButton(image: #imageLiteral(resourceName: "Strip"), target: self, action: #selector(presentTouchBar))
        NSTouchBarItem.addSystemTrayItem(item)
        DFRElementSetControlStripPresenceForIdentifier(.controlStripItem, true)
    }
    
    func updateControlStripPresence() {
        DFRElementSetControlStripPresenceForIdentifier(.controlStripItem, true)
    }
    
    @objc private func presentTouchBar() {
        NSTouchBar.presentSystemModalFunctionBar(touchBar, placement: 1, systemTrayItemIdentifier: .controlStripItem)
    }
    
    @objc private func dismissTouchBar() {
        NSTouchBar.minimizeSystemModalFunctionBar(touchBar)
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .escButton:
            return CustomButtonTouchBarItem(identifier: identifier, title: "esc", key: ESCKeyPress())
        case .dismissButton:
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.view = NSButton(title: "exit", target: self, action: #selector(dismissTouchBar))
            return item
            
        case .brightUp:
            return CustomButtonTouchBarItem(identifier: identifier, title: "🔆", key: BrightnessUpPress())
        case .brightDown:
            return CustomButtonTouchBarItem(identifier: identifier, title: "🔅", key: BrightnessDownPress())

        case .volumeDown:
            return CustomButtonTouchBarItem(identifier: identifier, title: "🔉", HIDKeycode: NX_KEYTYPE_SOUND_DOWN)
        case .volumeUp:
            return CustomButtonTouchBarItem(identifier: identifier, title: "🔊", HIDKeycode: NX_KEYTYPE_SOUND_UP)
 
        case .prev:
            return CustomButtonTouchBarItem(identifier: identifier, title: "⏪", HIDKeycode: NX_KEYTYPE_PREVIOUS)
        case .play:
            return CustomButtonTouchBarItem(identifier: identifier, title: "⏯", HIDKeycode: NX_KEYTYPE_PLAY)
        case .next:
            return CustomButtonTouchBarItem(identifier: identifier, title: "⏩", HIDKeycode: NX_KEYTYPE_NEXT)
    
        case .time:
            return TimeTouchBarItem(identifier: identifier, formatTemplate: "HH:mm")
            
        default:
            return nil
        }
    }
    
//    func getBattery() {
//        var error: NSDictionary?
//        if let scriptObject = NSAppleScript(source: <#T##String#>) {
//            if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(
//                &error) {
//                print(output.stringValue)
//            } else if (error != nil) {
//                print("error: \(error)")
//            }
//        }
//    }

}

extension CustomButtonTouchBarItem {
    convenience init(identifier: NSTouchBarItem.Identifier, title: String, HIDKeycode: Int) {
        self.init(identifier: identifier, title: title) { _ in
            HIDPostAuxKey(HIDKeycode)
        }
    }
    convenience init(identifier: NSTouchBarItem.Identifier, title: String, key: KeyPress) {
        self.init(identifier: identifier, title: title) { _ in
            key.send()
        }
    }
}
