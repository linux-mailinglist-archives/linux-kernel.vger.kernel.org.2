Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D86370474
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhEAAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhEAAdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:33:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9797B61423;
        Sat,  1 May 2021 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619829168;
        bh=VGp+EnEo6bJM2uYI1Zf7i2BonaUudIbyRMUx9u9PEY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOQtcvonzAohbG1ylnpik4InepzfhulZEjVl7Gm60jlA9zwNc4Pfs9IX4Ch7LG/IP
         EG5BBHlPjchIHjRoVSCUrWm62WjgKghjtShHLJwdKWw8bJNZ6hpuUmKs9rb/U1KuoU
         99PsutLmaGwaVwmvJAPWOHLeML04e8/0WzqB22wtZS0v4MZ9ySyI9klaa/ZWKKRqir
         mE1qmD2lwN3WYeUpF5N7MPsu6cis2bwQ9Cf6NS0bdj+XWEdhVSnHubqJ/ONoxW1lfU
         Kt/vHeo7ULUSlbav0owcD1KeBmx4P5N2CgNGmR8wLf3oVYt0xuPNSG/DN+jIumQXWx
         DN1A6Q0uJRqig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CB8D5C0361; Fri, 30 Apr 2021 17:32:48 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v12 clocksource 5/5] clocksource: Provide kernel module to test clocksource watchdog
Date:   Fri, 30 Apr 2021 17:32:47 -0700
Message-Id: <20210501003247.2448287-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210501003204.GA2447938@paulmck-ThinkPad-P17-Gen-1>
References: <20210501003204.GA2447938@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the clocksource watchdog marks a clock as unstable, this might
be due to that clock being unstable or it might be due to delays that
happen to occur between the reads of the two clocks.  It would be good
to have a way of testing the clocksource watchdog's ability to
distinguish between these two causes of clock skew and instability.

Therefore, provide a new clocksource-wdtest module selected by a new
TEST_CLOCKSOURCE_WATCHDOG Kconfig option.  This module has a single module
parameter named "holdoff" that provides the number of seconds of delay
before testing should start, which defaults to zero when built as a module
and to 10 seconds when built directly into the kernel.  Very large systems
that boot slowly may need to increase the value of this module parameter.

This module uses hand-crafted clocksource structures to do its testing,
thus avoiding messing up timing for the rest of the kernel and for user
applications.  This module first verifies that the ->uncertainty_margin
field of the clocksource structures are set sanely.  It then tests the
delay-detection capability of the clocksource watchdog, increasing the
number of consecutive delays injected, first provoking console messages
complaining about the delays and finally forcing a clock-skew event.
Unexpected test results cause at least one WARN_ON_ONCE() console splat.
If there are no splats, the test has passed.  Finally, it fuzzes the
value returned from a clocksource to test the clocksource watchdog's
ability to detect time skew.

This module checks the state of its clocksource after each test, and
uses WARN_ON_ONCE() to emit a console splat if there are any failures.
This should enable all types of test frameworks to detect any such
failures.

This facility is intended for diagnostic use only, and should be avoided
on production systems.

Link: https://lore.kernel.org/lkml/202104291438.PuHsxRkl-lkp@intel.com/
Link: https://lore.kernel.org/lkml/20210429140440.GT975577@paulmck-ThinkPad-P17-Gen-1
Link: https://lore.kernel.org/lkml/20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210420064934.GE31773@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 include/linux/clocksource.h                   |   3 +
 kernel/time/Makefile                          |   1 +
 kernel/time/clocksource-wdtest.c              | 202 ++++++++++++++++++
 kernel/time/clocksource.c                     |  11 +-
 lib/Kconfig.debug                             |  12 ++
 6 files changed, 230 insertions(+), 5 deletions(-)
 create mode 100644 kernel/time/clocksource-wdtest.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 485023c99244..79733e7c04a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,12 @@
 			The actual CPUs are chosen randomly, with
 			no replacement if the same CPU is chosen twice.
 
+	clocksource-wdtest.holdoff= [KNL]
+			Set the time in seconds that the clocksource
+			watchdog test waits before commencing its tests.
+			Defaults to zero when built as a module and to
+			10 seconds when built into the kernel.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 8f87c1a6f323..83b3c6639c39 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -285,4 +285,7 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
+extern ulong max_cswd_read_retries;
+void clocksource_verify_percpu(struct clocksource *cs);
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 1fb1c1ef6a19..1ed85b25b096 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
 obj-$(CONFIG_TIME_NS)				+= namespace.o
+obj-$(CONFIG_TEST_CLOCKSOURCE_WATCHDOG)		+= clocksource-wdtest.o
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
new file mode 100644
index 000000000000..01df12395c0e
--- /dev/null
+++ b/kernel/time/clocksource-wdtest.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Unit test for the clocksource watchdog.
+ *
+ * Copyright (C) 2021 Facebook, Inc.
+ *
+ * Author: Paul E. McKenney <paulmck@kernel.org>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
+#include <linux/tick.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/prandom.h>
+#include <linux/cpu.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
+
+static int holdoff = IS_BUILTIN(CONFIG_TEST_CLOCKSOURCE_WATCHDOG) ? 10 : 0;
+module_param(holdoff, int, 0444);
+MODULE_PARM_DESC(holdoff, "Time to wait to start test (s).");
+
+/* Watchdog kthread's task_struct pointer for debug purposes. */
+static struct task_struct *wdtest_task;
+
+static u64 wdtest_jiffies_read(struct clocksource *cs)
+{
+	return (u64)jiffies;
+}
+
+/* Assume HZ > 100. */
+#define JIFFIES_SHIFT	8
+
+static struct clocksource clocksource_wdtest_jiffies = {
+	.name			= "wdtest-jiffies",
+	.rating			= 1, /* lowest valid rating*/
+	.uncertainty_margin	= TICK_NSEC,
+	.read			= wdtest_jiffies_read,
+	.mask			= CLOCKSOURCE_MASK(32),
+	.flags			= CLOCK_SOURCE_MUST_VERIFY,
+	.mult			= TICK_NSEC << JIFFIES_SHIFT, /* details above */
+	.shift			= JIFFIES_SHIFT,
+	.max_cycles		= 10,
+};
+
+static int wdtest_ktime_read_ndelays;
+static bool wdtest_ktime_read_fuzz;
+
+static u64 wdtest_ktime_read(struct clocksource *cs)
+{
+	int wkrn = READ_ONCE(wdtest_ktime_read_ndelays);
+	static int sign = 1;
+	u64 ret;
+
+	if (wkrn) {
+		udelay(cs->uncertainty_margin / 250);
+		WRITE_ONCE(wdtest_ktime_read_ndelays, wkrn - 1);
+	}
+	ret = ktime_get_real_fast_ns();
+	if (READ_ONCE(wdtest_ktime_read_fuzz)) {
+		sign = -sign;
+		ret = ret + sign * 100 * NSEC_PER_MSEC;
+	}
+	return ret;
+}
+
+static void wdtest_ktime_cs_mark_unstable(struct clocksource *cs)
+{
+	pr_info("--- Marking %s unstable due to clocksource watchdog.\n", cs->name);
+}
+
+#define KTIME_FLAGS (CLOCK_SOURCE_IS_CONTINUOUS | \
+		     CLOCK_SOURCE_VALID_FOR_HRES | \
+		     CLOCK_SOURCE_MUST_VERIFY | \
+		     CLOCK_SOURCE_VERIFY_PERCPU)
+
+static struct clocksource clocksource_wdtest_ktime = {
+	.name			= "wdtest-ktime",
+	.rating			= 300,
+	.read			= wdtest_ktime_read,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.flags			= KTIME_FLAGS,
+	.mark_unstable		= wdtest_ktime_cs_mark_unstable,
+	.list			= LIST_HEAD_INIT(clocksource_wdtest_ktime.list),
+};
+
+/* Reset the clocksource if needed. */
+static void wdtest_ktime_clocksource_reset(void)
+{
+	if (clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE) {
+		clocksource_unregister(&clocksource_wdtest_ktime);
+		clocksource_wdtest_ktime.flags = KTIME_FLAGS;
+		schedule_timeout_uninterruptible(HZ / 10);
+		clocksource_register_khz(&clocksource_wdtest_ktime, 1000 * 1000);
+	}
+}
+
+/* Run the specified series of watchdog tests. */
+static int wdtest_func(void *arg)
+{
+	unsigned long j1, j2;
+	char *s;
+	int i;
+
+	schedule_timeout_uninterruptible(holdoff * HZ);
+
+	/*
+	 * Verify that jiffies-like clocksources get the manually
+	 * specified uncertainty margin.
+	 */
+	pr_info("--- Verify jiffies-like uncertainty margin.\n");
+	__clocksource_register(&clocksource_wdtest_jiffies);
+	WARN_ON_ONCE(clocksource_wdtest_jiffies.uncertainty_margin != TICK_NSEC);
+
+	j1 = clocksource_wdtest_jiffies.read(&clocksource_wdtest_jiffies);
+	schedule_timeout_uninterruptible(HZ);
+	j2 = clocksource_wdtest_jiffies.read(&clocksource_wdtest_jiffies);
+	WARN_ON_ONCE(j1 == j2);
+
+	clocksource_unregister(&clocksource_wdtest_jiffies);
+
+	/*
+	 * Verify that tsc-like clocksources are assigned a reasonable
+	 * uncertainty margin.
+	 */
+	pr_info("--- Verify tsc-like uncertainty margin.\n");
+	clocksource_register_khz(&clocksource_wdtest_ktime, 1000 * 1000);
+	WARN_ON_ONCE(clocksource_wdtest_ktime.uncertainty_margin < NSEC_PER_USEC);
+
+	j1 = clocksource_wdtest_ktime.read(&clocksource_wdtest_ktime);
+	udelay(1);
+	j2 = clocksource_wdtest_ktime.read(&clocksource_wdtest_ktime);
+	pr_info("--- tsc-like times: %lu - %lu = %lu.\n", j2, j1, j2 - j1);
+	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
+
+	/* Verify tsc-like stability with various numbers of errors injected. */
+	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
+		if (i <= 1 && i < max_cswd_read_retries)
+			s = "";
+		else if (i <= max_cswd_read_retries)
+			s = ", expect message";
+		else
+			s = ", expect clock skew";
+		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
+		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
+		schedule_timeout_uninterruptible(2 * HZ);
+		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
+		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
+		wdtest_ktime_clocksource_reset();
+	}
+
+	/* Verify tsc-like stability with clock-value-fuzz error injection. */
+	pr_info("--- Watchdog clock-value-fuzz error injection, expect clock skew and per-CPU mismatches.\n");
+	WRITE_ONCE(wdtest_ktime_read_fuzz, true);
+	schedule_timeout_uninterruptible(2 * HZ);
+	WARN_ON_ONCE(!(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
+	clocksource_verify_percpu(&clocksource_wdtest_ktime);
+	WRITE_ONCE(wdtest_ktime_read_fuzz, false);
+
+	clocksource_unregister(&clocksource_wdtest_ktime);
+
+	pr_info("--- Done with test.\n");
+	return 0;
+}
+
+static void wdtest_print_module_parms(void)
+{
+	pr_alert("--- holdoff=%d\n", holdoff);
+}
+
+/* Cleanup function. */
+static void clocksource_wdtest_cleanup(void)
+{
+}
+
+static int __init clocksource_wdtest_init(void)
+{
+	int ret = 0;
+
+	wdtest_print_module_parms();
+
+	/* Create watchdog-test task. */
+	wdtest_task = kthread_run(wdtest_func, NULL, "wdtest");
+	if (IS_ERR(wdtest_task)) {
+		ret = PTR_ERR(wdtest_task);
+		pr_warn("%s: Failed to create wdtest kthread.\n", __func__);
+		wdtest_task = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+module_init(clocksource_wdtest_init);
+module_exit(clocksource_wdtest_cleanup);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a6de23800b65..f9466dcd4bf3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -199,8 +199,9 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-static ulong max_read_retries = 3;
-module_param(max_read_retries, ulong, 0644);
+ulong max_cswd_read_retries = 3;
+module_param(max_cswd_read_retries, ulong, 0644);
+EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
@@ -210,7 +211,7 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 	u64 wd_end, wd_delta;
 	int64_t wd_delay;
 
-	for (nretries = 0; nretries <= max_read_retries; nretries++) {
+	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -220,7 +221,7 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_read_retries) {
+			if (nretries > 1 || nretries >= max_cswd_read_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
@@ -293,7 +294,7 @@ static void clocksource_verify_one_cpu(void *csin)
 	csnow_mid = cs->read(cs);
 }
 
-static void clocksource_verify_percpu(struct clocksource *cs)
+void clocksource_verify_percpu(struct clocksource *cs)
 {
 	int64_t cs_nsec, cs_nsec_max = 0, cs_nsec_min = LLONG_MAX;
 	u64 csnow_begin, csnow_end;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2779c29d9981..344735b8b151 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2513,6 +2513,18 @@ config TEST_FPU
 
 	  If unsure, say N.
 
+config TEST_CLOCKSOURCE_WATCHDOG
+	tristate "Test clocksource watchdog in kernel space"
+	depends on CLOCKSOURCE_WATCHDOG
+	help
+	  Enable this option to create a kernel module that will trigger
+	  a test of the clocksource watchdog.  This module may be loaded
+	  via modprobe or insmod in which case it will run upon being
+	  loaded, or it may be built in, in which case it will run
+	  shortly after boot.
+
+	  If unsure, say N.
+
 endif # RUNTIME_TESTING_MENU
 
 config MEMTEST
-- 
2.31.1.189.g2e36527f23

