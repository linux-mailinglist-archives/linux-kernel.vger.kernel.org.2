Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8A3F7CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbhHYTWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhHYTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:22:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D535C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mGBByPIo25J6BVO3YosXuxIZ69YugJIByiASwnXnmPE=; b=DvdB0t1kcmOkGCPzhCGt+VNGy0
        qGSYtRdssuZJA+9+GpcyfgKZgVwNoyApuAAOHFSAIYzktMAan6SuqewO6Jve89KPjNKF3xKqniVxI
        tcro9kNGf37NQyJHbUDke0pq20ur7PexL5RRekmVg5aWqNTs8GrZXk1mlGdZQwgvbRuTj7w2tqghs
        MBB+8doYRGitjETn3jafQASN1kE/T9Etcu1pB9eAfK5zp9P9Gw+XUYLhFbNK8xnkyrNMnZLcCX03g
        CnqZcAywUuU7vAueAexw/mmHnY/SqwjYPGTmI3yEgToc3Dot0E9fyChWtj4X+PrIbCoVdsw691rqQ
        JIdC7+Fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIySH-00CbIf-6M; Wed, 25 Aug 2021 19:21:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AA7898136E; Wed, 25 Aug 2021 21:20:56 +0200 (CEST)
Date:   Wed, 25 Aug 2021 21:20:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        "dbueso@suse.de" <dbueso@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH] rbtree:
 stop iteration early in rb_find_first
Message-ID: <20210825192056.GF17784@worktop.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <20210825115859.GB4645@lespinasse.org>
 <YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
 <90ea3457ddc7485fbc8db5f7ca5b07ab@baidu.com>
 <20210825171850.GD17784@worktop.programming.kicks-ass.net>
 <000ff2757fc24d91ade7cab0195ab9b4@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000ff2757fc24d91ade7cab0195ab9b4@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 06:26:59PM +0000, Li,Rongqing wrote:
> 
>                        10
>                      /
>                     5
>                        \
>                       10
> 
> the above case should not exist. like below, when second 10 is inserted, it should be inserted to right leaf
>                        10
>                      /
>                     5
> 
> as a result, it should be
> 
>                        10
>                      /     \
>                     5      10
> 
> since 10 is not less 10, so new 10 is inserted to right.

You're right that rb_add() does a tail-add for elements it considers
equal -- there is actually code in the tree that relies on this.

But that doesn't mean rb_find_first() should go right, it *must*not*,
because then it wouldn't find the 'first' aka 'leftmost' instance of the
equal elements.

Also, you're only considering building the tree in-order with rb_add(),
trees get modified all the time and the pattern Michel gave is perfectly
valid (also see rb_prev()).

Sure the snippet is not a balanced tree, but you can construct the
pattern as part of a larger tree just fine, just add some elements:


	 10(b)
	/  \
       5   10(c)
        \
	10(a)

is a tree that is balanced (remember, RB trees only require the left and
right depths to no more than double -- as opposed to AVL trees, which
have a tighter constraint). This tree has order: 5, 10(a), 10(b), 10(c).
Also note that the tree rotations are stable -- they must be since they
do not refence the order function.

As such, if we rb_find_first() for 10, we must find 10(a), the leftmost
10 in the tree.

