Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA63AD3DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhFRUuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233461AbhFRUuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59BBA61260;
        Fri, 18 Jun 2021 20:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624049280;
        bh=KSEIS3WK3d5bADDZSLb+L+9bS+rV3xsSJamYQxvF/Ws=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mOzboDR6T0F6jOXQCe0tWc4NQl18ckB4RGDWP8DvinfCKWBNLc7v/SkTitPxuZPg+
         XYro4AyjRwVmVCLqSe8r1QR4x7352Fxca6lIcbUHi9XtrcnokTj8/6IJ8ErHppojos
         v2Rg8Rhc3JUjWr9ug4K+Ycs9McmcCjs0rsPyf+uWSRHUwJK2ycGpB0QkAdU5OJLKCf
         7ggp0+svjHBRLL05ZtxTq1W5gg2J2nZnc+9BcEX1Fr9Gd+iNBFk5rfJIKLqCyQwZPg
         Qys1OK2NL8Xkna42RaP8Dyg+PS5Zk/iVpRfIgD+pVf25N0DKZon57cWWUeCfZqQ0Dl
         nYosmnALr9Gfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1A22B5C0389; Fri, 18 Jun 2021 13:48:00 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:48:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 01:26:10PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 18, 2021 at 10:59:26AM +0200, Marco Elver wrote:
> > On Fri, Jun 18, 2021 at 10:24AM +0200, Peter Zijlstra wrote:
> > > Hi Paul,
> > > 
> > > Due to a merge conflict I had to look at some recent RCU code, and I saw
> > > you went a little overboard with data_race(). How's something like the
> > > below look to you?
> > 
> > I commented below. The main thing is just using the __no_kcsan function
> > attribute if it's only about accesses within the function (and not
> > also about called functions elsewhere).
> > 
> > Using the attribute also improves performance slightly (not that it
> > matters much in a KCSAN-enabled kernel) due to no instrumentation.
> 
> Aah yes ofcourse! Much better still.
> 
> > > The idea being that we fundamentally don't care about data races for
> > > debug/error condition prints, so marking every single variable access is
> > > just clutter.
> > 
> > Having data_race() around the pr_* helpers seems reasonable, if you
> > worry about future unnecessary markings that might pop up due to them.
> 
> Right, so I did them on WARN and higher, figuring that those really only
> happen when there's smoething wrong and we're way past caring about
> data races. Paul has a few pr_info() users that are heavy on
> data_race(), but your __no_kcsan attribute suggestion helps with that.

But there can be cases where some mutex is supposed to be held across
updates to one of the fields to be printed, and that mutex is held across
the pr_*().  In that case, we -want- KCSAN to yell if there is a data
race involving that field.

So I am not at all a fan of this change.

But a similar technique might help elsewhere.  RCU uses strict
KCSAN settings (something about me not wanting minor code-generation
performance issues turnign into full-fledged RCU concurrency bugs),
but invokes code that uses looser settings.  This means that RCU gets
"false-positive" KCSAN complaints on racing calls to (for example)
schedule_timeout_interruptible().

My thought is to create a rcu_schedule_timeout_interruptible(), for one
example, that suppresses KCSAN warnings under the assumption that they
will be caught by KCSAN runs on other parts of the kernel.  Among other
things, this would also allow them to be easily adjusted as appropriate.

Thoughts?

							Thanx, Paul
