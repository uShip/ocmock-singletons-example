//
//  ViewController.m
//  OCMockSingletonsExample
//
//  Created by Matt Hayes on 11/15/13.
//  Copyright (c) 2013 uShip. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@end

@implementation SettingsViewController

- (UIApplication*)application
{
    if (!_application)
    {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (void)viewDidLoad
{
    self.pushNotificationsSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(145, 50, 50, 30)];
    [self.pushNotificationsSwitch addTarget:self action:@selector(pushNotificationsSwitchWasToggled:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pushNotificationsSwitch];
}

- (IBAction)pushNotificationsSwitchWasToggled:(id)sender
{
    UISwitch *toggleSwitch = sender;
    
    if (toggleSwitch.on)
    {
        [self.application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)];
    }
    else
    {
        [self.application unregisterForRemoteNotifications];
    }
}

@end
