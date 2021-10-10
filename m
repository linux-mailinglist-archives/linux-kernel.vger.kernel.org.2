Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB442803E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhJJJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 05:40:40 -0400
Received: from out1.migadu.com ([91.121.223.63]:49149 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhJJJkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 05:40:39 -0400
Date:   Sun, 10 Oct 2021 17:39:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633858719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HV2MRxqZxUOv90k6cq7pPFRKLDcqUw/RladinsljL7c=;
        b=IWYhrM0kACSOCEckYh4GwjWjeWCmJ4kbLmhl/uCcK34k+jeHfFulU1zi6TiVPtRTZqKxG1
        ZEtAKbCB7rN1NTU4mQx0B5wqz33h6wGb5Li2+f0KnKvr8SeVKLQylnDjKZc3O5CXPGr8HE
        3Imd9fHnrO1TthfyS8zLxAWHNx7Un5s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/fair: Check idle_cpu in select_idle_core/cpu()
Message-ID: <YWK0yEJNGYAZ3hhD@geo.homenetwork>
References: <20211009180941.20458-1-tao.zhou@linux.dev>
 <20211009225057.GB174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009225057.GB174703@worktop.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sun, Oct 10, 2021 at 12:50:57AM +0200, Peter Zijlstra wrote:
> On Sun, Oct 10, 2021 at 02:09:41AM +0800, Tao Zhou wrote:
> > In select_idle_core(), the idle core returned may have no cpu
> > allowed. I think the idle core returned for the task is the one
> > that can be allowed to run. I insist on this semantics.
> > 
> > In select_idle_cpu(), if select_idle_core() can not find the
> > idle core, one reason is that the core is not allowed for the
> > task, but the core itself is idle from the point of
> > sds->has_idle_cores. I insist on this semantics.
> > 
> > No others, just two additional check.
> > ---
> >  kernel/sched/fair.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f6a05d9b5443..a44aca5095d3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6213,7 +6213,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
> >  			*idle_cpu = cpu;
> >  	}
> >  
> > -	if (idle)
> > +	if (idle && *idle_cpu != -1)
> >  		return core;
> 
> In that case, core would be nr_cpu_ids (==nr_cpumask_bits), and then the caller checks:
> 
> 	(unsigned)i < nr_cpumask_bits

Thank you for reply.


If (1)there is no idle core or (2)the idle core has no allowed cpu, we return -1.
Originally, just (1) has happened, we return -1. The (2) is what I want to add.

If we find idle core and has allowed cpu in the core, is it better to return
@*idle_cpu.

    if (idle && *idle_cpu != -1)
   	    return *idle_cpu;

This @*idle_cpu is the allowed cpu in the idle core. We do not promise anything
about the @core(target) is the allowed cpu until we hit in select_task_rq() -->
select_fallback_rq(). And the select_fallback_rq() will return a different cpu
than the @core or @*idle_cpu.

> >  	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> > @@ -6324,7 +6324,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  		}
> >  	}
> >  
> > -	if (has_idle_core)
> > +	if (has_idle_core && *idle_cpu != -1)
> >  		set_idle_cores(target, false);
> 
> And this one I'm completely failing, why shouldn't we mark the core as
> non-idle when there is a single idle CPU found? That's just worng.

When @has_idle_core is true, it implies for all cpu in the core the case
(1) or case (2) has happened. The (1) can be mark as non-idle. I conclude
to contradiction myself last time. The (2) is also seemed to be non-idle.


But, I think I am totally wrong because the sds->has_idle_cores is related
to the cpu not task. So, the affinity should not affect the decision of
sds->has_idle_cores.



Thanks,
Tao
