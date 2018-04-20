//
//  DivisionViewViewController.m
//  TheSwitcher_HugoCosta
//
//  Created by Hugo Costa on 19/04/2018.
//  Copyright © 2018 Hugo Costa. All rights reserved.
//

#import "DivisionViewViewController.h"

@interface DivisionViewViewController ()

@end

@implementation DivisionViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set the title of the navigation bar with the name of the divisio
    [self setTitle:self.division.name];
    
    // change the state of the lamp based on the highlighted properpty
    [self.imageLamp setHighlighted:self.division.highlighted];
    
    // transforming the boolen on a more readable string
    NSString * state = self.division.highlighted ? @"on" : @"off";
    [self.labelDivision setText:[NSString stringWithFormat:@"Your %@ light is", self.division.name]];
    [self.labelState setText:state];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
