//
//  OCMockSingletonsExampleTests.m
//  OCMockSingletonsExampleTests
//
//  Created by Matt Hayes on 11/15/13.
//  Copyright (c) 2013 uShip. All rights reserved.
//

#import "SettingsViewController.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <OCMock/OCMock.h>
#import <OCMockito/OCMockito.h>
#import <XCTest/XCTest.h>

@interface SettingsViewControllerTests : XCTestCase

@end

@implementation SettingsViewControllerTests

- (void)testToggleOnRegistersForPushNotifications_On_OCMock_NoDI
{
    //given
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    [[[mockApplication stub] andReturn:mockApplication] sharedApplication];
    [[mockApplication expect] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)];
    
    SettingsViewController *sut = [[SettingsViewController alloc] init];
    [sut view];
    [sut.pushNotificationsSwitch setOn:YES];
    
    //when
    [sut pushNotificationsSwitchWasToggled:sut.pushNotificationsSwitch];
    
    //then
    [mockApplication verify];
    
    [mockApplication stopMocking];
}

- (void)testToggleOnRegistersForPushNotifications_On_OCMock_DI
{
    //given
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    [[mockApplication expect] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)];
    
    SettingsViewController *sut = [[SettingsViewController alloc] init];
    sut.application = mockApplication;
    [sut view];
    [sut.pushNotificationsSwitch setOn:YES];
    
    //when
    [sut pushNotificationsSwitchWasToggled:sut.pushNotificationsSwitch];
    
    //then
    [mockApplication verify];
}

- (void)testToggleOnRegistersForPushNotifications_On_OCMockito_DI
{
    //given
    UIApplication *mockApplication = MKTMock([UIApplication class]);
    
    SettingsViewController *sut = [[SettingsViewController alloc] init];
    sut.application = mockApplication;
    [sut view];
    [sut.pushNotificationsSwitch setOn:YES];
    
    //when
    [sut pushNotificationsSwitchWasToggled:sut.pushNotificationsSwitch];
    
    //then
    [MKTVerify(mockApplication) registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)];
}

- (void)testToggleOnRegistersForPushNotifications_Off_OCMockito_DI
{
    //given
    UIApplication *mockApplication = MKTMock([UIApplication class]);
    
    SettingsViewController *sut = [[SettingsViewController alloc] init];
    sut.application = mockApplication;
    [sut view];
    [sut.pushNotificationsSwitch setOn:NO];
    
    //when
    [sut pushNotificationsSwitchWasToggled:sut.pushNotificationsSwitch];
    
    //then
    [MKTVerify(mockApplication) unregisterForRemoteNotifications];
}

- (void)testToggleOnRegistersForPushNotifications_Off_OCMock_DI
{
    //given
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    [[[mockApplication stub] andReturn:mockApplication] sharedApplication];
    [[mockApplication expect] unregisterForRemoteNotifications];
    
    SettingsViewController *sut = [[SettingsViewController alloc] init];
    sut.application = mockApplication;
    [sut view];
    [sut.pushNotificationsSwitch setOn:NO];
    
    //when
    [sut pushNotificationsSwitchWasToggled:sut.pushNotificationsSwitch];
    
    //then
    
    //then
    [mockApplication verify];
    
    [mockApplication stopMocking];
}

//NOTE: tests run in alphabetical order
//this next test is named starting with a 'Z' on purpose it runs after all other tests
- (void)testZeeMockWasActuallyDestroyed
{
    id app = [UIApplication sharedApplication];
    XCTAssert([app isMemberOfClass:[UIApplication class]],
              @"a mock for UIApplication sharedApplication was not cleaned up!");
}

@end
