//
//  KeyView.swift
//  CalculatorApp03
//
//  Created by Beatriz Enríquez on 30/01/24.
//

import SwiftUI

struct KeyView: View {
    
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    
    let buttons : [[Keys]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    
    ]
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(changeColor ? Color("num").opacity(0.4): Color.pink.opacity(0.2))
                    .scaleEffect(changeColor ? 1.5 : 1.0)
                    .frame(width: 350, height: 280)
                    .animation(Animation.easeInOut.speed(0.17).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                           // self.blur = 20
                        self.changeColor.toggle()
                        })
                    .overlay(Text(value)
                        .bold()
                        .font(.system(size: 100))
                    .foregroundStyle(.black))
            }.padding()
                
            ForEach(buttons, id: \.self ){row in
                HStack(spacing: 10){
                    ForEach(row, id: \.self){elem in
                        Button(action: {
                            self.didTap(button: elem)
                        }, label: {
                            Text(elem.rawValue)
                                .font(.system(size: 30))
                                .frame(width: self.getWidth(elem: elem), height: self.getHeight(elem: elem))
                                .background(elem.buttonColor)
                                .foregroundStyle(.black)
                                .cornerRadius(self.getWidth(elem: elem) / 2)
                                .shadow(color:.purple.opacity(0.8), radius: 5)
                            
                        })
                    }
                }.padding(.bottom, 4)
                
            }
        }
    }
    
    func getWidth(elem: Keys) -> CGFloat {
        if elem == .zero {
            return (UIScreen.main.bounds.width - (5*10))/2
        }
        return (UIScreen.main.bounds.width - (5*10))/4
    }
    
    func getHeight (elem: Keys) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*10))/5
    }
    
    func didTap(button: Keys){
        let valueD = Double(self.value) ?? 0.0
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = valueD
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = valueD
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = valueD
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = valueD
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = valueD
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
           
            if button == .negative {
                self.value = String(valueD * -1)
            }else if button == .percent{
                self.value = String(valueD * 0.01)
            }else if(button == .decimal){
                if(!self.value.contains(button.rawValue)){
                    self.value += button.rawValue
                    }
                }
                
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
            
        }
    }
}

#Preview {
    KeyView()
}
