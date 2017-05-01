//
//  ServiceAPI.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ServiceAPI.h"

static NSString* BASE_API_URL = @"http://wishbyte.org/api/v1";

@implementation ServiceAPI

-(void)addRequestContentType:(NSMutableURLRequest*)request{
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}


-(void)getPublicKeyWithCompleteResponse:(APIServiceResponse)completeResponse{
    
    NSString* url = @"http://wishbyte.org/api/v1/key_exchanger/get_public";
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithString:url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.URL = components.URL;
    request.HTTPMethod = @"GET";
    
    [self addRequestContentType:request];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", url);
        completeResponse(dicReponse, status);
    }];
}

- (void)sendMyPublicKeyToServer:(NSString *)myPublicKey identifier:(NSString *)identifier complete:(APIServiceResponse)completeResponse {
    
    NSString* urlString = [NSString stringWithFormat:@"%@/key_exchanger/send_public", BASE_API_URL];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithString:urlString];
    
    NSURLQueryItem *itemIdentifier = [NSURLQueryItem queryItemWithName:@"identifier" value:identifier];
    NSURLQueryItem *itemPublicKey = [NSURLQueryItem queryItemWithName:@"public_key" value:myPublicKey];
    components.queryItems = @[itemIdentifier, itemPublicKey];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.URL = components.URL;
    request.HTTPMethod = @"POST";
    
    [self addRequestContentType:request];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", urlString);
        completeResponse(dicReponse, status);
    }];
    
}

-(void)authUserWithIndetifier:(NSString*)identifier email:(NSString*)email password:(NSString*)password completeResponse:(APIServiceResponse)completeResponse{
    

    NSString* strURL = [NSString stringWithFormat:@"%@/users/auth",BASE_API_URL];
    
    NSURLQueryItem* itemPassword = [[NSURLQueryItem alloc] initWithName:@"password" value:password];
    NSURLQueryItem* itemEmail = [[NSURLQueryItem alloc] initWithName:@"email" value:email];
    NSURLQueryItem* itemIdentifier = [[NSURLQueryItem alloc] initWithName:@"identifier" value:identifier];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:strURL] resolvingAgainstBaseURL:NO];
    components.queryItems = @[itemPassword, itemEmail, itemIdentifier];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    
    request.URL = components.URL;
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[components percentEncodedQuery] dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        
        NSLog(@"%@", strURL);
        completeResponse(dicReponse, status);
    }];
    
    
}



@end
