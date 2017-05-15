//
//  AppDelegate.m
//  Cryptochat
//
//  Created by Сергей Романков on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "AppDelegate.h"
#import "CRMediator.h"
#import "AuthService.h"
#import "ChatService.h"

#import "ExchangeService.h"
#import "ChatMessageModel.h"


@interface AppDelegate ()
@property(strong, nonatomic)AuthService* authService;
@property(strong, nonatomic)ChatService* chatService;

@end

@implementation AppDelegate

-(instancetype)init{
    self = [super init];
    if(self){
        _authService = [AuthService new];
        _chatService = [ChatService new];
    }
    return self;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [CRMediator instance].window = self.window;
    

    if([_authService isAuthorized]){
        [[CRMediator instance]showChatList];
    }else{
        [[CRMediator instance]showAuthorization];
    }
    ExchangeService *service = [ExchangeService new];
    [service keyExchangeWithCompleteStatus:^(TransportResponseStatus status) {
        NSLog(@"Status: %ld", (long)status);
    }];
    
    [_chatService getChatHistoryWithID:@"32" limit:20 offset:0 complete:^(TransportResponseStatus status, NSArray<ChatMessageModel *> *arrHistory) {
    
    }];
 //   [_chatService startConfigChat];


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
