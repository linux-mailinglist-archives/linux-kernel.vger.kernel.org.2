Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0302836C11D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhD0IjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhD0Iiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 01:38:03 -0700 (PDT)
Message-Id: <20210427083724.732437214@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tjoOaRJ0VG1BA/IRv30bb4o48CCGuIbta8lNlR7BPbo=;
        b=F3cqOE2PmRt0gA3xhTQPcL4BBq3VmxyOY0YUVzCr+VstjCDscRw8Tq/HjG4L6ROz0+7esN
        XhCIKmUBEm8pzONyk24O+hXp1y/RrsxKdxmWVEFLhWyw3DtKGFMyl7IQNNwtFDC2NRsF6Y
        s0/0X8OBwLMlY9MeVohkPzMmn6hpitxPeyUpeimpXcH1LV8TdqyOKncEoacOu/bQBrkdDk
        5L/Ly1/MYocUkHSAbvZ9ptv20Yz9SrNSQFqHaUzg9QC8v+r+J52YAL0obhKLd7lM5ddnRI
        jISStCHNQCoeQzOVVRXkht4Fthl+CXje+wODuO+BocOROjXKY4HoVjHF6lf7Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tjoOaRJ0VG1BA/IRv30bb4o48CCGuIbta8lNlR7BPbo=;
        b=xixVy8vJ6ektsddN/VFn8xSauODPFIlb6Y6dUzSJd3pA68igTruTsmPZZypvJvBdkD7L6i
        okWPuxILS2Z1KkBw==
Date:   Tue, 27 Apr 2021 10:25:44 +0200
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
Subject: [patch 7/8] hrtimer: Avoid unnecessary SMP function calls in clock_was_set()
References: <20210427082537.611978720@linutronix.de>
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

