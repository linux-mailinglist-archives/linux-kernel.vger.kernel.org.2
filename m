Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA03C7185
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhGMN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhGMN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32135C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:54:28 -0700 (PDT)
Message-Id: <20210713135158.196661266@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bkUsY/NLtZGxDKBl8tQPvY8p0RCtIJv+wgqRO9c5yrQ=;
        b=xtXxS1A19Mt9T7TzAlSEKOA5+pwcjuCRI6SLP+gvftSeuT1o5+Lw6OhFNWxEmK6hM7VZ1H
        tUicLV6+A+Q6eaJFYjhnSHoFw7TIHIqbG9Vtu7zknivRcHSaZQET+YwKrEzIZmQJ73yoyV
        lheYO43qrtSYob+0xmU0oLIc8NY2A417+lhtl/ZFQmu0g9x3GxEL+b0siphm2gFCPUcS9N
        Ha7h1kmh/eAr+XpuNXrlmAsROKTtalvsORekq+FwP7YJv5pc/KWIVytuaxSsYahMBszsWT
        N5IZsHI68QgRQ84emlhX74U4A+kZlBEKAO3DVAifLKA14nU2bZWODVSQBoeWHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bkUsY/NLtZGxDKBl8tQPvY8p0RCtIJv+wgqRO9c5yrQ=;
        b=72rWWZlLjyDSyCapHKQQSiaCXwlrQYL7Oj9E2huh/4RoNRUUyOGhYcYDP7R3Skyz2cIuHi
        Pk5x/scU8GmtPWAg==
Date:   Tue, 13 Jul 2021 15:39:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 03/10] hrtimer: Ensure timerfd notification for HIGHRES=n
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

If high resolution timers are disabled the timerfd notification about a
clock was set event is not happening for all cases which use
clock_was_set_delayed() because that's a NOP for HIGHRES=n, which is wrong.

Make clock_was_set_delayed() unconditially available to fix that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h     |    5 -----
 kernel/time/hrtimer.c       |   32 ++++++++++++++++----------------
 kernel/time/tick-internal.h |    3 +++
 3 files changed, 19 insertions(+), 21 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -318,16 +318,12 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-extern void clock_was_set_delayed(void);
-
 extern unsigned int hrtimer_resolution;
 
 #else
 
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
-static inline void clock_was_set_delayed(void) { }
-
 #endif
 
 static inline ktime_t
@@ -351,7 +347,6 @@ hrtimer_expires_remaining_adjusted(const
 						    timer->base->get_time());
 }
 
-extern void clock_was_set(void);
 #ifdef CONFIG_TIMERFD
 extern void timerfd_clock_was_set(void);
 #else
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -777,22 +777,6 @@ static void hrtimer_switch_to_hres(void)
 	retrigger_next_event(NULL);
 }
 
-static void clock_was_set_work(struct work_struct *work)
-{
-	clock_was_set();
-}
-
-static DECLARE_WORK(hrtimer_work, clock_was_set_work);
-
-/*
- * Called from timekeeping and resume code to reprogram the hrtimer
- * interrupt device on all cpus.
- */
-void clock_was_set_delayed(void)
-{
-	schedule_work(&hrtimer_work);
-}
-
 #else
 
 static inline int hrtimer_is_hres_enabled(void) { return 0; }
@@ -877,6 +861,22 @@ void clock_was_set(void)
 	timerfd_clock_was_set();
 }
 
+static void clock_was_set_work(struct work_struct *work)
+{
+	clock_was_set();
+}
+
+static DECLARE_WORK(hrtimer_work, clock_was_set_work);
+
+/*
+ * Called from timekeeping and resume code to reprogram the hrtimer
+ * interrupt device on all cpus and to notify timerfd.
+ */
+void clock_was_set_delayed(void)
+{
+	schedule_work(&hrtimer_work);
+}
+
 /*
  * During resume we might have to reprogram the high resolution timer
  * interrupt on all online CPUs.  However, all other CPUs will be
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,3 +165,6 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base,
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
+
+void clock_was_set(void);
+void clock_was_set_delayed(void);

