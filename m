Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB6D353052
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhDBUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBUbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BC5461155;
        Fri,  2 Apr 2021 20:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617395499;
        bh=+HfSzmYjE2EyoqNxHMoVtn67tt1Ol36MTxRSdyaMhXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbroI3O92fAKfznxMqc9dxDiHr37vzDZwXnw0S8IP83E5YaNc6DCEWSf4UsC3hLNQ
         +oyyCubKdtV9olf9KdyIxQbrry+0dqN4rmFeYm7z8EuZGuzRN28DjJyjfpjbpQOI0/
         jmG+ECx0LQ1b+vGkHaXPR++Hj+6GZMC7o+gZhoag2HYGsm4v1sa0QcAJ+leysGPBbJ
         wgwfw7OTBxa3XkU2K7z1sGjx2HxKonaVaEXM7BbXHx9/og6n2unNC9QMLvVk7gkyqO
         +gDt0Jc1F4Sh6g/2EjcHirzfoSwg/mxiDpxIwAeKpzdQD85X7PlVrRM52bSUz32Frd
         Z7UIINvEjjuWw==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org, ak@linux.intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v6 clocksource] Do not mark clocks unstable dueclocksource: Check per-CPU clock synchronization when marked unstable
Date:   Fri,  2 Apr 2021 13:31:35 -0700
Message-Id: <20210402203137.22479-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210402202929.GA22273@paulmck-ThinkPad-P72>
References: <20210402202929.GA22273@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Some sorts of per-CPU clock sources have a history of going out of
synchronization with each other.  However, this problem has purportedy
been solved in the past ten years.  Except that it is all too possible
that the problem has instead simply been made less likely, which might
mean that some of the occasional "Marking clocksource 'tsc' as unstable"
messages might be due to desynchronization.  How would anyone know?

This commit therefore adds CPU-to-CPU synchronization checking
for newly unstable clocksource that are marked with the new
CLOCK_SOURCE_VERIFY_PERCPU flag.  Lists of desynchronized CPUs are
printed, with the caveat that if it is the reporting CPU that is itself
desynchronized, it will appear that all the other clocks are wrong.
Just like in real life.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Add "static" to clocksource_verify_one_cpu() per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/kvmclock.c  |  2 +-
 arch/x86/kernel/tsc.c       |  3 +-
 include/linux/clocksource.h |  2 +-
 kernel/time/clocksource.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1fc0962..97eeaf1 100644
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
index f70dffc..5628917 100644
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
index 86d143d..83a3ebf 100644
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
index 3f734c6..663bc53 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -211,6 +211,78 @@ static void clocksource_watchdog_inject_delay(void)
 	WARN_ON_ONCE(injectfail < 0);
 }
 
+static struct clocksource *clocksource_verify_work_cs;
+static DEFINE_PER_CPU(u64, csnow_mid);
+static cpumask_t cpus_ahead;
+static cpumask_t cpus_behind;
+
+static void clocksource_verify_one_cpu(void *csin)
+{
+	struct clocksource *cs = (struct clocksource *)csin;
+
+	__this_cpu_write(csnow_mid, cs->read(cs));
+}
+
+static void clocksource_verify_percpu_wq(struct work_struct *unused)
+{
+	int cpu;
+	struct clocksource *cs;
+	int64_t cs_nsec;
+	u64 csnow_begin;
+	u64 csnow_end;
+	u64 delta;
+
+	cs = smp_load_acquire(&clocksource_verify_work_cs); // pairs with release
+	if (WARN_ON_ONCE(!cs))
+		return;
+	pr_warn("Checking clocksource %s synchronization from CPU %d.\n",
+		cs->name, smp_processor_id());
+	cpumask_clear(&cpus_ahead);
+	cpumask_clear(&cpus_behind);
+	csnow_begin = cs->read(cs);
+	smp_call_function(clocksource_verify_one_cpu, cs, 1);
+	csnow_end = cs->read(cs);
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		delta = (per_cpu(csnow_mid, cpu) - csnow_begin) & cs->mask;
+		if ((s64)delta < 0)
+			cpumask_set_cpu(cpu, &cpus_behind);
+		delta = (csnow_end - per_cpu(csnow_mid, cpu)) & cs->mask;
+		if ((s64)delta < 0)
+			cpumask_set_cpu(cpu, &cpus_ahead);
+	}
+	if (!cpumask_empty(&cpus_ahead))
+		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_ahead),
+			smp_processor_id(), cs->name);
+	if (!cpumask_empty(&cpus_behind))
+		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_behind),
+			smp_processor_id(), cs->name);
+	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind)) {
+		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
+		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		pr_warn("        CPU %d duration %lldns for clocksource %s.\n",
+			smp_processor_id(), cs_nsec, cs->name);
+	}
+	smp_store_release(&clocksource_verify_work_cs, NULL); // pairs with acquire.
+}
+
+static DECLARE_WORK(clocksource_verify_work, clocksource_verify_percpu_wq);
+
+static void clocksource_verify_percpu(struct clocksource *cs)
+{
+	if (!(cs->flags & CLOCK_SOURCE_VERIFY_PERCPU))
+		return;
+	if (smp_load_acquire(&clocksource_verify_work_cs)) { // pairs with release.
+		pr_warn("Previous clocksource synchronization still in flight.\n");
+		return;
+	}
+	smp_store_release(&clocksource_verify_work_cs, cs); //pairs with acquire.
+	queue_work(system_highpri_wq, &clocksource_verify_work);
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
@@ -284,6 +356,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 				watchdog->name, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, csnow, cslast, cs->mask);
+			clocksource_verify_percpu(cs);
 			__clocksource_unstable(cs);
 			continue;
 		}
-- 
2.9.5

