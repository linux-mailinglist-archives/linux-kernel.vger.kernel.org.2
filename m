Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B845F30DF46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhBCQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:10:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234915AbhBCQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:08:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1101864FA7;
        Wed,  3 Feb 2021 16:05:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf8-009JCP-W1; Wed, 03 Feb 2021 11:05:50 -0500
Message-ID: <20210203160550.868939346@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Chen <chensong_2000@189.cn>
Subject: [for-next][PATCH 15/15] kernel: trace: preemptirq_delay_test: add cpu affinity
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Chen <chensong_2000@189.cn>

The kernel thread executing test can run on any cpu, which might be
different cpu latency tracer is running on, as a result, the
big latency caused by preemptirq delay test can't be detected.

Therefore, the argument cpu_affinity is added to be passed to test,
ensure it's running on the same cpu with latency tracer.

e.g.
cyclictest -p 90 -m -c 0 -i 1000 -a 3
modprobe preemptirq_delay_test test_mode=preempt delay=500 \
burst_size=3 cpu_affinity=3

Link: https://lkml.kernel.org/r/1611797713-20965-1-git-send-email-chensong_2000@189.cn

Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig                 |  4 ++++
 kernel/trace/preemptirq_delay_test.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 4f976f8d9a38..799dbcfe65ad 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -886,6 +886,10 @@ config PREEMPTIRQ_DELAY_TEST
 	  irq-disabled critical sections for 500us:
 	  modprobe preemptirq_delay_test test_mode=irq delay=500 burst_size=3
 
+	  What's more, if you want to attach the test on the cpu which the latency
+	  tracer is running on, specify cpu_affinity=cpu_num at the end of the
+	  command.
+
 	  If unsure, say N
 
 config SYNTH_EVENT_GEN_TEST
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 312d1a0ca3b6..8c4ffd076162 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -21,13 +21,16 @@
 static ulong delay = 100;
 static char test_mode[12] = "irq";
 static uint burst_size = 1;
+static int  cpu_affinity = -1;
 
 module_param_named(delay, delay, ulong, 0444);
 module_param_string(test_mode, test_mode, 12, 0444);
 module_param_named(burst_size, burst_size, uint, 0444);
+module_param_named(cpu_affinity, cpu_affinity, int, 0444);
 MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
 MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
 MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
+MODULE_PARM_DESC(cpu_affinity, "Cpu num test is running on");
 
 static struct completion done;
 
@@ -36,7 +39,9 @@ static struct completion done;
 static void busy_wait(ulong time)
 {
 	u64 start, end;
+
 	start = trace_clock_local();
+
 	do {
 		end = trace_clock_local();
 		if (kthread_should_stop())
@@ -47,6 +52,7 @@ static void busy_wait(ulong time)
 static __always_inline void irqoff_test(void)
 {
 	unsigned long flags;
+
 	local_irq_save(flags);
 	busy_wait(delay);
 	local_irq_restore(flags);
@@ -113,6 +119,14 @@ static int preemptirq_delay_run(void *data)
 {
 	int i;
 	int s = MIN(burst_size, NR_TEST_FUNCS);
+	struct cpumask cpu_mask;
+
+	if (cpu_affinity > -1) {
+		cpumask_clear(&cpu_mask);
+		cpumask_set_cpu(cpu_affinity, &cpu_mask);
+		if (set_cpus_allowed_ptr(current, &cpu_mask))
+			pr_err("cpu_affinity:%d, failed\n", cpu_affinity);
+	}
 
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
-- 
2.29.2


