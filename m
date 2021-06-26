Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC403B4EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFZNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhFZNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30F0761C47;
        Sat, 26 Jun 2021 13:05:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx809-000ElZ-7g; Sat, 26 Jun 2021 09:05:37 -0400
Message-ID: <20210626130537.073880448@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:18 -0400
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
Subject: [for-next][PATCH 14/24] trace/hwlat: Implement the per-cpu mode
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

Implements the per-cpu mode in which a sampling thread is created for
each cpu in the "cpus" (and tracing_mask).

The per-cpu mode has the potention to speed up the hwlat detection by
running on multiple CPUs at the same time, at the cost of higher cpu
usage with irqs disabled. Use with care.

[
  Changed get_cpu_data() to static.
  Reported-by: kernel test robot <lkp@intel.com>
]

Link: https://lkml.kernel.org/r/ec06d0ab340e8460d293772faba19ad8a5c371aa.1624372313.git.bristot@redhat.com

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
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
index bae74b95cf55..3957b36826e2 100644
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
 
+static struct hwlat_kthread_data *get_cpu_data(void)
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
2.30.2
