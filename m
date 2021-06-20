Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748303ADFDC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFTTRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 15:17:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18813C061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBeH+SHoL7C0MKMCX4YqOe2HDqnXuXXtN1RDLIDhmwM=; b=JzRl/uI878oFefdAL+763dWcxZ
        YJPVnO+jbeL37rZj1CaTBs4uKaJ8Cg1cx1l4AyI1CM38CGDLCgvJfVMdGDOVR+JRGxmcjyAhWNJKU
        Q4ao0VQUXeMOSYof8TCDKq1+OJWhaWV06RIUETUPkmyGNBTobZvu9cssH+4dzVHmGIQ8AvgHXg/1W
        SIpKUbI7kEDhjv2hAE7m7uv63uI3tQYick15Z/9ww/eBEO47fJeKToQ/Rp+NV6FG3yxVUuISh3MAj
        a/SQYFSAOHm/PTgAFOysaqdtyjiddaji1ndcm7OVpvIeYsh8At8T9YFSGOiyauMQfYknCirgilY/p
        R4nCeqUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lv2tp-00CPV6-Qi; Sun, 20 Jun 2021 19:14:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88322300204;
        Sun, 20 Jun 2021 21:14:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5181C2D9B1A8B; Sun, 20 Jun 2021 21:14:28 +0200 (CEST)
Date:   Sun, 20 Jun 2021 21:14:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 01:48:00PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 18, 2021 at 01:26:10PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 18, 2021 at 10:59:26AM +0200, Marco Elver wrote:
> > > On Fri, Jun 18, 2021 at 10:24AM +0200, Peter Zijlstra wrote:
> > > > Hi Paul,
> > > > 
> > > > Due to a merge conflict I had to look at some recent RCU code, and I saw
> > > > you went a little overboard with data_race(). How's something like the
> > > > below look to you?
> > > 
> > > I commented below. The main thing is just using the __no_kcsan function
> > > attribute if it's only about accesses within the function (and not
> > > also about called functions elsewhere).
> > > 
> > > Using the attribute also improves performance slightly (not that it
> > > matters much in a KCSAN-enabled kernel) due to no instrumentation.
> > 
> > Aah yes ofcourse! Much better still.
> > 
> > > > The idea being that we fundamentally don't care about data races for
> > > > debug/error condition prints, so marking every single variable access is
> > > > just clutter.
> > > 
> > > Having data_race() around the pr_* helpers seems reasonable, if you
> > > worry about future unnecessary markings that might pop up due to them.
> > 
> > Right, so I did them on WARN and higher, figuring that those really only
> > happen when there's smoething wrong and we're way past caring about
> > data races. Paul has a few pr_info() users that are heavy on
> > data_race(), but your __no_kcsan attribute suggestion helps with that.
> 
> But there can be cases where some mutex is supposed to be held across
> updates to one of the fields to be printed, and that mutex is held across
> the pr_*().  In that case, we -want- KCSAN to yell if there is a data
> race involving that field.

I don't buy that argument. pr_err() (or worse) is not supposed to
happen, ever. If it does, *that* is a far worse condition that any data
race possibly found by kcsan.

So the only way the pr_err() expression itself can lead to kcsan
determining a data-race, if something far worse triggered the pr_err()
itself.

> So I am not at all a fan of this change.
> 
> But a similar technique might help elsewhere.  RCU uses strict
> KCSAN settings (something about me not wanting minor code-generation
> performance issues turnign into full-fledged RCU concurrency bugs),
> but invokes code that uses looser settings.  This means that RCU gets
> "false-positive" KCSAN complaints on racing calls to (for example)
> schedule_timeout_interruptible().
> 
> My thought is to create a rcu_schedule_timeout_interruptible(), for one
> example, that suppresses KCSAN warnings under the assumption that they
> will be caught by KCSAN runs on other parts of the kernel.  Among other
> things, this would also allow them to be easily adjusted as appropriate.
> 
> Thoughts?

You've lost me on the schedule thing, what?

All I'm saying is that RCU is turning into an unreadable mess of
data_race(), and marking whole functions or whole statements that should
only ever happen on actual errors *anyway*, seems to significantly
reduce the clutter.


