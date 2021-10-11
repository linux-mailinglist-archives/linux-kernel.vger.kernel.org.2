Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33204294B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhJKQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhJKQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:48:00 -0400
X-Greylist: delayed 167699 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Oct 2021 09:46:00 PDT
Received: from out10.migadu.com (out10.migadu.com [IPv6:2001:41d0:2:e8e3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228CAC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:46:00 -0700 (PDT)
Date:   Tue, 12 Oct 2021 00:46:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633970758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSwYqzD11KmXd+8YpjlGtEeh+PEnIA0dpMw4hh6zABg=;
        b=HBetP+k9BrURdBZ2mmqrqxwJ6uAFm3SZzus9GesDmoYylmxfT07mPEBQ0+UKw+V30vr5Gb
        GJExI9aPNIqpp9qIDgr7U5LjsmQxA4PV37tK+2ppjdrvKBdiXK2JZUW4hpBPychNgiCi6c
        G1xAZrB+r7JgDvvEkd5vFYGF2cNlcjg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] sched/fair: Use this_sd->weight to calculate span_avg
Message-ID: <YWRqbKc0nY29/Qiz@geo.homenetwork>
References: <20211009181055.20512-1-tao.zhou@linux.dev>
 <20211011105802.344b907c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011105802.344b907c@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, Oct 11, 2021 at 10:58:02AM -0400, Steven Rostedt wrote:
> On Sun, 10 Oct 2021 02:10:55 +0800
> Tao Zhou <tao.zhou@linux.dev> wrote:
> 
> > avg_idle, avg_cost got from this_rq and this_sd. I think
> > use this_sd->weight to calculate and estimate the number
> > of loop cpus in the target domain.
> 
> If that's the case, then shouldn't the CPUs to be checked come from this_sd
> as well? I mean, at the beginning of the function we have:
> 
> 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> 	if (!this_sd)
> 		return -1;
> 
> 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> 
> Where "cpus" comes from sd, and not this_sd.

Thank you for reply.


Cycles are spent on this CPU(and in this Domain) if I am not wrong.
If T1(on this CPU) want to try to wake up T2 on another CPU, Kernel
(on this CPU) should evaluate that not spend much time in finding
idle siblings. And the avg_idle and span_avg are two fators to compare
with. avg_idle is the CPU average idle time of this rq and avg_cost
is the last time this Domain was being looped and the recorded avg
cost time. Two values are history averaged. So, use the history to
evaluate future that we do *now* the another Domain cpu search to not
let this CPU(and in this Domain) too busy. This is what I want to say.
Not sure yet.

> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f6a05d9b5443..7fab7b70814c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6300,7 +6300,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  		avg_idle = this_rq->wake_avg_idle;
> >  		avg_cost = this_sd->avg_scan_cost + 1;
> >  
> > -		span_avg = sd->span_weight * avg_idle;
> > +		span_avg = this_sd->span_weight * avg_idle;
> >  		if (span_avg > 4*avg_cost)
> >  			nr = div_u64(span_avg, avg_cost);
> >  		else
> 
> 
> And after this code, the nr that is determined from the above, is for
> limiting the looping over those CPUs from sd, not this_sd:
> 
> 	for_each_cpu_wrap(cpu, cpus, target + 1) {
> 		if (has_idle_core) {
> 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> 			if ((unsigned int)i < nr_cpumask_bits)
> 				return i;
> 
> 		} else {
> 			if (!--nr)
> 				return -1;
> 			idle_cpu = __select_idle_cpu(cpu, p);
> 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> 				break;
> 		}
> 	}
> 
> I'm guessing there's nothing wrong here. But, I don't fully understand it
> myself.

I replied to Barry and not say that I missed that AND operation.

Here is another go.

@cpus is per-cpu and irq disable. I am not sure irq disable can
be preempt in in RT. If that is possiable, cpu_ptr is not safe.
Based on the code and comments in __do_set_cpus_allowed(), he will
not use ->pi_lock to change affinity(eg. SCA_MIGRATE_DISABLE).

If the cpu_ptr not get changed(I must be right and wrong more 5 time)
@core is not in @cpu_ptr mask, BUT, the cpu in smt mask of @core is
the one that we use to call select_idle_core() and @core is in this
smt mask but is not allowed and we get @*idle_cpu and @idle is true
we return the @core. Another not sure.

If the @cpu_ptr can changed in eg. just before the @core loop.
It is possible that @*idle_cpu == -1 and all cpu in smt mask
of @core is seemed to be not allowed. And, we return @core.
This case is what I just look at select_idle_core() semantics
and missed that AND operation.

> -- Steve




Thanks,
Tao
