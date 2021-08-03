Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8EA3DF018
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhHCOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhHCOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:27 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjicPH1gRtogjC1ipZMt/PGqj+9H/UIXgqIaEVp80sQ=;
        b=UIj6aH70HUhYzQRWRcC1MczGNvA4m89aJeih1rQPndKO/Pwr0XEcWFpl1oHUBemqdZWNgv
        boyuf7MinuTdztB3+lkb/07P2flNQ77YZ3lnLNQsOn3H3Bwk+tscApGnp+N2vm7ghPhEzL
        Fcy/1qqqP/nRDWwIOErF4wZWHTgFxjk6B6QAmT/oLpW1tSctU4Eqd3sRz5NP15FUCjMeiO
        aQZrPrEY7n3hwfJmdd1lCqcoacL/EtVceMq8uS6O/xLpPEUxYjrDpz0rA5cpexTEAIeFGG
        WV3f1+qUaTFd7kOcYsEvAS/ZxsulegJ7QU67JqAA4mp5/KI9H9QtqKPWGpm9Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjicPH1gRtogjC1ipZMt/PGqj+9H/UIXgqIaEVp80sQ=;
        b=4cyjfXAZmDvRmpGtmjDazFeE4MK9cqiGyx66uZqt05lobB9mcqjcHVYLREOXU0URGIsPec
        BUOZFtzhyFLj2pCA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 36/38] tracing: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:19 +0200
Message-Id: <20210803141621.780504-37-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/ring_buffer.c   |  8 ++++----
 kernel/trace/trace_hwlat.c   | 28 ++++++++++++++--------------
 kernel/trace/trace_osnoise.c | 16 ++++++++--------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e592d1df6f888..c5a3fbf19617e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2111,7 +2111,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, u=
nsigned long size,
 			}
 		}
=20
-		get_online_cpus();
+		cpus_read_lock();
 		/*
 		 * Fire off all the required work handlers
 		 * We can't schedule on offline CPUs, but it's not necessary
@@ -2143,7 +2143,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, u=
nsigned long size,
 			cpu_buffer->nr_pages_to_update =3D 0;
 		}
=20
-		put_online_cpus();
+		cpus_read_unlock();
 	} else {
 		cpu_buffer =3D buffer->buffers[cpu_id];
=20
@@ -2171,7 +2171,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, u=
nsigned long size,
 			goto out_err;
 		}
=20
-		get_online_cpus();
+		cpus_read_lock();
=20
 		/* Can't run something on an offline CPU. */
 		if (!cpu_online(cpu_id))
@@ -2183,7 +2183,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, u=
nsigned long size,
 		}
=20
 		cpu_buffer->nr_pages_to_update =3D 0;
-		put_online_cpus();
+		cpus_read_unlock();
 	}
=20
  out:
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index a6c0cdaf4b878..172948ead25c0 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -325,10 +325,10 @@ static void move_to_next_cpu(void)
 	if (!cpumask_equal(current_mask, current->cpus_ptr))
 		goto change_mode;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 	next_cpu =3D cpumask_next(smp_processor_id(), current_mask);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (next_cpu >=3D nr_cpu_ids)
 		next_cpu =3D cpumask_first(current_mask);
@@ -398,7 +398,7 @@ static void stop_single_kthread(void)
 	struct hwlat_kthread_data *kdata =3D get_cpu_data();
 	struct task_struct *kthread;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	kthread =3D kdata->kthread;
=20
 	if (!kthread)
@@ -408,7 +408,7 @@ static void stop_single_kthread(void)
 	kdata->kthread =3D NULL;
=20
 out_put_cpus:
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
=20
@@ -425,14 +425,14 @@ static int start_single_kthread(struct trace_array *t=
r)
 	struct task_struct *kthread;
 	int next_cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	if (kdata->kthread)
 		goto out_put_cpus;
=20
 	kthread =3D kthread_create(kthread_fn, NULL, "hwlatd");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-		put_online_cpus();
+		cpus_read_unlock();
 		return -ENOMEM;
 	}
=20
@@ -452,7 +452,7 @@ static int start_single_kthread(struct trace_array *tr)
 	wake_up_process(kthread);
=20
 out_put_cpus:
-	put_online_cpus();
+	cpus_read_unlock();
 	return 0;
 }
=20
@@ -479,10 +479,10 @@ static void stop_per_cpu_kthreads(void)
 {
 	unsigned int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu)
 		stop_cpu_kthread(cpu);
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 /*
@@ -515,7 +515,7 @@ static void hwlat_hotplug_workfn(struct work_struct *du=
mmy)
=20
 	mutex_lock(&trace_types_lock);
 	mutex_lock(&hwlat_data.lock);
-	get_online_cpus();
+	cpus_read_lock();
=20
 	if (!hwlat_busy || hwlat_data.thread_mode !=3D MODE_PER_CPU)
 		goto out_unlock;
@@ -526,7 +526,7 @@ static void hwlat_hotplug_workfn(struct work_struct *du=
mmy)
 	start_cpu_kthread(cpu);
=20
 out_unlock:
-	put_online_cpus();
+	cpus_read_unlock();
 	mutex_unlock(&hwlat_data.lock);
 	mutex_unlock(&trace_types_lock);
 }
@@ -582,7 +582,7 @@ static int start_per_cpu_kthreads(struct trace_array *t=
r)
 	unsigned int cpu;
 	int retval;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	/*
 	 * Run only on CPUs in which hwlat is allowed to run.
 	 */
@@ -596,12 +596,12 @@ static int start_per_cpu_kthreads(struct trace_array =
*tr)
 		if (retval)
 			goto out_error;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
=20
 out_error:
-	put_online_cpus();
+	cpus_read_unlock();
 	stop_per_cpu_kthreads();
 	return retval;
 }
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a7e3c24dee13f..ec0015f8a64ce 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1444,12 +1444,12 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
=20
 	for_each_online_cpu(cpu)
 		stop_kthread(cpu);
=20
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 /*
@@ -1497,7 +1497,7 @@ static int start_per_cpu_kthreads(struct trace_array =
*tr)
 	int retval;
 	int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	/*
 	 * Run only on CPUs in which trace and osnoise are allowed to run.
 	 */
@@ -1518,7 +1518,7 @@ static int start_per_cpu_kthreads(struct trace_array =
*tr)
 		}
 	}
=20
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
 }
@@ -1536,7 +1536,7 @@ static void osnoise_hotplug_workfn(struct work_struct=
 *dummy)
 		goto out_unlock_trace;
=20
 	mutex_lock(&interface_lock);
-	get_online_cpus();
+	cpus_read_lock();
=20
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		goto out_unlock;
@@ -1547,7 +1547,7 @@ static void osnoise_hotplug_workfn(struct work_struct=
 *dummy)
 	start_kthread(cpu);
=20
 out_unlock:
-	put_online_cpus();
+	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
 out_unlock_trace:
 	mutex_unlock(&trace_types_lock);
@@ -1689,11 +1689,11 @@ osnoise_cpus_write(struct file *filp, const char __=
user *ubuf, size_t count,
 	/*
 	 * osnoise_cpumask is read by CPU hotplug operations.
 	 */
-	get_online_cpus();
+	cpus_read_lock();
=20
 	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
=20
-	put_online_cpus();
+	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
=20
 	if (running)
--=20
2.32.0

