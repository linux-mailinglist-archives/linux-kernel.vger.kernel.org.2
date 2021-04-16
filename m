Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218FF362BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhDPXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhDPXim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:38:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11C28610FA;
        Fri, 16 Apr 2021 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618616296;
        bh=CCGgMNa2OXYeEEJ8LudTGSdogttXdZBp1fNS9VP2awM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7NWsPM3c4/veSyW+Ne4SVsah7ym7mIqX62w7ypY6gRI4ILheY1EB9m8tahg/IqkD
         Qq5upwD90nOa+96Atm9MYRn/fj3aE8PHqaFa4XkttYl+FYdOUBQLydOfuDAhfmJgBi
         Byo/5hk0HYpzz9rjcKHu0lFtThvpf9xvx2aMTkTiqkA4UJaazMPfqY/aPb0O4GjfPH
         CsjGHfOfN9fxaNyEy6eyfPCOh0KNPdVqotzr8UlqML7+iOriJ1N/pOMPUURav03jRU
         vwB7El3kK6XpyNKdVgCA6nqq3M/Kgz9opw2F53hBz0+NuTPFl3fTpnmPGQurfC4RQb
         FwixVgJ83fStw==
Date:   Sat, 17 Apr 2021 01:38:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/2] srcu: Fix broken node geometry after early ssp init
Message-ID: <20210416233814.GB123979@lothringen>
References: <20210414132413.98062-1-frederic@kernel.org>
 <20210414132413.98062-2-frederic@kernel.org>
 <20210414155538.GO4510@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414155538.GO4510@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:55:38AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 14, 2021 at 03:24:12PM +0200, Frederic Weisbecker wrote:
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 75ed367d5b60..24db97cbf76b 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -278,6 +278,7 @@ extern void resched_cpu(int cpu);
> >  extern int rcu_num_lvls;
> >  extern int num_rcu_lvl[];
> >  extern int rcu_num_nodes;
> > +extern bool rcu_geometry_initialized;
> 
> Can this be a static local variable inside rcu_init_geometry()?
> 
> After all, init_srcu_struct() isn't called all that often, and its overhead
> is such that an extra function call and check is going to hurt it.  This
> of course requires removing __init from rcu_init_geometry(), but it is not
> all that large, so why not just remove the __init?
> 
> But if we really are worried about reclaiming rcu_init_geometry()'s
> instructions (maybe we are?), then rcu_init_geometry() can be split
> into a function that just does the check (which is not __init) and the
> remainder of the function, which could remain __init.

Indeed that makes sense, I'll move the variable inside rcu_init_geometry().
Also since rcu_init_geometry() can now be called anytime after the boot, I
already removed the __init. I don't think we can do the split trick because a
non-init function can't call an __init function. That would trigger a section
mismatch.


> > @@ -171,6 +171,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  		ssp->sda = alloc_percpu(struct srcu_data);
> >  	if (!ssp->sda)
> >  		return -ENOMEM;
> > +	if (!rcu_geometry_initialized)
> > +		rcu_init_geometry();
> 
> With the suggested change above, this just becomes an unconditional call
> to rcu_init_geometry().

Right.

> > -static void __init rcu_init_geometry(void)
> > +void rcu_init_geometry(void)
> >  {
> >  	ulong d;
> >  	int i;
> > +	static unsigned long old_nr_cpu_ids;
> >  	int rcu_capacity[RCU_NUM_LVLS];
> 
> And then rcu_geometry_initialized is declared static here.
> 
> Or am I missing something?

Looks good, I'll resend with that.

Thanks!

> 
> > +	if (rcu_geometry_initialized) {
> > +		/*
> > +		 * Arrange for warning if rcu_init_geometry() was called before
> > +		 * setup_nr_cpu_ids(). We may miss cases when
> > +		 * nr_cpus_ids == NR_CPUS but that shouldn't matter too much.
> > +		 */
> > +		WARN_ON_ONCE(old_nr_cpu_ids != nr_cpu_ids);
> > +		return;
> > +	}
> > +
> > +	old_nr_cpu_ids = nr_cpu_ids;
> > +	rcu_geometry_initialized = true;
> > +
> >  	/*
> >  	 * Initialize any unspecified boot parameters.
> >  	 * The default values of jiffies_till_first_fqs and
> > -- 
> > 2.25.1
> > 
