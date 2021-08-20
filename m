Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989A73F2DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbhHTOMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238242AbhHTOMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:12:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43928610E6;
        Fri, 20 Aug 2021 14:12:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mH5FZ-004oJZ-9s; Fri, 20 Aug 2021 10:12:01 -0400
Message-ID: <20210820141201.145144322@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 10:11:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 1/9] tracing: Replace deprecated CPU-hotplug functions.
References: <20210820141109.993445617@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Link: https://lkml.kernel.org/r/20210803141621.780504-37-bigeasy@linutronix.de

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c   |  8 ++++----
 kernel/trace/trace_hwlat.c   | 28 ++++++++++++++--------------
 kernel/trace/trace_osnoise.c | 16 ++++++++--------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e592d1df6f88..c5a3fbf19617 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2111,7 +2111,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			}
 		}
 
-		get_online_cpus();
+		cpus_read_lock();
 		/*
 		 * Fire off all the required work handlers
 		 * We can't schedule on offline CPUs, but it's not necessary
@@ -2143,7 +2143,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			cpu_buffer->nr_pages_to_update = 0;
 		}
 
-		put_online_cpus();
+		cpus_read_unlock();
 	} else {
 		cpu_buffer = buffer->buffers[cpu_id];
 
@@ -2171,7 +2171,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			goto out_err;
 		}
 
-		get_online_cpus();
+		cpus_read_lock();
 
 		/* Can't run something on an offline CPU. */
 		if (!cpu_online(cpu_id))
@@ -2183,7 +2183,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		}
 
 		cpu_buffer->nr_pages_to_update = 0;
-		put_online_cpus();
+		cpus_read_unlock();
 	}
 
  out:
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 14f46aae1981..1b83d75eb103 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -325,10 +325,10 @@ static void move_to_next_cpu(void)
 	if (!cpumask_equal(current_mask, current->cpus_ptr))
 		goto change_mode;
 
-	get_online_cpus();
+	cpus_read_lock();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 	next_cpu = cpumask_next(raw_smp_processor_id(), current_mask);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (next_cpu >= nr_cpu_ids)
 		next_cpu = cpumask_first(current_mask);
@@ -398,7 +398,7 @@ static void stop_single_kthread(void)
 	struct hwlat_kthread_data *kdata = get_cpu_data();
 	struct task_struct *kthread;
 
-	get_online_cpus();
+	cpus_read_lock();
 	kthread = kdata->kthread;
 
 	if (!kthread)
@@ -408,7 +408,7 @@ static void stop_single_kthread(void)
 	kdata->kthread = NULL;
 
 out_put_cpus:
-	put_online_cpus();
+	cpus_read_unlock();
 }
 
 
@@ -425,14 +425,14 @@ static int start_single_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
 
-	get_online_cpus();
+	cpus_read_lock();
 	if (kdata->kthread)
 		goto out_put_cpus;
 
 	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		put_online_cpus();
+		cpus_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -452,7 +452,7 @@ static int start_single_kthread(struct trace_array *tr)
 	wake_up_process(kthread);
 
 out_put_cpus:
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 }
 
@@ -479,10 +479,10 @@ static void stop_per_cpu_kthreads(void)
 {
 	unsigned int cpu;
 
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu)
 		stop_cpu_kthread(cpu);
-	put_online_cpus();
+	cpus_read_unlock();
 }
 
 /*
@@ -515,7 +515,7 @@ static void hwlat_hotplug_workfn(struct work_struct *dummy)
 
 	mutex_lock(&trace_types_lock);
 	mutex_lock(&hwlat_data.lock);
-	get_online_cpus();
+	cpus_read_lock();
 
 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
 		goto out_unlock;
@@ -526,7 +526,7 @@ static void hwlat_hotplug_workfn(struct work_struct *dummy)
 	start_cpu_kthread(cpu);
 
 out_unlock:
-	put_online_cpus();
+	cpus_read_unlock();
 	mutex_unlock(&hwlat_data.lock);
 	mutex_unlock(&trace_types_lock);
 }
@@ -582,7 +582,7 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	unsigned int cpu;
 	int retval;
 
-	get_online_cpus();
+	cpus_read_lock();
 	/*
 	 * Run only on CPUs in which hwlat is allowed to run.
 	 */
@@ -596,12 +596,12 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 		if (retval)
 			goto out_error;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return 0;
 
 out_error:
-	put_online_cpus();
+	cpus_read_unlock();
 	stop_per_cpu_kthreads();
 	return retval;
 }
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b61eefe5ccf5..65b08b8e5bf8 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1498,12 +1498,12 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	get_online_cpus();
+	cpus_read_lock();
 
 	for_each_online_cpu(cpu)
 		stop_kthread(cpu);
 
-	put_online_cpus();
+	cpus_read_unlock();
 }
 
 /*
@@ -1551,7 +1551,7 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	int retval;
 	int cpu;
 
-	get_online_cpus();
+	cpus_read_lock();
 	/*
 	 * Run only on CPUs in which trace and osnoise are allowed to run.
 	 */
@@ -1572,7 +1572,7 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 		}
 	}
 
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return 0;
 }
@@ -1590,7 +1590,7 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 		goto out_unlock_trace;
 
 	mutex_lock(&interface_lock);
-	get_online_cpus();
+	cpus_read_lock();
 
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		goto out_unlock;
@@ -1601,7 +1601,7 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	start_kthread(cpu);
 
 out_unlock:
-	put_online_cpus();
+	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
 out_unlock_trace:
 	mutex_unlock(&trace_types_lock);
@@ -1743,11 +1743,11 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	/*
 	 * osnoise_cpumask is read by CPU hotplug operations.
 	 */
-	get_online_cpus();
+	cpus_read_lock();
 
 	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
 
-	put_online_cpus();
+	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
 
 	if (running)
-- 
2.30.2
