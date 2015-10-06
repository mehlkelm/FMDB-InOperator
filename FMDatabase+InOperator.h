//
//  FMDatabase+InOperator.h
//  zoziapps.ch
//
//  Created by Stefan Pauwels on 06.10.15.
//

#import "FMDatabase.h"

@interface FMDatabase (InOperator)

/** Execute single update statement.
 
 This method executes a single SQL update statement can handle arrays for MySQL IN-Operators.
 
 The optional values provided to this method should be objects (e.g. `NSString`, `NSNumber`, `NSNull`, `NSDate`, and `NSData` objects as well as `NSArray` for the IN Operator), not fundamental data types (e.g. `int`, `long`, `NSInteger`, etc.). This method automatically handles the aforementioned object types, and all other object types will be interpreted as text values using the object's `description` method.
 This method replaces all `[?]` with the appropriate number of `?` for the array that was passed, throws all array contents together with the other objects into one array, and calls - (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments
 
 @see - (BOOL)executeUpdate:(NSString *)sql, ...;
 @see - (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments;
 
 @param sql The SQL to be performed, with optional `?` and/or `[?]` placeholders.
 @param ... Optional list of parameters to bind to `?` and `[?]` placeholders in the SQL statement. These should be Objective-C objects (e.g. `NSString`, `NSNumber`, etc.) to bind to `?` and `NSArray`to bind to `[?]`, not fundamental C data types (e.g. `int`, `char *`, etc.).
 @return `YES` upon success; `NO` upon failure. If failed, you can call `<lastError>`, `<lastErrorCode>`, or `<lastErrorMessage>` for diagnostic information regarding the failure.
 
 */

- (BOOL)executeUpdateWithInOperator:(NSString *)sql, ...;

@end
