Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5937FCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhEMRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhEMRrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:47:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA72761106;
        Thu, 13 May 2021 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620927997;
        bh=cJH6sWLGBZOCGMDITaiB1M5zp079qAZFdZYdcJzLAyw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bYsNxeM0hvgyvxu3isGdMN8UxdB4EHvkefoCYBB1AsPusYH2hZYFf5qqvGtJGAH7A
         xSw3Vq5YbI7XbGiM5GGf7Q4hdtqX3rSGRbYY5pZS5/lIx07Ek17ZgePb5G7KQwiZJc
         FXgXRQcoM0VOcEl4VOVn0zM2y3gmLbqJi7ULroU0VdkM/F/xiokLcZGGxK7JfT1qd7
         3nWmg/K0BL7WhufZ8Bq8oPwPuJ5mJOPHXqiOKSV/8Z0IjizSJjkHUoDmstMZ/r9hMa
         idV1tBVKB0uRgHXuHbnrmP1+Ea2udj6WDPytMpRhat+iGWHAo29tVzOBoL4IzYqEC/
         EaM4In/0pvKcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF19F5C014E; Thu, 13 May 2021 10:46:36 -0700 (PDT)
Date:   Thu, 13 May 2021 10:46:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [entry]  47b8ff194c:  will-it-scale.per_process_ops -3.0%
 regression
Message-ID: <20210513174636.GB975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210428071653.GC13086@xsang-OptiPlex-9020>
 <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:19:21AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 28, 2021 at 03:16:53PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed a -3.0% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 47b8ff194c1fd73d58dc339b597d466fe48c8958 ("entry: Explicitly flush pending rcuog wakeup before last rescheduling point")
> 
> So the RCU bits are in rcu_user_enter(), which is called from
> __context_tracking_enter() aka user_enter(), which is under
> context_tracking_enabled().
> 
> But the new code in entry is not; we now unconditionally call
> rcu_nocb_flush_deferred_wakeup(). Did that want to be under
> context_tracking_enabled() as well?
> 
> Frederic, Paul?

My argument in favor of the change below is that if there is no context
tracking, then scheduling-clock interrupts will happen on all non-idle
CPUs.  The next scheduling-clock interrupt will check this deferred-wakeup
state, and if set, cause rcu_core() to be invoked (for example, within the
RCU_SOFTIRQ handler).  And rcu_core() invokes do_nocb_deferred_wakeup(),
which takes care of this.

For idle CPUs, do_idle() invokes rcu_nocb_flush_deferred_wakeup().

Frederic, any cases that I am missing?

							Thanx, Paul

> ---
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 9455476c5ba2..f4df001410fc 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -114,7 +114,12 @@ static inline void rcu_user_exit(void) { }
>  void rcu_init_nohz(void);
>  int rcu_nocb_cpu_offload(int cpu);
>  int rcu_nocb_cpu_deoffload(int cpu);
> -void rcu_nocb_flush_deferred_wakeup(void);
> +void __rcu_nocb_flush_deferred_wakeup(void);
> +static inline void rcu_nocb_flush_deferred_wakeup(void)
> +{
> +	if (context_tracking_enabled())
> +		__rcu_nocb_flush_deferred_wakeup();
> +}
>  #else /* #ifdef CONFIG_RCU_NOCB_CPU */
>  static inline void rcu_init_nohz(void) { }
>  static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index ad0156b86937..3cdbbf7fba01 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2378,7 +2378,7 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
>  	return false;
>  }
>  
> -void rcu_nocb_flush_deferred_wakeup(void)
> +void __rcu_nocb_flush_deferred_wakeup(void)
>  {
>  	do_nocb_deferred_wakeup(this_cpu_ptr(&rcu_data));
>  }
> 
