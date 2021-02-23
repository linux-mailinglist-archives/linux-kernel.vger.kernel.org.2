Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB356322E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhBWQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:04:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhBWQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:03:42 -0500
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614096176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=927T3TTLQb/sPMTRYoiAA9sCG2eHtJoMHvlawJ6xqms=;
        b=36VuCZZBaNRts2vQqkDGyBfTnkV1X9UKWJGb0dIvVOksubyM+2HeJ0XHqQqVcpRyG4gxgx
        IIOxCiFDPDtC25rqJ51xmr/UN9h7CyNNrZVvsTKoEvMZuRVqsRmyu1oEvmB5xMc2QLtmQZ
        D2wGRxAb4OIB+pjXj7pdWN6G91ILN9ereTW660/b+ku9/et60GXrXbIMwgolTKCVCadCQl
        PcL5pCqN0IAqGKQepgK52J40wtRkt2b0H2jtyzcGOHdMUHPYd3Fbiv4CLtWEFup1p8Dn02
        7lfHa3u2jaijz0X8cUsPTB+ff79VkKz9Rl6SUeF9L0+NUNvDF0XN1ChdrYqPrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614096176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=927T3TTLQb/sPMTRYoiAA9sCG2eHtJoMHvlawJ6xqms=;
        b=W11OV9DrbWL+omKPDbqZhzGaGstQqaay4PclvmuyHimShwIF0w2vP09uupE4PIStnE3K6G
        AlDVxyS8bYqT37BA==
To:     mikael.beckius@windriver.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
Date:   Tue, 23 Feb 2021 17:02:40 +0100
Message-Id: <20210223160240.27518-1-anna-maria@linutronix.de>
In-Reply-To: <PH0PR11MB4904A4830FED08F91CA97C04928B9@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <PH0PR11MB4904A4830FED08F91CA97C04928B9@PH0PR11MB4904.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hrtimer_force_reprogram() and hrtimer_interrupt() invokes
__hrtimer_get_next_event() to find the earliest expiry time of hrtimer
bases. __hrtimer_get_next_event() does not update
cpu_base::[softirq_]_expires_next to preserve reprogramming logic. That
needs to be done at the callsites.

hrtimer_force_reprogram() updates cpu_base::softirq_expires_next only when
the first expiring timer is a softirq timer and the soft interrupt is not
activated. That's wrong because cpu_base::softirq_expires_next is left
stale when the first expiring timer of all bases is a timer which expires
in hard interrupt context. hrtimer_interrupt() does never update
cpu_base::softirq_expires_next which is wrong too.

That becomes a problem when clock_settime() sets CLOCK_REALTIME forward and
the first soft expiring timer is in the CLOCK_REALTIME_SOFT base. Setting
CLOCK_REALTIME forward moves the clock MONOTONIC based expiry time of that
timer before the stale cpu_base::softirq_expires_next.

cpu_base::softirq_expires_next is cached to make the check for raising the
soft interrupt fast. In the above case the soft interrupt won't be raised
until clock monotonic reaches the stale cpu_base::softirq_expires_next
value. That's incorrect, but what's worse it that if the softirq timer
becomes the first expiring timer of all clock bases after the hard expiry
timer has been handled the reprogramming of the clockevent from
hrtimer_interrupt() will result in an interrupt storm. That happens because
the reprogramming does not use cpu_base::softirq_expires_next, it uses
__hrtimer_get_next_event() which returns the actual expiry time. Once clock
MONOTONIC reaches cpu_base::softirq_expires_next the soft interrupt is
raised and the storm subsides.

Change the logic in hrtimer_force_reprogram() to evaluate the soft and hard
bases seperately, update softirq_expires_next and handle the case when a
soft expiring timer is the first of all bases by comparing the expiry times
and updating the required cpu base fields. Split this functionality into a
separate function to be able to use it in hrtimer_interrupt() as well
without copy paste.

Micke, please test this patch - it is compile tested only...

Fixes:5da70160462e ("hrtimer: Implement support for softirq based hrtimers")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reported-by: Mikael Beckius <mikael.beckius@windriver.com>
---
 kernel/time/hrtimer.c | 53 +++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 46bd35d5fc0d..788b9d137de4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -591,6 +591,37 @@ __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_
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
@@ -631,23 +662,7 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
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
@@ -1647,8 +1662,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
 
-	/* Reevaluate the clock bases for the next expiry */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
+	/* Reevaluate the clock bases for the [soft] next expiry */
+	expires_next = hrtimer_update_next_event(cpu_base);
 	/*
 	 * Store the new expiry value so the migration code can verify
 	 * against it.
-- 
2.20.1

