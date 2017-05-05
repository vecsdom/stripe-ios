//
//  STPAPIClientTest.m
//  Stripe
//
//  Created by Jack Flintermann on 12/19/14.
//  Copyright (c) 2014 Stripe, Inc. All rights reserved.
//

@import XCTest;

#import "STPAPIClient+Private.h"

@interface STPAPIClient (Testing)

@property (nonatomic, readwrite) NSURLSession *urlSession;

@end

@interface STPAPIClientTest : XCTestCase
@end

@implementation STPAPIClientTest

- (void)testSharedClient {
    XCTAssertEqualObjects([STPAPIClient sharedClient], [STPAPIClient sharedClient]);
}

- (void)testPublishableKey {
    [Stripe setDefaultPublishableKey:@"test"];
    STPAPIClient *client = [STPAPIClient sharedClient];
    XCTAssertEqualObjects(client.publishableKey, @"test");
}

- (void)testSetPublishableKey {
    STPAPIClient *sut = [[STPAPIClient alloc] initWithPublishableKey:@"pk_foo"];
    NSString *authHeader = sut.urlSession.configuration.HTTPAdditionalHeaders[@"Authorization"];
    XCTAssertEqualObjects(authHeader, @"Bearer pk_foo");
    sut.publishableKey = @"pk_bar";
    authHeader = sut.urlSession.configuration.HTTPAdditionalHeaders[@"Authorization"];
    XCTAssertEqualObjects(authHeader, @"Bearer pk_bar");
}

- (void)testSetAPIKey {
    STPAPIClient *sut = [[STPAPIClient alloc] initWithAPIKey:nil];
    NSString *authHeader = sut.urlSession.configuration.HTTPAdditionalHeaders[@"Authorization"];
    XCTAssertEqualObjects(authHeader, @"Bearer ");
    sut.apiKey = @"rk_bar";
    authHeader = sut.urlSession.configuration.HTTPAdditionalHeaders[@"Authorization"];
    XCTAssertEqualObjects(authHeader, @"Bearer rk_bar");
}

@end