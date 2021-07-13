Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BC3C718D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhGMN5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53228 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbhGMN5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:25 -0400
Message-Id: <20210713135158.887322464@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Al+tO89KZ0WnAXZVnnl4CFnWdviNIoH34huQsHYgfow=;
        b=uQyVQ+im3lM/kdchGEO4MUB0ZhGpJqyXlBuCMMNFaZwkEnb/BO0wV4OAJLMp8KG7/tAgdY
        Huu7Nj4wrLibJ5sERzUZ8n7phnl8EiunpeGv+xq+ez/yFWWC6Zp6o9lSYNLd8rIUYadlmS
        sTcVPs4DqAYTDNVBjln1waBazXz7tODk4Npom0Yrxsyg3TyH63G/z3akqkgKLBlJK09RQn
        Blg5RfZTP+5xIxc0LEaJEAWXo21Nfzk5RMLeq5eIYEC/2RzxR9k574LDTNNOAdbZJa/gX3
        839rAzej40JiorTe1qOdwt+laFzBrlY8W8LAVrmPvkybJ1fkClIFk2eTG9hUtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Al+tO89KZ0WnAXZVnnl4CFnWdviNIoH34huQsHYgfow=;
        b=W5utYlBd6EQXn1VSu1Zvfgt3se7v6eHK0bpju/6l0otgPPc0ET+ORDGlkI/M9/d7+Q2Tx0
        JXB9Sj8zdEpmZeDg==
Date:   Tue, 13 Jul 2021 15:39:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 10/10] hrtimer: Avoid more SMP function calls in clock_was_set()
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

By unconditionally updating the offsets there are more indicators
whether the SMP function calls on clock_was_set() can be avoided:

  - When the offset update already happened on the remote CPU then the
    remote update attempt will yield the same seqeuence number and no
    IPI is required.

  - When the remote CPU is currently handling hrtimer_interrupt(). In
    that case the remote CPU will reevaluate the timer bases before
    reprogramming anyway, so nothing to do.

  - After updating it can be checked whether the first expiring timer in
    the affected clock bases moves before the first expiring (softirq)
    timer of the CPU. If that's not the case then sending the IPI is not
    required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the in_hrtirq thinko (Marcelo)
    Add the missing masking (reported by 0day)

P.S.: The git branch is updated as well
---
 kernel/time/hrtimer.c |   74 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 9 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -866,6 +866,68 @@ static void hrtimer_reprogram(struct hrt
 	__hrtimer_reprogram(cpu_base, true, timer, expires);
 }
 
+static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
+			     unsigned int active)
+{
+	struct hrtimer_clock_base *base;
+	unsigned int seq;
+	ktime_t expires;
+
+	/*
+	 * Update the base offsets unconditionally so the following
+	 * checks whether the SMP function call is required works.
+	 *
+	 * The update is safe even when the remote CPU is in the hrtimer
+	 * interrupt or the hrtimer soft interrupt and expiring affected
+	 * bases. Either it will see the update before handling a base or
+	 * it will see it when it finishes the processing and reevaluates
+	 * the next expiring timer.
+	 */
+	seq = cpu_base->clock_was_set_seq;
+	hrtimer_update_base(cpu_base);
+
+	/*
+	 * If the sequence did not change over the update then the
+	 * remote CPU already handled it.
+	 */
+	if (seq == cpu_base->clock_was_set_seq)
+		return false;
+
+	/*
+	 * If the remote CPU is currently handling an hrtimer interrupt, it
+	 * will reevaluate the first expiring timer of all clock bases
+	 * before reprogramming. Nothing to do here.
+	 */
+	if (cpu_base->in_hrtirq)
+		return false;
+
+	/*
+	 * Walk the affected clock bases and check whether the first expiring
+	 * timer in a clock base is moving ahead of the first expiring timer of
+	 * @cpu_base. If so, the IPI must be invoked because per CPU clock
+	 * event devices cannot be remotely reprogrammed.
+	 */
+	active &= cpu_base->active_bases;
+
+	for_each_active_base(base, cpu_base, active) {
+		struct timerqueue_node *next;
+
+		next = timerqueue_getnext(&base->active);
+		expires = ktime_sub(next->expires, base->offset);
+		if (expires < cpu_base->expires_next)
+			return true;
+
+		/* Extra check for softirq clock bases */
+		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+			continue;
+		if (cpu_base->softirq_activated)
+			continue;
+		if (expires < cpu_base->softirq_expires_next)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
  * CLOCK_BOOTTIME (for late sleep time injection).
@@ -900,16 +962,10 @@ void clock_was_set(unsigned int bases)
 		unsigned long flags;
 
 		raw_spin_lock_irqsave(&cpu_base->lock, flags);
-		/*
-		 * Only send the IPI when there are timers queued in one of
-		 * the affected clock bases. Otherwise update the base
-		 * remote to ensure that the next enqueue of a timer on
-		 * such a clock base will see the correct offsets.
-		 */
-		if (cpu_base->active_bases & bases)
+
+		if (update_needs_ipi(cpu_base, bases))
 			cpumask_set_cpu(cpu, mask);
-		else
-			hrtimer_update_base(cpu_base);
+
 		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	}
 

