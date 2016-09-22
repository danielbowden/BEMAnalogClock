//
//  ViewController.m
//  BEMAnalogClockView
//
//  Created by Boris Emorine on 2/23/14.
//  Copyright (c) 2014 Boris Emorine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDate *date;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myClock1.enableShadows = YES;
    self.myClock1.realTime = YES;
    self.myClock1.currentTime = YES;
    self.myClock1.setTimeViaTouch = YES;
    self.myClock1.borderColor = [UIColor whiteColor];
    self.myClock1.borderWidth = 3;
    self.myClock1.faceBackgroundColor = [UIColor whiteColor];
    self.myClock1.faceBackgroundAlpha = 0.0;
    self.myClock1.delegate = self;
    self.myClock1.digitFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:17];
    self.myClock1.digitColor = [UIColor whiteColor];
    self.myClock1.enableDigit = YES;
    
    
    self.myClock2.setTimeViaTouch = NO;
    self.myClock2.enableGraduations = NO;
    self.myClock2.realTime = YES;
    self.myClock2.currentTime = YES;
    self.myClock2.faceBackgroundAlpha = 0;
    self.myClock2.enableShadows = NO;
    self.myClock2.borderColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
    self.myClock2.hourHandColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
    self.myClock2.minuteHandColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
    self.myClock2.borderWidth = 1;
    self.myClock2.hourHandWidth = 1.0;
    self.myClock2.hourHandLength = 10;
    self.myClock2.minuteHandWidth = 1.0;
    self.myClock2.minuteHandLength = 15;
    self.myClock2.minuteHandOffsideLength = 0;
    self.myClock2.hourHandOffsideLength = 0;
    self.myClock2.secondHandAlpha = 0;
    self.myClock2.delegate = self;
    self.myClock2.userInteractionEnabled = NO;
    
    self.sydneyClock.timeZone = [NSTimeZone timeZoneWithName:@"Australia/Sydney"];
    self.sydneyClock.setTimeViaTouch = NO;
    self.sydneyClock.realTime = YES;
    self.sydneyClock.currentTime = YES;
    self.sydneyClock.borderColor = [UIColor whiteColor];
    self.sydneyClock.borderWidth = 1;
    self.sydneyClock.faceBackgroundColor = [UIColor whiteColor];
    self.sydneyClock.faceBackgroundAlpha = 0.0;
    self.sydneyClock.delegate = self;
    self.sydneyClock.hourHandWidth = 1.0;
    self.sydneyClock.hourHandLength = 15;
    self.sydneyClock.minuteHandWidth = 1.0;
    self.sydneyClock.minuteHandLength = 20;
    self.sydneyClock.minuteHandOffsideLength = 0;
    self.sydneyClock.hourHandOffsideLength = 0;
    self.sydneyClock.secondHandLength = 20;
    self.sydneyClock.secondHandOffsideLength = 5;
    self.sydneyClock.digitFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:10];
    self.sydneyClock.digitColor = [UIColor whiteColor];
    self.sydneyClock.digitOffset = 12;
    self.sydneyClock.enableDigit = YES;
    self.sydneyClock.enableGraduations = NO;
    self.sydneyClock.delegate = self;
    self.sydneyClock.userInteractionEnabled = NO;
    
    self.londonClock.timeZone = [NSTimeZone timeZoneWithName:@"Europe/London"];
    self.londonClock.setTimeViaTouch = NO;
    self.londonClock.realTime = YES;
    self.londonClock.currentTime = YES;
    self.londonClock.borderColor = [UIColor whiteColor];
    self.londonClock.borderWidth = 1;
    self.londonClock.faceBackgroundColor = [UIColor whiteColor];
    self.londonClock.faceBackgroundAlpha = 0.0;
    self.londonClock.delegate = self;
    self.londonClock.hourHandWidth = 1.0;
    self.londonClock.hourHandLength = 15;
    self.londonClock.minuteHandWidth = 1.0;
    self.londonClock.minuteHandLength = 20;
    self.londonClock.minuteHandOffsideLength = 0;
    self.londonClock.hourHandOffsideLength = 0;
    self.londonClock.secondHandLength = 20;
    self.londonClock.secondHandOffsideLength = 5;
    self.londonClock.digitFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:10];
    self.londonClock.digitColor = [UIColor whiteColor];
    self.londonClock.digitOffset = 12;
    self.londonClock.enableDigit = YES;
    self.londonClock.enableGraduations = NO;
    self.londonClock.delegate = self;
    self.londonClock.userInteractionEnabled = NO;

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [panGesture setMaximumNumberOfTouches:1];
    [self.panView addGestureRecognizer:panGesture];
}

- (CGFloat)analogClock:(BEMAnalogClockView *)clock graduationLengthForIndex:(NSInteger)index {
    if (clock == self.myClock1) {
        if ((index % 5) == 0) { // Every 5 graduation will be longer.
            return 20;
        } else {
            return 5;
        }
    }
    
    else return 0;
}

- (UIColor *)analogClock:(BEMAnalogClockView *)clock graduationColorForIndex:(NSInteger)index {
    if ((index % 15) == 0) {
        return [UIColor blueColor];
    }
    else
    {
        return [UIColor whiteColor];
    }
}

- (void)currentTimeOnClock:(BEMAnalogClockView *)clock date:(NSDate *)date timeZone:(NSTimeZone *)timeZone hours:(NSString *)hours minutes:(NSString *)minutes seconds:(NSString *)seconds {
    if (clock == self.myClock1) {
        int hoursInt = [hours intValue];
        int minutesInt = [minutes intValue];
        int secondsInt = [seconds intValue];
        self.myLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hoursInt, minutesInt, secondsInt];
        
        self.sydneyClock.date = date;
        [self.sydneyClock updateTimeAnimated:YES];
        
        self.londonClock.date = date;
        [self.londonClock updateTimeAnimated:YES];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer locationInView:self.view];
    CGPoint velocity = [recognizer velocityInView:self.view];
    float minutes = translation.x/2.666667;  // 320 width / 2.666667 = 120 minutes [2 hours]
    
    _date = self.myClock2.date;
    NSDate *newDate;
    if (velocity.x > 0) { //panned right, go forward in time
        newDate = [_date dateByAddingTimeInterval:minutes];
    } else { //panned left, go backward in time
        newDate = [_date dateByAddingTimeInterval:-minutes];
    }

    self.myClock1.date = newDate;
    self.myClock2.date = newDate;

    [self.myClock1 updateTimeAnimated:NO];
    [self.myClock2 updateTimeAnimated:NO];
}

- (IBAction)pushRefreshButton:(id)sender {
    self.myClock1.hours = arc4random() % 12;
    self.myClock1.minutes = arc4random() % 60;
    self.myClock1.seconds = arc4random() % 60;
    [self matchHoursClock1ToClock2];
    [self.myClock1 updateTimeAnimated:YES];
    [self.myClock2 updateTimeAnimated:YES];
}

- (IBAction)pushCurrentTimeButton:(id)sender {
    if (self.myClock1.realTimeIsActivated == NO) {
        [self.myClock1 startRealTime];
    } else {
        [self.myClock1 stopRealTime];
    }
}

- (void)matchHoursClock1ToClock2 {
    self.myClock2.hours = self.myClock1.hours;
    self.myClock2.minutes = self.myClock1.minutes;
    self.myClock2.seconds = self.myClock1.seconds;
}


/*
 These two methods are commented out because the time on the clock is set up by directly giving values to the 'hours' and 'minutes' properties (see 'viewDidLoad').
 However, the code remains as an example to set up the time on the clock with these two methods.
 
 - (NSString *)dateFormatterForClock:(BEMAnalogClockView *)clock {
 return @"MM, dd yyyy HH:mm:ss";
 }
 
 - (NSString *)timeForClock:(BEMAnalogClockView *)clock {
 return @"11, 03 1982 22:34:22";
 }

 - (NSDate *)dateForClock:(BEMAnalogClockView *)clock {
     NSDate *now = [NSDate date];
     return now;
 }

 // OR //

 - (NSDate *)dateForClock:(BEMAnalogClockView *)clock {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
    components.hour = 4;
    components.minute = 35;
    components.second = 0;
    return [calendar dateFromComponents:components];
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
