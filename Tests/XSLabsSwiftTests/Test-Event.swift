/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2023, Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the Software), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import XCTest
@testable import XSLabsSwift

final class Test_Event: XCTestCase
{
    func testFire() throws
    {
        var received1:  String?
        var received2:  String?
        let event     = Event< String >()
        let observer1 = event.add { received1 = $0 }
        let observer2 = event.add { received2 = $0 }

        event.fire( "hello, world" )

        XCTAssertNotNil( received1 )
        XCTAssertNotNil( received2 )
        XCTAssertEqual( received1, "hello, world" )
        XCTAssertEqual( received2, "hello, world" )

        received1 = nil
        received2 = nil

        event.fire( "hello, universe" )

        XCTAssertNotNil( received1 )
        XCTAssertNotNil( received2 )
        XCTAssertEqual( received1, "hello, universe" )
        XCTAssertEqual( received2, "hello, universe" )

        _ = observer1
        _ = observer2
    }

    func testRemove() throws
    {
        var received1:  String?
        var received2:  String?
        let event     = Event< String >()
        let observer1 = event.add { received1 = $0 }
        let observer2 = event.add { received2 = $0 }

        event.fire( "hello, world" )

        XCTAssertNotNil( received1 )
        XCTAssertNotNil( received2 )
        XCTAssertEqual( received1, "hello, world" )
        XCTAssertEqual( received2, "hello, world" )

        received1 = nil
        received2 = nil

        event.remove( observer: observer1 )

        event.fire( "hello, universe" )

        XCTAssertNil( received1 )
        XCTAssertNotNil( received2 )
        XCTAssertEqual( received2, "hello, universe" )

        _ = observer1
        _ = observer2
    }

    func testDeinit() throws
    {
        var received: String?
        let event   = Event< String >()
        let test    =
        {
            let observer = event.add { received = $0 }

            event.fire( "hello, world" )

            _ = observer
        }

        test()

        XCTAssertNotNil( received )
        XCTAssertEqual( received, "hello, world" )

        received = nil

        event.fire( "hello, universe" )

        XCTAssertNil( received )
    }
}
