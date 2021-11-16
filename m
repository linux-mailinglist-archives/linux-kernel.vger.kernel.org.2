Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C127453CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhKPXsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhKPXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637106338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V34pAhiYl9bqIdNtp8d1cOUoBjtPMl/WaHQBDkGUd+s=;
        b=SrW0nA+Tv4hpd4OQiFBF59NRHeCaxO6Q7KuHdedRnySP5h95cZhPibrCVVr5fD+QKGSlAE
        ov/ZKS5ZTtzQ3nK4ks02AIFB6R/44v6NaHkkegpgT0cOxquW3RsTv09+YInV9mYTgeuJZO
        YbVucZuuk25ZHixLh/fx2j6S+Q+HBZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-HSNuhnrPPmWf4w5Neo2vLQ-1; Tue, 16 Nov 2021 18:45:35 -0500
X-MC-Unique: HSNuhnrPPmWf4w5Neo2vLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFC53802E64;
        Tue, 16 Nov 2021 23:45:33 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FC0814104;
        Tue, 16 Nov 2021 23:45:32 +0000 (UTC)
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
Subject: [PATCH v2 3/4] clocksource: Dynamically increase watchdog_max_skew
Date:   Tue, 16 Nov 2021 18:44:25 -0500
Message-Id: <20211116234426.837799-4-longman@redhat.com>
In-Reply-To: <20211116234426.837799-1-longman@redhat.com>
References: <20211116234426.837799-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that a long-lasting intensive workload running on
a system may cause the clock skew test to be skipped for extended
period of time. One way to avoid this is to dynamically increase the
watchdog_max_skew used in the clock skew test.

However, we also don't want watchdog_max_skew to be continuously increased
without bound. So we limit the increase up to 10*WATCHDOG_MAX_SKEW. If
that happens, there is something wrong the current watchdog and we are
going to mark it as unstable and select a new watchdog, if possible.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a7814b543a9b..b1813b09fe9b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -108,6 +108,15 @@ static u64 suspend_start;
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
 #define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+static u64 watchdog_max_skew = WATCHDOG_MAX_SKEW;
+
+/*
+ * The clock-skew check will be skipped if the watchdog shows too much
+ * read-back delay. To avoid indefinite test skips, watchdog_max_skew will be
+ * increased after a certain number of test skips.
+ */
+#define CLOCK_SKEW_SKIP_MAX	10
+static int clock_skew_skip;
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
@@ -205,6 +214,8 @@ EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
+static void __clocksource_select_watchdog(bool fallback);
+
 enum wd_read_status {
 	WD_READ_SUCCESS,
 	WD_READ_UNSTABLE,
@@ -228,7 +239,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
-		if (wd_delay <= WATCHDOG_MAX_SKEW) {
+		if (wd_delay <= watchdog_max_skew) {
 			if (nretries > 1 || nretries >= max_cswd_read_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
@@ -241,13 +252,13 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		 * there is too much external interferences that cause
 		 * significant delay in reading both clocksource and watchdog.
 		 *
-		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
+		 * If consecutive WD read-back delay > watchdog_max_skew/2,
 		 * report system busy, reinit the watchdog and skip the current
 		 * watchdog test.
 		 */
 		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
 		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
-		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+		if (wd_seq_delay > watchdog_max_skew/2)
 			goto skip_test;
 	}
 
@@ -260,6 +271,36 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		smp_processor_id(), watchdog->name, wd_seq_delay);
 	pr_warn("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
 		cs->name, wd_delay);
+	if (++clock_skew_skip > CLOCK_SKEW_SKIP_MAX) {
+		/*
+		 * Increase watchdog_max_skew and watchdog->uncertainty_margin
+		 * unless it will exceed 10*WATCHDOG_MAX_SKEW. In that case, the
+		 * watchdog itself will be marked unstable.
+		 */
+		clock_skew_skip = 0;
+		if (wd_seq_delay > 5 * WATCHDOG_MAX_SKEW) {
+			const char *old_wd_name = watchdog->name;
+			unsigned long flags;
+
+			/*
+			 * Consecutive watchdog delay exceed limit, mark
+			 * watchdog as unstable & select a new watchdog,
+			 * if possible.
+			 */
+			local_irq_save(flags);
+			__clocksource_unstable(watchdog);
+			__clocksource_select_watchdog(true);
+			local_irq_restore(flags);
+			pr_warn("timekeeping watchdog: old %s watchdog marked unstable, new %s watchdog selected\n",
+				old_wd_name, watchdog->name);
+			return WD_READ_SKIP;
+		}
+		watchdog_max_skew = 2 * wd_seq_delay;
+		if (wd_seq_delay > watchdog->uncertainty_margin)
+			watchdog->uncertainty_margin = wd_seq_delay;
+		pr_warn("timekeeping watchdog on CPU%d: watchdog_max_skew increased to %lldns\n",
+			smp_processor_id(), watchdog_max_skew);
+	}
 	return WD_READ_SKIP;
 }
 
@@ -559,12 +600,10 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 	}
 }
 
-static void clocksource_select_watchdog(bool fallback)
+static void __clocksource_select_watchdog(bool fallback)
 {
 	struct clocksource *cs, *old_wd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&watchdog_lock, flags);
 	/* save current watchdog */
 	old_wd = watchdog;
 	if (fallback)
@@ -593,6 +632,14 @@ static void clocksource_select_watchdog(bool fallback)
 
 	/* Check if the watchdog timer needs to be started. */
 	clocksource_start_watchdog();
+}
+
+static void clocksource_select_watchdog(bool fallback)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&watchdog_lock, flags);
+	__clocksource_select_watchdog(fallback);
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-- 
2.27.0

