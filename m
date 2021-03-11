Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596D833769F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhCKPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:13:38 -0500
Received: from foss.arm.com ([217.140.110.172]:38170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234034AbhCKPNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:13:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9611B1FB;
        Thu, 11 Mar 2021 07:13:20 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703993F70D;
        Thu, 11 Mar 2021 07:13:18 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        qais.yousef@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
In-Reply-To: <20210310150109.259726371@infradead.org>
References: <20210310145258.899619710@infradead.org> <20210310150109.259726371@infradead.org>
Date:   Thu, 11 Mar 2021 15:13:04 +0000
Message-ID: <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> @@ -7883,14 +7889,6 @@ int sched_cpu_deactivate(unsigned int cp
>  	set_cpu_active(cpu, false);
>  
>  	/*
> -	 * From this point forward, this CPU will refuse to run any task that
> -	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> -	 * push those tasks away until this gets cleared, see
> -	 * sched_cpu_dying().
> -	 */
> -	balance_push_set(cpu, true);
> -
> -	/*
>  	 * We've cleared cpu_active_mask / set balance_push, wait for all
>  	 * preempt-disabled and RCU users of this state to go away such that
>  	 * all new such users will observe it.
> @@ -7910,6 +7908,14 @@ int sched_cpu_deactivate(unsigned int cp
>  	}
>  	rq_unlock_irqrestore(rq, &rf);
>  
> +	/*
> +	 * From this point forward, this CPU will refuse to run any task that
> +	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
> +	 * push those tasks away until this gets cleared, see
> +	 * sched_cpu_dying().
> +	 */
> +	balance_push_set(cpu, true);
> +

AIUI with cpu_dying_mask being flipped before even entering
sched_cpu_deactivate(), we don't need this to be before the
synchronize_rcu() anymore; is there more than that to why you're punting it
back this side of it?

>  #ifdef CONFIG_SCHED_SMT
>  	/*
>  	 * When going down, decrement the number of cores with SMT present.

> @@ -8206,7 +8212,7 @@ void __init sched_init(void)
>  		rq->sd = NULL;
>  		rq->rd = NULL;
>  		rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
> -		rq->balance_callback = NULL;
> +		rq->balance_callback = &balance_push_callback;
>  		rq->active_balance = 0;
>  		rq->next_balance = jiffies;
>  		rq->push_cpu = 0;
> @@ -8253,6 +8259,7 @@ void __init sched_init(void)
>  
>  #ifdef CONFIG_SMP
>  	idle_thread_set_boot_cpu();
> +	balance_push_set(smp_processor_id(), false);
>  #endif
>  	init_sched_fair_class();
>

I don't get what these two changes do - the end result is the same as
before, no?


Also, AIUI this patch covers the cpu_dying -> !cpu_dying rollback case
since balance_push gets numbed down by !cpu_dying. What about the other way
around (hot-plug failure + rollback)? We may have allowed !pcpu tasks on the
now-dying CPU, and we'd need to re-install the balance_push callback. 

I'm starting to think we'd need to have

  rq->balance_callback = &balance_push_callback

for any CPU with hotplug state < CPUHP_AP_ACTIVE. Thus we would
need:

  balance_push_set(cpu, true) in sched_init() and sched_cpu_deactivate()
  balance_push_set(cpu, false) in sched_cpu_activate()

and the rest would be driven by the cpu_dying_mask.
