//
//  ViewController.m
//  TheSwitcher_HugoCosta
//
//  Created by Hugo Costa on 19/04/2018.
//  Copyright © 2018 Hugo Costa. All rights reserved.
//

#import "ViewController.h"
#import "Division+CoreDataProperties.h"
#import "DivisionViewViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    // all the core data will be loaded on memory on this array
    NSMutableArray <Division *>*divisions;
    
    // just an helper so i dont need to declare all the time
    AppDelegate *appDelegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // helper initialization
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // geting the data from core data
    [self getData];

    // to remove the extra lines of the empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

// small alert to create one new divisio
-(void)createDivision
{
    // create one new alert
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"New"
                                                                              message: @"Input division name"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
    }];
    
    // add ok button to the alert
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
    
        // updating core data and table
        Division * div = [[Division alloc] initWithContext:self->appDelegate.persistentContainer.viewContext];
        [div setName:namefield.text];
        [self->appDelegate saveContext];
        [self->divisions addObject:div];
        [self->_tableView reloadData];
    }]];
    
    // add cancel button to the alert
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

// geting the data from core data
- (void)getData{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Division"];
    divisions = [[NSMutableArray alloc] initWithArray: [appDelegate.persistentContainer.viewContext executeFetchRequest:request error:nil]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // change it here so i dont need to create one custom cell just because the height is diferent
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [divisions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"devisionCell";
    
    // the normal UITableView already have all i need so i wont need to create one custom tableviewcell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //add a switch
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = switchview;
    }
    
    Division *division = ((Division *)[divisions objectAtIndex:indexPath.row]);
    
    cell.textLabel.text = division.name;
    [((UISwitch *)cell.accessoryView) setOn:division.highlighted];
    // set the tag to identify witch switch was pressed
    [cell.accessoryView setTag:indexPath.row];
    // adding an listener to the detect when the switch is pressed
    [((UISwitch *)cell.accessoryView) addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES for the item to be editable and later deleted
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Division *division = ((Division *)[divisions objectAtIndex:indexPath.row]);
        [divisions removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
        [appDelegate.persistentContainer.viewContext deleteObject:division];
        [self->appDelegate saveContext];
    }

}

/**
 catching the toggle of the switch and saving it on core data
 */
- (void)updateSwitchAtIndexPath:(id)sender {
    UISwitch* switcher = (UISwitch*)sender;

    Division *division = ((Division *)[divisions objectAtIndex:switcher.tag]);
    [division setHighlighted:[switcher isOn]];
    [self->appDelegate saveContext];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"openDivision" sender:self];
}


#pragma mark- segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openDivision"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DivisionViewViewController *destViewController = segue.destinationViewController;
        destViewController.division = [divisions objectAtIndex:indexPath.row];
    }
}

- (IBAction)addDivision:(id)sender {
    [self createDivision];
}
@end
