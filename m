Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5443F43F6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 05:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhHWDeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 23:34:05 -0400
Received: from mail-m17664.qiye.163.com ([59.111.176.64]:50328 "EHLO
        mail-m17664.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhHWDeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:34:04 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Aug 2021 23:34:03 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [116.31.82.26])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id 805501400E9;
        Mon, 23 Aug 2021 11:33:18 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH,RESEND] softirq: Introduce SOFTIRQ_FORCED_THREADING
Date:   Mon, 23 Aug 2021 11:33:01 +0800
Message-Id: <1629689583-25324-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoaHkhWTk5DGB0fGUtPSk
        0eVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6NBw5NT8CFwpCITUXPAoP
        CBJPFD1VSlVKTUlCTUNCTkJCTEJKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSkpN
        VUhKVUNJVUlNWVdZCAFZQU5KS0w3Bg++
X-HM-Tid: 0a7b7111d36fda2fkuws805501400e9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, whether the softirq is executed when the interrupt exits 
is controlled by IRQ_FORCED_THREADING. This is unreasonable. It should 
be split and allowed to take effect separately.

At the same time, we should increase the priority of ksoftirqd when
forbidden to execute in interrupt exits. I refer to the implementation 
of PREEMPT_RT and think it is reasonable.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/Kconfig.preempt | 10 ++++++++++
 kernel/irq/Kconfig     |  3 ++-
 kernel/softirq.c       | 21 ++++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 5876e30..42d60e7
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -60,6 +60,7 @@ config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
 	select PREEMPTION
+	select SOFTIRQ_FORCED_THREADING
 	help
 	  This option turns the kernel into a real-time kernel by replacing
 	  various locking primitives (spinlocks, rwlocks, etc.) with
@@ -118,4 +119,13 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
+config SOFTIRQ_FORCED_THREADING
+	bool "Balance softirq execute"
+	help
+	 This option will force the softirq to be executed in ksoftirqd,
+	 cancel its execution timing when the interrupt exits, and change
+	 ksoftirqd to a real-time process.

+	 In this way, the execution of softirq can be executed more balanced,
+	 and the maximum scheduling delay caused by the execution of softirq
+	 in the RT process can be reduced.
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2..ecd3236
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -111,7 +111,8 @@ config GENERIC_IRQ_RESERVATION_MODE
 
 # Support forced irq threading
 config IRQ_FORCED_THREADING
-       bool
+    bool
+	select SOFTIRQ_FORCED_THREADING
 
 config SPARSE_IRQ
 	bool "Support sparse irq numbering" if MAY_HAVE_SPARSE_IRQ
diff --git a/kernel/softirq.c b/kernel/softirq.c
index f3a0121..f02f0d9
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -29,6 +29,7 @@
 #include <linux/wait_bit.h>
 
 #include <asm/softirq_stack.h>
+#include <uapi/linux/sched/types.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
@@ -417,12 +418,18 @@ static inline bool should_wake_ksoftirqd(void)
 	return true;
 }
 
+#ifdef CONFIG_SOFTIRQ_FORCED_THREADING
+static inline void invoke_softirq(void)
+{
+	wakeup_softirqd();
+}
+#else
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
-	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
+	if (!__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
@@ -442,6 +449,7 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 	}
 }
+#endif
 
 asmlinkage __visible void do_softirq(void)
 {
@@ -909,6 +917,14 @@ static int ksoftirqd_should_run(unsigned int cpu)
 	return local_softirq_pending();
 }
 
+#ifdef CONFIG_SOFTIRQ_FORCED_THREADING
+static void ksoftirqd_set_sched_params(unsigned int cpu)
+{
+	struct sched_param param = { .sched_priority = 1 };
+	sched_setscheduler(current, SCHED_FIFO, &param);
+}
+#endif
+
 static void run_ksoftirqd(unsigned int cpu)
 {
 	ksoftirqd_run_begin();
@@ -957,6 +973,9 @@ static int takeover_tasklets(unsigned int cpu)
 
 static struct smp_hotplug_thread softirq_threads = {
 	.store			= &ksoftirqd,
+#ifdef CONFIG_SOFTIRQ_FORCED_THREADING
+	.setup			= ksoftirqd_set_sched_params,
+#endif
 	.thread_should_run	= ksoftirqd_should_run,
 	.thread_fn		= run_ksoftirqd,
 	.thread_comm		= "ksoftirqd/%u",
-- 
2.7.4

