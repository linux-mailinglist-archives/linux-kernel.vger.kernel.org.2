Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B100C35867E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhDHOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbhDHOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617891247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muA8b7H7HNJrjHvQw+3zm3oYOLfC/q3YjaIcXh9oGWM=;
        b=dJS4ZkV79I3m5p1Vyngst5vshBUmFwP0R+3qBMX9pVrt5B++PbvkFreCcKK7OP7+PIUac0
        ko4BjG/tq/JhB60whRNAOrWBa14VigdbFTUExud2TJhaMtEhXcp3SOTg962wGNNZGr6TEA
        6i6Vaiz1eJFsltg0OICNwFEW2awhr2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-t_jDGpn5NmaZPsXKQHwNpg-1; Thu, 08 Apr 2021 10:14:04 -0400
X-MC-Unique: t_jDGpn5NmaZPsXKQHwNpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F285189C464;
        Thu,  8 Apr 2021 14:14:03 +0000 (UTC)
Received: from x1.com (ovpn-112-230.rdu2.redhat.com [10.10.112.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A709690F7;
        Thu,  8 Apr 2021 14:14:00 +0000 (UTC)
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
Subject: [RFC PATCH 1/5] tracing/hwlat: Add a cpus file specific for hwlat_detector
Date:   Thu,  8 Apr 2021 16:13:19 +0200
Message-Id: <94bbcd0e0f06b79aeb775e8dbf3a301f6679bb4c.1617889883.git.bristot@redhat.com>
In-Reply-To: <cover.1617889883.git.bristot@redhat.com>
References: <cover.1617889883.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides a "cpus" interface to the hardware latency detector. By
default, it lists all CPUs, allowing hwlatd threads to run on any online
CPU of the system.

It serves to restrict the execution of hwlatd to the set of CPUs writing
via this interface. Note that hwlatd also respects the "tracing_cpumask."
Hence, hwlatd threads will run only on the set of CPUs allowed here AND
on "tracing_cpumask."

Why not keep just "tracing_cpumask"? Because the user might be interested
in tracing what is running on other CPUs. For instance, one might run
hwlatd in one HT CPU while observing what is running on the sibling HT
CPU. The cpu list format is also more intuitive.

Also in preparation to the per-cpu mode.

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
 Documentation/trace/hwlat_detector.rst |  14 +--
 kernel/trace/trace_hwlat.c             | 125 ++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 8 deletions(-)

diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
index 5739349649c8..86f973a7763c 100644
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -73,11 +73,13 @@ in /sys/kernel/tracing:
 
  - tracing_threshold	- minimum latency value to be considered (usecs)
  - tracing_max_latency	- maximum hardware latency actually observed (usecs)
- - tracing_cpumask	- the CPUs to move the hwlat thread across
- - hwlat_detector/width	- specified amount of time to spin within window (usecs)
- - hwlat_detector/window	- amount of time between (width) runs (usecs)
+ - hwlat_detector/width - specified amount of time to spin within window (usecs)
+ - hwlat_detector/window        - amount of time between (width) runs (usecs)
+ - hwlat_detector/cpus  - the CPUs to move the hwlat thread across
 
 The hwlat detector's kernel thread will migrate across each CPU specified in
-tracing_cpumask between each window. To limit the migration, either modify
-tracing_cpumask, or modify the hwlat kernel thread (named [hwlatd]) CPU
-affinity directly, and the migration will stop.
+cpus list between each window. The hwlat detector will also obey the
+tracing_cpumask, so the thread will migrate on the set of cpus that is
+both on its cpus list and in the global tracing_cpumask file.
+To limit the migration, either modify cpumask, or modify the hwlat kernel
+thread (named [hwlatd]) CPU affinity directly, and the migration will stop.
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 34dc1a712dcb..deecb93f97f2 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -59,6 +59,7 @@ static struct task_struct *hwlat_kthread;
 
 static struct dentry *hwlat_sample_width;	/* sample width us */
 static struct dentry *hwlat_sample_window;	/* sample window us */
+static struct dentry *hwlat_cpumask_dentry;	/* hwlat cpus allowed */
 
 /* Save the previous tracing_thresh value */
 static unsigned long save_tracing_thresh;
@@ -272,6 +273,7 @@ static int get_sample(void)
 	return ret;
 }
 
+static struct cpumask hwlat_cpumask;
 static struct cpumask save_cpumask;
 static bool disable_migrate;
 
@@ -292,7 +294,14 @@ static void move_to_next_cpu(void)
 		goto disable;
 
 	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+	/*
+	 * Run only on CPUs in which trace and hwlat are allowed to run.
+	 */
+	cpumask_and(current_mask, tr->tracing_cpumask, &hwlat_cpumask);
+	/*
+	 * And the CPU is online.
+	 */
+	cpumask_and(current_mask, cpu_online_mask, current_mask);
 	next_cpu = cpumask_next(smp_processor_id(), current_mask);
 	put_online_cpus();
 
@@ -368,7 +377,14 @@ static int start_kthread(struct trace_array *tr)
 
 	/* Just pick the first CPU on first iteration */
 	get_online_cpus();
-	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+	/*
+	 * Run only on CPUs in which trace and hwlat are allowed to run.
+	 */
+	cpumask_and(current_mask, tr->tracing_cpumask, &hwlat_cpumask);
+	/*
+	 * And the CPU is online.
+	 */
+	cpumask_and(current_mask, cpu_online_mask, current_mask);
 	put_online_cpus();
 	next_cpu = cpumask_first(current_mask);
 
@@ -402,6 +418,94 @@ static void stop_kthread(void)
 	hwlat_kthread = NULL;
 }
 
+/*
+ * hwlat_cpus_read - Read function for reading the "cpus" file
+ * @filp: The active open file structure
+ * @ubuf: The userspace provided buffer to read value into
+ * @cnt: The maximum number of bytes to read
+ * @ppos: The current "file" position
+ *
+ * Prints the "cpus" output into the user-provided buffer.
+ */
+static ssize_t
+hwlat_cpus_read(struct file *filp, char __user *ubuf, size_t count,
+		   loff_t *ppos)
+{
+	char *mask_str;
+	int len;
+
+	len = snprintf(NULL, 0, "%*pbl\n",
+		       cpumask_pr_args(&hwlat_cpumask)) + 1;
+	mask_str = kmalloc(len, GFP_KERNEL);
+	if (!mask_str)
+		return -ENOMEM;
+
+	len = snprintf(mask_str, len, "%*pbl\n",
+		       cpumask_pr_args(&hwlat_cpumask));
+	if (len >= count) {
+		count = -EINVAL;
+		goto out_err;
+	}
+	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
+
+out_err:
+	kfree(mask_str);
+
+	return count;
+}
+
+/**
+ * hwlat_cpus_write - Write function for "cpus" entry
+ * @filp: The active open file structure
+ * @ubuf: The user buffer that contains the value to write
+ * @cnt: The maximum number of bytes to write to "file"
+ * @ppos: The current position in @file
+ *
+ * This function provides a write implementation for the "cpus"
+ * interface to the hardware latency detector. By default, it lists all
+ * CPUs, in this way, allowing hwlatd threads to run on any online CPU
+ * of the system. It serves to restrict the execution of hwlatd to the
+ * set of CPUs writing via this interface. Note that hwlatd also
+ * respects the "tracing_cpumask." Hence, hwlatd threads will run only
+ * on the set of CPUs allowed here AND on "tracing_cpumask." Why not
+ * have just "tracing_cpumask?" Because the user might be interested
+ * in tracing what is running on other CPUs. For instance, one might
+ * run hwlatd in one HT CPU while observing what is running on the
+ * sibling HT CPU.
+ */
+static ssize_t
+hwlat_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
+		    loff_t *ppos)
+{
+	cpumask_var_t hwlat_cpumask_new;
+	char buf[256];
+	int err;
+
+	if (count >= 256)
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+
+	if (!zalloc_cpumask_var(&hwlat_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpulist_parse(buf, hwlat_cpumask_new);
+	if (err)
+		goto err_free;
+
+	cpumask_copy(&hwlat_cpumask, hwlat_cpumask_new);
+
+	free_cpumask_var(hwlat_cpumask_new);
+
+	return count;
+
+err_free:
+	free_cpumask_var(hwlat_cpumask_new);
+
+	return err;
+}
+
 /*
  * hwlat_read - Wrapper read function for reading both window and width
  * @filp: The active open file structure
@@ -523,6 +627,14 @@ static const struct file_operations window_fops = {
 	.write		= hwlat_window_write,
 };
 
+static const struct file_operations cpus_fops = {
+	.open		= tracing_open_generic,
+	.read		= hwlat_cpus_read,
+	.write		= hwlat_cpus_write,
+	.llseek		= generic_file_llseek,
+};
+
+
 /**
  * init_tracefs - A function to initialize the tracefs interface files
  *
@@ -558,6 +670,13 @@ static int init_tracefs(void)
 	if (!hwlat_sample_width)
 		goto err;
 
+	hwlat_cpumask_dentry = trace_create_file("cpus", 0644,
+						 top_dir,
+						 NULL,
+						 &cpus_fops);
+	if (!hwlat_cpumask_dentry)
+		goto err;
+
 	return 0;
 
  err:
@@ -637,6 +756,8 @@ __init static int init_hwlat_tracer(void)
 	if (ret)
 		return ret;
 
+	cpumask_copy(&hwlat_cpumask, cpu_all_mask);
+
 	init_tracefs();
 
 	return 0;
-- 
2.30.2

