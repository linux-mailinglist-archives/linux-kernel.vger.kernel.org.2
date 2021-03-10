Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB39B333D43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhCJNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhCJNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:04:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54047C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1GVA14YASE/pj8ef7Uy3SoORMgzS/l5NBqDogUwl8Wg=; b=OkqOvhSc9bL1+TdOIf/t0NFGXF
        4ZFCx9pYH69TXHb8I78nxtx8XHPaTf05feEPaQ5MrUwAXhCZR94Usmws59BK9fDwXpYyTB/zi7GfG
        FxIgPDkgO0ttZ1vSmRlhjcsB34nM47TugVLgpCXB3iLwfT6v6+EBXmcmE3q0mnT04yRT+vXZPJwdK
        7ENX+mJD/C1BDqIZCbSc49wP6436ZDODI7RBmhEzPB/4Rqn9uYSPwzeEngsCrPf7mjuH1pvKaaKR7
        y+ldCcqmJryIljVuFXxuPo+aOz/QYgMnHrckq1bS1aS8ZpFB6YYKsfukcUEpOi7MilS0Iohdkxts6
        LayxZtNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJyVf-003UDO-Ry; Wed, 10 Mar 2021 13:04:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE7683013E5;
        Wed, 10 Mar 2021 14:04:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB216206936C5; Wed, 10 Mar 2021 14:04:08 +0100 (CET)
Date:   Wed, 10 Mar 2021 14:04:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 2/4] sched/fair: Make CFS bandwidth controller
 burstable
Message-ID: <YEjDyADiVjVyt3ur@hirez.programming.kicks-ass.net>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210121110453.18899-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121110453.18899-3-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:04:51PM +0800, Huaixin Chang wrote:
> Accumulate unused quota from previous periods, thus accumulated
> bandwidth runtime can be used in the following periods. During
> accumulation, take care of runtime overflow. Previous non-burstable
> CFS bandwidth controller only assign quota to runtime, that saves a lot.
> 
> A sysctl parameter sysctl_sched_cfs_bw_burst_onset_percent is introduced to
> denote how many percent of burst is given on setting cfs bandwidth. By
> default it is 0, which means on burst is allowed unless accumulated.
> 
> Also, parameter sysctl_sched_cfs_bw_burst_enabled is introduced as a
> switch for burst. It is enabled by default.
> 
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>

Identical invalid SoB chain.

> Reported-by: kernel test robot <lkp@intel.com>

What exactly did the robot report; the whole patch?

> ---
>  include/linux/sched/sysctl.h |  2 ++
>  kernel/sched/core.c          | 31 +++++++++++++++++++++++++----
>  kernel/sched/fair.c          | 47 ++++++++++++++++++++++++++++++++++++--------
>  kernel/sched/sched.h         |  4 ++--
>  kernel/sysctl.c              | 18 +++++++++++++++++
>  5 files changed, 88 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 3c31ba88aca5..3400828eaf2d 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -72,6 +72,8 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
>  extern unsigned int sysctl_sched_cfs_bandwidth_slice;
> +extern unsigned int sysctl_sched_cfs_bw_burst_onset_percent;
> +extern unsigned int sysctl_sched_cfs_bw_burst_enabled;
>  #endif
>  
>  #ifdef CONFIG_SCHED_AUTOGROUP
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 48d3bad12be2..fecf0f05ef0c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -66,6 +66,16 @@ const_debug unsigned int sysctl_sched_features =
>   */
>  const_debug unsigned int sysctl_sched_nr_migrate = 32;
>  
> +#ifdef CONFIG_CFS_BANDWIDTH
> +/*
> + * Percent of burst assigned to cfs_b->runtime on tg_set_cfs_bandwidth,
> + * 0 by default.
> + */
> +unsigned int sysctl_sched_cfs_bw_burst_onset_percent;
> +
> +unsigned int sysctl_sched_cfs_bw_burst_enabled = 1;
> +#endif

There's already an #ifdef block that contains that bandwidth_slice
thing, see the previous hunk, so why create a new #ifdef here?

Also, personally I think percentages are over-represented as members of
Q.

> @@ -7891,7 +7901,7 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
>  const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
>  static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
>  /* More than 203 days if BW_SHIFT equals 20. */
> -static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
> +const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
>  
>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>  
> @@ -7900,7 +7910,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  {
>  	int i, ret = 0, runtime_enabled, runtime_was_enabled;
>  	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
> -	u64 buffer;
> +	u64 buffer, burst_onset;
>  
>  	if (tg == &root_task_group)
>  		return -EINVAL;
> @@ -7961,11 +7971,24 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  	cfs_b->burst = burst;
>  	cfs_b->buffer = buffer;
>  
> -	__refill_cfs_bandwidth_runtime(cfs_b);
> +	cfs_b->max_overrun = DIV_ROUND_UP_ULL(max_cfs_runtime, quota);
> +	cfs_b->runtime = cfs_b->quota;
> +
> +	/* burst_onset needed */
> +	if (cfs_b->quota != RUNTIME_INF &&
> +			sysctl_sched_cfs_bw_burst_enabled &&
> +			sysctl_sched_cfs_bw_burst_onset_percent > 0) {

'creative' indentation again...

Also, this gives rise to the question as to why onset_percent is
separate from enabled.

> +
> +		burst_onset = do_div(burst, 100) *
> +			sysctl_sched_cfs_bw_burst_onset_percent;

and again..

> +
> +		cfs_b->runtime += burst_onset;
> +		cfs_b->runtime = min(max_cfs_runtime, cfs_b->runtime);
> +	}
>  
>  	/* Restart the period timer (if active) to handle new period expiry: */
>  	if (runtime_enabled)
> -		start_cfs_bandwidth(cfs_b);
> +		start_cfs_bandwidth(cfs_b, 1);
>  
>  	raw_spin_unlock_irq(&cfs_b->lock);
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6bb4f89259fd..abe6eb05fe09 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4598,10 +4598,23 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>   *
>   * requires cfs_b->lock
>   */
> -void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
> +static void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b,
> +		u64 overrun)
>  {
> -	if (cfs_b->quota != RUNTIME_INF)
> -		cfs_b->runtime = cfs_b->quota;
> +	u64 refill;
> +
> +	if (cfs_b->quota != RUNTIME_INF) {
> +
> +		if (!sysctl_sched_cfs_bw_burst_enabled) {
> +			cfs_b->runtime = cfs_b->quota;
> +			return;
> +		}
> +
> +		overrun = min(overrun, cfs_b->max_overrun);
> +		refill = cfs_b->quota * overrun;
> +		cfs_b->runtime += refill;
> +		cfs_b->runtime = min(cfs_b->runtime, cfs_b->buffer);
> +	}
>  }
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4623,7 +4636,7 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
>  	if (cfs_b->quota == RUNTIME_INF)
>  		amount = min_amount;
>  	else {
> -		start_cfs_bandwidth(cfs_b);
> +		start_cfs_bandwidth(cfs_b, 0);
>  
>  		if (cfs_b->runtime > 0) {
>  			amount = min(cfs_b->runtime, min_amount);
> @@ -4957,7 +4970,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
>  	if (cfs_b->idle && !throttled)
>  		goto out_deactivate;
>  
> -	__refill_cfs_bandwidth_runtime(cfs_b);
> +	__refill_cfs_bandwidth_runtime(cfs_b, overrun);
>  
>  	if (!throttled) {
>  		/* mark as potentially idle for the upcoming period */
> @@ -5181,6 +5194,7 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  }
>  
>  extern const u64 max_cfs_quota_period;
> +extern const u64 max_cfs_runtime;
>  
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
> @@ -5210,7 +5224,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  			new = old * 2;
>  			if (new < max_cfs_quota_period) {
>  				cfs_b->period = ns_to_ktime(new);
> -				cfs_b->quota *= 2;
> +				cfs_b->quota = min(cfs_b->quota * 2,
> +						max_cfs_runtime);

again, broken indent

> +
> +				cfs_b->buffer = min(max_cfs_runtime,
> +						cfs_b->quota + cfs_b->burst);

and again..

> +				/* Add 1 in case max_overrun becomes 0. */

A better comment would explain *why* 0 is a problem; and possibly
include a reference to the code that cares
(__refill_cfs_bandiwdth_runtime() afaict).

> +				cfs_b->max_overrun >>= 1;
> +				cfs_b->max_overrun++;
>  
>  				pr_warn_ratelimited(
>  	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
