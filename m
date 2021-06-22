Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40493B07CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFVOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232108AbhFVOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eebi0WrpI9Gy43hWF2jkUFa8UxVoGGi5E6o3ye5YN84=;
        b=YWkdOu0/nWhI9+mLSZYTOEIXJsD0vIsl2dm25fSz4qg+Yyo89Myrp/Nu/kykkbR6AdBsoo
        ataU8zCSsKLFQfLb+s+zYjLspiVXws90caE8JdZ7bcyQ9xbdz4h+XUgzKGI10HI0mtlfDY
        2TwtpbwAm7vjg85eGOCw1IalUQDM4Ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-4a7nCJmSMDSwDM7wVkmNpQ-1; Tue, 22 Jun 2021 10:45:07 -0400
X-MC-Unique: 4a7nCJmSMDSwDM7wVkmNpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D032C1084F57;
        Tue, 22 Jun 2021 14:45:05 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6FA15D9CA;
        Tue, 22 Jun 2021 14:44:57 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 14/14] trace/osnoise: Support hotplug operations
Date:   Tue, 22 Jun 2021 16:42:32 +0200
Message-Id: <39f98590b3caeb3c32f09526214058efe0e9272a.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and disable osnoise/timerlat thread during on CPU hotplug online
and offline operations respectivelly.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_osnoise.c | 165 ++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f4b1330ac89d..e8a63af1aeb6 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1414,22 +1414,67 @@ static int timerlat_main(void *data)
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
@@ -1441,9 +1486,7 @@ static void stop_per_cpu_kthreads(void)
 static int start_per_cpu_kthreads(struct trace_array *tr)
 {
 	struct cpumask *current_mask = &save_cpumask;
-	struct task_struct *kthread;
-	char comm[24];
-	void *main = osnoise_main;
+	int retval;
 	int cpu;
 
 	get_online_cpus();
@@ -1455,37 +1498,91 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
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
@@ -1581,7 +1678,14 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
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
@@ -1938,6 +2042,7 @@ __init static int init_osnoise_tracer(void)
 		return ret;
 	}
 #endif
+	osnoise_init_hotplug_support();
 
 	init_tracefs();
 
-- 
2.31.1

