Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9933B4EAF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhFZNJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhFZNIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D6061C57;
        Sat, 26 Jun 2021 13:05:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx80A-000Eqe-Vs; Sat, 26 Jun 2021 09:05:38 -0400
Message-ID: <20210626130538.823006612@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:27 -0400
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
Subject: [for-next][PATCH 23/24] trace/hwlat: Support hotplug operations
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

Enable and disable hwlat thread during cpu hotplug online
and offline operations, respectivelly.

Link: https://lore.kernel.org/linux-doc/20210621134636.5b332226@oasis.local.home/
Link: https://lkml.kernel.org/r/52012d25ea35491a0f8088b947864d8df8e25157.1624372313.git.bristot@redhat.com

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
 kernel/trace/trace_hwlat.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 20e31f79ebd9..a6c0cdaf4b87 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -466,6 +466,7 @@ static void stop_cpu_kthread(unsigned int cpu)
 	kthread = per_cpu(hwlat_per_cpu_data, cpu).kthread;
 	if (kthread)
 		kthread_stop(kthread);
+	per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
 }
 
 /*
@@ -506,6 +507,68 @@ static int start_cpu_kthread(unsigned int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void hwlat_hotplug_workfn(struct work_struct *dummy)
+{
+	struct trace_array *tr = hwlat_trace;
+	unsigned int cpu = smp_processor_id();
+
+	mutex_lock(&trace_types_lock);
+	mutex_lock(&hwlat_data.lock);
+	get_online_cpus();
+
+	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
+		goto out_unlock;
+
+	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
+		goto out_unlock;
+
+	start_cpu_kthread(cpu);
+
+out_unlock:
+	put_online_cpus();
+	mutex_unlock(&hwlat_data.lock);
+	mutex_unlock(&trace_types_lock);
+}
+
+static DECLARE_WORK(hwlat_hotplug_work, hwlat_hotplug_workfn);
+
+/*
+ * hwlat_cpu_init - CPU hotplug online callback function
+ */
+static int hwlat_cpu_init(unsigned int cpu)
+{
+	schedule_work_on(cpu, &hwlat_hotplug_work);
+	return 0;
+}
+
+/*
+ * hwlat_cpu_die - CPU hotplug offline callback function
+ */
+static int hwlat_cpu_die(unsigned int cpu)
+{
+	stop_cpu_kthread(cpu);
+	return 0;
+}
+
+static void hwlat_init_hotplug_support(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "trace/hwlat:online",
+				hwlat_cpu_init, hwlat_cpu_die);
+	if (ret < 0)
+		pr_warn(BANNER "Error to init cpu hotplug support\n");
+
+	return;
+}
+#else /* CONFIG_HOTPLUG_CPU */
+static void hwlat_init_hotplug_support(void)
+{
+	return;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * start_per_cpu_kthreads - Kick off the hardware latency sampling/detector kthreads
  *
@@ -822,6 +885,8 @@ __init static int init_hwlat_tracer(void)
 	if (ret)
 		return ret;
 
+	hwlat_init_hotplug_support();
+
 	init_tracefs();
 
 	return 0;
-- 
2.30.2
