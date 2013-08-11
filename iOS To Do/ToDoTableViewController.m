//
//  ToDoTableViewController.m
//  iOS To Do
//
//  Created by Y.CORP.YAHOO.COM\jmedrano on 8/4/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\jmedrano. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "ToDoTableViewCell.h"

@interface ToDoTableViewController ()

- (void)onNewItem;
- (void)doneWithNewItem;
- (void)saveData;
- (void)loadData;

@end

@implementation ToDoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"To Do List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *todoCellNib = [UINib nibWithNibName:@"ToDoTableViewCell" bundle:nil];
    [self.tableView registerNib:todoCellNib forCellReuseIdentifier:@"ToDoTableViewCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onNewItem)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self loadData];
    if(todoArray.count == 0){
        todoArray = [[NSMutableArray alloc] init];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [todoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ToDoTableViewCell";
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.editableCell.text = [todoArray objectAtIndex:indexPath.row];
    [cell.editableCell setBorderStyle:UITextBorderStyleNone];
    cell.shouldIndentWhileEditing = YES;
    cell.editableCell.delegate = self;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [todoArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSObject *fromObject = [todoArray objectAtIndex:fromIndexPath.row];
    NSObject *toObject = [todoArray objectAtIndex:toIndexPath.row];
    
    [todoArray setObject:fromObject atIndexedSubscript:toIndexPath.row];
    [todoArray setObject:toObject atIndexedSubscript:fromIndexPath.row];
    [self saveData];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Private methods

- (void)onNewItem {
    
    //Display keyboard
    
    //Once user is done editing add text string as an object to the array
    //static NSString *CellIdentifier = @"ToDoTableViewCell";
    //ToDoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //ToDoTableViewCell *cell = [self.tableView selectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO scrollPosition:[todoArray count]];
    //[self.tableView selectRowAtIndexPath:indexPath.row animated:NO scrollPosition:2];
    
    [todoArray insertObject:@"" atIndex:0];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    ToDoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.editableCell becomeFirstResponder];
    
}

- (void)doneWithNewItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onNewItem)];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    ToDoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.editableCell resignFirstResponder];
    //[todoArray insertObject:cell.editableCell.text atIndex:0];
    [todoArray setObject:cell.editableCell.text atIndexedSubscript:0];
    [self.tableView reloadData];
    [self saveData];

    
}

#pragma mark - Private methods

- (void)saveData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:todoArray forKey:@"todoArray"];
    [defaults synchronize];
}

- (void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    todoArray = [defaults objectForKey:@"todoArray"];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
     
    
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneWithNewItem)];
    self.navigationItem.rightBarButtonItem.title = @"Done";
    
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onNewItem)];
    //self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    
    return YES;
    
}

@end
