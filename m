Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A643A3C7187
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhGMN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbhGMN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32BEC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:54:28 -0700 (PDT)
Message-Id: <20210713135158.288697903@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=DuOTPpKUPNVXkcp5O8JN+0U1iVYL9forzh2/KrTRKdw=;
        b=WH8A+nj6lIbSvJWsVzYJ2hL8zWIT0dcSLDgjJLoZd0JTbwU8sATB1swNx1V72DNLTh2UqR
        tN/uXK0OrDjQrtLvuzqwhPwthSz8ddZScTYAcYp8g/9briI9vlvyQOovH2tNvemgYQcfJT
        Ebj1paTFCAfb1BDi5j3CkHwuw7Le/1xozX3DC0AkxcEpOgQR43bSCTHg4675yBwUxKJBFd
        gUWdgvI7URKPkPz2PSjLfIFXtTpz+3ipHsuaBu9JbdDylYNPK8dcDv5qgNR4S1su0PFreW
        l1N+oMaxdLNUzTba3wfoS4ozZ2OyVtoqFQXHuFZelPgY8sgLgnR/p1oy00Heng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=DuOTPpKUPNVXkcp5O8JN+0U1iVYL9forzh2/KrTRKdw=;
        b=5YusHhU7a/Hbzh1GWxBHKw3CwkDv/Xte/t/cFkFW7fTO+aGAwWXpzW5E54/taoNPCGRPF1
        /XhG7OJoabgpqKDw==
Date:   Tue, 13 Jul 2021 15:39:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 04/10] hrtimer: Force clock_was_set() handling for the
 HIGHRES=n, NOHZ=y case
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
@@ -739,23 +739,7 @@ static inline int hrtimer_is_hres_enable
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
@@ -781,9 +765,50 @@ static void hrtimer_switch_to_hres(void)
 
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
@@ -842,22 +867,28 @@ static void hrtimer_reprogram(struct hrt
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
 

