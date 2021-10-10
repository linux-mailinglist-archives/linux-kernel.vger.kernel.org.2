Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1F4281E2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhJJO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 10:28:45 -0400
Received: from out0.migadu.com ([94.23.1.103]:42383 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhJJO2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:28:43 -0400
Date:   Sun, 10 Oct 2021 22:27:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633876001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhOtgkZ+tjHM29IGh04Mb8pYgZ9ao2sJhmPA9HYKAj0=;
        b=O4tkQGJHLIiN/cVHsrR7jVBTfMZMJjGrIODjARk8Vm/vcjQKOJN8wRk0Ea0PCaPDJlcxTZ
        4IR+XiIZJXi+5Vt1ByRSi+gUL0aNAjFTa7fRyZDT0p3ZP1wghlKatjnS3aqdMZqkCK0IO3
        JPTqzenacxiy5n2IBuPno+G7ssU8Axc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/fair: Check idle_cpu in select_idle_core/cpu()
Message-ID: <YWL4TA19eFsfd4c7@geo.homenetwork>
References: <20211009180941.20458-1-tao.zhou@linux.dev>
 <20211009225057.GB174703@worktop.programming.kicks-ass.net>
 <YWK0yEJNGYAZ3hhD@geo.homenetwork>
 <CAGsJ_4xW5s-ze6QjVLJPscEcCaakdS6Np84w9Hwh8Zj_=WqhTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xW5s-ze6QjVLJPscEcCaakdS6Np84w9Hwh8Zj_=WqhTw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Mon, Oct 11, 2021 at 01:19:57AM +1300, Barry Song wrote:
> On Sun, Oct 10, 2021 at 10:45 PM Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > Hi Peter,
> >
> > On Sun, Oct 10, 2021 at 12:50:57AM +0200, Peter Zijlstra wrote:
> > > On Sun, Oct 10, 2021 at 02:09:41AM +0800, Tao Zhou wrote:
> > > > In select_idle_core(), the idle core returned may have no cpu
> > > > allowed. I think the idle core returned for the task is the one
> > > > that can be allowed to run. I insist on this semantics.
> > > >
> > > > In select_idle_cpu(), if select_idle_core() can not find the
> > > > idle core, one reason is that the core is not allowed for the
> > > > task, but the core itself is idle from the point of
> > > > sds->has_idle_cores. I insist on this semantics.
> > > >
> > > > No others, just two additional check.
> > > > ---
> > > >  kernel/sched/fair.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index f6a05d9b5443..a44aca5095d3 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -6213,7 +6213,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> > > >                     *idle_cpu = cpu;
> > > >     }
> > > >
> > > > -   if (idle)
> > > > +   if (idle && *idle_cpu != -1)
> > > >             return core;
> > >
> > > In that case, core would be nr_cpu_ids (==nr_cpumask_bits), and then the caller checks:
> > >
> > >       (unsigned)i < nr_cpumask_bits
> >
> > Thank you for reply.
> >
> >
> > If (1)there is no idle core or (2)the idle core has no allowed cpu, we return -1.
> > Originally, just (1) has happened, we return -1. The (2) is what I want to add.
> 
> I don't understand (2). before doing
>         for_each_cpu_wrap(cpu, cpus, target + 1) {
>                 if (has_idle_core) {
>                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
>                         if ((unsigned int)i < nr_cpumask_bits)
>                                 return i;
> 
>                 } else {
>                         if (!--nr)
>                                 return -1;
>                         idle_cpu = __select_idle_cpu(cpu, p);
>                         if ((unsigned int)idle_cpu < nr_cpumask_bits)
>                                 break;
>                 }
>         }
> 
> to select idle core, we have already done:
>     cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> 
> so we are only scanning allowed cpus.

Um.. You read top down.. and you are right.
The function itself semantics is important to me.

After a secondary recall and not thorough now, I realize that
cpus_ptr may be changed.


See code of this:

static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
{
	if (likely(!p->migration_disabled))
		return;

	if (p->cpus_ptr != &p->cpus_mask)
		return;

	/*
	 * Violates locking rules! see comment in __do_set_cpus_allowed().
	 */
	__do_set_cpus_allowed(p, cpumask_of(rq->cpu), SCA_MIGRATE_DISABLE);
}


This change is under the light of ->pi_lock.
That thing is quick to forget to me..
Not sure I am right. Thank you for remind.

If the cpu_ptr can be changed, you can not depend on the first AND
operation there.

> >
> > If we find idle core and has allowed cpu in the core, is it better to return
> > @*idle_cpu.
> >
> >     if (idle && *idle_cpu != -1)
> >             return *idle_cpu;
> >
> > This @*idle_cpu is the allowed cpu in the idle core. We do not promise anything
> > about the @core(target) is the allowed cpu until we hit in select_task_rq() -->
> > select_fallback_rq(). And the select_fallback_rq() will return a different cpu
> > than the @core or @*idle_cpu.
> >
> > > >     cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> > > > @@ -6324,7 +6324,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >             }
> > > >     }
> > > >
> > > > -   if (has_idle_core)
> > > > +   if (has_idle_core && *idle_cpu != -1)
> > > >             set_idle_cores(target, false);
> > >
> > > And this one I'm completely failing, why shouldn't we mark the core as
> > > non-idle when there is a single idle CPU found? That's just worng.
> >
> > When @has_idle_core is true, it implies for all cpu in the core the case
> > (1) or case (2) has happened. The (1) can be mark as non-idle. I conclude
> > to contradiction myself last time. The (2) is also seemed to be non-idle.
> >
> >
> > But, I think I am totally wrong because the sds->has_idle_cores is related
> > to the cpu not task. So, the affinity should not affect the decision of
> > sds->has_idle_cores.
> >
> >
> >
> > Thanks,
> > Tao
> 
> Thanks
> barry



Thanks,
Tao
