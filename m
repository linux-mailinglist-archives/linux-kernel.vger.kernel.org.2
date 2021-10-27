Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4D43D32A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbhJ0UvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:51:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45228 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234080AbhJ0UvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:51:09 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19RKmVl6012304;
        Wed, 27 Oct 2021 22:48:31 +0200
Date:   Wed, 27 Oct 2021 22:48:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: GCC not detecting use of uninitialized variable?
Message-ID: <20211027204831.GB12219@1wt.eu>
References: <20211027201249.GA1326060@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027201249.GA1326060@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:12:49PM -0400, Alan Stern wrote:
> The following code does not generate a warning when compiled with GCC 
> 11.2.1:
> 
> 
> int foo;
> 
> void cc_test(void)
> {
> 	int	a, b;
> 
> 	a = 0;
> 	a = READ_ONCE(foo);	// Should be: b = READ_ONCE(foo)
> 	do {
> 		a += b;
> 		b = READ_ONCE(foo);
> 	} while (a > 0);
> 	WRITE_ONCE(foo, a);
> }
> 
> 
> But if the loop is changed to execute only once -- replace the while 
> test with "while (0)" -- then gcc does warn about the uninitialized use 
> of b.
> 
> Is this a known problem with gcc?  Is it being too conservative about 
> detecting uses of uninitialized variables?

I already had similar issues not being detected in loops.  I guess the
reason is simple: it might not be trivial for the compiler to prove
that the value was not set on any path leading to the first use,
because one of these paths is the loop itself after the instruction was
assigned. I've been so much used to it that I think it has always been
there and I can live with it.

Willy
