Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E943AE434
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFUHa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:30:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=haHDecvcKFwi0SuXjVWII8gjdgtHNbX4lfA4IE6eaXg=; b=SWQaLB5CEoNHQ1uRKPkhcBr1Vo
        jJ6KCILsVpdKsYCzcgbPuaLRvkZfxxbS8OJmDJyuEO/dSbz9ZSGiTmDwWtvDM1M6PEIRj96ClOfpK
        UCZKdbdSBK6rpANvdQtzW1ZZLXKBsnZfq7MRZZkup2C8odTpXfg9oNGuy6TcY/0WRJgLfvj2IcXIb
        ClShmQ7SRO61bmGKn+IP8K5TAsYjjndEpwjuaO/7l1Jaxf7x/x2GoaTfes7KSnI9/rCxo01jcF/li
        B4yw0mNrpZPnXlGsJIrMKk1cT3GBGKJBPdvEDhmFc+3GgRSfTMHAw8FKK4+Rrzms/jRuUt01IuIx/
        pJPeaygQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvELk-00Cq5k-6y; Mon, 21 Jun 2021 07:28:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 208EC3001C0;
        Mon, 21 Jun 2021 09:28:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0749B2C73B726; Mon, 21 Jun 2021 09:28:02 +0200 (CEST)
Date:   Mon, 21 Jun 2021 09:28:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 02:01:27PM -0700, Paul E. McKenney wrote:
> On Sun, Jun 20, 2021 at 09:14:28PM +0200, Peter Zijlstra wrote:

> > I don't buy that argument. pr_err() (or worse) is not supposed to
> > happen, ever. If it does, *that* is a far worse condition that any data
> > race possibly found by kcsan.
> > 
> > So the only way the pr_err() expression itself can lead to kcsan
> > determining a data-race, if something far worse triggered the pr_err()
> > itself.
> 
> Earlier, you said pr_warn().  Above, I said pr_*().  Now you say
> pr_err().  But OK...

Same, thing.. also Sundays aren't great for details it seems :-)

> Let's take for example the pr_err() in __call_rcu(), that is, the
> double-free diagnostic.  A KCSAN warning on the unmarked load from
> head->func could give valuable information on the whereabouts of the
> other code interfering with the callback.  Blanket disabling of KCSAN
> across all pr_err() calls (let alone all pr_*() calls) would be the
> opposite of helpful.

I'm confused. That pr_err() should never happen in a correct program. If
it happens, fix it and any data race as a consequence of that pr_err()
no longer exists either.

I fundementally don't see the relevance of a possible data race from a
statement that should never happen in a correct program to begin with.

Why do you think otherwise?

> > You've lost me on the schedule thing, what?
> 
> The definition of schedule_timeout_interruptible() is in part of the
> kernel that uses much looser KCSAN checking.  Thus there are some
> KCSAN warnings from RCU involving schedule_timeout_interruptible().
> But at least some of these warnings are for conflicting writes, which
> many parts of the kernel suppress KCSAN warnings for.

You've lost me again.. schedule_timeout_interruptible() doesn't do
writes to rcu state, does it? So how can there be problems?
