Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCA3BD91F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhGFO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhGFO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFAB561945;
        Tue,  6 Jul 2021 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625580984;
        bh=MBVBLZiSFsmG7jEkCt8y+AXzDkRkBXIHinSQ7oRWt/c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Tje/nQNrEi6Fi4Zx8mZULwyh/1WO1BWI0Ftw9+hmfrC7G/4rYFy+No8F7S2ZOwZUG
         PEq5v0h7U0rajob2lvUbz0u5BMnHXT0sC+LN76Qsx9/Ttk+mWU1LEp2NgoWTw2zVc9
         8YU+fjM6R6IuSXpG8YNHR4fozNAujKinLpBUCt5jdFEALJTAzvEEPnLuc6MVM6v4Up
         bW7zBJlmDA4VjOyZlBuqdFmwvtEHJdIybCIgC6uOhRzcmFSs3upXPTeyt7hN87DD0H
         iLhuwbQ59eOiOPFyE8LLG7WFZ4Bnk5PvvoeEeC7E3hw66Qk1UsyKP14ITDqiJaxmaE
         L9dd3IJJ2Sgeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A03BF5C034D; Tue,  6 Jul 2021 07:16:24 -0700 (PDT)
Date:   Tue, 6 Jul 2021 07:16:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <20210706141624.GA4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
 <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
 <YOQWXVzj5T+AGKWg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOQWXVzj5T+AGKWg@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:37:49AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 21, 2021 at 06:37:57AM -0700, Paul E. McKenney wrote:
> > Because the static inline functions end up in RCU's tranlation units,
> > and they do write to other state.  See for example the line marked with
> > the asterisk at the end of this email, which is apparently between
> > __run_timers() and rcu_torture_reader().  But gdb says that this is
> > really between this statement in __run_timers():
> > 
> > 	base->running_timer = NULL;
> 
> (I'm finding that in expire_timers(), not in __run_timers(), and both
> are in kernel/time/timer.c)
> 
> > And this statement in try_to_del_timer_sync():
> > 
> > 	if (base->running_timer != timer)
> > 
> > Because of inline functions, running KCSAN on RCU can detect races in
> > other subsystems.  In this case, I could argue for a READ_ONCE() on the
> > "if" condition, but last I knew, the rules for timers are that C-language
> > writes do not participate in data races.  So maybe I should add that
> > READ_ONCE(), but running KCSAN on rcutorture would still complain.
> 
> That code is correct as is, AFAICT, so READ_ONCE() is not the right
> annotation.  Also, READ_ONCE() would not actively help the situation in
> any case, and arguably make the code worse and more confusing.
> 
> 
> What happens here is that we read base->running_timer while holding
> base->lock. We set base->running_timer to !0 holding that same
> base->lock from the timer IRQ context. We clear base->running_timer
> *without* base->lock, from the timer IRQ context.
> 
> So yes, there's a race between the locked load of base->running_timer
> and the timer IRQ on another CPU clearing it.
> 
> But since the comparison is an equality test and the only purpose of the
> clear is to destroy that equality, any partial clear serves that
> purpose.
> 
> Now, a partial clear could create a false positive match for another
> timer, which in turn could make try_to_del_timer_sync() fail spuriously
> I suppose, but any caller needs to be able to deal with failure of that
> function, so no harm done there.
> 
> 
> *HOWEVER* timer_curr_running() violates all that.. but that looks like
> it's only ever used as a diagnostic, so that should be fine too.

Maybe a data_race(), then?  Except that in current mainline (as opposed
to v5.13) timer_curr_running() seems to have been inlined.

> Anyway, AFAIU the problem is on the WRITE side, so any READ_ONCE() will
> not ever fix anything here. If we want to get rid of the possible
> spurious fail in try_to_del_timer_sync() we need to consistently
> WRITE/READ_ONCE() all of base->running_timer, if we don't care, we need
> a data_race() annotation somewhere, although I'm not currently seeing
> that inlining you mention that's needed for this problem to manifest in
> the first place.

Coming back to my original question, is my best strategy for RCU
to create data_race()-wrapped variants of the schedule_timeout*()
functions?

							Thanx, Paul
