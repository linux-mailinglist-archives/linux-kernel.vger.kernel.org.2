Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53C336D968
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhD1OTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhD1OTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:19:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35540613FA;
        Wed, 28 Apr 2021 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619619505;
        bh=JTcNelOy4HAuItSK2ze/+Or0nI5YTpnu0GNDaGzLqls=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Czi8oX52i7bBsEfkDWA2Y5ymTLuS7tVdJ58hp470mTFwrulxWWS1dBcAJiO6LHIbH
         EEy0sbbOKmMqR2A4FACOtp6AOV+LWrUoUX17bjaGoThRT+hkX0XyGKxxxKNle2FIWU
         rtd+Bf7r2JUU9vGK2z6UdWFy7nbcEirX0biCpRxzeCCywP+zFtXWzb+nJEizq6oAcA
         /iuB0KVzWqNT9+tkKLOdNJcEAcgMXHlOyrOQ/Im0QxJVzAlgTwaJjMPfraO0T6uL9T
         9Xx5JS9cN/LJQeGVqP8nMzJ4IaSBK87/9xIv92IOcNg49s0shk3/njm7TJHNmaQY00
         RdIWeZWm2iGLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B0EBA5C0163; Wed, 28 Apr 2021 07:18:24 -0700 (PDT)
Date:   Wed, 28 Apr 2021 07:18:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aubrey Li <aubrey.intel@gmail.com>, Josh Don <joshdon@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <20210428141824.GO975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net>
 <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com>
 <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
 <CAERHkrttLutB1yUHS=i_syQZjqWmttm8PfQeH4WkcCLQvaR64A@mail.gmail.com>
 <YIlBASJRMHlLBivL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIlBASJRMHlLBivL@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 01:03:29PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 28, 2021 at 06:35:36PM +0800, Aubrey Li wrote:
> > On Wed, Apr 28, 2021 at 5:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Ah, indeed so.. rq_lockp() could do with an assertion, not sure how to
> > > sanely do that. Anyway, double_rq_unlock() is simple enough to fix, we
> > > can simply flip the unlock()s.
> > >
> > > ( I'm suffering a cold and am really quite slow atm )
> > >
> > > How's this then?
> > >
> > > ---
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index f732642e3e09..3a534c0c1c46 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
> > >  static void __sched_core_enable(void)
> > >  {
> > >         static_branch_enable(&__sched_core_enabled);
> > > +       /*
> > > +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> > > +        */
> > > +       synchronize_sched();
> > 
> > synchronize_sched() seems no longer exist...
> 
> Bah.. Paul, why did that go away? I realize RCU merged in the sched and
> bh flavours, but I still find it expressive to use sync_sched() vs
> preempt_disable().

I could have made synchronize_sched() a synonym for synchronize_rcu(),
but that would be more likely to mislead than to help.

> Anyway, just use sync_rcu().

And yes, just use synchronize_rcu().

							Thanx, Paul
