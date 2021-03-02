Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021DE32A0F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhCBEq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:46:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:30313 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381005AbhCBCzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:55:09 -0500
IronPort-SDR: 3ITWqOIoAChKB6/nNNo6ztnMZ93LJiq5UL9txBh+iEUtYJxHqBJs1yST99RVLhLnsi6svO/Eq7
 tfuY3C+rD36w==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="185992775"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="185992775"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 18:54:27 -0800
IronPort-SDR: bmdWUdfOIPqUlZLY1pawC/bRyxvXqDLStBkwfZBjSfqFmAwiCP67RA/9ydiO5cjZrEHTvBoTUu
 j8BA71BHJ7kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="398030697"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2021 18:54:25 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, andi.kleen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH] clocksource: don't run watchdog forever
Date:   Tue,  2 Mar 2021 10:54:24 +0800
Message-Id: <1614653665-20905-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clocksource watchdog runs every 500ms, which creates some OS noise.
As the clocksource wreckage (especially for those that has per-cpu
reading hook) usually happens shortly after CPU is brought up or
after system resumes from sleep state, so add a time limit for
clocksource watchdog to only run for a period of time, and make
sure it run at least twice for each CPU.

Regarding performance data, there is no improvement data with the
micro-benchmarks we have like hackbench/netperf/fio/will-it-scale
etc. But it obviously reduces periodic timer interrupts, and may
help in following cases:
* When some CPUs are isolated to only run scientific or high
  performance computing tasks on a NOHZ_FULL kernel, where there
  is almost no interrupts, this could make it more quiet
* On a cluster which runs a lot of systems in parallel with
  barriers there are always enough systems which run the watchdog
  and make everyone else wait

Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 include/linux/clocksource.h |  7 +++++++
 kernel/cpu.c                |  3 +++
 kernel/time/clocksource.c   | 31 +++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 86d143d..cf428a2 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -252,6 +252,13 @@ static inline void __clocksource_update_freq_khz(struct clocksource *cs, u32 khz
 	__clocksource_update_freq_scale(cs, 1000, khz);
 }
 
+#ifdef CONFIG_CLOCKSOURCE_WATCHDOG
+extern void clocksource_kick_watchdog(void);
+#else
+static inline void clocksource_kick_watchdog(void) { }
+#endif
+
+
 #ifdef CONFIG_ARCH_CLOCKSOURCE_INIT
 extern void clocksource_arch_init(struct clocksource *cs);
 #else
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302e..fdf3c69 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -32,6 +32,7 @@
 #include <linux/relay.h>
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/clocksource.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1286,6 +1287,8 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 	}
 
 	err = _cpu_up(cpu, 0, target);
+
+	clocksource_kick_watchdog();
 out:
 	cpu_maps_update_done();
 	return err;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cce484a..aba985a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -104,6 +104,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static unsigned long watchdog_stop_time;	/* in jiffies */
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -295,10 +296,16 @@ static void clocksource_watchdog(struct timer_list *unused)
 		next_cpu = cpumask_first(cpu_online_mask);
 
 	/*
-	 * Arm timer if not already pending: could race with concurrent
-	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
+	 * Arm timer if not already pending or pass the check time window:
+	 * could race with concurrent pair clocksource_stop_watchdog()
+	 * clocksource_start_watchdog().
 	 */
 	if (!timer_pending(&watchdog_timer)) {
+		if (time_after(jiffies, watchdog_stop_time)) {
+			atomic_inc(&watchdog_reset_pending);
+			watchdog_running = 0;
+			goto out;
+		}
 		watchdog_timer.expires += WATCHDOG_INTERVAL;
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
@@ -308,6 +315,16 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 static inline void clocksource_start_watchdog(void)
 {
+	unsigned long check_ticks;
+
+	/*
+	 * As all CPUs will be looped to run the timer, make sure each
+	 * CPU can run the timer twice, and the check run for at least
+	 * 10 minutes.
+	 */
+	check_ticks = max_t(unsigned long, num_possible_cpus(), 600) * HZ;
+	watchdog_stop_time = jiffies + check_ticks;
+
 	if (watchdog_running || !watchdog || list_empty(&watchdog_list))
 		return;
 	timer_setup(&watchdog_timer, clocksource_watchdog, 0);
@@ -324,6 +341,15 @@ static inline void clocksource_stop_watchdog(void)
 	watchdog_running = 0;
 }
 
+void clocksource_kick_watchdog(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&watchdog_lock, flags);
+	clocksource_start_watchdog();
+	spin_unlock_irqrestore(&watchdog_lock, flags);
+}
+
 static inline void clocksource_reset_watchdog(void)
 {
 	struct clocksource *cs;
@@ -618,6 +644,7 @@ void clocksource_resume(void)
 			cs->resume(cs);
 
 	clocksource_resume_watchdog();
+	clocksource_kick_watchdog();
 }
 
 /**
-- 
2.7.4

