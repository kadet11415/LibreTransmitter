//
//  ModeSelectionView.swift
//  LibreTransmitterUI
//
//  Created by LoopKit Authors on 02/09/2021.
//  Copyright © 2021 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI

struct ModeSelectionView: View {

    @ObservedObject public var cancelNotifier: GenericObservableObject
    @ObservedObject public var saveNotifier: GenericObservableObject
    
    var supportsFakeSensor = Features.supportsFakeSensor

    var modeSelectSection : some View {
        Section(header: Text(LocalizedString("Connection options", comment: "Text describing options for connecting to sensor or transmitter"))) {
            if supportsFakeSensor {
                NavigationLink(destination: Libre2DirectSetup(cancelNotifier: cancelNotifier, saveNotifier: saveNotifier, isMockedSensor: true)) {
                    
                    SettingsItem(title: LocalizedString("Fake Libre 2 Direct", comment: "Fake Libre 2 connection option"))
                        .actionButtonStyle(.primary)
                        .padding([.top, .bottom], 8)
                        
                }
            }
            
            #if canImport(CoreNFC)
            

            
                NavigationLink(destination: Libre2DirectSetup(cancelNotifier: cancelNotifier, saveNotifier: saveNotifier)) {
                    
                    SettingsItem(title: LocalizedString("Libre 2 Direct", comment: "Libre 2 connection option"))
                        .actionButtonStyle(.primary)
                        .padding([.top, .bottom], 8)
                        
                }
            
            #endif
            
                NavigationLink(destination: BluetoothSelection(cancelNotifier: cancelNotifier, saveNotifier: saveNotifier)) {
                    SettingsItem(title: LocalizedString("Bluetooth Transmitters", comment: "Bluetooth Transmitter connection option"))
                        .actionButtonStyle(.primary)
                        .padding([.top, .bottom], 8)
                }

        }
    }

    var cancelButton: some View {
        Button(LocalizedString("Cancel", comment: "Cancel button")) {
            cancelNotifier.notify()

        }// .accentColor(.red)
    }

    var body : some View {
        GuidePage(content: {
            VStack {
                getLeadingImage()
                
                HStack {
                    InstructionList(instructions: [
                        LocalizedString("Сенсор должен быть активирован и полностью прогрет", comment: "Label text for step 1 of connection setup"),
                        LocalizedString("SВыберите тип мониторинга, который Вы хотите.", comment: "Label text for step 2 of connection setup"),
                        LocalizedString("Не все типы сенсоров поддерживаются, читайте подробнее в  readme.md", comment: "Label text for step 3 of connection setup"),
                        LocalizedString("Несколько предостережений: сенсор не будет использовать заводской алгоритм, поэтому некоторые заводские нюансы могут быть не учтены во время использования", comment: "Label text for step 4 of connection setup")
                    ])
                }
  
            }

        }) {
            VStack(spacing: 10) {
                modeSelectSection
            }.padding()
        }
        
        .navigationBarTitle("New Device Setup", displayMode: .large)
        .navigationBarItems(trailing: cancelButton)
        .navigationBarBackButtonHidden(true)
    }
}

struct ModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ModeSelectionView(cancelNotifier: GenericObservableObject(), saveNotifier: GenericObservableObject())
    }
}
