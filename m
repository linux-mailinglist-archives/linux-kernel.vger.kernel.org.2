Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341B35A790
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhDIUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233657AbhDIUFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:05:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CCFE6105A;
        Fri,  9 Apr 2021 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617998711;
        bh=jPirD6AFgqrx5T70iNJSnKVguvkaiGABVLXA8bNgzAs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pivTiouDUjHJzZjqfWZ5RBqxJkskejgOcXXlRy3dIHON+74gsOgHCmjy9CrmtabTL
         UDYhJdXF/YVqOfFRDwythj5DpDMoOToOOs7dQZg4B22CF+9PlZxT20ItfNMS/RfnH+
         Ho78JxXS3nFkvd2564sCcDqzdwQUyVW0CGUq4VqxdQfmifECmTjUDpeAuLMJ4UIktd
         LNjDpWjSyQsZDXTRzjk7VlWHs5d1rfZHPLkVXeQwrpZGgzht+BrPDgMfRiF9MMe0S6
         o0L30kA6D+4TPLU6UD0N6ZJaX7z7S09SEWREJRPUqA3rhngNY5m0bFjLPrkaL26e20
         Uezd+8KfKuqYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D222D5C00B4; Fri,  9 Apr 2021 13:05:10 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:05:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/5] srcu: Initialize SRCU after timers
Message-ID: <20210409200510.GR4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210408223902.6405-1-frederic@kernel.org>
 <20210408223902.6405-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408223902.6405-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:38:59AM +0200, Frederic Weisbecker wrote:
> Once srcu_init() is called, the SRCU core is free to queue delayed
> workqueues, which rely on timers. However init_timers() is called
> several steps after rcu_init(). Any call_srcu() in-between would finish
> its course inside a dangerously uninitialized timer core.
> 
> Make sure we stay in early SRCU mode until everything is well settled.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Good catches!  Apparently not so many people are using SRCU that early
in boot, but good to get it working.  I queued this patch and the
preceding one (1/5).

								
							Thanx, Paul

> ---
>  include/linux/srcu.h  | 6 ++++++
>  init/main.c           | 2 ++
>  kernel/rcu/rcu.h      | 6 ------
>  kernel/rcu/srcutree.c | 5 +++++
>  kernel/rcu/tiny.c     | 1 -
>  kernel/rcu/tree.c     | 1 -
>  6 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index a0895bbf71ce..e6011a9975af 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -64,6 +64,12 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
>  unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
>  bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
>  
> +#ifdef CONFIG_SRCU
> +void srcu_init(void);
> +#else /* #ifdef CONFIG_SRCU */
> +static inline void srcu_init(void) { }
> +#endif /* #else #ifdef CONFIG_SRCU */
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
>  /**
> diff --git a/init/main.c b/init/main.c
> index 53b278845b88..1bc5cc9e52ef 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -42,6 +42,7 @@
>  #include <linux/profile.h>
>  #include <linux/kfence.h>
>  #include <linux/rcupdate.h>
> +#include <linux/srcu.h>
>  #include <linux/moduleparam.h>
>  #include <linux/kallsyms.h>
>  #include <linux/writeback.h>
> @@ -956,6 +957,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	tick_init();
>  	rcu_init_nohz();
>  	init_timers();
> +	srcu_init();
>  	hrtimers_init();
>  	softirq_init();
>  	timekeeping_init();
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index d64b842f4078..b3af34068051 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -422,12 +422,6 @@ do {									\
>  
>  #endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
>  
> -#ifdef CONFIG_SRCU
> -void srcu_init(void);
> -#else /* #ifdef CONFIG_SRCU */
> -static inline void srcu_init(void) { }
> -#endif /* #else #ifdef CONFIG_SRCU */
> -
>  #ifdef CONFIG_TINY_RCU
>  /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
>  static inline bool rcu_gp_is_normal(void) { return true; }
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 10e681ea7051..108f9ca06047 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1384,6 +1384,11 @@ void __init srcu_init(void)
>  {
>  	struct srcu_struct *ssp;
>  
> +	/*
> +	 * Once that is set, call_srcu() can follow the normal path and
> +	 * queue delayed work. This must follow RCU workqueues creation
> +	 * and timers initialization.
> +	 */
>  	srcu_init_done = true;
>  	while (!list_empty(&srcu_boot_list)) {
>  		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index c8a029fbb114..340b3f8b090d 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -221,5 +221,4 @@ void __init rcu_init(void)
>  {
>  	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
>  	rcu_early_boot_tests();
> -	srcu_init();
>  }
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5c214705c33f..740f5cd34459 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4714,7 +4714,6 @@ void __init rcu_init(void)
>  	WARN_ON(!rcu_gp_wq);
>  	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
>  	WARN_ON(!rcu_par_gp_wq);
> -	srcu_init();
>  
>  	/* Fill in default value for rcutree.qovld boot parameter. */
>  	/* -After- the rcu_node ->lock fields are initialized! */
> -- 
> 2.25.1
> 
