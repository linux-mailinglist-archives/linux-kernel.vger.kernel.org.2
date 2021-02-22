Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162B321D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhBVQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:41:16 -0500
Received: from foss.arm.com ([217.140.110.172]:56020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhBVQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:40:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0BC31FB;
        Mon, 22 Feb 2021 08:39:44 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BED7F3F73B;
        Mon, 22 Feb 2021 08:39:42 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:39:47 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <20210222163947.GB225035@e124901.cambridge.arm.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
 <YDPUwKKYgZfzzCJm@google.com>
 <YDPajlnvgkonocpp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDPajlnvgkonocpp@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:23:42PM +0000, Quentin Perret wrote:
> On Monday 22 Feb 2021 at 15:58:56 (+0000), Quentin Perret wrote:
> > But in any case, if we're going to address this, I'm still not sure this
> > patch will be what we want. As per my first comment we need to keep the
> > frequency estimation right.
> 
> Totally untested, but I think in principle you would like something like
> the snippet below. Would that work?

You preempted my previous email :)

Yeah, that looks like what we want, I'll give a try.

Thanks,

-- 
Vincent.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce20da67..6594d875c6ac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6534,8 +6534,13 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>          * its pd list and will not be accounted by compute_energy().
>          */
>         for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> -               unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
> +               unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
> +               unsigned long util_running = cpu_util_without(cpu, p);
>                 struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
> +               unsigned long cpu_util;
> +
> +               if (cpu == dst_cpu)
> +                       util_running += task_util_est();
> 
>                 /*
>                  * Busy time computation: utilization clamping is not
> @@ -6543,7 +6548,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * is already enough to scale the EM reported power
>                  * consumption at the (eventually clamped) cpu_capacity.
>                  */
> -               sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +               sum_util += schedutil_cpu_util(cpu, util_running, cpu_cap,
>                                                ENERGY_UTIL, NULL);
> 
>                 /*
> @@ -6553,7 +6558,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  * NOTE: in case RT tasks are running, by default the
>                  * FREQUENCY_UTIL's utilization can be max OPP.
>                  */
> -               cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
> +               cpu_util = schedutil_cpu_util(cpu, util_freq, cpu_cap,
>                                               FREQUENCY_UTIL, tsk);
>                 max_util = max(max_util, cpu_util);
>         }
>



