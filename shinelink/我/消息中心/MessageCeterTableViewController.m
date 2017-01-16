//
//  MessageCeterTableViewController.m
//  shinelink
//
//  Created by sky on 16/6/14.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "MessageCeterTableViewController.h"
#import "messgeSecondViewController.h"
#import "JPUSHService.h"

@interface MessageCeterTableViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableDictionary *messageDic;
@property (nonatomic, strong) UIAlertView *Alert1;
@property (nonatomic, strong)  UIImageView *AlertView ;
@property (nonatomic, strong)  NSString *languageValue ;
@end

@implementation MessageCeterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//   self.titleArray =[NSMutableArray arrayWithObjects:@"第一111",@"第二222",@"第三333",nil];
//       self.timeArray =[NSMutableArray arrayWithObjects:@"第一111",@"第二222",@"第三333",nil];
//       self.contentArray =[NSMutableArray arrayWithObjects:@"123213123213123123",@"sdaasdasdadsasdasdasd",@"sssssssssssssssssssssss",nil];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }

        self.tableView.frame=CGRectMake(0, 0, SCREEN_Width, SCREEN_Height-100*HEIGHT_SIZE);
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_wo_qingkong_message style:UIBarButtonItemStylePlain target:self action:@selector(clearData)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    [self initData];
    
}

-(void)clearBadge{
    int badge=0;
    [JPUSHService setBadge:badge];
    [UIApplication sharedApplication].applicationIconBadgeNumber =badge;
}

-(void)clearData{

      _Alert1 = [[UIAlertView alloc] initWithTitle:root_Alet_user message:root_wo_qingkong_lishi_shuju delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_wo_qingkong_shuju,root_wo_qingkong_tubiao_shuliang, nil];
    
    [_Alert1 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1){
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes setObject:nil forKey:@"MessageTitleArray"];
        [userDefaultes setObject:nil forKey:@"MessageTimeArray"];
        [userDefaultes setObject:nil forKey:@"MessageContentArray"];
        [self.navigationController popViewControllerAnimated:NO];
    }else if (buttonIndex==2){
        [self clearBadge];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}


-(void)initData{

 NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
      //[userDefaultes setObject:_messegeDic forKey:@"MessageDic"];
    
    _messageDic=[NSMutableDictionary dictionaryWithDictionary:[userDefaultes dictionaryForKey:@"MessageDic"]];
    _titleArray =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"MessageTitleArray"]];
   
    
    _timeArray =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"MessageTimeArray"]];

    
    _contentArray =[NSMutableArray arrayWithArray:[userDefaultes arrayForKey:@"MessageContentArray"]];
    
    if (_messageDic.count>2) {
        [_titleArray addObject:_messageDic[@"title"]];
        [_timeArray addObject:_messageDic[@"time"]];
        [_contentArray addObject:_messageDic[@"content"]];
        
        [userDefaultes setObject:_titleArray forKey:@"MessageTitleArray"];
        [userDefaultes setObject:_timeArray forKey:@"MessageTimeArray"];
        [userDefaultes setObject:_contentArray forKey:@"MessageContentArray"];
            [userDefaultes setObject:nil forKey:@"MessageDic"];
    }
    
    [self getPic];
}

-(void)getPic{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
  if ([currentLanguage hasPrefix:@"zh-Hans"] ){
        _languageValue=@"0";
     }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    
    if(_titleArray.count==0){
        
        if (!_AlertView) {
            if ([_languageValue isEqualToString:@"0"]) {
                _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                _AlertView.image=[UIImage imageNamed:@"massage_cn2.png"];
                [self.view addSubview:_AlertView];
            }else{
                _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                _AlertView.image=[UIImage imageNamed:@"massage_en2.png"];
                [self.view addSubview:_AlertView];
            }
        }
        
    }else{
        if (_AlertView) {
            [_AlertView removeFromSuperview];
            _AlertView=nil;
        }
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=_titleArray[indexPath.row];
    cell.detailTextLabel.text=_timeArray[indexPath.row];
    cell.detailTextLabel.textColor=COLOR(113, 113, 113, 1);
    cell.detailTextLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    cell.textLabel.textColor=COLOR(60, 60, 60, 1);
    return cell;
    
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    messgeSecondViewController *go=[[messgeSecondViewController alloc]init];
    go.titleString=_titleArray[indexPath.row];
    go.contentString=_contentArray[indexPath.row];
    
    [self.navigationController pushViewController:go animated:NO];
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
