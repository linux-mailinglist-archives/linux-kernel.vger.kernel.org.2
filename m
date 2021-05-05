Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7E373CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhEEOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhEEOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:00:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F190C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hHQTdk29tySjRz+Nb81eZPl2KWyrgM9RRrCRMdxPkvU=; b=Bv6dNSDiJ6DbjEy6bVgiSmZhnb
        jG8d4YqFzPZyqjojp72BCs/bYhhOJUYN1HuUP2Salji/enDu9JtUt72jXbU6eAl+EPqCZOY4CuAx6
        LpsZLu3ug7eoJxa+1mwxG+/4sBK2cwC2iF3RxkYAPyxIrrpDZUKFjkfXqqb7BslqgoKS2k15iGNMn
        8/gDSG70pSUZ/WYpOEHpzAHGaUAw4sO87VZnzjFLCmJUYY9IiVEnPeRJ6PFQ37QSljGSYtAjcXmqH
        waJ6Pbi4hLU42AamRxvDC60SEy1Igdhv1cVVl6IyqpyUVEVolM2lSsSnp1BSlQFwMqNap3uVrmX8L
        UNm3iDoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leI1Y-000OMB-7N; Wed, 05 May 2021 13:57:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67CBB300103;
        Wed,  5 May 2021 15:57:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13936203E67C1; Wed,  5 May 2021 15:57:08 +0200 (CEST)
Date:   Wed, 5 May 2021 15:57:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: Re: [PATCH 8/8] tick/nohz: Kick only _queued_ task whose tick
 dependency is updated
Message-ID: <YJKkNJTQFtmQPv1u@hirez.programming.kicks-ass.net>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-9-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422120158.33629-9-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:01:58PM +0200, Frederic Weisbecker wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 98191218d891..08526227d200 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1580,6 +1580,11 @@ static inline void uclamp_post_fork(struct task_struct *p) { }
>  static inline void init_uclamp(void) { }
>  #endif /* CONFIG_UCLAMP_TASK */
>  
> +bool sched_task_on_rq(struct task_struct *p)
> +{
> +	return task_on_rq_queued(p);
> +}
> +
>  static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	if (!(flags & ENQUEUE_NOCLOCK))

That's a wee bit sad..

> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index ad5c3905196a..faba7881048f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -324,8 +324,6 @@ void tick_nohz_full_kick_cpu(int cpu)
>  
>  static void tick_nohz_kick_task(struct task_struct *tsk)
>  {
> -	int cpu = task_cpu(tsk);
> -
>  	/*
>  	 * If the task concurrently migrates to another cpu,
>  	 * we guarantee it sees the new tick dependency upon
> @@ -340,6 +338,23 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
>  	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
>  	 *      LOAD p->tick_dep_mask           LOAD p->cpu
>  	 */
> +	int cpu = task_cpu(tsk);
> +
> +	/*
> +	 * If the task is not running, run_posix_cpu_timers
> +	 * has nothing to elapsed, can spare IPI in that
> +	 * case.
> +	 *
> +	 * activate_task()                      STORE p->tick_dep_mask
> +	 * STORE p->on_rq
> +	 * __schedule() (switch to task 'p')    smp_mb() (atomic_fetch_or())
> +	 * LOCK rq->lock                        LOAD p->on_rq
> +	 * smp_mb__after_spin_lock()
> +	 * tick_nohz_task_switch()
> +	 *	LOAD p->tick_dep_mask
> +	 */

That needs indenting, the style is distinctly different from the comment
right above it.

> +	if (!sched_task_on_rq(tsk))
> +		return;

I'm too tired, but do we really need the task_cpu() load to be before
this?

>  
>  	preempt_disable();
>  	if (cpu_online(cpu))
> -- 
> 2.25.1
> 
