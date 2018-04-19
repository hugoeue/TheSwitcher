//
//  AppDelegate.h
//  TheSwitcher_HugoCosta
//
//  Created by Hugo Costa on 19/04/2018.
//  Copyright © 2018 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

