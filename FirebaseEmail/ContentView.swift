//
//  ContentView.swift
//  FirebaseEmail
//
//  Created by JU HAN LEE on 2020/05/07.
//  Copyright © 2020 yht. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var email = ""
    @State var pass = ""
    @State var shown = false
    @State var msg = ""
    
    var body: some View {
        
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField("pass", text: $pass)
                .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            HStack {
                
                Button(action: {
                    
                    if self.email == "" && self.pass == "" {
                        
                        self.msg = "Fill The Contents"
                        self.shown.toggle()
                        return
                    }
                    
                    Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                        
                        if err != nil {
                            
                            print((err!.localizedDescription)) //애러에대한 현지언어로 서술
                            self.msg = err!.localizedDescription
                            self.shown.toggle()
                            return
                        }
                        
                        self.msg = "Success"
                        self.shown.toggle()
                    }
                    
                }) {
                    
                    Text("Signin")
                }
                Button(action: {
                    
                    if self.email == "" && self.pass == "" {
                        
                        self.msg = "Fill The Contents"
                        self.shown.toggle()
                        return
                    }
                    
                    Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                        
                        if err != nil {
                            
                            print(err!.localizedDescription)
                            self.msg = err!.localizedDescription
                            self.shown.toggle()
                            return
                        }
                        
                        self.msg = "성공적으로 만들어졌습니다"
                        self.shown.toggle()
                    }
                    
                }) {
                    Text("SignUp")
                }
                
            }.alert(isPresented: $shown) {
                
                return Alert(title: Text(self.msg))
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
