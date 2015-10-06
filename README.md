# FMDB-InOperator
A simple extension for FMDB that allows passing NSArrays for MySQL IN Operators 

Pass an array to FMDB using the method

    - (BOOL)executeUpdateWithInOperator:(NSString *)sql, ...

like you would pass other NSObjects, but bind it to `[?]` instead of `?`

    NSArray *feedIds = @["feed/bla.com/rss.xml", "feed/foo.com/rss.xml", "feed/bar.com/rss.xml"]; 
    [database executeUpdateWithInOperator:@"UPDATE feeds SET subscribed = ? WHERE id IN ([?])", @(1), feedIds];

Behind the scenes, this will produce a new NSArray with all arguments and a new Query by replacing any `?` with the correct number of `?`:

    NSArray *arguments = @[@(1), "feed/bla.com/rss.xml", "feed/foo.com/rss.xml", "feed/bar.com/rss.xml"];
    @"UPDATE feeds SET subscribed = ? WHERE id IN (?,?,?)"

and call

    - (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments
