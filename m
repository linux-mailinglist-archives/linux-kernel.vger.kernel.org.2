Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567F836C116
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhD0Iij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:38:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhD0Iii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:38 -0400
Message-Id: <20210427083724.027145011@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=B64RfRxJ2uTxt0KU7ZCmrT4IOqVFkRPA5LLJCiAqXLs=;
        b=sJNhgEvsq1B2m0JbfUXpWNgIjQRgqu8gJenA6MCngWH9A8jqyg4qrzI6wx2+v9sGECvOkU
        XEBd65dcA7JraOD1wgcQV70tFcnfPztOO1/Zq0kT+SvYuvfiNeJA2O32MzYCc68D7Hcgto
        bX2KOAcfAYlXBXXL4kB3H4dsTOuaLT8RuFAyIWIKfxzABXWtoUNM+qWAtMwEt6kZgIKwqe
        BAKwOGrKqkHbTBUH13Y1bzBRbiz6UvdTblT2qaax/5+4N9+ZcX+9iKASF7CcvzvWRONWVT
        7Mtu1KHCedNwnC9Uxn0QVtm6GKd+Rno9e/AKVDxTlf25cRs/L4/92QHc37GawQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=B64RfRxJ2uTxt0KU7ZCmrT4IOqVFkRPA5LLJCiAqXLs=;
        b=uJP+mw8KouLBmxZScdO2Veiq4bTki+7GSH0XOFXFf9spMKQWbGOjZzBvidMEXV0004A/hT
        M0Zh3H1FLqpMBFAQ==
Date:   Tue, 27 Apr 2021 10:25:38 +0200
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
Subject: [patch 1/8] hrtimer: Ensure timerfd notification for HIGHRES=n
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
@@ -758,22 +758,6 @@ static void hrtimer_switch_to_hres(void)
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
@@ -891,6 +875,22 @@ void clock_was_set(void)
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
@@ -164,3 +164,6 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base,
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
+
+void clock_was_set(void);
+void clock_was_set_delayed(void);

