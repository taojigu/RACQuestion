//
//  ViewController.swift
//  RacQuestion
//
//  Created by gus on 16/7/16.
//  Copyright © 2016年 gujitao. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cmdButton:UIButton?;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let command:RACCommand = RACCommand.init { (objc) -> RACSignal! in
            
            return RACSignal.createSignal { (subscriber) -> RACDisposable! in
                print("command signal worked");
                subscriber.sendNext("Next");
                subscriber.sendCompleted();
                return nil;
            }

        }
        
        command.executionSignals.switchToLatest().subscribeNext { (_) in
            print("subscribe next worked")
        }
        
        command.executionSignals.switchToLatest().subscribeCompleted {
            print(" subcribe switchToLatest complete worked")
        }
        
        command.executionSignals.materialize().subscribeCompleted {
            print(" subcribe materialize complete worked")
        }
        

        cmdButton?.rac_command = command;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func commandSignal()->RACSignal
    {
        let signal = RACSignal.createSignal { (subscriber) -> RACDisposable! in
            print("command signal worked");
            subscriber.sendNext("Next");
            
            NSThread.sleepForTimeInterval(2);
            subscriber.sendCompleted();
            return nil;
        }

        
        return signal;
    }


}

