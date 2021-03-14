Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C733A57E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhCNPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCNPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:40:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15293C061763
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 08:40:27 -0700 (PDT)
Date:   Sun, 14 Mar 2021 15:40:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615736425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gw6rWjgDnhbJeVIOYBamwczulfJC9kPc+PAUZ0cGRzE=;
        b=nHsdy3JlyZ0Ds/ScbUolpLSXnUp4tdyw8aao7r8lKCFwcPzGlRSQEjZj0b1Teu5mC+51qa
        BsxucAtUoLuKhiflbJxXJOkcrLDNmKtc3bgUdbSk5ly0LS0gJv2LQGzs4eC20lbL3+aqsI
        gCp8sGhMGhNPka3kRqwUdSiphvjyE8/5S9Wm5Fyox/4+68bCZSowHlTbPh79qNz+e3X34l
        X08nz+S5eL5dADW2xJDK3aDnUYVmMVLkvSm/FygXz0sjgNjHc8lBdhgMNQkNT7sijF1tUT
        stHRBYfJ4VRCMOI93pIPPKGFKkvq5/B1tBfaQ4nCRt6DG8plDw9IAMs+OMDjyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615736425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gw6rWjgDnhbJeVIOYBamwczulfJC9kPc+PAUZ0cGRzE=;
        b=Ok8kHtaXDtNktcE5Zbl1tXqGibXr4OvMGkOIq2XeySO6SMBZLYS6hay4tcE9lfa681M+Sq
        qJsIswafk99do+CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.12-rc3
References: <161573639668.27979.17827928369874291298.tglx@nanos>
Message-ID: <161573640030.27979.11632442807067871943.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-03-14

up to:  46eb1701c046: hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()


A single fix in for hrtimers to prevent an interrupt storm caused by the
lack of reevaluation of the timers which expire in softirq context under
certain circumstances, e.g. when the clock was set.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (1):
      hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()


 kernel/time/hrtimer.c | 60 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 743c852e10f2..788b9d137de4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -546,8 +546,11 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
 }
 
 /*
- * Recomputes cpu_base::*next_timer and returns the earliest expires_next but
- * does not set cpu_base::*expires_next, that is done by hrtimer_reprogram.
+ * Recomputes cpu_base::*next_timer and returns the earliest expires_next
+ * but does not set cpu_base::*expires_next, that is done by
+ * hrtimer[_force]_reprogram and hrtimer_interrupt only. When updating
+ * cpu_base::*expires_next right away, reprogramming logic would no longer
+ * work.
  *
  * When a softirq is pending, we can ignore the HRTIMER_ACTIVE_SOFT bases,
  * those timers will get run whenever the softirq gets handled, at the end of
@@ -588,6 +591,37 @@ __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_
 	return expires_next;
 }
 
+static ktime_t hrtimer_update_next_event(struct hrtimer_cpu_base *cpu_base)
+{
+	ktime_t expires_next, soft = KTIME_MAX;
+
+	/*
+	 * If the soft interrupt has already been activated, ignore the
+	 * soft bases. They will be handled in the already raised soft
+	 * interrupt.
+	 */
+	if (!cpu_base->softirq_activated) {
+		soft = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_SOFT);
+		/*
+		 * Update the soft expiry time. clock_settime() might have
+		 * affected it.
+		 */
+		cpu_base->softirq_expires_next = soft;
+	}
+
+	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_HARD);
+	/*
+	 * If a softirq timer is expiring first, update cpu_base->next_timer
+	 * and program the hardware with the soft expiry time.
+	 */
+	if (expires_next > soft) {
+		cpu_base->next_timer = cpu_base->softirq_next_timer;
+		expires_next = soft;
+	}
+
+	return expires_next;
+}
+
 static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 {
 	ktime_t *offs_real = &base->clock_base[HRTIMER_BASE_REALTIME].offset;
@@ -628,23 +662,7 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 {
 	ktime_t expires_next;
 
-	/*
-	 * Find the current next expiration time.
-	 */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
-
-	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
-		/*
-		 * When the softirq is activated, hrtimer has to be
-		 * programmed with the first hard hrtimer because soft
-		 * timer interrupt could occur too late.
-		 */
-		if (cpu_base->softirq_activated)
-			expires_next = __hrtimer_get_next_event(cpu_base,
-								HRTIMER_ACTIVE_HARD);
-		else
-			cpu_base->softirq_expires_next = expires_next;
-	}
+	expires_next = hrtimer_update_next_event(cpu_base);
 
 	if (skip_equal && expires_next == cpu_base->expires_next)
 		return;
@@ -1644,8 +1662,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
 
-	/* Reevaluate the clock bases for the next expiry */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
+	/* Reevaluate the clock bases for the [soft] next expiry */
+	expires_next = hrtimer_update_next_event(cpu_base);
 	/*
 	 * Store the new expiry value so the migration code can verify
 	 * against it.

