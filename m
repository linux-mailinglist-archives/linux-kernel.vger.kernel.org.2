Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7E362FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhDQMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:24:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:24:51 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618662264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycqw4/W8tL6Zg12m4ow+23zqNrxSJ3NVs+0Fh2DL9ZE=;
        b=FvL4tTfAGJoWj2IVOyuWzf2qwhC9WKT2pggn9XQ1kxeODqX1GmMQBvUoidgkJue+cE1DoV
        m70aoIA6fxKV5qeuWlWnPsVGvjVIZGZHACK/wTKAtUXj5vPpq5JauvueuBC9u+RwsDF8Xd
        xYU9ObjBhxe5yrmJgSc1goNWQW6mzRnCYDgc7hUQl3ns0VanprT/OO0MksdF1usuDr4oXh
        4NUcexTMKC/R7TEQNc2Y9OXPDjos58qz5K2hy9edOPu1Djp09sqnRloCIpUl5Zt3RZmZ4W
        phmw4G2/+usrlceN8e9SIozpeavAhs2B0ybJc12/DFFjJE8Sb+O0Km4Xvb4sBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618662264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycqw4/W8tL6Zg12m4ow+23zqNrxSJ3NVs+0Fh2DL9ZE=;
        b=0v+n3HEbAK5f5nW2WehOrcV3YmFh0Ju1hWnJhnAOGaNiJAcrcEv8s9YhWlzF+c3PJJo74G
        C3I/w7VbsyIVsIDg==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long delays detected
In-Reply-To: <20210414043602.2812981-2-paulmck@kernel.org>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1> <20210414043602.2812981-2-paulmck@kernel.org>
Date:   Sat, 17 Apr 2021 14:24:23 +0200
Message-ID: <87y2dhrte0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13 2021 at 21:35, Paul E. McKenney wrote:
>  #define WATCHDOG_INTERVAL (HZ >> 1)
>  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
> +#define WATCHDOG_MAX_SKEW (NSEC_PER_SEC >> 6)

That's ~15ms which is a tad large I'd say...
  
>  static void clocksource_watchdog_work(struct work_struct *work)
>  {
> @@ -213,9 +214,10 @@ static void clocksource_watchdog_inject_delay(void)
>  static void clocksource_watchdog(struct timer_list *unused)
>  {
>  	struct clocksource *cs;
> -	u64 csnow, wdnow, cslast, wdlast, delta;
> -	int64_t wd_nsec, cs_nsec;
> +	u64 csnow, wdnow, wdagain, cslast, wdlast, delta;
> +	int64_t wd_nsec, wdagain_delta, wderr_nsec = 0, cs_nsec;
>  	int next_cpu, reset_pending;
> +	int nretries;
>  
>  	spin_lock(&watchdog_lock);
>  	if (!watchdog_running)
> @@ -224,6 +226,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>  	reset_pending = atomic_read(&watchdog_reset_pending);
>  
>  	list_for_each_entry(cs, &watchdog_list, wd_list) {
> +		nretries = 0;
>  
>  		/* Clocksource already marked unstable? */
>  		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
> @@ -232,11 +235,24 @@ static void clocksource_watchdog(struct timer_list *unused)
>  			continue;
>  		}
>  
> +retry:
>  		local_irq_disable();
> -		csnow = cs->read(cs);
> -		clocksource_watchdog_inject_delay();
>  		wdnow = watchdog->read(watchdog);
> +		clocksource_watchdog_inject_delay();
> +		csnow = cs->read(cs);
> +		wdagain = watchdog->read(watchdog);
>  		local_irq_enable();
> +		delta = clocksource_delta(wdagain, wdnow, watchdog->mask);
> +		wdagain_delta = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> +		if (wdagain_delta > WATCHDOG_MAX_SKEW) {
> +			wderr_nsec = wdagain_delta;
> +			if (nretries++ < max_read_retries)
> +				goto retry;
> +		}
> +		if (nretries) {
> +			pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d\n",
> +				smp_processor_id(), watchdog->name, wderr_nsec, nretries);
> +		}
>  
>  		/* Clocksource initialized ? */
>  		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||

This can nicely be split out into a read function which avoids brain
overload when reading. Something like the uncompiled below.

I so wish we could just delete all of this horror instead of making it
more horrible.

Thanks,

        tglx
---
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -124,6 +124,12 @@ static void __clocksource_change_rating(
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
 
+/*
+ * The maximum delay between two consecutive readouts of the watchdog
+ * clocksource to detect SMI,NMI,vCPU preemption.
+ */
+#define WATCHDOG_MAX_DELAY (100 * NSEC_PER_USEC)
+
 static void clocksource_watchdog_work(struct work_struct *work)
 {
 	/*
@@ -184,12 +190,37 @@ void clocksource_mark_unstable(struct cl
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
+static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+{
+	unsigned int nretries;
+	u64 wd_end, wd_delta;
+	int64_t wd_delay;
+
+	for (nretries = 0; nretries < max_read_retries; nretries++) {
+		local_irq_disable();
+		*wdnow = watchdog->read(watchdog);
+		clocksource_watchdog_inject_delay();
+		*csnow = cs->read(cs);
+		wd_end = watchdog->read(watchdog);
+		local_irq_enable();
+
+		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
+		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		if (wd_delay < WATCHDOG_MAX_DELAY)
+			return true;
+	}
+
+	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, %d attempts\n",
+		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	return false;
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	struct clocksource *cs;
 	u64 csnow, wdnow, cslast, wdlast, delta;
-	int64_t wd_nsec, cs_nsec;
 	int next_cpu, reset_pending;
+	int64_t wd_nsec, cs_nsec;
+	struct clocksource *cs;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -206,10 +237,14 @@ static void clocksource_watchdog(struct
 			continue;
 		}
 
-		local_irq_disable();
-		csnow = cs->read(cs);
-		wdnow = watchdog->read(watchdog);
-		local_irq_enable();
+		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
+			/*
+			 * No point to continue if the watchdog readout is
+			 * unreliable.
+			 */
+			__clocksource_unstable(cs);
+			continue;
+		}
 
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
