Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37136C118
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhD0Iim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhD0Iik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16812C061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 01:37:57 -0700 (PDT)
Message-Id: <20210427083724.180273544@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c8gw/KnmQDuk7AqqMWZdyc8tDsYLFVxxbHgZhWkFy5M=;
        b=TIPomGBzP/OtPRR8eQOQSY/iCEP+QXlfDhIHeuWo0qaSRNisVb0h9h26mDLUuxOi7omKrR
        BHiK21cuPQU+0antq9cwkU2Cq1PJfzKqgGqzgy6YScdXQFd0hGpPxBH8zxfLrDlsSENqo8
        VcAfsjnjg1o5SpPYQRicJYmotnhvJBxta5p97oMDDimVqkCb2lIXKF1g6Yk+d42/oyeiHf
        BnwJz3zM+MsdNcvkJijr/FbZprozs94FZ+5+wG5fiGUPM3B4h7NsXGIbJkuDYmd5xiXoAz
        EdfYhg6X6BCDujlYEs1JwwZ0Cyiwj7k3mi/jhPvH8dGqMdGmzbQP1ENHvAwkdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c8gw/KnmQDuk7AqqMWZdyc8tDsYLFVxxbHgZhWkFy5M=;
        b=sXqKkKtY3IsSKCF8w7xs5GLTdP2O8g4z/FN1p/N7XLtcKH3DECjAOuf69hmPIcou6de6SH
        BXm/QGO3p9tLXlBQ==
Date:   Tue, 27 Apr 2021 10:25:39 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [patch 2/8] hrtimer: Force clock_was_set() handling for the
 HIGHRES=n, NOHZ=y case
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HIGH_RES_TIMERS is disabled, but NOHZ is enabled then
clock_was_set() is not doing anything. With HIGHRES=n the kernel relies on
the periodic tick to update the clock offsets, but when NOHZ is enabled and
active then CPUs which are in a deep idle sleep do not have a periodic tick
which means the expiry of timers affected by clock_was_set() can be
arbitrarily delayed up to the point where the CPUs are brought out of idle
again.

Make the clock_was_set() logic unconditionaly available so that idle CPUs
are kicked out of idle to handle the update.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |   87 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 28 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -720,23 +720,7 @@ static inline int hrtimer_is_hres_enable
 	return hrtimer_hres_enabled;
 }
 
-/*
- * Retrigger next event is called after clock was set
- *
- * Called with interrupts disabled via on_each_cpu()
- */
-static void retrigger_next_event(void *arg)
-{
-	struct hrtimer_cpu_base *base = this_cpu_ptr(&hrtimer_bases);
-
-	if (!__hrtimer_hres_active(base))
-		return;
-
-	raw_spin_lock(&base->lock);
-	hrtimer_update_base(base);
-	hrtimer_force_reprogram(base, 0);
-	raw_spin_unlock(&base->lock);
-}
+static void retrigger_next_event(void *arg);
 
 /*
  * Switch to high resolution mode
@@ -762,9 +746,50 @@ static void hrtimer_switch_to_hres(void)
 
 static inline int hrtimer_is_hres_enabled(void) { return 0; }
 static inline void hrtimer_switch_to_hres(void) { }
-static inline void retrigger_next_event(void *arg) { }
 
 #endif /* CONFIG_HIGH_RES_TIMERS */
+/*
+ * Retrigger next event is called after clock was set with interrupts
+ * disabled through an SMP function call or directly from low level
+ * resume code.
+ *
+ * This is only invoked when:
+ *	- CONFIG_HIGH_RES_TIMERS is enabled.
+ *	- CONFIG_NOHZ_COMMON is enabled
+ *
+ * For the other cases this function is empty and because the call sites
+ * are optimized out it vanishes as well, i.e. no need for lots of
+ * #ifdeffery.
+ */
+static void retrigger_next_event(void *arg)
+{
+	struct hrtimer_cpu_base *base = this_cpu_ptr(&hrtimer_bases);
+
+	/*
+	 * When high resolution mode or nohz is active, then the offsets of
+	 * CLOCK_REALTIME/TAI/BOOTTIME have to be updated. Otherwise the
+	 * next tick will take care of that.
+	 *
+	 * If high resolution mode is active then the next expiring timer
+	 * must be reevaluated and the clock event device reprogrammed if
+	 * necessary.
+	 *
+	 * In the NOHZ case the update of the offset and the reevaluation
+	 * of the next expiring timer is enough. The return from the SMP
+	 * function call will take care of the reprogramming in case the
+	 * CPU was in a NOHZ idle sleep.
+	 */
+	if (!__hrtimer_hres_active(base) && !tick_nohz_active)
+		return;
+
+	raw_spin_lock(&base->lock);
+	hrtimer_update_base(base);
+	if (__hrtimer_hres_active(base))
+		hrtimer_force_reprogram(base, 0);
+	else
+		hrtimer_update_next_event(base);
+	raw_spin_unlock(&base->lock);
+}
 
 /*
  * When a timer is enqueued and expires earlier than the already enqueued
@@ -856,22 +881,28 @@ static void hrtimer_reprogram(struct hrt
 }
 
 /*
- * Clock realtime was set
- *
- * Change the offset of the realtime clock vs. the monotonic
- * clock.
+ * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
+ * CLOCK_BOOTTIME (for late sleep time injection).
  *
- * We might have to reprogram the high resolution timer interrupt. On
- * SMP we call the architecture specific code to retrigger _all_ high
- * resolution timer interrupts. On UP we just disable interrupts and
- * call the high resolution interrupt code.
+ * This requires to update the offsets for these clocks
+ * vs. CLOCK_MONOTONIC. When high resolution timers are enabled, then this
+ * also requires to eventually reprogram the per CPU clock event devices
+ * when the change moves an affected timer ahead of the first expiring
+ * timer on that CPU. Obviously remote per CPU clock event devices cannot
+ * be reprogrammed. The other reason why an IPI has to be sent is when the
+ * system is in !HIGH_RES and NOHZ mode. The NOHZ mode updates the offsets
+ * in the tick, which obviously might be stopped, so this has to bring out
+ * the remote CPU which might sleep in idle to get this sorted.
  */
 void clock_was_set(void)
 {
-#ifdef CONFIG_HIGH_RES_TIMERS
+	if (!hrtimer_hres_active() && !tick_nohz_active)
+		goto out_timerfd;
+
 	/* Retrigger the CPU local events everywhere */
 	on_each_cpu(retrigger_next_event, NULL, 1);
-#endif
+
+out_timerfd:
 	timerfd_clock_was_set();
 }
 

