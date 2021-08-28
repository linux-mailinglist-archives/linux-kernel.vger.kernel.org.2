Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4DA3FA43F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 09:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhH1HWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhH1HWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 03:22:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F99C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 00:21:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630135269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wp8vZTcoOUe8csxv0ZsEKxGaFCPMo9Fd0Pf6ar7OWDY=;
        b=Yw1YGA+EN4+vyknpbkxmjeGGPGZIrAAR38DFFbDUyLyUuvZDzlcUcWK53UDXW8woIQ4Rnq
        amPCvGSA8uszmS0aGiChVB+U/amPMD42PZfB2Ak3rk4FzYYNPzfh582BLTLEY1CiFzh0KA
        LsFjsoVvWR9dGBQKFEByEf0yUFWoKKYuejK9SIvrI/oStP6FMwEBDlb0KNvT/0QcbBWsU/
        e9utkJyxqVlTtRqX6T6heXGC8JGJau2o2krtlCmpVAqKHVnVOKkuBNhW5JXiisriITqUWz
        NEe+2Cyu0P/b61gF9yECYilhz2xXuaq7b/kzu4cD9iudAe310oqIb1mkYeVA5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630135269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wp8vZTcoOUe8csxv0ZsEKxGaFCPMo9Fd0Pf6ar7OWDY=;
        b=F1BjRq/EJcZhQwoWNlOAulBuhKUIWycxyO+G209XViopgPWvTsW4sbmOmofyRShI/r0FFd
        0SAuWi76rC3fn7BA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched: Prevent balance_push() on remote runqueues
In-Reply-To: <87tujb0yn1.ffs@tglx>
References: <87tujb0yn1.ffs@tglx>
Date:   Sat, 28 Aug 2021 09:21:08 +0200
Message-ID: <87eeae11cr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27 2021 at 16:07, Thomas Gleixner wrote:
> sched_setscheduler() and rt_mutex_setprio() invoke the run-queue balance
> callback after changing priorities or the scheduling class of a task. The
> run-queue for which the callback is invoked can be local or remote.
>
> That's not a problem for the regular rq::push_work which is serialized with
> a busy flag in the run-queue struct, but for the balance_push() work which
> is only valid to be invoked on the outgoing CPU that's wrong. It not only
> triggers the debug warning, but also leaves the per CPU variable push_work
> unprotected, which can result in double enqueues on the stop machine list.
>
> Remove the warning and check that the function is invoked on the
> outgoing CPU. If not, just return and do nothing.
>
> Fixes: ae7927023243 ("sched: Optimize finish_lock_switch()")
> Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  kernel/sched/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8523,7 +8523,6 @@ static void balance_push(struct rq *rq)
>  	struct task_struct *push_task = rq->curr;
>  
>  	lockdep_assert_rq_held(rq);
> -	SCHED_WARN_ON(rq->cpu != smp_processor_id());
>  
>  	/*
>  	 * Ensure the thing is persistent until balance_push_set(.on = false);
> @@ -8531,9 +8530,10 @@ static void balance_push(struct rq *rq)
>  	rq->balance_callback = &balance_push_callback;
>  
>  	/*
> -	 * Only active while going offline.
> +	 * Only active while going offline and when invoked on the outgoing
> +	 * CPU.
>  	 */
> -	if (!cpu_dying(rq->cpu))
> +	if (!cpu_dying(rq->cpu) && rq == this_rq())
>  		return;

Stupid me. The last minute change of moving the condition into the same
line fatfingered != to ==. Will resend ...
