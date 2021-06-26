Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2623B4EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFZNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhFZNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F5261C3D;
        Sat, 26 Jun 2021 13:05:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx808-000EkS-Rp; Sat, 26 Jun 2021 09:05:36 -0400
Message-ID: <20210626130536.697765823@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:16 -0400
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
Subject: [for-next][PATCH 12/24] trace/hwlat: Implement the mode config option
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

Provides the "mode" config to the hardware latency detector. hwlatd has
two different operation modes. The default mode is the "round-robin" one,
in which a single hwlatd thread runs, migrating among the allowed CPUs in a
"round-robin" fashion. This is the current behavior.

The "none" sets the allowed cpumask for a single hwlatd thread at the
startup, but skips the round-robin, letting the scheduler handle the
migration.

In preparation to the per-cpu mode.

Link: https://lkml.kernel.org/r/f3b1271262aa030c680e26615c1b9b2d71e55e92.1624372313.git.bristot@redhat.com

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
 Documentation/trace/hwlat_detector.rst |  12 +-
 kernel/trace/trace_hwlat.c             | 179 +++++++++++++++++++++++--
 2 files changed, 175 insertions(+), 16 deletions(-)

diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
index 5739349649c8..4d952df0586a 100644
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -76,8 +76,12 @@ in /sys/kernel/tracing:
  - tracing_cpumask	- the CPUs to move the hwlat thread across
  - hwlat_detector/width	- specified amount of time to spin within window (usecs)
  - hwlat_detector/window	- amount of time between (width) runs (usecs)
+ - hwlat_detector/mode	- the thread mode
 
-The hwlat detector's kernel thread will migrate across each CPU specified in
-tracing_cpumask between each window. To limit the migration, either modify
-tracing_cpumask, or modify the hwlat kernel thread (named [hwlatd]) CPU
-affinity directly, and the migration will stop.
+By default, the hwlat detector's kernel thread will migrate across each CPU
+specified in cpumask at the beginning of a new window, in a round-robin
+fashion. This behavior can be changed by changing the thread mode,
+the available options are:
+
+ - none:        do not force migration
+ - round-robin: migrate across each CPU specified in cpumask [default]
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 0a5635401125..43a436d85a01 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -59,6 +59,14 @@ static struct task_struct *hwlat_kthread;
 
 static struct dentry *hwlat_sample_width;	/* sample width us */
 static struct dentry *hwlat_sample_window;	/* sample window us */
+static struct dentry *hwlat_thread_mode;	/* hwlat thread mode */
+
+enum {
+	MODE_NONE = 0,
+	MODE_ROUND_ROBIN,
+	MODE_MAX
+};
+static char *thread_mode_str[] = { "none", "round-robin" };
 
 /* Save the previous tracing_thresh value */
 static unsigned long save_tracing_thresh;
@@ -96,11 +104,16 @@ static struct hwlat_data {
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
 
+	int	thread_mode;		/* thread mode */
+
 } hwlat_data = {
 	.sample_window		= DEFAULT_SAMPLE_WINDOW,
 	.sample_width		= DEFAULT_SAMPLE_WIDTH,
+	.thread_mode		= MODE_ROUND_ROBIN
 };
 
+static bool hwlat_busy;
+
 static void trace_hwlat_sample(struct hwlat_sample *sample)
 {
 	struct trace_array *tr = hwlat_trace;
@@ -328,7 +341,8 @@ static int kthread_fn(void *data)
 
 	while (!kthread_should_stop()) {
 
-		move_to_next_cpu();
+		if (hwlat_data.thread_mode == MODE_ROUND_ROBIN)
+			move_to_next_cpu();
 
 		local_irq_disable();
 		get_sample();
@@ -351,7 +365,7 @@ static int kthread_fn(void *data)
 	return 0;
 }
 
-/**
+/*
  * start_kthread - Kick off the hardware latency sampling/detector kthread
  *
  * This starts the kernel thread that will sit and sample the CPU timestamp
@@ -366,11 +380,6 @@ static int start_kthread(struct trace_array *tr)
 	if (hwlat_kthread)
 		return 0;
 
-	/* Just pick the first CPU on first iteration */
-	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
-	put_online_cpus();
-	next_cpu = cpumask_first(current_mask);
 
 	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
 	if (IS_ERR(kthread)) {
@@ -378,8 +387,19 @@ static int start_kthread(struct trace_array *tr)
 		return -ENOMEM;
 	}
 
-	cpumask_clear(current_mask);
-	cpumask_set_cpu(next_cpu, current_mask);
+
+	/* Just pick the first CPU on first iteration */
+	get_online_cpus();
+	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+	put_online_cpus();
+
+	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
+		next_cpu = cpumask_first(current_mask);
+		cpumask_clear(current_mask);
+		cpumask_set_cpu(next_cpu, current_mask);
+
+	}
+
 	sched_setaffinity(kthread->pid, current_mask);
 
 	hwlat_kthread = kthread;
@@ -388,7 +408,7 @@ static int start_kthread(struct trace_array *tr)
 	return 0;
 }
 
-/**
+/*
  * stop_kthread - Inform the hardware latency sampling/detector kthread to stop
  *
  * This kicks the running hardware latency sampling/detector kernel thread and
@@ -511,6 +531,129 @@ hwlat_window_write(struct file *filp, const char __user *ubuf,
 	return cnt;
 }
 
+static void *s_mode_start(struct seq_file *s, loff_t *pos)
+{
+	int mode = *pos;
+
+	mutex_lock(&hwlat_data.lock);
+
+	if (mode >= MODE_MAX)
+		return NULL;
+
+	return pos;
+}
+
+static void *s_mode_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	int mode = ++(*pos);
+
+	if (mode >= MODE_MAX)
+		return NULL;
+
+	return pos;
+}
+
+static int s_mode_show(struct seq_file *s, void *v)
+{
+	loff_t *pos = v;
+	int mode = *pos;
+
+	if (mode == hwlat_data.thread_mode)
+		seq_printf(s, "[%s]", thread_mode_str[mode]);
+	else
+		seq_printf(s, "%s", thread_mode_str[mode]);
+
+	if (mode != MODE_MAX)
+		seq_puts(s, " ");
+
+	return 0;
+}
+
+static void s_mode_stop(struct seq_file *s, void *v)
+{
+	seq_puts(s, "\n");
+	mutex_unlock(&hwlat_data.lock);
+}
+
+static const struct seq_operations thread_mode_seq_ops = {
+	.start		= s_mode_start,
+	.next		= s_mode_next,
+	.show		= s_mode_show,
+	.stop		= s_mode_stop
+};
+
+static int hwlat_mode_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &thread_mode_seq_ops);
+};
+
+static void hwlat_tracer_start(struct trace_array *tr);
+static void hwlat_tracer_stop(struct trace_array *tr);
+
+/**
+ * hwlat_mode_write - Write function for "mode" entry
+ * @filp: The active open file structure
+ * @ubuf: The user buffer that contains the value to write
+ * @cnt: The maximum number of bytes to write to "file"
+ * @ppos: The current position in @file
+ *
+ * This function provides a write implementation for the "mode" interface
+ * to the hardware latency detector. hwlatd has different operation modes.
+ * The "none" sets the allowed cpumask for a single hwlatd thread at the
+ * startup and lets the scheduler handle the migration. The default mode is
+ * the "round-robin" one, in which a single hwlatd thread runs, migrating
+ * among the allowed CPUs in a round-robin fashion.
+ */
+static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
+				 size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = hwlat_trace;
+	const char *mode;
+	char buf[64];
+	int ret, i;
+
+	if (cnt >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+
+	mode = strstrip(buf);
+
+	ret = -EINVAL;
+
+	/*
+	 * trace_types_lock is taken to avoid concurrency on start/stop
+	 * and hwlat_busy.
+	 */
+	mutex_lock(&trace_types_lock);
+	if (hwlat_busy)
+		hwlat_tracer_stop(tr);
+
+	mutex_lock(&hwlat_data.lock);
+
+	for (i = 0; i < MODE_MAX; i++) {
+		if (strcmp(mode, thread_mode_str[i]) == 0) {
+			hwlat_data.thread_mode = i;
+			ret = cnt;
+		}
+	}
+
+	mutex_unlock(&hwlat_data.lock);
+
+	if (hwlat_busy)
+		hwlat_tracer_start(tr);
+	mutex_unlock(&trace_types_lock);
+
+	*ppos += cnt;
+
+
+
+	return ret;
+}
+
 static const struct file_operations width_fops = {
 	.open		= tracing_open_generic,
 	.read		= hwlat_read,
@@ -523,6 +666,13 @@ static const struct file_operations window_fops = {
 	.write		= hwlat_window_write,
 };
 
+static const struct file_operations thread_mode_fops = {
+	.open		= hwlat_mode_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+	.write		= hwlat_mode_write
+};
 /**
  * init_tracefs - A function to initialize the tracefs interface files
  *
@@ -558,6 +708,13 @@ static int init_tracefs(void)
 	if (!hwlat_sample_width)
 		goto err;
 
+	hwlat_thread_mode = trace_create_file("mode", 0644,
+					      top_dir,
+					      NULL,
+					      &thread_mode_fops);
+	if (!hwlat_thread_mode)
+		goto err;
+
 	return 0;
 
  err:
@@ -579,8 +736,6 @@ static void hwlat_tracer_stop(struct trace_array *tr)
 	stop_kthread();
 }
 
-static bool hwlat_busy;
-
 static int hwlat_tracer_init(struct trace_array *tr)
 {
 	/* Only allow one instance to enable this */
-- 
2.30.2
