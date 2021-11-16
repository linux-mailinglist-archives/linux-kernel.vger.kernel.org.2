Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE029453CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhKPXs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhKPXs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637106328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4E5vXamFye8mgOum+Il+2N13pQ7YOT4zlmMq3dnnxo=;
        b=J6jxKggk28/i5npqxYZ59B0Xplc07iuzSCw6S5152zIffR673SK03KSRulP3maFk0HdXDJ
        yh0Ch+jRinYeEYTc19THGva5125JscLARplLSzO/9PBvtIz/SORkYLZf/BW2MLZt/UHJJB
        wdAZKJpwa+6kPnYQ3VxGaBgVFMsNA8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-dvAnFv76NHSIVY1X0vKeWQ-1; Tue, 16 Nov 2021 18:45:25 -0500
X-MC-Unique: dvAnFv76NHSIVY1X0vKeWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF14A1006AA1;
        Tue, 16 Nov 2021 23:45:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB2914104;
        Tue, 16 Nov 2021 23:45:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/4] clocksource: Avoid accidental unstable marking of clocksources
Date:   Tue, 16 Nov 2021 18:44:23 -0500
Message-Id: <20211116234426.837799-2-longman@redhat.com>
In-Reply-To: <20211116234426.837799-1-longman@redhat.com>
References: <20211116234426.837799-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit db3a34e17433 ("clocksource: Retry clock read if long delays
detected") and commit 2e27e793e280 ("clocksource: Reduce clocksource-skew
threshold"), it is found that tsc clocksource fallback to hpet can
sometimes happen on both Intel and AMD systems especially when they are
running stressful benchmarking workloads. Of the 23 systems tested with
a v5.14 kernel, 10 of them have switched to hpet clock source during
the test run.

The result of falling back to hpet is a drastic reduction of performance
when running benchmarks. For example, the fio performance tests can
drop up to 70% whereas the iperf3 performance can drop up to 80%.

4 hpet fallbacks happened during bootup. They were:

  [    8.749399] clocksource: timekeeping watchdog on CPU13: hpet read-back delay of 263750ns, attempt 4, marking unstable
  [   12.044610] clocksource: timekeeping watchdog on CPU19: hpet read-back delay of 186166ns, attempt 4, marking unstable
  [   17.336941] clocksource: timekeeping watchdog on CPU28: hpet read-back delay of 182291ns, attempt 4, marking unstable
  [   17.518565] clocksource: timekeeping watchdog on CPU34: hpet read-back delay of 252196ns, attempt 4, marking unstable

Other fallbacks happen when the systems were running stressful
benchmarks. For example:

  [ 2685.867873] clocksource: timekeeping watchdog on CPU117: hpet read-back delay of 57269ns, attempt 4, marking unstable
  [46215.471228] clocksource: timekeeping watchdog on CPU8: hpet read-back delay of 61460ns, attempt 4, marking unstable

Commit 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold"),
changed the skew margin from 100us to 50us. I think this is too small
and can easily be exceeded when running some stressful workloads on
a thermally stressed system.  So it is switched back to 100us. On
the other hand, it doesn't look like we need to increase the minimum
uncertainty margin. So it is kept the same at 100us too.

Even a maximum skew margin of 100us may be too small in for some systems
when booting up especially if those systems are under thermal stress. To
eliminate the case that the large skew is due to the system being too
busy slowing down the reading of both the watchdog and the clocksource,
an extra consecutive read of watchdog clock is being done to check this.

The consecutive watchdog read delay is compared against
WATCHDOG_MAX_SKEW/2. If the delay exceeds the limit, we assume that
the system is just too busy. A warning will be printed to the console
and the clock skew check is skipped for this round.

Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 58 ++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2fb5ba..a5c2b130adbf 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,7 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
@@ -205,17 +205,24 @@ EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
-static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+enum wd_read_status {
+	WD_READ_SUCCESS,
+	WD_READ_UNSTABLE,
+	WD_READ_SKIP
+};
+
+static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries;
-	u64 wd_end, wd_delta;
-	int64_t wd_delay;
+	u64 wd_end, wd_end2, wd_delta;
+	int64_t wd_delay, wd_seq_delay;
 
 	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
 		wd_end = watchdog->read(watchdog);
+		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
 		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
@@ -226,13 +233,34 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-			return true;
+			return WD_READ_SUCCESS;
 		}
+
+		/*
+		 * Now compute delay in consecutive watchdog read to see if
+		 * there is too much external interferences that cause
+		 * significant delay in reading both clocksource and watchdog.
+		 *
+		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
+		 * report system busy, reinit the watchdog and skip the current
+		 * watchdog test.
+		 */
+		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
+		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+			goto skip_test;
 	}
 
 	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
 		smp_processor_id(), watchdog->name, wd_delay, nretries);
-	return false;
+	return WD_READ_UNSTABLE;
+
+skip_test:
+	pr_warn("timekeeping watchdog on CPU%d: %s wd-wd read-back delay of %lldns\n",
+		smp_processor_id(), watchdog->name, wd_seq_delay);
+	pr_warn("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
+		cs->name, wd_delay);
+	return WD_READ_SKIP;
 }
 
 static u64 csnow_mid;
@@ -356,6 +384,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	enum wd_read_status read_ret;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -373,9 +402,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
-			/* Clock readout unreliable, so give it up. */
-			__clocksource_unstable(cs);
+		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
+
+		if (read_ret != WD_READ_SUCCESS) {
+			if (read_ret == WD_READ_UNSTABLE)
+				/* Clock readout unreliable, so give it up. */
+				__clocksource_unstable(cs);
 			continue;
 		}
 
@@ -1061,7 +1093,7 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 	/*
 	 * If the uncertainty margin is not specified, calculate it.
 	 * If both scale and freq are non-zero, calculate the clock
-	 * period, but bound below at 2*WATCHDOG_MAX_SKEW.  However,
+	 * period, but bound below at WATCHDOG_MAX_SKEW.  However,
 	 * if either of scale or freq is zero, be very conservative and
 	 * take the tens-of-milliseconds WATCHDOG_THRESHOLD value for the
 	 * uncertainty margin.  Allow stupidly small uncertainty margins
@@ -1070,12 +1102,12 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 	 */
 	if (scale && freq && !cs->uncertainty_margin) {
 		cs->uncertainty_margin = NSEC_PER_SEC / (scale * freq);
-		if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
-			cs->uncertainty_margin = 2 * WATCHDOG_MAX_SKEW;
+		if (cs->uncertainty_margin < WATCHDOG_MAX_SKEW)
+			cs->uncertainty_margin = WATCHDOG_MAX_SKEW;
 	} else if (!cs->uncertainty_margin) {
 		cs->uncertainty_margin = WATCHDOG_THRESHOLD;
 	}
-	WARN_ON_ONCE(cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW);
+	WARN_ON_ONCE(cs->uncertainty_margin < WATCHDOG_MAX_SKEW);
 
 	/*
 	 * Ensure clocksources that have large 'mult' values don't overflow
-- 
2.27.0

