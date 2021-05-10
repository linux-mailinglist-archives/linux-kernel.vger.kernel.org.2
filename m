Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944A33786CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhEJLLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233509AbhEJKuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97EFE61947;
        Mon, 10 May 2021 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620643144;
        bh=/DjZ2B4KoKtqZOfT8A0KYExXfi16cQxKFTdOHG8klYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPOhAz5fRgmpQpoB/FjrlPkO9mIgCnFZiT4v6RCyNUqUfBzpYIjNw69Iz0fRYM+rq
         XyDXvQrRA9NjyviVRDJdOYKtkNbnZTmS+q3KopRB4XU9T6Y1RYcLXxv7GkkMeSl2re
         F7p/UwGjoaqm8ESROopuU4jlUIiUJsXWpzeUwL3+c++wgmZrx/G+VzmsrkuOyu/Wg0
         1HnYjHF5f8tl4hnsjcZPSt/DLcqVLUqYbVvaVaK3n8ZW7iEd60IMZdcXDYeamNfMpi
         EI7Aq3l141oMhpoMUKwE5li7kgN3m2PgONACrk8gSYhFigm+T1ldoi7hnGoUPNrODP
         bucak7Y5xRd5A==
Date:   Mon, 10 May 2021 12:39:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 6/8] tick/nohz: Only wakeup a single target cpu when
 kicking a task
Message-ID: <20210510103901.GA97481@lothringen>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-7-frederic@kernel.org>
 <YJKhAFAbOXzopp6/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKhAFAbOXzopp6/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 03:43:28PM +0200, Peter Zijlstra wrote:
> That had me looking at tick_nohz_task_switch(), does we want the below?
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9143163fa678..ff45fc513ba7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4207,6 +4207,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	vtime_task_switch(prev);
>  	perf_event_task_sched_in(prev, current);
>  	finish_task(prev);
> +	tick_nohz_task_switch();
>  	finish_lock_switch(rq);
>  	finish_arch_post_lock_switch();
>  	kcov_finish_switch(current);
> @@ -4252,7 +4253,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		put_task_struct_rcu_user(prev);
>  	}
>  
> -	tick_nohz_task_switch();
>  	return rq;
>  }
>  
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 828b091501ca..ea079be9097f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -447,13 +447,10 @@ void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bi
>   */
>  void __tick_nohz_task_switch(void)
>  {
> -	unsigned long flags;
>  	struct tick_sched *ts;
>  
> -	local_irq_save(flags);
> -
>  	if (!tick_nohz_full_cpu(smp_processor_id()))
> -		goto out;
> +		return;
>  
>  	ts = this_cpu_ptr(&tick_cpu_sched);
>  
> @@ -462,8 +459,6 @@ void __tick_nohz_task_switch(void)
>  		    atomic_read(&current->signal->tick_dep_mask))
>  			tick_nohz_full_kick();
>  	}
> -out:
> -	local_irq_restore(flags);
>  }
>  
>  /* Get the boot-time nohz CPU list from the kernel parameters. */


Sure, I'll take your SoB on that too, ok?
