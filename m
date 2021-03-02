Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352332A405
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379131AbhCBKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:05:19 -0500
Received: from foss.arm.com ([217.140.110.172]:47644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577798AbhCBJyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:54:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3430EED1;
        Tue,  2 Mar 2021 01:53:18 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A3EF3F70D;
        Tue,  2 Mar 2021 01:53:15 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <19bfd781-05f7-b220-d8a2-fde8ea2d9959@arm.com>
Date:   Tue, 2 Mar 2021 10:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2021 17:40, Srikar Dronamraju wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..d49bfcdc4a19 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5869,6 +5869,36 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>  	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
>  }
> 
> +static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
> +{
> +	struct sched_domain_shared *tsds, *psds;
> +	int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
> +
> +	tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
> +	tnr_busy = atomic_read(&tsds->nr_busy_cpus);
> +	tllc_size = per_cpu(sd_llc_size, this_cpu);
> +
> +	psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
> +	pnr_busy = atomic_read(&psds->nr_busy_cpus);
> +	pllc_size = per_cpu(sd_llc_size, prev_cpu);
> +
> +	/* No need to compare, if both LLCs are fully loaded */
> +	if (pnr_busy == pllc_size && tnr_busy == pllc_size)

                                                     ^
                                           shouldn't this be tllc_size ?

> +		return nr_cpumask_bits;
> +
> +	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> +		return this_cpu;
> +
> +	/* For better wakeup latency, prefer idler LLC to cache affinity */
> +	diff = tnr_busy * pllc_size - sync - pnr_busy * tllc_size;
> +	if (!diff)
> +		return nr_cpumask_bits;
> +	if (diff < 0)
> +		return this_cpu;
> +
> +	return prev_cpu;
> +}
> +
