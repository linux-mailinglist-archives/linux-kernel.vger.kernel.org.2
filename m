Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA843A7A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFOJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231536AbhFOJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stvg0megILuPd6NvgqVa+NZDpI9rrbcItm0z8KhGLwc=;
        b=JYrn1HsI2SpCwoPXc53JlOjsRsfp4cvfa7qY1SHB7WzNJtZv+iZb3oYPX74200+uh9XyFd
        1dlXmGSKSuL8S2Zy9f4LZ4RUOuscDAcolgl89CwIpyPKRjcVkwrkfZUSDvKkUeyyLov0QD
        nrIo49sP80KP5veexUkcaJUQSNdKNb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-33FR3KMCMFCN2ejGc2sfpQ-1; Tue, 15 Jun 2021 05:30:06 -0400
X-MC-Unique: 33FR3KMCMFCN2ejGc2sfpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6FFE101C8A8;
        Tue, 15 Jun 2021 09:30:04 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D4D35D6AD;
        Tue, 15 Jun 2021 09:30:00 +0000 (UTC)
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
Subject: [PATCH V4 12/12] trace/osnoise: Support hotplug operations
Date:   Tue, 15 Jun 2021 11:28:51 +0200
Message-Id: <ee28d6e8b028a66a1d624895cf0aa04ddd17cb37.1623746916.git.bristot@redhat.com>
In-Reply-To: <cover.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 kernel/trace/trace_osnoise.c | 133 +++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 2c1e2a074b1e..e8f057a3bdc3 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1399,22 +1399,67 @@ static int timerlat_main(void *data)
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
+	char comm[24];
+	void *main = osnoise_main;
+
+#ifdef CONFIG_TIMERLAT_TRACER
+	if (osnoise_data.timerlat_tracer) {
+		snprintf(comm, 24, "timerlat/%d", cpu);
+		main = timerlat_main;
+	} else {
+		snprintf(comm, 24, "osnoise/%d", cpu);
+	}
+#else
+	snprintf(comm, 24, "osnoise/%d", cpu);
+#endif
+	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		stop_per_cpu_kthreads();
+		return -ENOMEM;
 	}
+
+	per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+	wake_up_process(kthread);
+
+	return 0;
 }
 
 /*
@@ -1426,9 +1471,7 @@ static void stop_per_cpu_kthreads(void)
 static int start_per_cpu_kthreads(struct trace_array *tr)
 {
 	struct cpumask *current_mask = &save_cpumask;
-	struct task_struct *kthread;
-	char comm[24];
-	void *main = osnoise_main;
+	int retval;
 	int cpu;
 
 	get_online_cpus();
@@ -1440,34 +1483,52 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
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
+	return 0;
+}
+
+/*
+ * osnoise_cpu_init - CPU hotplug online callback function
+ */
+static int osnoise_cpu_init(unsigned int cpu)
+{
+	struct trace_array *tr = osnoise_trace;
+
+	if (!osnoise_busy)
+		return 0;
+
+	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
+		return 0;
+
+	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
+		return 0;
+
+	return start_kthread(cpu);
+}
+
+/*
+ * osnoise_cpu_die - CPU hotplug offline callback function
+ */
+static int osnoise_cpu_die(unsigned int cpu)
+{
+	if (!osnoise_busy)
+		return 0;
+
+	stop_kthread(cpu);
+
 	return 0;
 }
 
@@ -1566,7 +1627,14 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 		osnoise_tracer_stop(tr);
 
 	mutex_lock(&interface_lock);
+	/*
+	 * osnoise_cpumask is ready by CPU hotplug operations.
+	 */
+	get_online_cpus();
+
 	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
+
+	put_online_cpus();
 	mutex_unlock(&interface_lock);
 
 	if (running)
@@ -1924,6 +1992,11 @@ __init static int init_osnoise_tracer(void)
 	}
 #endif
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "trace/osnoise:online",
+				osnoise_cpu_init, osnoise_cpu_die);
+	if (ret < 0)
+		pr_warn(BANNER "Error to init cpu hotplug support\n");
+
 	init_tracefs();
 
 	return 0;
-- 
2.31.1

