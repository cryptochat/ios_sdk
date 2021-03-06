//
//  AuthService.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAPI.h"
@class UserAuthModel;
@class AuthViewModel;

@interface AuthService : NSObject
-(void)authUserWithAuthViewModel:(AuthViewModel*)authViewModel WithCompleteResponse:(void (^)(TransportResponseStatus status, UserAuthModel* model ))completeResponse;

- (void)getPublicKeyFromServerWithComplete:(void (^)(TransportResponseStatus status, NSData *publicKey))completeResponse;
- (void)sendMyPublicKeyToServerWithComplete:(void (^)(TransportResponseStatus status))completeResponse;
-(BOOL)isAuthorized;
@end
