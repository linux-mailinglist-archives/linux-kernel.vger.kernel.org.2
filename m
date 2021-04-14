Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758A735EBED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDNEg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhDNEgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BD81613B1;
        Wed, 14 Apr 2021 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618374964;
        bh=0xOW3bfDkrCRWg2l4Eye168w643hRQjMtJGzkFyoPkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxtv0NGkulLqJ5uvZH5OycQI5hLPJ0tSiUU40NJ4YwI7PROSg/QdKtyC4IvMDTDxi
         eTmCzE6mR0lL6At9v4LDTMGFuI1JT1aNCF2lni/FZux2LmMNB9AU8GhL+v6Oe+tTXD
         6Lp5ScRmzgVviGUupId4oHveizBq/SDfqeFDBOoje+/k9vVcpLaD6y6VHkMq2o4wlO
         RQalvCveCj347oSMDdIXl47qikcf6QhZiZLmdVxRyDnuGWW4cQF6cLUCdidbibIa7n
         J0i6JecODaaxdvCviiKoITJnwQZUqg9XgOAYPSK9AkRjyWFGTpFUmpvq1yO2F282sh
         5VIY5MHF5An0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B1065C26B7; Tue, 13 Apr 2021 21:36:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v8 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
Date:   Tue, 13 Apr 2021 21:36:00 -0700
Message-Id: <20210414043602.2812981-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sorts of per-CPU clock sources have a history of going out of
synchronization with each other.  However, this problem has purportedy
been solved in the past ten years.  Except that it is all too possible
that the problem has instead simply been made less likely, which might
mean that some of the occasional "Marking clocksource 'tsc' as unstable"
messages might be due to desynchronization.  How would anyone know?

Therefore apply CPU-to-CPU synchronization checking to newly unstable
clocksource that are marked with the new CLOCK_SOURCE_VERIFY_PERCPU flag.
Lists of desynchronized CPUs are printed, with the caveat that if it
is the reporting CPU that is itself desynchronized, it will appear that
all the other clocks are wrong.  Just like in real life.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Add "static" to clocksource_verify_one_cpu() per kernel test robot feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/kvmclock.c  |  2 +-
 arch/x86/kernel/tsc.c       |  3 +-
 include/linux/clocksource.h |  2 +-
 kernel/time/clocksource.c   | 63 +++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1fc0962c89c0..97eeaf164296 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -169,7 +169,7 @@ struct clocksource kvm_clock = {
 	.read	= kvm_clock_get_cycles,
 	.rating	= 400,
 	.mask	= CLOCKSOURCE_MASK(64),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VERIFY_PERCPU,
 	.enable	= kvm_cs_enable,
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc2771f..56289170753c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1151,7 +1151,8 @@ static struct clocksource clocksource_tsc = {
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_VALID_FOR_HRES |
-				  CLOCK_SOURCE_MUST_VERIFY,
+				  CLOCK_SOURCE_MUST_VERIFY |
+				  CLOCK_SOURCE_VERIFY_PERCPU,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 86d143db6523..83a3ebff7456 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -131,7 +131,7 @@ struct clocksource {
 #define CLOCK_SOURCE_UNSTABLE			0x40
 #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
 #define CLOCK_SOURCE_RESELECT			0x100
-
+#define CLOCK_SOURCE_VERIFY_PERCPU		0x200
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3ac19a7859f5..69311deab428 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -211,6 +211,63 @@ static void clocksource_watchdog_inject_delay(void)
 	WARN_ON_ONCE(injectfail < 0);
 }
 
+static u64 csnow_mid;
+static cpumask_t cpus_ahead;
+static cpumask_t cpus_behind;
+
+static void clocksource_verify_one_cpu(void *csin)
+{
+	struct clocksource *cs = (struct clocksource *)csin;
+
+	csnow_mid = cs->read(cs);
+}
+
+static void clocksource_verify_percpu(struct clocksource *cs)
+{
+	int64_t cs_nsec, cs_nsec_max, cs_nsec_min;
+	u64 csnow_begin, csnow_end;
+	bool firsttime = 1;
+	int testcpu;
+	s64 delta;
+	int cpu;
+
+	cpumask_clear(&cpus_ahead);
+	cpumask_clear(&cpus_behind);
+	preempt_disable();
+	testcpu = smp_processor_id();
+	pr_warn("Checking clocksource %s synchronization from CPU %d.\n", cs->name, testcpu);
+	for_each_online_cpu(cpu) {
+		if (cpu == testcpu)
+			continue;
+		csnow_begin = cs->read(cs);
+		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
+		csnow_end = cs->read(cs);
+		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
+		if (delta < 0)
+			cpumask_set_cpu(cpu, &cpus_behind);
+		delta = (csnow_end - csnow_mid) & cs->mask;
+		if (delta < 0)
+			cpumask_set_cpu(cpu, &cpus_ahead);
+		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
+		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		if (firsttime || cs_nsec > cs_nsec_max)
+			cs_nsec_max = cs_nsec;
+		if (firsttime || cs_nsec < cs_nsec_min)
+			cs_nsec_min = cs_nsec;
+		firsttime = 0;
+	}
+	preempt_enable();
+	if (!cpumask_empty(&cpus_ahead))
+		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
+	if (!cpumask_empty(&cpus_behind))
+		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
+	if (!firsttime && (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind)))
+		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
+			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
@@ -450,6 +507,12 @@ static int __clocksource_watchdog_kthread(void)
 	unsigned long flags;
 	int select = 0;
 
+	/* Do any required per-CPU skew verification. */
+	if (curr_clocksource &&
+	    curr_clocksource->flags & CLOCK_SOURCE_UNSTABLE &&
+	    curr_clocksource->flags & CLOCK_SOURCE_VERIFY_PERCPU)
+		clocksource_verify_percpu(curr_clocksource);
+
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
-- 
2.25.1

