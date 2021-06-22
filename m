Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67D33B07CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFVOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhFVOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Zi1Jmc7PpFitMHz4fgLN9ayTf1QzlW/J4F/Jv6tk2I=;
        b=ZWpHBy79I0YggXKUcmw163L09j0GP0QKo6yXNjvqnODpE2IdrILO/FBPletvXAaJq2pFu3
        WB7DZu/FCcLFKW7JH8MOS474GumnuAHM/IOAc5vESyD7uRC6djZakgWWDDdpbZ+sdWA3qM
        mqh953mLJLFxGkq+/XEuVuQEv4D1SfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-wy3rKc9tMKuGIna2unZOzA-1; Tue, 22 Jun 2021 10:45:00 -0400
X-MC-Unique: wy3rKc9tMKuGIna2unZOzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DB2191272;
        Tue, 22 Jun 2021 14:44:57 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B168F5D9CA;
        Tue, 22 Jun 2021 14:44:49 +0000 (UTC)
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
Subject: [PATCH V5 13/14] trace/hwlat: Support hotplug operations
Date:   Tue, 22 Jun 2021 16:42:31 +0200
Message-Id: <52012d25ea35491a0f8088b947864d8df8e25157.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and disable hwlat thread during cpu hotplug online
and offline operations, respectivelly.

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
 kernel/trace/trace_hwlat.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index dc30b8a9bd5f..e13b8c836995 100644
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
2.31.1

