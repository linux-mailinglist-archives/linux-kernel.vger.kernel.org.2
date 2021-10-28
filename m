Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E243E503
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhJ1P02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:26:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49417 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230201AbhJ1P01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:26:27 -0400
Received: (qmail 1354402 invoked by uid 1000); 28 Oct 2021 11:24:00 -0400
Date:   Thu, 28 Oct 2021 11:24:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: GCC not detecting use of uninitialized variable?
Message-ID: <20211028152400.GD1351384@rowland.harvard.edu>
References: <20211027201249.GA1326060@rowland.harvard.edu>
 <20211027204831.GB12219@1wt.eu>
 <20211028014731.GA1337521@rowland.harvard.edu>
 <20211028023554.GA14193@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028023554.GA14193@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:35:54AM +0200, Willy Tarreau wrote:
> On Wed, Oct 27, 2021 at 09:47:31PM -0400, Alan Stern wrote:
> > On Wed, Oct 27, 2021 at 10:48:31PM +0200, Willy Tarreau wrote:
> > > On Wed, Oct 27, 2021 at 04:12:49PM -0400, Alan Stern wrote:
> > > > The following code does not generate a warning when compiled with GCC 
> > > > 11.2.1:
> > > > 
> > > > 
> > > > int foo;
> > > > 
> > > > void cc_test(void)
> > > > {
> > > > 	int	a, b;
> > > > 
> > > > 	a = 0;
> > > > 	a = READ_ONCE(foo);	// Should be: b = READ_ONCE(foo)
> > > > 	do {
> > > > 		a += b;
> > > > 		b = READ_ONCE(foo);
> > > > 	} while (a > 0);
> > > > 	WRITE_ONCE(foo, a);
> > > > }
> > > > 
> > > > 
> > > > But if the loop is changed to execute only once -- replace the while 
> > > > test with "while (0)" -- then gcc does warn about the uninitialized use 
> > > > of b.
> > > > 
> > > > Is this a known problem with gcc?  Is it being too conservative about 
> > > > detecting uses of uninitialized variables?
> > > 
> > > I already had similar issues not being detected in loops.  I guess the
> > > reason is simple: it might not be trivial for the compiler to prove
> > > that the value was not set on any path leading to the first use,
> > > because one of these paths is the loop itself after the instruction was
> > > assigned. I've been so much used to it that I think it has always been
> > > there and I can live with it.
> > 
> > Well, in this case there's only one path leading to the first use, since 
> > the path that is the loop itself will never be the first use.  It seems 
> > like a rather surprising oversight.
> 
> For the first iteration yes but not the next ones. And each time I met
> a similar bug not being detected it was exactly in this situation. For
> example the warning about "variable X is set but not used" tends to
> disappear in such loops:
> 
>       extern int blah();
>       int ret()
>       {
>           int a;
>           do { a = 1; } while (blah());
>           return 0;
>       }
> 
> says "variable 'a' is set but not used". Just change "a=1" to "a++" and
> it disappears:
> 
>       extern int blah();
>       int ret()
>       {
>           int a;
>           do { a++; } while (blah());
>           return 0;
>       }
> 
> And the asm code shows that the a++ code is optimized away, explaining
> why there is no "may be used uninitialized" while it appears if you
> return a instead of 0.
> 
> With that said, it could also depend on the gcc version and/or some
> kernel options, as gcc-7, 8 and 9 do emit the warning for me on your
> code when I build it by hand. You may want to double-check this
> aspect before asking GCC people.

Heh -- you're right about that!

I did do a quick double-check.  Converting the test program into 
standard C and compiling it outside the kernel's build environment, I 
get a "may be used uninitialized" warning when gcc is invoked with "-O2 
-Wall" but not when it is invoked with just "-Wall".  On the other hand, 
in the "while (0)" case I get "is used uninitialized" either way.

In kernel builds, gcc is invoked with "-Wno-maybe-uninitialized".  That 
certainly explains the result I see.

But it doesn't explain why gcc fails to realize what happens the first 
time through a "do" loop.  Such first-time iterations always occur (as 
opposed to "while" loops) -- there's no "may" about it!

Alan
