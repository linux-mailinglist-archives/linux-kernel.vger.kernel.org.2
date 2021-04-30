Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38A036F543
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhD3FJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3FI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9210461452;
        Fri, 30 Apr 2021 05:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619759282;
        bh=WQ3ML70iCxbUEuWweU1TRALmJcFEoKPFoEWOu3/3lgg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fR78TahnAIxuX6G50/WVwuwZDElIfHcGaO7xzkuOL8NJgV3b+2pwv/MxaiguKdoK9
         m517R4XFVmrXD0l0MW3YiCPqSTj3wQVxckREgKXQewzv8OCpwk5jc+qp1vG390z/5+
         2oIziSFJlJUOoQXCcwufYvqegrMVTTZYT5dJoV6GiyZZyB/FZCIL6dArFyNjDItXN2
         gLSbY7E/vGoumvpPNtJDthNtCxCtFWgrYXLoqa/Nr1CNjemeU9tR+RTHTRcccCVkSk
         /dBOPCeHphKpuaFdJstkMRFUq/bdFuIJrB959oXJPnqd46DvPmHY3cBiPV4zAba/tH
         OiMvqW7zb/FYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B3205C04FE; Thu, 29 Apr 2021 22:08:02 -0700 (PDT)
Date:   Thu, 29 Apr 2021 22:08:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210430050802.GD975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
 <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <878s517axu.ffs@nanos.tec.linutronix.de>
 <20210429142641.GU975577@paulmck-ThinkPad-P17-Gen-1>
 <87lf91f177.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf91f177.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 07:30:20PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Thu, Apr 29 2021 at 07:26, Paul E. McKenney wrote:
> > On Thu, Apr 29, 2021 at 10:27:09AM +0200, Thomas Gleixner wrote:
> >> > Or are you saying that the checks should be in the host OS rather than
> >> > in the guests?
> >> 
> >> Yes. That's where it belongs. The host has to make sure that TSC is usable
> >> otherwise it should tell the guest not to use it. Anything else is
> >> wishful thinking and never reliable.
> >
> > Thank you for the confirmation.  I will look into this.
> 
> So the guest might need at least some basic sanity checking unless we
> declare that hypervisors are always working correctly :)
> 
> Which is admittedly more likely than making the same assumption about
> BIOS and hardware.

That could be a tough choice...

> >> > In addition, breakage due to age and environmentals is possible, and if
> >> > you have enough hardware, probable.  In which case it would be good to
> >> > get a notification so that the system in question can be dealt with.
> >> 
> >> Are you trying to find a problem for a solution again?
> >
> > We really do see this thing trigger. > I am trying to get rid of one
> > class of false positives that might be afflicting us.  Along the way,
> > I am thinking aloud about what might be the cause of any remaining
> > skew reports that might trigger in the future.
> 
> Fair enough. Admittedly this has at least entertainment value :)

Glad to help.  I think.  ;-)

> >> Well, you might then also build safety nets for interrupts, exceptions
> >> and if you go fully paranoid for every single CPU instruction. :)
> >
> > Fair, and I doubt that looking at failure data across a large fleet of
> > systems has done anything to reduce my level of paranoia.  ;-)
> 
> You should have known better than opening Pandoras box.

When has that ever stopped anyone?

> >> Sure. If you have a seperate module then you can add module params to it
> >> obviously. But you don't need any of the muck in the actual watchdog
> >> code because the watchdog::read() function in that module will simply
> >> handle the delay injection. Hmm?
> >
> > OK, first let me make sure I understand what you are suggesting.
> >
> > The idea is to leave the watchdog code in kernel/time/clocksource.c,
> > but to move the fault injection into kernel/time/clocksourcefault.c or
> > some such.  In this new file, new clocksource structures are created that
> > use some existing timebase/clocksource under the covers.  These then
> > inject delays based on module parameters (one senstive to CPU number,
> > the other unconditional).  They register these clocksources using the
> > normal interfaces, and verify that they are eventually marked unstable
> > when the fault-injection parameters warrant it.  This is combined with
> > the usual checking of the console log.
> >
> > Or am I missing your point?
> 
> That's what I meant.

OK, here is a sneak preview.  A fair amount of cleanup still needed,
but functional.  I also need to rip out the old error-injection code
and rejigger the commits.  And I of course leverage rcutorture to run
this thing, so there is probably at least one missing export in there
somewhere.

And yes, I did try making clocksource_wdtest_ktime be curr_clocksource,
with the expected (in retrospect, anyway) hilarious results.  Hence the
direct call to clocksource_verify_percpu().

							Thanx, Paul

------------------------------------------------------------------------

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
index 000000000000..e01f09defdf7
--- /dev/null
+++ b/kernel/time/clocksource-wdtest.c
@@ -0,0 +1,198 @@
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
+static int holdoff = IS_BUILTIN(CONFIG_TEST_CLOCKSOURCE_WATCHDOG) ? 20 : 0;
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
+/* Run the specified series of watchdog tests. */
+static int wdtest_func(void *arg)
+{
+	unsigned long j1, j2;
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
+	/* Verify tsc-like stability without error injection. */
+	pr_info("--- Watchdog without error injection.\n");
+	schedule_timeout_uninterruptible(2 * HZ);
+	WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE);
+
+	/* Verify tsc-like stability with various numbers of errors injected. */
+	for (i = 1; i <= max_cswd_read_retries + 1; i++) {
+		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n",
+			i, max_cswd_read_retries,
+			i <= 1 ? "" : i <= max_cswd_read_retries
+					? ", expect message"
+					: ", expect clock skew");
+		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
+		schedule_timeout_uninterruptible(2 * HZ);
+		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
+		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
+		if (clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE) {
+			clocksource_unregister(&clocksource_wdtest_ktime);
+			clocksource_wdtest_ktime.flags = KTIME_FLAGS;
+			schedule_timeout_uninterruptible(HZ / 10);
+			clocksource_register_khz(&clocksource_wdtest_ktime, 1000 * 1000);
+		}
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
index 328a65ddb959..2b2937551bfe 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -206,8 +206,9 @@ static ulong inject_delay_repeat = 1;
 module_param(inject_delay_repeat, ulong, 0644);
 static int inject_delay_shift_percpu = -1;
 module_param(inject_delay_shift_percpu, int, 0644);
-static ulong max_read_retries = 3;
-module_param(max_read_retries, ulong, 0644);
+ulong max_cswd_read_retries = 3;
+module_param(max_cswd_read_retries, ulong, 0644);
+EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
@@ -233,7 +234,7 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 	u64 wd_end, wd_delta;
 	int64_t wd_delay;
 
-	for (nretries = 0; nretries <= max_read_retries; nretries++) {
+	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		clocksource_watchdog_inject_delay();
@@ -244,7 +245,7 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_read_retries) {
+			if (nretries > 1 || nretries >= max_cswd_read_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
@@ -323,7 +324,7 @@ static void clocksource_verify_one_cpu(void *csin)
 	csnow_mid = cs->read(cs) + delta;
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
