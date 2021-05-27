Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C53935DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbhE0TDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236140AbhE0TC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47487610CE;
        Thu, 27 May 2021 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622142086;
        bh=lXtVYRcy3croNmaWVVrWotMzi/9V4iaQ5Eb/Fj29ehA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3ng1tOwMcMj6Efd8m3qdUE3oSuNzb8l98OD7QJqkeNBCkLo1MRiEQc8syrXyJsfg
         ryToz2D8O9EaEStBKYS7iW9wpArb4azVm995mSfCK3/7Yvkv86TY3Fs/pzncJMYu/D
         LfV+BZVVkXaNItFfTHGoBGAK4r5aoI5oftYwjOOTF8n6wSDdPGQtw0t1SeLVoQ6tb4
         2FsgIEltQ4mvxQ/gXGXO+SxW1KYBj4wF65+RBEQIMTewuc4gVKB7HBnWRjfoge60mq
         iGJ3xMy7ahB3lPYrpJlgPJQifgx/Z2kr3QJxl6VydrsoAmzIKwXa2uWKCuFXliXTaW
         uuu5dU+R2/Bjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 11BF25C02AB; Thu, 27 May 2021 12:01:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v15 clocksource 2/6] clocksource: Check per-CPU clock synchronization when marked unstable
Date:   Thu, 27 May 2021 12:01:20 -0700
Message-Id: <20210527190124.440372-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1>
References: <20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1>
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

Link: https://lore.kernel.org/lkml/202104291438.PuHsxRkl-lkp@intel.com/
Link: https://lore.kernel.org/lkml/20210429140440.GT975577@paulmck-ThinkPad-P17-Gen-1
Link: https://lore.kernel.org/lkml/20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210420064934.GE31773@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
Acked-by: Feng Tang <feng.tang@intel.com>
[ paulmck: Add "static" to clocksource_verify_one_cpu() per kernel test robot feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/tsc.c       |  3 +-
 include/linux/clocksource.h |  2 +-
 kernel/time/clocksource.c   | 60 +++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 57ec01192180..6eb1b097e97e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1152,7 +1152,8 @@ static struct clocksource clocksource_tsc = {
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
index d6ab416ee2d2..7f83d51c0fd7 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -137,7 +137,7 @@ struct clocksource {
 #define CLOCK_SOURCE_UNSTABLE			0x40
 #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
 #define CLOCK_SOURCE_RESELECT			0x100
-
+#define CLOCK_SOURCE_VERIFY_PERCPU		0x200
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ec9632b7e833..d0a178d579c4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -223,6 +223,60 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 	return false;
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
+	int64_t cs_nsec, cs_nsec_max = 0, cs_nsec_min = LLONG_MAX;
+	u64 csnow_begin, csnow_end;
+	int cpu, testcpu;
+	s64 delta;
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
+		if (cs_nsec > cs_nsec_max)
+			cs_nsec_max = cs_nsec;
+		if (cs_nsec < cs_nsec_min)
+			cs_nsec_min = cs_nsec;
+	}
+	preempt_enable();
+	if (!cpumask_empty(&cpus_ahead))
+		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
+	if (!cpumask_empty(&cpus_behind))
+		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
+	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
+		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
+			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
@@ -447,6 +501,12 @@ static int __clocksource_watchdog_kthread(void)
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
2.31.1.189.g2e36527f23

