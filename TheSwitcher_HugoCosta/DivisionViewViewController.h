//
//  DivisionViewViewController.h
//  TheSwitcher_HugoCosta
//
//  Created by Hugo Costa on 19/04/2018.
//  Copyright © 2018 Hugo Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Division+CoreDataProperties.h"

@interface DivisionViewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageLamp;

@property (weak, nonatomic) IBOutlet UILabel *labelDivision;
@property (weak, nonatomic) IBOutlet UILabel *labelState;

@property Division * division;

@end
