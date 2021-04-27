Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062C036BCFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhD0Bpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:45:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:19481 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232295AbhD0Bpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:45:44 -0400
IronPort-SDR: j/YlA/hh+RXXp9keLcCDxxts+aEylB/V5Ipwx2dZVfHtvi/deG9IEfAL+gIMxmmaGX9Rf/g884
 jEFmzc6MnTCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196492304"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="196492304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 18:45:00 -0700
IronPort-SDR: MOp/4ktbWsbAsLpIgmlev+gWto9RmxGhPEOPlr31Q8Z87FlzrLdOJsB8UcsCsHWk6wxqh59oCG
 VblXyEvnBm7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="429613745"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 26 Apr 2021 18:44:56 -0700
Date:   Tue, 27 Apr 2021 09:44:55 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 2/7] clocksource: Retry clock read if
 long delays detected
Message-ID: <20210427014455.GD89018@shbuild999.sh.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425224709.1312655-2-paulmck@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 03:47:03PM -0700, Paul E. McKenney wrote:
> When the clocksource watchdog marks a clock as unstable, this might
> be due to that clock being unstable or it might be due to delays that
> happen to occur between the reads of the two clocks.  Yes, interrupts are
> disabled across those two reads, but there are no shortage of things that
> can delay interrupts-disabled regions of code ranging from SMI handlers
> to vCPU preemption.  It would be good to have some indication as to why
> the clock was marked unstable.
> 
> Therefore, re-read the watchdog clock on either side of the read
> from the clock under test.  If the watchdog clock shows an excessive
> time delta between its pair of reads, the reads are retried.  The
> maximum number of retries is specified by a new kernel boot parameter
> clocksource.max_read_retries, which defaults to three, that is, up to four
> reads, one initial and up to three retries.  If more than one retry was
> required, a message is printed on the console (the occasional single retry
> is expected behavior, especially in guest OSes).  If the maximum number
> of retries is exceeded, the clock under test will be marked unstable.
> However, the probability of this happening due to various sorts of
> delays is quite small.  In addition, the reason (clock-read delays)
> for the unstable marking will be apparent.
 
I think this will help to filter some false alarms of unstable
cases, thanks!

Acked-by: Feng Tang <feng.tang@intel.com>

> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Reported-by: Chris Mason <clm@fb.com>
> [ paulmck: Per-clocksource retries per Neeraj Upadhyay feedback. ]
> [ paulmck: Don't reset injectfail per Neeraj Upadhyay feedback. ]
> [ paulmck: Apply Thomas Gleixner feedback. ]
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  kernel/time/clocksource.c                     | 53 ++++++++++++++++---
>  2 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4a372037b49f..7fff95bd5504 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -599,6 +599,12 @@
>  			will be five delay-free reads followed by three
>  			delayed reads.
>  
> +	clocksource.max_read_retries= [KNL]
> +			Number of clocksource_watchdog() retries due to
> +			external delays before the clock will be marked
> +			unstable.  Defaults to three retries, that is,
> +			four attempts to read the clock under test.
> +
>  	clearcpuid=BITNUM[,BITNUM...] [X86]
>  			Disable CPUID feature X for the kernel. See
>  			arch/x86/include/asm/cpufeatures.h for the valid bit
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index f1e1e6e4b387..94bfdb53f2f4 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -125,6 +125,13 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>  #define WATCHDOG_INTERVAL (HZ >> 1)
>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
>  
> +/*
> + * Maximum permissible delay between two readouts of the watchdog
> + * clocksource surrounding a read of the clocksource being validated.
> + * This delay could be due to SMIs, NMIs, or to VCPU preemptions.
> + */
> +#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
> +
>  static void clocksource_watchdog_work(struct work_struct *work)
>  {
>  	/*
> @@ -189,6 +196,8 @@ static ulong inject_delay_period;
>  module_param(inject_delay_period, ulong, 0644);
>  static ulong inject_delay_repeat = 1;
>  module_param(inject_delay_repeat, ulong, 0644);
> +static ulong max_read_retries = 3;
> +module_param(max_read_retries, ulong, 0644);
>  
>  static void clocksource_watchdog_inject_delay(void)
>  {
> @@ -206,12 +215,42 @@ static void clocksource_watchdog_inject_delay(void)
>  	invocations++;
>  }
>  
> +static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> +{
> +	unsigned int nretries;
> +	u64 wd_end, wd_delta;
> +	int64_t wd_delay;
> +
> +	for (nretries = 0; nretries <= max_read_retries; nretries++) {
> +		local_irq_disable();
> +		*wdnow = watchdog->read(watchdog);
> +		clocksource_watchdog_inject_delay();
> +		*csnow = cs->read(cs);
> +		wd_end = watchdog->read(watchdog);
> +		local_irq_enable();
> +
> +		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
> +		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
> +		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> +			if (nretries > 1 || nretries >= max_read_retries) {
> +				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> +					smp_processor_id(), watchdog->name, nretries);
> +			}
> +			return true;
> +		}
> +	}
> +
> +	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
> +		smp_processor_id(), watchdog->name, wd_delay, nretries);
> +	return false;
> +}
> +
>  static void clocksource_watchdog(struct timer_list *unused)
>  {
> -	struct clocksource *cs;
>  	u64 csnow, wdnow, cslast, wdlast, delta;
> -	int64_t wd_nsec, cs_nsec;
>  	int next_cpu, reset_pending;
> +	int64_t wd_nsec, cs_nsec;
> +	struct clocksource *cs;
>  
>  	spin_lock(&watchdog_lock);
>  	if (!watchdog_running)
> @@ -228,11 +267,11 @@ static void clocksource_watchdog(struct timer_list *unused)
>  			continue;
>  		}
>  
> -		local_irq_disable();
> -		csnow = cs->read(cs);
> -		clocksource_watchdog_inject_delay();
> -		wdnow = watchdog->read(watchdog);
> -		local_irq_enable();
> +		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
> +			/* Clock readout unreliable, so give it up. */
> +			__clocksource_unstable(cs);
> +			continue;
> +		}
>  
>  		/* Clocksource initialized ? */
>  		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> -- 
> 2.31.1.189.g2e36527f23
