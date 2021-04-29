Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4E36E2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhD2Bbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231564AbhD2BbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45CAB6143F;
        Thu, 29 Apr 2021 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619659838;
        bh=F5cbAlcmf+aEb764Zrismh1ok95cWf7Kuij41bO5ids=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHYtKQraJ3J7797Az5tYfC/TlteNLt//dRvKrAaCaq+QLE6rL88KkZYu6CnxbZm1J
         ViedKXNjOKD2HrxS/gb7BnQhvZ9Uz1MOWWnsrX1VP+3BrTfhPlLV8WLfefvoyHtIVV
         FtUScvaQ8rxtzKUiNnAoCCE+creaDuF5hH7RdHOdHMMu2gtfLjxYwtHrjzDaVDardp
         Yq98brfl6LfsQ5y2jRIX3jUydLghjqW93ZevXeChb5w4J3DurHcVHG0ojlC2KA/ONH
         LA3a/awArr36cFIa8OUyaxKor1RhUSsIca3fwNlVpa8yRwU7lFQl5ffkSmiP53UjkS
         oHRIa9hdrghhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 16D905C0563; Wed, 28 Apr 2021 18:30:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v11 clocksource 3/6] clocksource: Check per-CPU clock synchronization when marked unstable
Date:   Wed, 28 Apr 2021 18:30:34 -0700
Message-Id: <20210429013037.3958717-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
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
Cc: Feng Tang <feng.tang@intel.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Add "static" to clocksource_verify_one_cpu() per kernel test robot feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/tsc.c       |  3 +-
 include/linux/clocksource.h |  2 +-
 kernel/time/clocksource.c   | 60 +++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

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
index 94bfdb53f2f4..a8d73e1f9431 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -245,6 +245,60 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
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
@@ -469,6 +523,12 @@ static int __clocksource_watchdog_kthread(void)
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

