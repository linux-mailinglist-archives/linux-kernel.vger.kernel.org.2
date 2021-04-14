Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1926135EBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhDNEgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhDNEgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AD68613C1;
        Wed, 14 Apr 2021 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618374964;
        bh=8g3kzPeNL395r7Fn/+Wokm2rUjHXGOfitjVm0eJPi+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4MG1euBH2lReg2IbPLve7JqMGPgBbsed8GlG5GUw9u/yynNl5ILnnK51eAEDh7hs
         oP5CwOeoAdHFjxb6QnR3h8gHRSEzW9d8w0wCvYJARQDce0+K99hhEC6hbrZK8GHwbA
         9nTnBm76BBXWRYYIWqocjT+LW6Qs1WFdSYqh5ODKuOsD6d3PEes4hxiHPyLKUNfBCr
         gtpCOXMV3x73h1xNNdOloTxABbAHHQD36EWcEaG32sWafL3ZXwzn1w+qH1m/l3aELs
         WYK9Ggy8yLGbmKtK0U1BcNJeOXBHqWMTLERzKS2zpUeat6Le4AUSgFOsVgQ9FcqTLJ
         fk9x35qUZtvTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F49B5C26E0; Tue, 13 Apr 2021 21:36:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v8 clocksource 5/5] clocksource: Limit number of CPUs checked for clock synchronization
Date:   Tue, 13 Apr 2021 21:36:02 -0700
Message-Id: <20210414043602.2812981-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if skew is detected on a clock marked CLOCK_SOURCE_VERIFY_PERCPU,
that clock is checked on all CPUs.  This is thorough, but might not be
what you want on a system with a few tens of CPUs, let alone a few hundred
of them.

Therefore, by default check only up to eight randomly chosen CPUs.
Also provide a new clocksource.verify_n_cpus kernel boot parameter.
A value of -1 says to check all of the CPUs, and a non-negative value says
to randomly select that number of CPUs, without concern about selecting
the same CPU multiple times.  However, make use of a cpumask so that a
given CPU will be checked at most once.

Suggested-by: Thomas Gleixner <tglx@linutronix.de> # For verify_n_cpus=1.
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++
 kernel/time/clocksource.c                     | 74 ++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f9da90f2791f..c09be8392bd6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -621,6 +621,16 @@
 			unstable.  Defaults to three retries, that is,
 			four attempts to read the clock under test.
 
+	clocksource.verify_n_cpus= [KNL]
+			Limit the number of CPUs checked for clocksources
+			marked with CLOCK_SOURCE_VERIFY_PERCPU that
+			are marked unstable due to excessive skew.
+			A negative value says to check all CPUs, while
+			zero says not to check any.  Values larger than
+			nr_cpu_ids are silently truncated to nr_cpu_ids.
+			The actual CPUs are chosen randomly, with
+			no replacement if the same CPU is chosen twice.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 5f641b15ec6c..8f4967e59b05 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -15,6 +15,8 @@
 #include <linux/tick.h>
 #include <linux/kthread.h>
 #include <linux/delay.h>
+#include <linux/prandom.h>
+#include <linux/cpu.h>
 
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
@@ -194,6 +196,8 @@ static int inject_delay_shift_percpu = -1;
 module_param(inject_delay_shift_percpu, int, 0644);
 static int max_read_retries = 3;
 module_param(max_read_retries, int, 0644);
+static int verify_n_cpus = 8;
+module_param(verify_n_cpus, int, 0644);
 
 static void clocksource_watchdog_inject_delay(void)
 {
@@ -216,6 +220,55 @@ static void clocksource_watchdog_inject_delay(void)
 static u64 csnow_mid;
 static cpumask_t cpus_ahead;
 static cpumask_t cpus_behind;
+static cpumask_t cpus_chosen;
+
+static void clocksource_verify_choose_cpus(void)
+{
+	int cpu, i, n = verify_n_cpus;
+
+	if (n < 0) {
+		/* Check all of the CPUs. */
+		cpumask_copy(&cpus_chosen, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
+		return;
+	}
+
+	/* If no checking desired, or no other CPU to check, leave. */
+	cpumask_clear(&cpus_chosen);
+	if (n == 0 || num_online_cpus() <= 1)
+		return;
+
+	/* Make sure to select at least one CPU other than the current CPU. */
+	cpu = cpumask_next(-1, cpu_online_mask);
+	if (cpu == smp_processor_id())
+		cpu = cpumask_next(cpu, cpu_online_mask);
+	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+		return;
+	cpumask_set_cpu(cpu, &cpus_chosen);
+
+	/* Force a sane value for the boot parameter. */
+	if (n > nr_cpu_ids)
+		n = nr_cpu_ids - 1;
+
+	/*
+	 * Randomly select the specified number of CPUs.  If the same
+	 * CPU is selected multiple times, that CPU is checked only once,
+	 * and no replacement CPU is selected.  This gracefully handles
+	 * situations where verify_n_cpus is greater than the number of
+	 * CPUs that are currently online.
+	 */
+	for (i = 1; i < n; i++) {
+		cpu = prandom_u32() % n;
+		cpu = cpumask_next(cpu - 1, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_next(-1, cpu_online_mask);
+		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
+			cpumask_set_cpu(cpu, &cpus_chosen);
+	}
+
+	/* Don't verify ourselves. */
+	cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
+}
 
 static void clocksource_verify_one_cpu(void *csin)
 {
@@ -239,12 +292,22 @@ static void clocksource_verify_percpu(struct clocksource *cs)
 	s64 delta;
 	int cpu;
 
+	if (verify_n_cpus == 0)
+		return;
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
+	get_online_cpus();
 	preempt_disable();
+	clocksource_verify_choose_cpus();
+	if (cpumask_weight(&cpus_chosen) == 0) {
+		preempt_enable();
+		put_online_cpus();
+		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
+		return;
+	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d.\n", cs->name, testcpu);
-	for_each_online_cpu(cpu) {
+	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
 		csnow_begin = cs->read(cs);
@@ -265,6 +328,7 @@ static void clocksource_verify_percpu(struct clocksource *cs)
 		firsttime = 0;
 	}
 	preempt_enable();
+	put_online_cpus();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
@@ -350,6 +414,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 				watchdog->name, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, csnow, cslast, cs->mask);
+			if (curr_clocksource == cs)
+				pr_warn("                      '%s' is current clocksource.\n", cs->name);
+			else if (curr_clocksource)
+				pr_warn("                      '%s' (not '%s') is current clocksource.\n", curr_clocksource->name, cs->name);
+			else
+				pr_warn("                      No current clocksource.\n");
 			__clocksource_unstable(cs);
 			continue;
 		}
-- 
2.25.1

