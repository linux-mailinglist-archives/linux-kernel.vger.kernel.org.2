Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A799142A4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhJLMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:47:32 -0400
Received: from out10.migadu.com ([46.105.121.227]:62709 "EHLO out10.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232906AbhJLMrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:47:31 -0400
Date:   Tue, 12 Oct 2021 20:46:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634042727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZuN6RdU9+V+mfwW7uYhTEIc3kakTxoFz/4g+S0fdqTA=;
        b=oRCpo35i581aqkMLHno+vNHYDEsedL5PM4OPunPGkl/He1fPFLxcKpjRgImXbZi6sYw/Lm
        3ivG7dx1h5twqcVA7xPPJTmVpjCE7yO0zAPVFCnaCZNIeJQsBCcdm1NsfpZ0IGXeJkmWM7
        jRGK+Xqlc79eM5iNIZQp/Tot0Iy1E30=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] sched/fair: Use this_sd->weight to calculate span_avg
Message-ID: <YWWDkwhrqVaCRrxv@geo.homenetwork>
References: <20211009181055.20512-1-tao.zhou@linux.dev>
 <20211011105802.344b907c@gandalf.local.home>
 <YWRqbKc0nY29/Qiz@geo.homenetwork>
 <CAKfTPtAY0oE+BFgFGx1jKRrtanO80XwT-Ee9GATSDm55ZbFv-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAY0oE+BFgFGx1jKRrtanO80XwT-Ee9GATSDm55ZbFv-A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Tue, Oct 12, 2021 at 09:11:23AM +0200, Vincent Guittot wrote:
> On Mon, 11 Oct 2021 at 18:45, Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > Hi Steven,
> >
> > On Mon, Oct 11, 2021 at 10:58:02AM -0400, Steven Rostedt wrote:
> > > On Sun, 10 Oct 2021 02:10:55 +0800
> > > Tao Zhou <tao.zhou@linux.dev> wrote:
> > >
> > > > avg_idle, avg_cost got from this_rq and this_sd. I think
> > > > use this_sd->weight to calculate and estimate the number
> > > > of loop cpus in the target domain.
> > >
> > > If that's the case, then shouldn't the CPUs to be checked come from this_sd
> > > as well? I mean, at the beginning of the function we have:
> > >
> > >       this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> > >       if (!this_sd)
> > >               return -1;
> > >
> > >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > >
> > > Where "cpus" comes from sd, and not this_sd.
> >
> > Thank you for reply.
> >
> >
> > Cycles are spent on this CPU(and in this Domain) if I am not wrong.
> > If T1(on this CPU) want to try to wake up T2 on another CPU, Kernel
> > (on this CPU) should evaluate that not spend much time in finding
> > idle siblings. And the avg_idle and span_avg are two fators to compare
> > with. avg_idle is the CPU average idle time of this rq and avg_cost
> > is the last time this Domain was being looped and the recorded avg
> > cost time. Two values are history averaged. So, use the history to
> > evaluate future that we do *now* the another Domain cpu search to not
> > let this CPU(and in this Domain) too busy. This is what I want to say.
> > Not sure yet.
> 
> this_rq->wake_avg_idle is used to guest estimate how much busy is this_cpu
> this_sd->avg_scan_cost is used to estimate how much time was spent in
> average looking at an idle cpu at this domain level on this cpu
> and sd->span_weight is is used to take into account the size of the
> target domain on which it is going to loop. But we don't really care
> about the size of the domain of the this_cpu

So slow for me to get to this, we need to know the loop number base on
the target domain.

Thank you for reply.

> >
> > > > ---
> > > >  kernel/sched/fair.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index f6a05d9b5443..7fab7b70814c 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -6300,7 +6300,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >             avg_idle = this_rq->wake_avg_idle;
> > > >             avg_cost = this_sd->avg_scan_cost + 1;
> > > >
> > > > -           span_avg = sd->span_weight * avg_idle;
> > > > +           span_avg = this_sd->span_weight * avg_idle;
> > > >             if (span_avg > 4*avg_cost)
> > > >                     nr = div_u64(span_avg, avg_cost);
> > > >             else
> > >
> > >
> > > And after this code, the nr that is determined from the above, is for
> > > limiting the looping over those CPUs from sd, not this_sd:
> > >
> > >       for_each_cpu_wrap(cpu, cpus, target + 1) {
> > >               if (has_idle_core) {
> > >                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > >                       if ((unsigned int)i < nr_cpumask_bits)
> > >                               return i;
> > >
> > >               } else {
> > >                       if (!--nr)
> > >                               return -1;
> > >                       idle_cpu = __select_idle_cpu(cpu, p);
> > >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > >                               break;
> > >               }
> > >       }
> > >
> > > I'm guessing there's nothing wrong here. But, I don't fully understand it
> > > myself.
> >
> > I replied to Barry and not say that I missed that AND operation.
> >
> > Here is another go.
> >
> > @cpus is per-cpu and irq disable. I am not sure irq disable can
> > be preempt in in RT. If that is possiable, cpu_ptr is not safe.
> > Based on the code and comments in __do_set_cpus_allowed(), he will
> > not use ->pi_lock to change affinity(eg. SCA_MIGRATE_DISABLE).
> >
> > If the cpu_ptr not get changed(I must be right and wrong more 5 time)
> > @core is not in @cpu_ptr mask, BUT, the cpu in smt mask of @core is
> > the one that we use to call select_idle_core() and @core is in this
> > smt mask but is not allowed and we get @*idle_cpu and @idle is true
> > we return the @core. Another not sure.

Crap and wrong. Please ignore this.

> > If the @cpu_ptr can changed in eg. just before the @core loop.
> > It is possible that @*idle_cpu == -1 and all cpu in smt mask
> > of @core is seemed to be not allowed. And, we return @core.
> > This case is what I just look at select_idle_core() semantics
> > and missed that AND operation.
> >
> > > -- Steve
> >
> >
> >
> >
> > Thanks,
> > Tao




Thanks,
Tao
