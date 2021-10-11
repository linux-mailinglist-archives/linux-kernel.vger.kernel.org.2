Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84D4292AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhJKPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234614AbhJKPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:00:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6945D60EBD;
        Mon, 11 Oct 2021 14:58:04 +0000 (UTC)
Date:   Mon, 11 Oct 2021 10:58:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/fair: Use this_sd->weight to calculate span_avg
Message-ID: <20211011105802.344b907c@gandalf.local.home>
In-Reply-To: <20211009181055.20512-1-tao.zhou@linux.dev>
References: <20211009181055.20512-1-tao.zhou@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 02:10:55 +0800
Tao Zhou <tao.zhou@linux.dev> wrote:

> avg_idle, avg_cost got from this_rq and this_sd. I think
> use this_sd->weight to calculate and estimate the number
> of loop cpus in the target domain.

If that's the case, then shouldn't the CPUs to be checked come from this_sd
as well? I mean, at the beginning of the function we have:

	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
	if (!this_sd)
		return -1;

	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);

Where "cpus" comes from sd, and not this_sd.


> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f6a05d9b5443..7fab7b70814c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6300,7 +6300,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		avg_idle = this_rq->wake_avg_idle;
>  		avg_cost = this_sd->avg_scan_cost + 1;
>  
> -		span_avg = sd->span_weight * avg_idle;
> +		span_avg = this_sd->span_weight * avg_idle;
>  		if (span_avg > 4*avg_cost)
>  			nr = div_u64(span_avg, avg_cost);
>  		else


And after this code, the nr that is determined from the above, is for
limiting the looping over those CPUs from sd, not this_sd:

	for_each_cpu_wrap(cpu, cpus, target + 1) {
		if (has_idle_core) {
			i = select_idle_core(p, cpu, cpus, &idle_cpu);
			if ((unsigned int)i < nr_cpumask_bits)
				return i;

		} else {
			if (!--nr)
				return -1;
			idle_cpu = __select_idle_cpu(cpu, p);
			if ((unsigned int)idle_cpu < nr_cpumask_bits)
				break;
		}
	}

I'm guessing there's nothing wrong here. But, I don't fully understand it
myself.

-- Steve
