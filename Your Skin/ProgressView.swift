//
//  ProgressView.swift
//  Your Skin
//
//  Created by Rebecca Cofie on 30/10/2022.
//

import SwiftUI

struct ProgressView: View {
    
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
    
    
    @State var data = [
        Card(id: 0, img: "1", orientation: "Left", date: "14 Jun 2022", show: false),
        Card(id: 1, img: "2", orientation: "Front", date: "14 Jun 2022", show: false),
        Card(id: 2, img: "3", orientation: "Right", date: "14 Jun 2022", show: false),
        Card(id: 3, img: "4", orientation: "Left", date: "17 Jul 2022", show: false),
        Card(id: 4, img: "5", orientation: "Front", date: "17 Jul 2022", show: false),
        Card(id: 5, img: "6", orientation: "Right", date: "17 Jul 2022", show: false),
        Card(id: 6, img: "7", orientation: "Left", date: "28 Sept 2022", show: false),
        Card(id: 7, img: "8", orientation: "Front", date: "28 Sept 2022", show: false),
        Card(id: 8, img: "9", orientation: "Right", date: "28 Sept 2022", show: false),
    ]
    
    struct Card: Identifiable {
        var id: Int
        var img: String
        var orientation: String
        var date: String
        var show: Bool
    }
    
    struct CardView: View {
        var data: Card
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                Image(data.img)
                    .resizable()
                    Text(data.date)
                        .font(Font.custom("RobotoMono-SemiBold", size: 15))
                        .padding(.leading, 10)
                    Text(data.orientation)
                        .font(Font.custom("RobotoMono-Regular", size: 15))
                        .padding(.leading, 10)
                        .padding(.bottom, 10)

            }
            .frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 500 : 440)
            .background(Color.white)
            .cornerRadius(25) // putting it at the bottom means that not just the image is curved, but the frame as well
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                Text("Your Progress")
                    .font(Font.custom("RobotoMono-Regular", size: 35))
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .padding(.top, 75)
                    .padding(.leading, 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                    HStack(spacing: 15){
                        ForEach(data){i in
                            CardView(data: i)
                            .offset(x: self.x)
                            .highPriorityGesture(DragGesture()
                            
                                .onChanged({ (value) in
                                    
                                    if value.translation.width > 0{
                                        
                                        self.x = value.location.x
                                    }
                                    else{
                                        
                                        self.x = value.location.x - self.screen
                                    }
                                    
                                })
                                .onEnded({ (value) in

                                    if value.translation.width > 0{
                                        
                                        
                                        if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
                                            
                                            
                                            self.count -= 1
                                            self.updateHeight(value: Int(self.count))
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                        else{
                                            
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                    }
                                    else{
                                        
                                        
                                        if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
                                            
                                            self.count += 1
                                            self.updateHeight(value: Int(self.count))
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                        else{
                                            
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                    }
                                })
                            )
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(x: self.op)
                Spacer()
                }
            }
            .background(CustomBlue.blue.opacity(1).ignoresSafeArea())
    }
    .navigationBarTitle("Your Progress")
    .animation(.spring())
    .onAppear {
                self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
                self.data[0].show = true
            }
    }
    
    func updateHeight(value : Int){
        
        for i in 0..<data.count{
            
            data[i].show = false
        }
        
        data[value].show = true
    }
}
  
    struct ProgressView_Previews: PreviewProvider {
        static var previews: some View {
            ProgressView()
        }
    }
    
    // come back to the HomeScreen view afterwards
    

