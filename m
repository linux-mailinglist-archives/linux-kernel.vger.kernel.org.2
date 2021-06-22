Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3F3B07B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhFVOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231514AbhFVOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4FKNliD10WY2YFI3hbtNgeiM3iEWZDXkap9tKr4R8g=;
        b=daAMtwjnE79duCK+dnsi14zwg+xAHocMx5L4+4AEr0gKXuEPqO8X2yvY7wAUlTmHkNAt/y
        s5bEft/8Ruw2LgAZbfukkcUURDAeJxAAFkD3JIK+E6buBjylm4q+WP2zxJYNb0EaXkRiJo
        Zul2lx/2TpbK7Q8dBq8nNVGVt32HyhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-3r_aMMDqNqqcjHqnslCbbA-1; Tue, 22 Jun 2021 10:43:28 -0400
X-MC-Unique: 3r_aMMDqNqqcjHqnslCbbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5212719251A0;
        Tue, 22 Jun 2021 14:43:27 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EEBC5D9CA;
        Tue, 22 Jun 2021 14:43:22 +0000 (UTC)
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
Subject: [PATCH V5 04/14] trace/hwlat: Implement the per-cpu mode
Date:   Tue, 22 Jun 2021 16:42:22 +0200
Message-Id: <ec06d0ab340e8460d293772faba19ad8a5c371aa.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements the per-cpu mode in which a sampling thread is created for
each cpu in the "cpus" (and tracing_mask).

The per-cpu mode has the potention to speed up the hwlat detection by
running on multiple CPUs at the same time, at the cost of higher cpu
usage with irqs disabled. Use with care.

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
 Documentation/trace/hwlat_detector.rst |   3 +-
 kernel/trace/trace_hwlat.c             | 186 ++++++++++++++++++++-----
 2 files changed, 152 insertions(+), 37 deletions(-)

diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
index 4d952df0586a..de94b499b0bc 100644
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -78,10 +78,11 @@ in /sys/kernel/tracing:
  - hwlat_detector/window	- amount of time between (width) runs (usecs)
  - hwlat_detector/mode	- the thread mode
 
-By default, the hwlat detector's kernel thread will migrate across each CPU
+By default, one hwlat detector's kernel thread will migrate across each CPU
 specified in cpumask at the beginning of a new window, in a round-robin
 fashion. This behavior can be changed by changing the thread mode,
 the available options are:
 
  - none:        do not force migration
  - round-robin: migrate across each CPU specified in cpumask [default]
+ - per-cpu:     create one thread for each cpu in tracing_cpumask
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index bae74b95cf55..5a85d696a167 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -54,9 +54,6 @@ static struct trace_array	*hwlat_trace;
 #define DEFAULT_SAMPLE_WIDTH	500000			/* 0.5s */
 #define DEFAULT_LAT_THRESHOLD	10			/* 10us */
 
-/* sampling thread*/
-static struct task_struct *hwlat_kthread;
-
 static struct dentry *hwlat_sample_width;	/* sample width us */
 static struct dentry *hwlat_sample_window;	/* sample window us */
 static struct dentry *hwlat_thread_mode;	/* hwlat thread mode */
@@ -64,18 +61,26 @@ static struct dentry *hwlat_thread_mode;	/* hwlat thread mode */
 enum {
 	MODE_NONE = 0,
 	MODE_ROUND_ROBIN,
+	MODE_PER_CPU,
 	MODE_MAX
 };
-static char *thread_mode_str[] = { "none", "round-robin" };
+static char *thread_mode_str[] = { "none", "round-robin", "per-cpu" };
 
 /* Save the previous tracing_thresh value */
 static unsigned long save_tracing_thresh;
 
-/* NMI timestamp counters */
-static u64 nmi_ts_start;
-static u64 nmi_total_ts;
-static int nmi_count;
-static int nmi_cpu;
+/* runtime kthread data */
+struct hwlat_kthread_data {
+	struct task_struct	*kthread;
+	/* NMI timestamp counters */
+	u64			nmi_ts_start;
+	u64			nmi_total_ts;
+	int			nmi_count;
+	int			nmi_cpu;
+};
+
+struct hwlat_kthread_data hwlat_single_cpu_data;
+DEFINE_PER_CPU(struct hwlat_kthread_data, hwlat_per_cpu_data);
 
 /* Tells NMIs to call back to the hwlat tracer to record timestamps */
 bool trace_hwlat_callback_enabled;
@@ -112,6 +117,14 @@ static struct hwlat_data {
 	.thread_mode		= MODE_ROUND_ROBIN
 };
 
+struct hwlat_kthread_data *get_cpu_data(void)
+{
+	if (hwlat_data.thread_mode == MODE_PER_CPU)
+		return this_cpu_ptr(&hwlat_per_cpu_data);
+	else
+		return &hwlat_single_cpu_data;
+}
+
 static bool hwlat_busy;
 
 static void trace_hwlat_sample(struct hwlat_sample *sample)
@@ -149,7 +162,9 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
 
 void trace_hwlat_callback(bool enter)
 {
-	if (smp_processor_id() != nmi_cpu)
+	struct hwlat_kthread_data *kdata = get_cpu_data();
+
+	if (!kdata->kthread)
 		return;
 
 	/*
@@ -158,13 +173,13 @@ void trace_hwlat_callback(bool enter)
 	 */
 	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
 		if (enter)
-			nmi_ts_start = time_get();
+			kdata->nmi_ts_start = time_get();
 		else
-			nmi_total_ts += time_get() - nmi_ts_start;
+			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
 	}
 
 	if (enter)
-		nmi_count++;
+		kdata->nmi_count++;
 }
 
 /**
@@ -176,6 +191,7 @@ void trace_hwlat_callback(bool enter)
  */
 static int get_sample(void)
 {
+	struct hwlat_kthread_data *kdata = get_cpu_data();
 	struct trace_array *tr = hwlat_trace;
 	struct hwlat_sample s;
 	time_type start, t1, t2, last_t2;
@@ -188,9 +204,8 @@ static int get_sample(void)
 
 	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
 
-	nmi_cpu = smp_processor_id();
-	nmi_total_ts = 0;
-	nmi_count = 0;
+	kdata->nmi_total_ts = 0;
+	kdata->nmi_count = 0;
 	/* Make sure NMIs see this first */
 	barrier();
 
@@ -260,15 +275,15 @@ static int get_sample(void)
 		ret = 1;
 
 		/* We read in microseconds */
-		if (nmi_total_ts)
-			do_div(nmi_total_ts, NSEC_PER_USEC);
+		if (kdata->nmi_total_ts)
+			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
 
 		hwlat_data.count++;
 		s.seqnum = hwlat_data.count;
 		s.duration = sample;
 		s.outer_duration = outer_sample;
-		s.nmi_total_ts = nmi_total_ts;
-		s.nmi_count = nmi_count;
+		s.nmi_total_ts = kdata->nmi_total_ts;
+		s.nmi_count = kdata->nmi_count;
 		s.count = count;
 		trace_hwlat_sample(&s);
 
@@ -364,21 +379,40 @@ static int kthread_fn(void *data)
 }
 
 /*
- * start_kthread - Kick off the hardware latency sampling/detector kthread
+ * stop_stop_kthread - Inform the hardware latency sampling/detector kthread to stop
+ *
+ * This kicks the running hardware latency sampling/detector kernel thread and
+ * tells it to stop sampling now. Use this on unload and at system shutdown.
+ */
+static void stop_single_kthread(void)
+{
+	struct hwlat_kthread_data *kdata = get_cpu_data();
+	struct task_struct *kthread = kdata->kthread;
+
+	if (!kthread)
+		return;
+
+	kthread_stop(kthread);
+	kdata->kthread = NULL;
+}
+
+
+/*
+ * start_single_kthread - Kick off the hardware latency sampling/detector kthread
  *
  * This starts the kernel thread that will sit and sample the CPU timestamp
  * counter (TSC or similar) and look for potential hardware latencies.
  */
-static int start_kthread(struct trace_array *tr)
+static int start_single_kthread(struct trace_array *tr)
 {
+	struct hwlat_kthread_data *kdata = get_cpu_data();
 	struct cpumask *current_mask = &save_cpumask;
 	struct task_struct *kthread;
 	int next_cpu;
 
-	if (hwlat_kthread)
+	if (kdata->kthread)
 		return 0;
 
-
 	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -400,24 +434,97 @@ static int start_kthread(struct trace_array *tr)
 
 	sched_setaffinity(kthread->pid, current_mask);
 
-	hwlat_kthread = kthread;
+	kdata->kthread = kthread;
 	wake_up_process(kthread);
 
 	return 0;
 }
 
 /*
- * stop_kthread - Inform the hardware latency sampling/detector kthread to stop
+ * stop_cpu_kthread - Stop a hwlat cpu kthread
+ */
+static void stop_cpu_kthread(unsigned int cpu)
+{
+	struct task_struct *kthread;
+
+	kthread = per_cpu(hwlat_per_cpu_data, cpu).kthread;
+	if (kthread)
+		kthread_stop(kthread);
+}
+
+/*
+ * stop_per_cpu_kthreads - Inform the hardware latency sampling/detector kthread to stop
  *
- * This kicks the running hardware latency sampling/detector kernel thread and
+ * This kicks the running hardware latency sampling/detector kernel threads and
  * tells it to stop sampling now. Use this on unload and at system shutdown.
  */
-static void stop_kthread(void)
+static void stop_per_cpu_kthreads(void)
 {
-	if (!hwlat_kthread)
-		return;
-	kthread_stop(hwlat_kthread);
-	hwlat_kthread = NULL;
+	unsigned int cpu;
+
+	get_online_cpus();
+	for_each_online_cpu(cpu)
+		stop_cpu_kthread(cpu);
+	put_online_cpus();
+}
+
+/*
+ * start_cpu_kthread - Start a hwlat cpu kthread
+ */
+static int start_cpu_kthread(unsigned int cpu)
+{
+	struct task_struct *kthread;
+	char comm[24];
+
+	snprintf(comm, 24, "hwlatd/%d", cpu);
+
+	kthread = kthread_create_on_cpu(kthread_fn, NULL, cpu, comm);
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		return -ENOMEM;
+	}
+
+	per_cpu(hwlat_per_cpu_data, cpu).kthread = kthread;
+	wake_up_process(kthread);
+
+	return 0;
+}
+
+/*
+ * start_per_cpu_kthreads - Kick off the hardware latency sampling/detector kthreads
+ *
+ * This starts the kernel threads that will sit on potentially all cpus and
+ * sample the CPU timestamp counter (TSC or similar) and look for potential
+ * hardware latencies.
+ */
+static int start_per_cpu_kthreads(struct trace_array *tr)
+{
+	struct cpumask *current_mask = &save_cpumask;
+	unsigned int cpu;
+	int retval;
+
+	get_online_cpus();
+	/*
+	 * Run only on CPUs in which hwlat is allowed to run.
+	 */
+	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+
+	for_each_online_cpu(cpu)
+		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
+
+	for_each_cpu(cpu, current_mask) {
+		retval = start_cpu_kthread(cpu);
+		if (retval)
+			goto out_error;
+	}
+	put_online_cpus();
+
+	return 0;
+
+out_error:
+	put_online_cpus();
+	stop_per_cpu_kthreads();
+	return retval;
 }
 
 /*
@@ -600,7 +707,8 @@ static void hwlat_tracer_stop(struct trace_array *tr);
  * The "none" sets the allowed cpumask for a single hwlatd thread at the
  * startup and lets the scheduler handle the migration. The default mode is
  * the "round-robin" one, in which a single hwlatd thread runs, migrating
- * among the allowed CPUs in a round-robin fashion.
+ * among the allowed CPUs in a round-robin fashion. The "per-cpu" mode
+ * creates one hwlatd thread per allowed CPU.
  */
 static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 				 size_t cnt, loff_t *ppos)
@@ -724,14 +832,20 @@ static void hwlat_tracer_start(struct trace_array *tr)
 {
 	int err;
 
-	err = start_kthread(tr);
+	if (hwlat_data.thread_mode == MODE_PER_CPU)
+		err = start_per_cpu_kthreads(tr);
+	else
+		err = start_single_kthread(tr);
 	if (err)
 		pr_err(BANNER "Cannot start hwlat kthread\n");
 }
 
 static void hwlat_tracer_stop(struct trace_array *tr)
 {
-	stop_kthread();
+	if (hwlat_data.thread_mode == MODE_PER_CPU)
+		stop_per_cpu_kthreads();
+	else
+		stop_single_kthread();
 }
 
 static int hwlat_tracer_init(struct trace_array *tr)
@@ -760,7 +874,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
 
 static void hwlat_tracer_reset(struct trace_array *tr)
 {
-	stop_kthread();
+	hwlat_tracer_stop(tr);
 
 	/* the tracing threshold is static between runs */
 	last_tracing_thresh = tracing_thresh;
-- 
2.31.1

