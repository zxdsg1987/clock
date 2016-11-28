//
//  ViewController.m
//  时钟
//
//  Created by skywalker on 16/11/28.
//  Copyright © 2016年 斯芬克斯. All rights reserved.
//

#import "ViewController.h"
#define perSecond 6 // 1秒6度(秒针)
#define perMintue 6 // 1分钟6度(分针)
#define perHour 30 // 1小时30度（时针）
#define perMineHour 0.5 // 每分钟时针转(30 / 60 °)
#define kClockW _clockView.bounds.size.width
#define angle2radion(angle) ((angle) / 180.0 * M_PI)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;
@property(nonatomic,weak)CALayer * secondL;
@property(nonatomic,weak)CALayer * mintueL;
@property(nonatomic,weak)CALayer * hourL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildClock];
    //添加定时器
  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
    
}
-(void)buildClock{
    //秒
    CALayer * secondL=[CALayer layer];
    secondL.backgroundColor=[UIColor redColor].CGColor;
    secondL.anchorPoint=CGPointMake(0.5, 1);
    secondL.position=CGPointMake(kClockW *0.5, kClockW *0.5);
    secondL.bounds=CGRectMake(0, 0, 1, kClockW * 0.5 - 20);
    self.secondL=secondL;
    [self.clockView.layer addSublayer:secondL];
    //分
    CALayer * mintueL=[CALayer layer];
    mintueL.backgroundColor=[UIColor blueColor].CGColor;
    mintueL.anchorPoint=CGPointMake(0.5, 1);
    mintueL.position=CGPointMake(kClockW *0.5, kClockW *0.5);;
    mintueL.bounds=CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
    mintueL.cornerRadius=4;
    [self.clockView.layer addSublayer:mintueL];
    self.mintueL=mintueL;
    //时
    CALayer * hourL=[CALayer layer];
    hourL.backgroundColor=[UIColor blueColor].CGColor;
    hourL.anchorPoint=CGPointMake(0.5, 1);
    hourL.position=CGPointMake(kClockW *0.5, kClockW *0.5);;
    hourL.bounds=CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
    self.hourL=hourL;
    [self.clockView.layer addSublayer:hourL];
}
#pragma mark -获取当前时间
-(void)timeChange{
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSDateComponents * cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour  fromDate:[NSDate date]];
    
    CGFloat second = cmp.second;
    
    CGFloat secondA = (second * perSecond) ;
    
    NSInteger minute = cmp.minute;
    
    CGFloat mintuteA = minute * perMintue;
    
    NSInteger hour = cmp.hour;
    
    CGFloat hourA = hour * perHour + minute * perMineHour;
    
    _secondL.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    _mintueL.transform = CATransform3DMakeRotation(angle2radion(mintuteA), 0, 0, 1);
    
    _hourL.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
