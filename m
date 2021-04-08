Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701AC358680
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhDHOOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231696AbhDHOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617891256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzKuaqceOMjx5Z6vpgx0brbefnS2+2sIuheKOvkPVgc=;
        b=Fs6FJs+ucrTVjXYQ2vLPSDbqtlvvSLQLfJi6vKxh5EKaAMhp/LJf1gMr5Nj/7thdm2QkiC
        EDe9Y4d3IHsDAg/dld/eCVYqNBhRviIxKplVCv2GLF3nGmP0zSLhSWyr8zxvVQXiIUdIfW
        XDRk6ABBUpng/wc7Zr2oEz0x+LexBoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-vFJGotRBPoKESqeJAOpLzg-1; Thu, 08 Apr 2021 10:14:15 -0400
X-MC-Unique: vFJGotRBPoKESqeJAOpLzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FBF5189C447;
        Thu,  8 Apr 2021 14:14:13 +0000 (UTC)
Received: from x1.com (ovpn-112-230.rdu2.redhat.com [10.10.112.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F9215B4B0;
        Thu,  8 Apr 2021 14:14:03 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 2/5] tracing/hwlat: Implement the mode config option
Date:   Thu,  8 Apr 2021 16:13:20 +0200
Message-Id: <c6b6ac9274e417b650c7aa9494bcf4f6ca0a1097.1617889883.git.bristot@redhat.com>
In-Reply-To: <cover.1617889883.git.bristot@redhat.com>
References: <cover.1617889883.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides the "mode" config to the hardware latency detector. hwlatd has
two different operation modes. The default mode is the "round-robin" one,
in which a single hwlatd thread runs, migrating among the allowed CPUs in a
"round-robin" fashion. This is the current behavior.

The "none" sets the allowed cpumask for a single hwlatd thread at the
startup, but skips the round-robin, letting the scheduler handle the
migration.

In preparation to the per-cpu mode.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

---
 Documentation/trace/hwlat_detector.rst |  21 +++-
 kernel/trace/trace_hwlat.c             | 157 +++++++++++++++++++++++--
 2 files changed, 162 insertions(+), 16 deletions(-)

diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
index 86f973a7763c..f63fdd867598 100644
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -76,10 +76,19 @@ in /sys/kernel/tracing:
  - hwlat_detector/width - specified amount of time to spin within window (usecs)
  - hwlat_detector/window        - amount of time between (width) runs (usecs)
  - hwlat_detector/cpus  - the CPUs to move the hwlat thread across
+ - hwlat_detector/mode	- the thread mode
+
+By default, the hwlat detector's kernel thread will migrate across each CPU
+specified in cpumask at the beginning of a new window, in a round-robin
+fashion. This behavior can be changed by changing the thread mode,
+the available options are:
+
+ - none:        do not force migration
+ - round-robin: migrate across each CPU specified in cpus between each window
+
+By default, hwlat detector will also obey the tracing_cpumask, so the thread
+will be placed only in the set of cpus that is both on the hwlat detector's
+cpus and in the global tracing_cpumask file. The user can overwrite the
+cpumask by setting it manually. Changing the hwlatd affinity externally,
+e.g., via taskset tool, will disable the round-robin migration.
 
-The hwlat detector's kernel thread will migrate across each CPU specified in
-cpus list between each window. The hwlat detector will also obey the
-tracing_cpumask, so the thread will migrate on the set of cpus that is
-both on its cpus list and in the global tracing_cpumask file.
-To limit the migration, either modify cpumask, or modify the hwlat kernel
-thread (named [hwlatd]) CPU affinity directly, and the migration will stop.
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index deecb93f97f2..3818200c9e24 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -60,6 +60,15 @@ static struct task_struct *hwlat_kthread;
 static struct dentry *hwlat_sample_width;	/* sample width us */
 static struct dentry *hwlat_sample_window;	/* sample window us */
 static struct dentry *hwlat_cpumask_dentry;	/* hwlat cpus allowed */
+static struct dentry *hwlat_thread_mode;	/* hwlat thread mode */
+
+enum {
+	MODE_NONE = 0,
+	MODE_ROUND_ROBIN,
+	MODE_MAX
+};
+
+static char *thread_mode_str[] = { "none", "round-robin" };
 
 /* Save the previous tracing_thresh value */
 static unsigned long save_tracing_thresh;
@@ -97,11 +106,16 @@ static struct hwlat_data {
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
 
+	int	thread_mode;			/* thread mode */
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
@@ -337,7 +351,8 @@ static int kthread_fn(void *data)
 
 	while (!kthread_should_stop()) {
 
-		move_to_next_cpu();
+		if (hwlat_data.thread_mode == MODE_ROUND_ROBIN)
+			move_to_next_cpu();
 
 		local_irq_disable();
 		get_sample();
@@ -375,6 +390,14 @@ static int start_kthread(struct trace_array *tr)
 	if (hwlat_kthread)
 		return 0;
 
+
+	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		return -ENOMEM;
+	}
+
+
 	/* Just pick the first CPU on first iteration */
 	get_online_cpus();
 	/*
@@ -386,16 +409,14 @@ static int start_kthread(struct trace_array *tr)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, current_mask);
 	put_online_cpus();
-	next_cpu = cpumask_first(current_mask);
 
-	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
-	if (IS_ERR(kthread)) {
-		pr_err(BANNER "could not start sampling thread\n");
-		return -ENOMEM;
+	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
+		next_cpu = cpumask_first(current_mask);
+		cpumask_clear(current_mask);
+		cpumask_set_cpu(next_cpu, current_mask);
+
 	}
 
-	cpumask_clear(current_mask);
-	cpumask_set_cpu(next_cpu, current_mask);
 	sched_setaffinity(kthread->pid, current_mask);
 
 	hwlat_kthread = kthread;
@@ -615,6 +636,109 @@ hwlat_window_write(struct file *filp, const char __user *ubuf,
 	return cnt;
 }
 
+static void *s_mode_start(struct seq_file *s, loff_t *pos)
+{
+	int mode = *pos;
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
+	const char *mode;
+	char buf[64];
+	int ret;
+	int i;
+
+	if (hwlat_busy)
+		return -EBUSY;
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
+	for (i = 0; i < MODE_MAX; i++) {
+		if (strcmp(mode, thread_mode_str[i]) == 0) {
+			hwlat_data.thread_mode = i;
+			ret = cnt;
+		}
+	}
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
+
 static const struct file_operations width_fops = {
 	.open		= tracing_open_generic,
 	.read		= hwlat_read,
@@ -634,6 +758,14 @@ static const struct file_operations cpus_fops = {
 	.llseek		= generic_file_llseek,
 };
 
+static const struct file_operations thread_mode_fops = {
+	.open		= hwlat_mode_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+	.write		= hwlat_mode_write
+
+};
 
 /**
  * init_tracefs - A function to initialize the tracefs interface files
@@ -677,6 +809,13 @@ static int init_tracefs(void)
 	if (!hwlat_cpumask_dentry)
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
@@ -698,8 +837,6 @@ static void hwlat_tracer_stop(struct trace_array *tr)
 	stop_kthread();
 }
 
-static bool hwlat_busy;
-
 static int hwlat_tracer_init(struct trace_array *tr)
 {
 	/* Only allow one instance to enable this */
-- 
2.30.2

