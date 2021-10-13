Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF042CD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJMWPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJMWPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:15:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A938A61151;
        Wed, 13 Oct 2021 22:13:08 +0000 (UTC)
Date:   Wed, 13 Oct 2021 18:13:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 1/4] sched/rt: Annotate the RT balancing logic
 irqwork as IRQ_WORK_HARD_IRQ
Message-ID: <20211013181306.004c4bc6@gandalf.local.home>
In-Reply-To: <20211006111852.1514359-2-bigeasy@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
        <20211006111852.1514359-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Oct 2021 13:18:49 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The push-IPI logic for RT tasks expects to be invoked from hardirq
> context. One reason is that a RT task on the remote CPU would block the
> softirq processing on PREEMPT_RT and so avoid pulling / balancing the RT
> tasks as intended.
> 
> Annotate root_domain::rto_push_work as IRQ_WORK_HARD_IRQ.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 4e8698e62f075..3d0157bd4e144 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -526,7 +526,7 @@ static int init_rootdomain(struct root_domain *rd)
>  #ifdef HAVE_RT_PUSH_IPI
>  	rd->rto_cpu = -1;
>  	raw_spin_lock_init(&rd->rto_lock);
> -	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
> +	rd->rto_push_work = IRQ_WORK_INIT_HARD(rto_push_irq_work_func);

Should we not make an "init_irq_work_hard()" helper?

-- Steve

>  #endif
>  
>  	rd->visit_gen = 0;

