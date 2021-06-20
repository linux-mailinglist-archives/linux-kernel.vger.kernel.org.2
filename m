Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608043AE082
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 23:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFTVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 17:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhFTVDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 17:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5507860230;
        Sun, 20 Jun 2021 21:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624222887;
        bh=90ipx3OLTSsuFrqmvhfWuUGWrMJ8Na3a2DbMPCbhPV0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CJ9hvQ7oIGXYOhYQgdlSE5Cfgkt8dtHQhNgKrKXO2ZJlOZ+nSZfSLEWg4y1A9GaE2
         Dq0ZRvt26dQItZtg26O3DHzTa/EyuYy+IKJBYSHmrBTu0Dx720taQbJ8qUfDqz4jho
         xo/IhH/7a5FT9sb86ji3zhRvRd1jggt0rDvZ8Rp0C6y0hTodeC184pgCr4y8qOnOoK
         v+5zWQ3+UnsJyQLj8sh6NuGVP3WmybnQaTqzus0C+/JbN5LhRrl3beijMiBIudrzAh
         K+UMsrcXkepXrqf6zjfnNK8GgzTyJvnGQMhBvYEfNtGF5L39Ab1hafqW3x8Rpn673e
         nG9zkB7O5GJVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 180C55C013F; Sun, 20 Jun 2021 14:01:27 -0700 (PDT)
Date:   Sun, 20 Jun 2021 14:01:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 09:14:28PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 18, 2021 at 01:48:00PM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 18, 2021 at 01:26:10PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jun 18, 2021 at 10:59:26AM +0200, Marco Elver wrote:
> > > > On Fri, Jun 18, 2021 at 10:24AM +0200, Peter Zijlstra wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > Due to a merge conflict I had to look at some recent RCU code, and I saw
> > > > > you went a little overboard with data_race(). How's something like the
> > > > > below look to you?
> > > > 
> > > > I commented below. The main thing is just using the __no_kcsan function
> > > > attribute if it's only about accesses within the function (and not
> > > > also about called functions elsewhere).
> > > > 
> > > > Using the attribute also improves performance slightly (not that it
> > > > matters much in a KCSAN-enabled kernel) due to no instrumentation.
> > > 
> > > Aah yes ofcourse! Much better still.
> > > 
> > > > > The idea being that we fundamentally don't care about data races for
> > > > > debug/error condition prints, so marking every single variable access is
> > > > > just clutter.
> > > > 
> > > > Having data_race() around the pr_* helpers seems reasonable, if you
> > > > worry about future unnecessary markings that might pop up due to them.
> > > 
> > > Right, so I did them on WARN and higher, figuring that those really only
> > > happen when there's smoething wrong and we're way past caring about
> > > data races. Paul has a few pr_info() users that are heavy on
> > > data_race(), but your __no_kcsan attribute suggestion helps with that.
> > 
> > But there can be cases where some mutex is supposed to be held across
> > updates to one of the fields to be printed, and that mutex is held across
> > the pr_*().  In that case, we -want- KCSAN to yell if there is a data
> > race involving that field.
> 
> I don't buy that argument. pr_err() (or worse) is not supposed to
> happen, ever. If it does, *that* is a far worse condition that any data
> race possibly found by kcsan.
> 
> So the only way the pr_err() expression itself can lead to kcsan
> determining a data-race, if something far worse triggered the pr_err()
> itself.

Earlier, you said pr_warn().  Above, I said pr_*().  Now you say
pr_err().  But OK...

Let's take for example the pr_err() in __call_rcu(), that is, the
double-free diagnostic.  A KCSAN warning on the unmarked load from
head->func could give valuable information on the whereabouts of the
other code interfering with the callback.  Blanket disabling of KCSAN
across all pr_err() calls (let alone all pr_*() calls) would be the
opposite of helpful.

> > So I am not at all a fan of this change.
> > 
> > But a similar technique might help elsewhere.  RCU uses strict
> > KCSAN settings (something about me not wanting minor code-generation
> > performance issues turnign into full-fledged RCU concurrency bugs),
> > but invokes code that uses looser settings.  This means that RCU gets
> > "false-positive" KCSAN complaints on racing calls to (for example)
> > schedule_timeout_interruptible().
> > 
> > My thought is to create a rcu_schedule_timeout_interruptible(), for one
> > example, that suppresses KCSAN warnings under the assumption that they
> > will be caught by KCSAN runs on other parts of the kernel.  Among other
> > things, this would also allow them to be easily adjusted as appropriate.
> > 
> > Thoughts?
> 
> You've lost me on the schedule thing, what?

The definition of schedule_timeout_interruptible() is in part of the
kernel that uses much looser KCSAN checking.  Thus there are some
KCSAN warnings from RCU involving schedule_timeout_interruptible().
But at least some of these warnings are for conflicting writes, which
many parts of the kernel suppress KCSAN warnings for.

So a wrapper for some functions could get to clean KCSAN for RCU
without me having to push not-yet-wanted markings into other parts
of the kernel.

> All I'm saying is that RCU is turning into an unreadable mess of
> data_race(), and marking whole functions or whole statements that should
> only ever happen on actual errors *anyway*, seems to significantly
> reduce the clutter.

Sorry, but no.  Between your eyes and my sanity, my sanity wins.

							Thanx, Paul
