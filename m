Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8F4588AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhKVFFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:05:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:7310 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKVFFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:05:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="221604288"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; 
   d="scan'208";a="221604288"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 21:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; 
   d="scan'208";a="496725351"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 21 Nov 2021 21:02:25 -0800
Date:   Mon, 22 Nov 2021 13:02:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 3/4] clocksource: Dynamically increase
 watchdog_max_skew
Message-ID: <20211122050224.GH34844@shbuild999.sh.intel.com>
References: <20211118191439.1000012-1-longman@redhat.com>
 <20211118191439.1000012-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118191439.1000012-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:14:38PM -0500, Waiman Long wrote:
> It is possible that a long-lasting intensive workload running on
> a system may cause the clock skew test to be skipped for extended
> period of time. One way to avoid this is to dynamically increase the
> watchdog_max_skew used in the clock skew test.
> 
> However, we also don't want watchdog_max_skew to be continuously increased
> without bound. So we limit the increase up to 10*WATCHDOG_MAX_SKEW. If
> that happens, there is something wrong the current watchdog and we are
> going to mark it as unstable and select a new watchdog, if possible.
 
For reselecting watchdog, in these cases, I think it's the extreme system
stress causing the MMIO read of hpet to be slow (plus some lock), fallback
to other watchdog whose read is MMIO or ioport may not help much. I tried
this patch, and when "acpi_pm" timer is used instead of "hpet", similar
thing can still happen.

Thanks,
Feng

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/clocksource.h |  1 +
>  kernel/time/clocksource.c   | 57 +++++++++++++++++++++++++++++++++----
>  2 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b17327..6a62a1a4da85 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -108,6 +108,7 @@ struct clocksource {
>  	const char		*name;
>  	struct list_head	list;
>  	int			rating;
> +	int			clock_skew_skipcnt;
>  	enum clocksource_ids	id;
>  	enum vdso_clock_mode	vdso_clock_mode;
>  	unsigned long		flags;
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index b7e52a642948..284910b07f0c 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -108,6 +108,14 @@ static u64 suspend_start;
>   * a lower bound for cs->uncertainty_margin values when registering clocks.
>   */
>  #define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
> +static u64 watchdog_max_skew = WATCHDOG_MAX_SKEW;
> +
> +/*
> + * The clock-skew check will be skipped if the watchdog shows too much
> + * read-back delay. To avoid indefinite test skips, watchdog_max_skew will be
> + * increased after a certain number of test skips.
> + */
> +#define CLOCK_SKEW_SKIP_MAX	10
>  
>  #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
>  static void clocksource_watchdog_work(struct work_struct *work);
> @@ -205,6 +213,8 @@ EXPORT_SYMBOL_GPL(max_cswd_read_retries);
>  static int verify_n_cpus = 8;
>  module_param(verify_n_cpus, int, 0644);
>  
> +static void __clocksource_select_watchdog(bool fallback);
> +
>  enum wd_read_status {
>  	WD_READ_SUCCESS,
>  	WD_READ_UNSTABLE,
> @@ -228,7 +238,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
>  		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
>  					      watchdog->shift);
> -		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> +		if (wd_delay <= watchdog_max_skew) {
>  			if (nretries > 1 || nretries >= max_cswd_read_retries) {
>  				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
>  					smp_processor_id(), watchdog->name, nretries);
> @@ -241,13 +251,13 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  		 * there is too much external interferences that cause
>  		 * significant delay in reading both clocksource and watchdog.
>  		 *
> -		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
> +		 * If consecutive WD read-back delay > watchdog_max_skew/2,
>  		 * report system busy, reinit the watchdog and skip the current
>  		 * watchdog test.
>  		 */
>  		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
>  		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
> -		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
> +		if (wd_seq_delay > watchdog_max_skew/2)
>  			goto skip_test;
>  	}
>  
> @@ -260,6 +270,35 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  		smp_processor_id(), watchdog->name, wd_seq_delay);
>  	pr_info("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
>  		cs->name, wd_delay);
> +	if (++watchdog->clock_skew_skipcnt > CLOCK_SKEW_SKIP_MAX) {
> +		/*
> +		 * Increase watchdog_max_skew and watchdog->uncertainty_margin
> +		 * unless it will exceed 10*WATCHDOG_MAX_SKEW. In that case, the
> +		 * watchdog itself will be marked unstable.
> +		 */
> +		watchdog->clock_skew_skipcnt = 0;
> +		if (wd_seq_delay > 5 * WATCHDOG_MAX_SKEW) {
> +			const char *old_wd_name = watchdog->name;
> +
> +			/*
> +			 * Consecutive watchdog delay exceed limit, mark
> +			 * watchdog as unstable & select a new watchdog,
> +			 * if possible.
> +			 */
> +			local_irq_disable();
> +			__clocksource_unstable(watchdog);
> +			__clocksource_select_watchdog(true);
> +			local_irq_enable();
> +			pr_warn("timekeeping watchdog: old %s watchdog marked unstable, new %s watchdog selected\n",
> +				old_wd_name, watchdog->name);
> +			return WD_READ_SKIP;
> +		}
> +		watchdog_max_skew = 2 * wd_seq_delay;
> +		if (wd_seq_delay > watchdog->uncertainty_margin)
> +			watchdog->uncertainty_margin = wd_seq_delay;
> +		pr_warn("timekeeping watchdog on CPU%d: watchdog_max_skew increased to %lldns\n",
> +			smp_processor_id(), watchdog_max_skew);
> +	}
>  	return WD_READ_SKIP;
>  }
>  
> @@ -559,12 +598,10 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
>  	}
>  }
>  
> -static void clocksource_select_watchdog(bool fallback)
> +static void __clocksource_select_watchdog(bool fallback)
>  {
>  	struct clocksource *cs, *old_wd;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&watchdog_lock, flags);
>  	/* save current watchdog */
>  	old_wd = watchdog;
>  	if (fallback)
> @@ -593,6 +630,14 @@ static void clocksource_select_watchdog(bool fallback)
>  
>  	/* Check if the watchdog timer needs to be started. */
>  	clocksource_start_watchdog();
> +}
> +
> +static void clocksource_select_watchdog(bool fallback)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&watchdog_lock, flags);
> +	__clocksource_select_watchdog(fallback);
>  	spin_unlock_irqrestore(&watchdog_lock, flags);
>  }
>  
> -- 
> 2.27.0
