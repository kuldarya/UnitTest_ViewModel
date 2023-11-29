//
//  UnitTestingView.swift
//  UnitTesting
//
//  Created by Darya Kuliashova on 23/11/2023.
//

import SwiftUI

struct UnitTestingView: View {
    
    @StateObject var viewModel: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

struct UnitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingView(isPremium: true)
    }
}
