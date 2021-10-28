Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4F43D8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1Bt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:49:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48063 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229534AbhJ1Bt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:49:58 -0400
Received: (qmail 1337702 invoked by uid 1000); 27 Oct 2021 21:47:31 -0400
Date:   Wed, 27 Oct 2021 21:47:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: GCC not detecting use of uninitialized variable?
Message-ID: <20211028014731.GA1337521@rowland.harvard.edu>
References: <20211027201249.GA1326060@rowland.harvard.edu>
 <20211027204831.GB12219@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027204831.GB12219@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:48:31PM +0200, Willy Tarreau wrote:
> On Wed, Oct 27, 2021 at 04:12:49PM -0400, Alan Stern wrote:
> > The following code does not generate a warning when compiled with GCC 
> > 11.2.1:
> > 
> > 
> > int foo;
> > 
> > void cc_test(void)
> > {
> > 	int	a, b;
> > 
> > 	a = 0;
> > 	a = READ_ONCE(foo);	// Should be: b = READ_ONCE(foo)
> > 	do {
> > 		a += b;
> > 		b = READ_ONCE(foo);
> > 	} while (a > 0);
> > 	WRITE_ONCE(foo, a);
> > }
> > 
> > 
> > But if the loop is changed to execute only once -- replace the while 
> > test with "while (0)" -- then gcc does warn about the uninitialized use 
> > of b.
> > 
> > Is this a known problem with gcc?  Is it being too conservative about 
> > detecting uses of uninitialized variables?
> 
> I already had similar issues not being detected in loops.  I guess the
> reason is simple: it might not be trivial for the compiler to prove
> that the value was not set on any path leading to the first use,
> because one of these paths is the loop itself after the instruction was
> assigned. I've been so much used to it that I think it has always been
> there and I can live with it.

Well, in this case there's only one path leading to the first use, since 
the path that is the loop itself will never be the first use.  It seems 
like a rather surprising oversight.

Maybe I'll try asking the GCC people about this...

Thanks,

Alan Stern
