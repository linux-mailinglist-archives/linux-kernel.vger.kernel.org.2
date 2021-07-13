Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6EF3C718A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhGMN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbhGMN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:24 -0400
Message-Id: <20210713135158.787536542@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tjoOaRJ0VG1BA/IRv30bb4o48CCGuIbta8lNlR7BPbo=;
        b=IrXU8lvoudPHCxjw/7oJcpdzIDvXPPwlLjt38glmidk15PGtMZMF2DGc3SOow6AwxiiMkM
        uOvWdylgWtpEbHeKnilE7mUvNgs1WOEMFxnHsN/dWwc8YGxOBA961N8mrt87pv0plYThLd
        qeT12UqzPvQNFGy49K/urq31TKN3M//z0E0REePVyAekT2DjwMEsl0pV/753mEGqB2gvlC
        AoOXZOMrAtkPDFOutZmZ3JaG8ZfAhsV3zUp1F7PoctFrW/CIBr9ZeLSisr9pz2sZSqpGUh
        lS87gwYfG3Pj4MZyPYlepPNmIK+npFvPv2koJ3gkliaMg/uSAmZDI+BheMgGRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tjoOaRJ0VG1BA/IRv30bb4o48CCGuIbta8lNlR7BPbo=;
        b=ekuEbTniunfYYKZ9bWahhALw12WHiCY/pZt6I2CATqBK2Bmnsh+7YgcES4lo//umN1TV1m
        c7DHa5NXfsk19WDw==
Date:   Tue, 13 Jul 2021 15:39:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 09/10] hrtimer: Avoid unnecessary SMP function calls in
 clock_was_set()
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <mtosatti@redhat.com>

Setting of clocks triggers an unconditional SMP function call on all online
CPUs to reprogram the clock event device.

However, only some clocks have their offsets updated and therefore
potentially require a reprogram. That's CLOCK_REALTIME and CLOCK_TAI and in
the case of resume (delayed sleep time injection) also CLOCK_BOOTTIME.

Instead of sending an IPI unconditionally, check each per CPU hrtimer base
whether it has active timers in the affected clock bases which are
indicated by the caller in the @bases argument of clock_was_set().

If that's not the case, skip the IPI and update the offsets remotely which
ensures that any subsequently armed timers on the affected clocks are
evaluated with the correct offsets.

[ tglx: Adopted to the new bases argument, removed the softirq_active
  	check, added comment, fixed up stale comment ]

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
v6:
  - Remove the softirq_active check (Peter Xu)
  - Adopt to the new base argument
  - Add comment and fixup the stale one
  - Bring back CLOCK_BOOTTIME conditionally for late sleeptime
    injection on resume (missed that in the review of V1)

v5:
  - Add missing hrtimer_update_base (Peter Xu).

v4:
   - Drop unused code (Thomas).

v3:
   - Nicer changelog  (Thomas).
   - Code style fixes (Thomas).
   - Compilation warning with CONFIG_HIGH_RES_TIMERS=n (Thomas).
   - Shrink preemption disabled section (Thomas).

v2:
   - Only REALTIME and TAI bases are affected by offset-to-monotonic changes (Thomas).
   - Don't special case nohz_full CPUs (Thomas).


---
 kernel/time/hrtimer.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -896,11 +896,42 @@ static void hrtimer_reprogram(struct hrt
  */
 void clock_was_set(unsigned int bases)
 {
+	cpumask_var_t mask;
+	int cpu;
+
 	if (!hrtimer_hres_active() && !tick_nohz_active)
 		goto out_timerfd;
 
-	/* Retrigger the CPU local events everywhere */
-	on_each_cpu(retrigger_next_event, NULL, 1);
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto out_timerfd;
+	}
+
+	/* Avoid interrupting CPUs if possible */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&cpu_base->lock, flags);
+		/*
+		 * Only send the IPI when there are timers queued in one of
+		 * the affected clock bases. Otherwise update the base
+		 * remote to ensure that the next enqueue of a timer on
+		 * such a clock base will see the correct offsets.
+		 */
+		if (cpu_base->active_bases & bases)
+			cpumask_set_cpu(cpu, mask);
+		else
+			hrtimer_update_base(cpu_base);
+		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	}
+
+	preempt_disable();
+	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	preempt_enable();
+	cpus_read_unlock();
+	free_cpumask_var(mask);
 
 out_timerfd:
 	timerfd_clock_was_set();


