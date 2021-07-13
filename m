Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA2F3C718C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhGMN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbhGMN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A73FC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:54:31 -0700 (PDT)
Message-Id: <20210713135158.488853478@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7w/WjmY4L1WiRcb0h50YeGNn764ly9SO0FIXZqbq/0o=;
        b=JKZJ5CpgtLipWXMrXni4KP6hA6jYA+iOFak49JelSN1ovRLNSdPxrCMhAuGAS0FscG+kIX
        0S2dNdu4MdaXV1fs65v5IyxoIgSNkkdZ2MwZk+xTdeVpfJgcM1UMm6dJ1MK7YD2nQyMMX4
        MIxUqhCUcUX9FaJEoEXrMIwdGvtGttgvsnn9/Odpfc6j4dInaIWbzl0hWmIM5sTnOR5P7q
        wwXm6Kn82LxK7Oye6MRBk9vE+qU38XqV0JIJ7XhjYS/Y2d4lOa/y0Ok018RW0pt9cJxRV4
        L107tGkJLL090ISXCEuopfH30Sf5sT6fxe75SbD9wsSRG6MhtpV2cxv53HlFnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7w/WjmY4L1WiRcb0h50YeGNn764ly9SO0FIXZqbq/0o=;
        b=/LoNft1dinzXOXxXjMrIgV9KSTOGvyPFKQr0Vrmog65oY7rt0JqocgnHjHzzYBWXfi9Hrp
        H9+i/zd+P9zjVlDg==
Date:   Tue, 13 Jul 2021 15:39:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 06/10] timekeeping: Distangle resume and clock-was-set events
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Resuming timekeeping is a clock-was-set event and uses the clock-was-set
notification mechanism. This is in the way of making the clock-was-set
update for hrtimers selective so unnecessary IPIs are avoided when a CPU
base does not have timers queued which are affected by the clock setting.

Distangle it by invoking hrtimer_resume() on each unfreezing CPU and invoke
the new timerfd_resume() function from timekeeping_resume() which is the
only place where this is needed.

Rename hrtimer_resume() to hrtimer_resume_local() to reflect the change.

With this the clock_was_set*() functions are not longer required to IPI all
CPUs unconditionally and can get some smarts to avoid them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h     |    1 -
 kernel/time/hrtimer.c       |   15 ++++++---------
 kernel/time/tick-common.c   |    7 +++++++
 kernel/time/tick-internal.h |    2 ++
 kernel/time/timekeeping.c   |    4 +++-
 5 files changed, 18 insertions(+), 11 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -354,7 +354,6 @@ extern void timerfd_resume(void);
 static inline void timerfd_clock_was_set(void) { }
 static inline void timerfd_resume(void) { }
 #endif
-extern void hrtimers_resume(void);
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -900,8 +900,8 @@ static void clock_was_set_work(struct wo
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
 
 /*
- * Called from timekeeping and resume code to reprogram the hrtimer
- * interrupt device on all cpus and to notify timerfd.
+ * Called from timekeeping code to reprogram the hrtimer interrupt device
+ * on all cpus and to notify timerfd.
  */
 void clock_was_set_delayed(void)
 {
@@ -909,18 +909,15 @@ void clock_was_set_delayed(void)
 }
 
 /*
- * During resume we might have to reprogram the high resolution timer
- * interrupt on all online CPUs.  However, all other CPUs will be
- * stopped with IRQs interrupts disabled so the clock_was_set() call
- * must be deferred.
+ * Called during resume either directly from via timekeeping_resume()
+ * or in the case of s2idle from tick_unfreeze() to ensure that the
+ * hrtimers are up to date.
  */
-void hrtimers_resume(void)
+void hrtimers_resume_local(void)
 {
 	lockdep_assert_irqs_disabled();
 	/* Retrigger on the local CPU */
 	retrigger_next_event(NULL);
-	/* And schedule a retrigger for all others */
-	clock_was_set_delayed();
 }
 
 /*
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -470,6 +470,13 @@ void tick_resume_local(void)
 		else
 			tick_resume_oneshot();
 	}
+
+	/*
+	 * Ensure that hrtimers are up to date and the clockevents device
+	 * is reprogrammed correctly when high resolution timers are
+	 * enabled.
+	 */
+	hrtimers_resume_local();
 }
 
 /**
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -168,3 +168,5 @@ void timer_clear_idle(void);
 
 void clock_was_set(void);
 void clock_was_set_delayed(void);
+
+void hrtimers_resume_local(void);
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1810,8 +1810,10 @@ void timekeeping_resume(void)
 
 	touch_softlockup_watchdog();
 
+	/* Resume the clockevent device(s) and hrtimers */
 	tick_resume();
-	hrtimers_resume();
+	/* Notify timerfd as resume is equivalent to clock_was_set() */
+	timerfd_resume();
 }
 
 int timekeeping_suspend(void)

