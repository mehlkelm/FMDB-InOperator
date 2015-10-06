//
//  FMDatabase_InOperator.h
//  zoziapps.ch
//
//  Created by Stefan Pauwels on 06.10.15.
//
//

#import "FMDatabase+InOperator.h"

@implementation FMDatabase (InOperator)


- (BOOL)executeUpdateWithInOperator:(NSString *)sql, ... {
    va_list args;
    va_start(args, sql);
    
    NSMutableArray *newArguments = [NSMutableArray array];
    NSMutableString *newSql = [sql mutableCopy];
    
    NSUInteger currentLocation = 0;
    
    while (currentLocation != NSNotFound) {
        NSRange currentRange = NSMakeRange(currentLocation, sql.length - currentLocation);
        NSRange questRange = [sql rangeOfString:@"?" options:nil range:currentRange];
        NSRange squBrakQuestRange = [sql rangeOfString:@"[?]" options:nil range:currentRange];
        
        if (squBrakQuestRange.location != NSNotFound && squBrakQuestRange.location < questRange.location) {
            NSArray *arg = va_arg(args, NSArray*);
            if (![arg isKindOfClass:[NSArray class]]) {
                NSLog(@"Error: Object bound to `[?]` is not an NSArray in the query (%@) (executeUpdateWithInOperator)", sql);
            }
            currentLocation = squBrakQuestRange.location + squBrakQuestRange.length;
            [newArguments addObjectsFromArray:arg];
            
            NSMutableString *replacement = [NSMutableString stringWithString:@"?"];
            for (int i = 1; i < [arg count]; i++) {
                [replacement appendString:@",?"];
            }
            [newSql replaceCharactersInRange:squBrakQuestRange withString:replacement];
        } else if (questRange.location != NSNotFound) {
            id arg = va_arg(args, id);
            currentLocation = questRange.location + questRange.length;
            [newArguments addObject:arg];
        } else {
            currentLocation = NSNotFound;
        }
    }
    
    va_end(args);
    return [self executeUpdate:newSql withArgumentsInArray:newArguments];
}

@end
