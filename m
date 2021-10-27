Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDC043D5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJ0VoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:44:16 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53350 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233454AbhJ0VoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:44:15 -0400
X-Greylist: delayed 3426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 17:44:15 EDT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 19RKhn5e001184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 13:43:52 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 13:43:31 -0700
Received: from yow-pgortmak-d1.wrs.com (128.224.56.57) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 13:43:30 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 1/2] sched: isolation: cpu isolation handles for cpuset
Date:   Wed, 27 Oct 2021 16:43:18 -0400
Message-ID: <20211027204319.22697-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211027204319.22697-1-paul.gortmaker@windriver.com>
References: <20211027204319.22697-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming we want to drive isolation from cpuset and not something
like /sys/devices/system/cpu/cpu*/hotplug/isolation then we'll
need some kind of handle for cpuset to drive it from.

These would also serve as a collection point for all the isolation
related operations - current and future.  While only RCU nocb toggle
is currently deployed, I've left some guesses at what is probably to
come in the future.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
[PG: RFC code - not for merge]
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/sched/isolation.h |  4 ++++
 kernel/sched/isolation.c        | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cc9f393e2a70..3ab9c667c441 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -25,6 +25,8 @@ extern bool housekeeping_enabled(enum hk_flags flags);
 extern void housekeeping_affine(struct task_struct *t, enum hk_flags flags);
 extern bool housekeeping_test_cpu(int cpu, enum hk_flags flags);
 extern void __init housekeeping_init(void);
+extern void isolate_cpu(int cpu);
+extern void deisolate_cpu(int cpu);
 
 #else
 
@@ -46,6 +48,8 @@ static inline bool housekeeping_enabled(enum hk_flags flags)
 static inline void housekeeping_affine(struct task_struct *t,
 				       enum hk_flags flags) { }
 static inline void housekeeping_init(void) { }
+static void isolate_cpu(int cpu) { }
+static void deisolate_cpu(int cpu) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf12818..57b105d42632 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -63,6 +63,28 @@ bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+void isolate_cpu(int cpu)
+{
+	pr_info("Isolating core %d\n", cpu);
+	if (rcu_nocb_cpu_offload(cpu))
+		pr_warn("RCU; unable to nocb offload CPU %d\n", cpu);
+#if 0	/* TODO */
+	housekeeping_clear_cpu(cpu);
+	tick_nohz_full_add_cpus_to(cpumask_of(cpu));
+#endif
+}
+
+void deisolate_cpu(int cpu)
+{
+	pr_info("Deisolating core %d\n", cpu);
+#if 0	/* TODO */
+	tick_nohz_full_clear_cpus_from(cpumask_of(cpu));
+	housekeeping_add_cpu(cpu);
+#endif
+	if (rcu_nocb_cpu_deoffload(cpu))
+		pr_warn("RCU: unable to nocb reload CPU %d\n", cpu);
+}
+
 void __init housekeeping_init(void)
 {
 	if (!housekeeping_flags)
-- 
2.15.0

