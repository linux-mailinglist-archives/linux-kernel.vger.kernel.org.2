Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EDB3B4EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhFZNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhFZNIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263B461C59;
        Sat, 26 Jun 2021 13:05:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx80B-000ErD-5Z; Sat, 26 Jun 2021 09:05:39 -0400
Message-ID: <20210626130539.010501583@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 24/24] trace/osnoise: Support hotplug operations
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

Enable and disable osnoise/timerlat thread during on CPU hotplug online
and offline operations respectivelly.

Link: https://lore.kernel.org/linux-doc/20210621134636.5b332226@oasis.local.home/
Link: https://lkml.kernel.org/r/39f98590b3caeb3c32f09526214058efe0e9272a.1624372313.git.bristot@redhat.com

Cc: Phil Auld <pauld@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kate Carcia <kcarcia@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 165 ++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 8546e66bafcb..38aa5e208ffd 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1416,22 +1416,67 @@ static int timerlat_main(void *data)
 #endif /* CONFIG_TIMERLAT_TRACER */
 
 /*
- * stop_per_cpu_kthread - stop per-cpu threads
+ * stop_kthread - stop a workload thread
+ */
+static void stop_kthread(unsigned int cpu)
+{
+	struct task_struct *kthread;
+
+	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+	if (kthread)
+		kthread_stop(kthread);
+	per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+}
+
+/*
+ * stop_per_cpu_kthread - Stop per-cpu threads
  *
  * Stop the osnoise sampling htread. Use this on unload and at system
  * shutdown.
  */
 static void stop_per_cpu_kthreads(void)
 {
-	struct task_struct *kthread;
 	int cpu;
 
-	for_each_online_cpu(cpu) {
-		kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
-		if (kthread)
-			kthread_stop(kthread);
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+	get_online_cpus();
+
+	for_each_online_cpu(cpu)
+		stop_kthread(cpu);
+
+	put_online_cpus();
+}
+
+/*
+ * start_kthread - Start a workload tread
+ */
+static int start_kthread(unsigned int cpu)
+{
+	struct task_struct *kthread;
+	void *main = osnoise_main;
+	char comm[24];
+
+#ifdef CONFIG_TIMERLAT_TRACER
+	if (osnoise_data.timerlat_tracer) {
+		snprintf(comm, 24, "timerlat/%d", cpu);
+		main = timerlat_main;
+	} else {
+		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
+#else
+	snprintf(comm, 24, "osnoise/%d", cpu);
+#endif
+	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		stop_per_cpu_kthreads();
+		return -ENOMEM;
+	}
+
+	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	wake_up_process(kthread);
+
+	return 0;
 }
 
 /*
@@ -1443,9 +1488,7 @@ static void stop_per_cpu_kthreads(void)
 static int start_per_cpu_kthreads(struct trace_array *tr)
 {
 	struct cpumask *current_mask = &save_cpumask;
-	struct task_struct *kthread;
-	char comm[24];
-	void *main = osnoise_main;
+	int retval;
 	int cpu;
 
 	get_online_cpus();
@@ -1457,37 +1500,91 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	 * And the CPU is online.
 	 */
 	cpumask_and(current_mask, cpu_online_mask, current_mask);
-	put_online_cpus();
 
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 
 	for_each_cpu(cpu, current_mask) {
-#ifdef CONFIG_TIMERLAT_TRACER
-		if (osnoise_data.timerlat_tracer) {
-			snprintf(comm, 24, "timerlat/%d", cpu);
-			main = timerlat_main;
-		} else {
-			snprintf(comm, 24, "osnoise/%d", cpu);
-		}
-#else
-		snprintf(comm, 24, "osnoise/%d", cpu);
-#endif
-		kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
-
-		if (IS_ERR(kthread)) {
-			pr_err(BANNER "could not start sampling thread\n");
+		retval = start_kthread(cpu);
+		if (retval) {
 			stop_per_cpu_kthreads();
-			return -ENOMEM;
+			return retval;
 		}
-
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
-		wake_up_process(kthread);
 	}
 
+	put_online_cpus();
+
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void osnoise_hotplug_workfn(struct work_struct *dummy)
+{
+	struct trace_array *tr = osnoise_trace;
+	unsigned int cpu = smp_processor_id();
+
+
+	mutex_lock(&trace_types_lock);
+
+	if (!osnoise_busy)
+		goto out_unlock_trace;
+
+	mutex_lock(&interface_lock);
+	get_online_cpus();
+
+	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
+		goto out_unlock;
+
+	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
+		goto out_unlock;
+
+	start_kthread(cpu);
+
+out_unlock:
+	put_online_cpus();
+	mutex_unlock(&interface_lock);
+out_unlock_trace:
+	mutex_unlock(&trace_types_lock);
+}
+
+static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
+
+/*
+ * osnoise_cpu_init - CPU hotplug online callback function
+ */
+static int osnoise_cpu_init(unsigned int cpu)
+{
+	schedule_work_on(cpu, &osnoise_hotplug_work);
+	return 0;
+}
+
+/*
+ * osnoise_cpu_die - CPU hotplug offline callback function
+ */
+static int osnoise_cpu_die(unsigned int cpu)
+{
+	stop_kthread(cpu);
+	return 0;
+}
+
+static void osnoise_init_hotplug_support(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "trace/osnoise:online",
+				osnoise_cpu_init, osnoise_cpu_die);
+	if (ret < 0)
+		pr_warn(BANNER "Error to init cpu hotplug support\n");
+
+	return;
+}
+#else /* CONFIG_HOTPLUG_CPU */
+static void osnoise_init_hotplug_support(void)
+{
+	return 0;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * osnoise_cpus_read - Read function for reading the "cpus" file
  * @filp: The active open file structure
@@ -1583,7 +1680,14 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 		osnoise_tracer_stop(tr);
 
 	mutex_lock(&interface_lock);
+	/*
+	 * osnoise_cpumask is read by CPU hotplug operations.
+	 */
+	get_online_cpus();
+
 	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
+
+	put_online_cpus();
 	mutex_unlock(&interface_lock);
 
 	if (running)
@@ -1940,6 +2044,7 @@ __init static int init_osnoise_tracer(void)
 		return ret;
 	}
 #endif
+	osnoise_init_hotplug_support();
 
 	init_tracefs();
 
-- 
2.30.2
