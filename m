Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C19373C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhEENol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhEENok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:44:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7677C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ouVU1lFGYesDJ408JaUblRc5MBOEnLO2xbqaLV8Nsok=; b=iXS8hXw2F1CMw7wHZ0GTh7QZKn
        sr0rloRAgm/LZ/LVUSSF7qPmf4bwFVOmzL+b+qRzyEDrXGzAqvBEGc0N7QTCrcLKDAAyYeZUFEBYQ
        GsWsvZNNtHcghgnZn3vFH7r2+OxxakVeUmzxTA2oinojgyC4CJz/TLUv2RU67cdM0AGLEX0K93Lo0
        EcYTfOtpteaYq7aiQXADap/HIuVEjcYFYNUeCaN7w0dJsbtTj9QZGSl+1m+3gHG3yX05xB4WIaGyX
        GYON0eaiOAMcT1pKZzSl2896FotWSMvJ/Hlf0nVTG9UwJPOrBlYKll8jyEUYyDVT4Qvr+dxkY0+i9
        d0jG7RRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leHoI-001KjC-P4; Wed, 05 May 2021 13:43:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EEF63001CD;
        Wed,  5 May 2021 15:43:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF9F12027AFE6; Wed,  5 May 2021 15:43:28 +0200 (CEST)
Date:   Wed, 5 May 2021 15:43:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 6/8] tick/nohz: Only wakeup a single target cpu when
 kicking a task
Message-ID: <YJKhAFAbOXzopp6/@hirez.programming.kicks-ass.net>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422120158.33629-7-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:01:56PM +0200, Frederic Weisbecker wrote:
> When adding a tick dependency to a task, its necessary to
> wakeup the CPU where the task resides to reevaluate tick
> dependencies on that CPU.
> 
> However the current code wakes up all nohz_full CPUs, which
> is unnecessary.
> 
> Switch to waking up a single CPU, by using ordering of writes
> to task->cpu and task->tick_dep_mask.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yunfeng Ye <yeyunfeng@huawei.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> ---
>  kernel/time/tick-sched.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index ffc13b9dfbe3..45d9a4ea3ee0 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -322,6 +322,31 @@ void tick_nohz_full_kick_cpu(int cpu)
>  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
>  }
>  
> +static void tick_nohz_kick_task(struct task_struct *tsk)
> +{
> +	int cpu = task_cpu(tsk);
> +
> +	/*
> +	 * If the task concurrently migrates to another cpu,
> +	 * we guarantee it sees the new tick dependency upon
> +	 * schedule.
> +	 *
> +	 *
> +	 * set_task_cpu(p, cpu);
> +	 *   STORE p->cpu = @cpu
> +	 * __schedule() (switch to task 'p')
> +	 *   LOCK rq->lock
> +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> +	 */
> +
> +	preempt_disable();
> +	if (cpu_online(cpu))
> +		tick_nohz_full_kick_cpu(cpu);
> +	preempt_enable();
> +}


That had me looking at tick_nohz_task_switch(), does we want the below?


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9143163fa678..ff45fc513ba7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4207,6 +4207,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
+	tick_nohz_task_switch();
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
@@ -4252,7 +4253,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		put_task_struct_rcu_user(prev);
 	}
 
-	tick_nohz_task_switch();
 	return rq;
 }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091501ca..ea079be9097f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -447,13 +447,10 @@ void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bi
  */
 void __tick_nohz_task_switch(void)
 {
-	unsigned long flags;
 	struct tick_sched *ts;
 
-	local_irq_save(flags);
-
 	if (!tick_nohz_full_cpu(smp_processor_id()))
-		goto out;
+		return;
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
@@ -462,8 +459,6 @@ void __tick_nohz_task_switch(void)
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
 	}
-out:
-	local_irq_restore(flags);
 }
 
 /* Get the boot-time nohz CPU list from the kernel parameters. */
