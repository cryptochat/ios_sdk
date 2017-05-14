//
//  AuthorizationAuthorizationInteractor.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationInteractor.h"
#import "AuthService.h"
#import "UserAuthModel.h"

#import "ChatService.h"

@interface AuthorizationInteractor()
@property(strong, nonatomic)AuthService* authService;
@end

@implementation AuthorizationInteractor

-(instancetype)init{
    self = [super init];
    if(self){
        _authService = [AuthService new];
    }
    return self;
}

-(void)authUserWithModel:(AuthViewModel*)model{
    [_authService authUserWithAuthViewModel:model WithCompleteResponse:^(TransportResponseStatus status, UserAuthModel *model) {
        
        [self.presenter hideProgress];
        if(status == TransportResponseStatusSuccess){
            //TODO:
            ChatService *chat = [ChatService new];
            [chat getChatListWithToken:model.token complete:^(TransportResponseStatus status, NSArray<UserModel *> *userArray, NSArray<ChatListModel *> *chatLustArray) {
                
            }];
        }else{
            [self.presenter showMessage:status];
        }
        
    }];
}
@end
