Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6807F3DD425
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhHBKpJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Aug 2021 06:45:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7914 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhHBKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:45:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GdZKv1czSz82xy;
        Mon,  2 Aug 2021 18:41:07 +0800 (CST)
Received: from dggema771-chm.china.huawei.com (10.1.198.213) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:44:56 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema771-chm.china.huawei.com (10.1.198.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:44:56 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Mon, 2 Aug 2021 18:44:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH 7/9] sched/fair:
Thread-Topic: [PATCH 7/9] sched/fair:
Thread-Index: AdeHithpk+6MoH1nReOqdrhhcPaNRwAAAg3A
Date:   Mon, 2 Aug 2021 10:44:56 +0000
Message-ID: <15338f545c08409eb4b73af9c5d7d5aa@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mel Gorman [mailto:mgorman@techsingularity.net]
> Sent: Monday, July 26, 2021 10:23 PM
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>;
> Vincent Guittot <vincent.guittot@linaro.org>; Valentin Schneider
> <valentin.schneider@arm.com>; Aubrey Li <aubrey.li@linux.intel.com>; Mel
> Gorman <mgorman@techsingularity.net>
> Subject: [PATCH 7/9] sched/fair:
> 
> When scanning for a single CPU, the scan is limited based on the estimated
> average idle time for a domain to reduce the risk that more time is spent
> scanning for idle CPUs than we are idle for.
> 
> With SMT, if an idle core is expected to exist there is no scan depth
> limits so the scan depth may or may not be related to average idle time.
> Unfortunately has_idle_cores can be very inaccurate when workloads are
> rapidly entering/exiting idle (e.g. hackbench).
> 
> As the scan depth is now proportional to cores and not CPUs, enforce
> SIS_PROP for idle core scans.
> 
> The performance impact of this is variable and is neither a universal
> gain nor loss. In some cases, has_idle_cores will be cleared prematurely
> because the whole domain was not scanned but has_idle_cores is already
> known to be an inaccurate heuristic. There is also additional cost because
> time calculations are made even for an idle core scan and the delta is
> calculated for both scan successes and failures. Finally, SMT siblings
> may be used prematurely due to scan depth limitations.
> 
> On the flip side, scan depth is now consistent for both core and smt
> scans. The reduction in scan depth improves performance in some cases
> and wakeup latency is reduced in some cases.
> 
> There were few changes identified in the SIS statistics but notably,
> "SIS Core Hit" was slightly reduced in tbench as thread counts increased,
> presumably due to the core search depth being throttled.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 20b9255ebf97..b180205e6b25 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6232,7 +6232,7 @@ static int select_idle_cpu(struct task_struct *p, struct
> sched_domain *sd, bool
> 
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> 
> -	if (sched_feat(SIS_PROP) && !has_idle_core) {
> +	if (sched_feat(SIS_PROP)) {
>  		u64 avg_cost, avg_idle, span_avg;
>  		unsigned long now = jiffies;
> 
> @@ -6265,30 +6265,35 @@ static int select_idle_cpu(struct task_struct *p, struct
> sched_domain *sd, bool
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>  			if ((unsigned int)i < nr_cpumask_bits)
> -				return i;
> +				break;
> 
> +			nr -= sched_smt_weight;
>  		} else {
> -			if (!--nr)
> -				return -1;
>  			idle_cpu = __select_idle_cpu(cpu, p);
>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
>  				break;
> +			nr--;
>  		}
> +
> +		if (nr < 0)
> +			break;
>  	}
> 
> -	if (has_idle_core)
> -		set_idle_cores(target, false);
> +	if ((unsigned int)idle_cpu < nr_cpumask_bits) {
> +		if (has_idle_core)
> +			set_idle_cores(target, false);

For example, if we have 16 cpus(8 SMT2 cores). In case core7 is idle,
we only have scanned core0+core1(cpu0-cpu3) and if these two cores
are not idle, but here we set has_idle_cores to false while core7 is
idle. It seems incorrect.

> 
> -	if (sched_feat(SIS_PROP) && !has_idle_core) {
> -		time = cpu_clock(this) - time;
> +		if (sched_feat(SIS_PROP)) {
> +			time = cpu_clock(this) - time;
> 
> -		/*
> -		 * Account for the scan cost of wakeups against the average
> -		 * idle time.
> -		 */
> -		this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> +			/*
> +			 * Account for the scan cost of wakeups against the average
> +			 * idle time.
> +			 */
> +			this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> 
> -		update_avg(&this_sd->avg_scan_cost, time);
> +			update_avg(&this_sd->avg_scan_cost, time);
> +		}
>  	}
> 
>  	return idle_cpu;
> --
> 2.26.2

Thanks
Barry

