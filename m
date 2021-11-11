Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C518644CEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhKKBZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:25:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:27582 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhKKBZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:25:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="212857336"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="212857336"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="452547240"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2021 17:23:01 -0800
Date:   Thu, 11 Nov 2021 09:23:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211111012301.GA15663@shbuild999.sh.intel.com>
References: <20211110221732.272986-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110221732.272986-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman, Paul,

On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
> It was found that when an x86 system was being stressed by running
> various different benchmark suites, the clocksource watchdog might
> occasionally mark TSC as unstable and fall back to hpet which will
> have a signficant impact on system performance.
 
We've seen similar cases while running 'netperf' and 'lockbus/ioport'
cases of 'stress-ng' tool.

In those scenarios, the clocksource used by kernel is tsc, while
hpet is used as watchdog. And when the "screwing" happens, we found
mostly it's the hpet's 'fault', that when system is under extreme
pressure, the read of hpet could take a long time, and even 2
consecutive read of hpet will have a big gap (up to 1ms+) in between.
So the screw we saw is actually caused by hpet instead of tsc, as
tsc read is a lightweight cpu operation

I tried the following patch to detect the screw of watchdog itself,
and avoid wrongly judging the tsc to be unstable. It does help in
our tests, please help to review.

And one futher idea is to also adding 2 consecutive read of current
clocksource, and compare its gap with watchdog's, and skip the check
if the watchdog's is bigger.


From f68c668f19abc77c409795ccc1800de3f4fcfc5a Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Wed, 10 Nov 2021 21:12:10 +0800
Subject: [PATCH RFC] clocksource: add detection for screw of watchdog

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2fb5ba6..6fbef74b0ed74 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -205,34 +205,54 @@ EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
-static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+enum {
+	WATCHDOG_READ_SCREWED,
+	CLOCKSROUCE_READ_SCREWED,
+	BOTH_READ_FINE,
+};
+
+static int cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries;
-	u64 wd_end, wd_delta;
-	int64_t wd_delay;
+	u64 wd_end, wd_delta, wd_third;
+	int64_t wd_delay, wd_seq_delay;
+
 
 	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
 		wd_end = watchdog->read(watchdog);
+		wd_third = watchdog->read(watchdog);
 		local_irq_enable();
 
 		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
+		/*
+		 * If a big delay is seen between 2 consecutive read of watchdog,
+		 * then there must be something wrong with watchdog itself, or
+		 * the system is under some extreme pressures, no need to judge
+		 * clocksource for this run.
+		 */
+		wd_delta = clocksource_delta(wd_third, wd_end, watchdog->mask);
+		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
+						watchdog->shift);
+		if (wd_seq_delay > WATCHDOG_MAX_SKEW / 2)
+			return WATCHDOG_READ_SCREWED;
+
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >= max_cswd_read_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-			return true;
+			return BOTH_READ_FINE;
 		}
 	}
 
 	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
 		smp_processor_id(), watchdog->name, wd_delay, nretries);
-	return false;
+	return CLOCKSROUCE_READ_SCREWED;
 }
 
 static u64 csnow_mid;
@@ -373,10 +393,17 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
+		switch (cs_watchdog_read(cs, &csnow, &wdnow)) {
+		case WATCHDOG_READ_SCREWED:
+			/* skip checking this 'cs' */
+			continue;
+		case CLOCKSROUCE_READ_SCREWED:
 			/* Clock readout unreliable, so give it up. */
 			__clocksource_unstable(cs);
 			continue;
+		case BOTH_READ_FINE:
+		default:
+			;
 		}
 
 		/* Clocksource initialized ? */
-- 
2.27.0

Thanks,
Feng

> The current watchdog clocksource skew threshold of 50us is found to be
> insufficient. So it is changed back to 100us before commit 2e27e793e280
> ("clocksource: Reduce clocksource-skew threshold") in patch 1. Patch 2
> adds a Kconfig option to allow kernel builder to control the actual
> threshold to be used.
> 
> Waiman Long (2):
>   clocksource: Avoid accidental unstable marking of clocksources
>   clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
> 
>  kernel/time/Kconfig       |  9 ++++++
>  kernel/time/clocksource.c | 58 ++++++++++++++++++++++++++++++---------
>  2 files changed, 54 insertions(+), 13 deletions(-)
> 
> -- 
> 2.27.0
