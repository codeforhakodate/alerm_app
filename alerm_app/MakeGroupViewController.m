//
//  MakeGroupViewController.m
//  alerm_app
//
//  Created by 諸原聖 on 2015/07/04.
//  Copyright (c) 2015年 fun. All rights reserved.
//

#import "MakeGroupViewController.h"

@interface MakeGroupViewController ()

@end

@implementation MakeGroupViewController
@synthesize flagArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    selectNameArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    for(int j=0;j<flagArray.count;j++){
        NSLog(@"%@",[flagArray objectAtIndex:j]);
    }
    
    NSURL *url = [NSURL URLWithString:@"http://175.184.46.172/server/usersList.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
    
    for(int i = 0;i < [array count];i++){
        NSString *encode_msg = [[array valueForKeyPath:@"name"] objectAtIndex:i];
        NSLog(@"%@", [encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        if([flagArray objectAtIndex:i]==[NSNumber numberWithInteger:1]){
        [selectNameArray addObject:[encode_msg stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }

    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return selectNameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    for(int j=0;j<selectNameArray.count;j++){
        if(indexPath.row == j){
            cell.textLabel.text = [selectNameArray objectAtIndex:j];
        }
    }
    
    
    return cell;
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

- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButtonAction:(id)sender {
    NSLog(@"%@",mytext);
     NSLog(@"%@",selectNameArray);
    
//    NSString *url = @"http://175.184.46.172/server/postUserGroupName.php";
//    NSString *param = [NSString stringWithFormat:@"data1=%@&data2=%@", mytext, selectNameArray];
//    
//    NSMutableURLRequest *request;
//    request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"POST"];
//    [request setURL: [NSURL URLWithString:url]];
//    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//    [request setTimeoutInterval:20];
//    [request setHTTPShouldHandleCookies:FALSE];
//    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}



- (IBAction)inputText:(id)sender {
    mytext = self.myTextField.text;
}
@end
