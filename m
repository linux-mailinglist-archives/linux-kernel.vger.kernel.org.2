Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7F363394
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhDREqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 00:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDREqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 00:46:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC74F60C3F;
        Sun, 18 Apr 2021 04:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618721177;
        bh=ulo1qQ5TILsrOWzbXdmbCyUk4AEhn2HPkCCo3C4Fv2A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=imMnY2Na35M+R/V6vthHxQzGmHdlcm3xBR4chvKgQPavNpd2nTH9eyEQc0fRUBAM+
         NraSnli7csomyl3fLFaP99zZjUrI25V7a3bEX8183vYcHe5pOdP4EBpvFw/PWlzxkE
         LBX6p+YDGlAjNphlPNMq8nM8oL6I24m2otiQJQFSmTbKrUYnHnNAEk34ut2G0gzxRX
         7ZtBHqB6tJWrFhZ7w4TbRR9VyPPwSFmMvp9VtkUNxUe0xZ9tZjG9KIve+BYqib2pee
         ZcLv9yoJKeAOAb+MFc0cyR317GJX5vjSZnWrOKg42NYzKq8G5IHaiDXjP1rvd4YgGn
         bVOS0q15+p9Bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5C115C0253; Sat, 17 Apr 2021 21:46:16 -0700 (PDT)
Date:   Sat, 17 Apr 2021 21:46:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/2] srcu: Fix broken node geometry after early ssp init
Message-ID: <20210418044616.GE5006@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414132413.98062-1-frederic@kernel.org>
 <20210414132413.98062-2-frederic@kernel.org>
 <20210414155538.GO4510@paulmck-ThinkPad-P17-Gen-1>
 <20210417131649.GA146778@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417131649.GA146778@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 03:16:49PM +0200, Frederic Weisbecker wrote:
> On Wed, Apr 14, 2021 at 08:55:38AM -0700, Paul E. McKenney wrote:
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 75ed367d5b60..24db97cbf76b 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -278,6 +278,7 @@ extern void resched_cpu(int cpu);
> > >  extern int rcu_num_lvls;
> > >  extern int num_rcu_lvl[];
> > >  extern int rcu_num_nodes;
> > > +extern bool rcu_geometry_initialized;
> > 
> > Can this be a static local variable inside rcu_init_geometry()?
> > 
> > After all, init_srcu_struct() isn't called all that often, and its overhead
> > is such that an extra function call and check is going to hurt it.  This
> > of course requires removing __init from rcu_init_geometry(), but it is not
> > all that large, so why not just remove the __init?
> > 
> > But if we really are worried about reclaiming rcu_init_geometry()'s
> > instructions (maybe we are?), then rcu_init_geometry() can be split
> > into a function that just does the check (which is not __init) and the
> > remainder of the function, which could remain __init.
> 
> There you go:

Queued, thank you!

							Thanx, Paul

> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Wed, 31 Mar 2021 16:10:36 +0200
> Subject: [PATCH] srcu: Fix broken node geometry after early ssp init
> 
> An ssp initialized before rcu_init_geometry() will have its snp hierarchy
> based on CONFIG_NR_CPUS.
> 
> Once rcu_init_geometry() is called, the nodes distribution is shrinked
> and optimized toward meeting the actual possible number of CPUs detected
> on boot.
> 
> Later on, the ssp that was initialized before rcu_init_geometry() is
> confused and sometimes refers to its initial CONFIG_NR_CPUS based node
> hierarchy, sometimes to the new num_possible_cpus() based one instead.
> For example each of its sdp->mynode remain backward and refer to the
> early node leaves that may not exist anymore. On the other hand the
> srcu_for_each_node_breadth_first() refers to the new node hierarchy.
> 
> There are at least two bad possible outcomes to this:
> 
> 1) a) A callback enqueued early on an sdp is recorded pending on
>       sdp->mynode->srcu_data_have_cbs in srcu_funnel_gp_start() with
>       sdp->mynode pointing to a deep leaf (say 3 levels).
> 
>    b) The grace period ends after rcu_init_geometry() which shrinks the
>       nodes level to a single one. srcu_gp_end() walks through the new
>       snp hierarchy without ever reaching the old leaves so the callback
>       is never executed.
> 
>    This is easily reproduced on an 8 CPUs machine with
>    CONFIG_NR_CPUS >= 32 and "rcupdate.rcu_self_test=1". The
>    srcu_barrier() after early tests verification never completes and
>    the boot hangs:
> 
> 	[ 5413.141029] INFO: task swapper/0:1 blocked for more than 4915 seconds.
> 	[ 5413.147564]       Not tainted 5.12.0-rc4+ #28
> 	[ 5413.151927] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 	[ 5413.159753] task:swapper/0       state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
> 	[ 5413.168099] Call Trace:
> 	[ 5413.170555]  __schedule+0x36c/0x930
> 	[ 5413.174057]  ? wait_for_completion+0x88/0x110
> 	[ 5413.178423]  schedule+0x46/0xf0
> 	[ 5413.181575]  schedule_timeout+0x284/0x380
> 	[ 5413.185591]  ? wait_for_completion+0x88/0x110
> 	[ 5413.189957]  ? mark_held_locks+0x61/0x80
> 	[ 5413.193882]  ? mark_held_locks+0x61/0x80
> 	[ 5413.197809]  ? _raw_spin_unlock_irq+0x24/0x50
> 	[ 5413.202173]  ? wait_for_completion+0x88/0x110
> 	[ 5413.206535]  wait_for_completion+0xb4/0x110
> 	[ 5413.210724]  ? srcu_torture_stats_print+0x110/0x110
> 	[ 5413.215610]  srcu_barrier+0x187/0x200
> 	[ 5413.219277]  ? rcu_tasks_verify_self_tests+0x50/0x50
> 	[ 5413.224244]  ? rdinit_setup+0x2b/0x2b
> 	[ 5413.227907]  rcu_verify_early_boot_tests+0x2d/0x40
> 	[ 5413.232700]  do_one_initcall+0x63/0x310
> 	[ 5413.236541]  ? rdinit_setup+0x2b/0x2b
> 	[ 5413.240207]  ? rcu_read_lock_sched_held+0x52/0x80
> 	[ 5413.244912]  kernel_init_freeable+0x253/0x28f
> 	[ 5413.249273]  ? rest_init+0x250/0x250
> 	[ 5413.252846]  kernel_init+0xa/0x110
> 	[ 5413.256257]  ret_from_fork+0x22/0x30
> 
> 2) An ssp that gets initialized before rcu_init_geometry() and used
>    afterward will always have stale rdp->mynode references, resulting in
>    callbacks to be missed in srcu_gp_end(), just like in the previous
>    scenario.
> 
> Solve this with initializing nodes geometry whenever an struct srcu_state
> happens to be initialized before rcu_init(). This way we make sure the
> RCU nodes hierarchy is properly built and distributed before the nodes
> of an struct srcu_state are allocated.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> ---
>  kernel/rcu/rcu.h      |  2 ++
>  kernel/rcu/srcutree.c |  3 +++
>  kernel/rcu/tree.c     | 17 ++++++++++++++++-
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 75ed367d5b60..edba5976ca17 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -308,6 +308,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
>  	}
>  }
>  
> +extern void rcu_init_geometry(void);
> +
>  /* Returns a pointer to the first leaf rcu_node structure. */
>  #define rcu_first_leaf_node() (rcu_state.level[rcu_num_lvls - 1])
>  
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 55bc9473562b..9efd5eeb5dd5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -90,6 +90,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
>  	struct srcu_node *snp;
>  	struct srcu_node *snp_first;
>  
> +	/* First make sure the nodes hierarchy is properly built */
> +	rcu_init_geometry();
> +
>  	/* Work out the overall tree geometry. */
>  	ssp->level[0] = &ssp->node[0];
>  	for (i = 1; i < rcu_num_lvls; i++)
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 51600ef3fb0c..906f81786ca5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4617,11 +4617,26 @@ static void __init rcu_init_one(void)
>   * replace the definitions in tree.h because those are needed to size
>   * the ->node array in the rcu_state structure.
>   */
> -static void __init rcu_init_geometry(void)
> +void rcu_init_geometry(void)
>  {
>  	ulong d;
>  	int i;
> +	static unsigned long old_nr_cpu_ids;
>  	int rcu_capacity[RCU_NUM_LVLS];
> +	static bool initialized;
> +
> +	if (initialized) {
> +		/*
> +		 * Arrange for warning if rcu_init_geometry() was called before
> +		 * setup_nr_cpu_ids(). We may miss cases when
> +		 * nr_cpus_ids == NR_CPUS but that shouldn't matter too much.
> +		 */
> +		WARN_ON_ONCE(old_nr_cpu_ids != nr_cpu_ids);
> +		return;
> +	}
> +
> +	old_nr_cpu_ids = nr_cpu_ids;
> +	initialized = true;
>  
>  	/*
>  	 * Initialize any unspecified boot parameters.
> -- 
> 2.25.1
> 
