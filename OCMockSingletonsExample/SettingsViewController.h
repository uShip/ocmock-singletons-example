//
//  ViewController.h
//  OCMockSingletonsExample
//
//  Created by Matt Hayes on 11/15/13.
//  Copyright (c) 2013 uShip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISwitch *pushNotificationsSwitch;
@property (nonatomic, strong) UIApplication *application;

- (IBAction)pushNotificationsSwitchWasToggled:(id)sender;

@end
