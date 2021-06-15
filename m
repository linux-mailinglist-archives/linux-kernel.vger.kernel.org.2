Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6148E3A7A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFOJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhFOJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Tcza8B+IzicjFZOzwWphin0Pm8DaEw20FUzayWFypg=;
        b=GTFHpNWl6yYBVHOEgxaDfwx7aUBaMiaB1DSHf0S4BWaRt0SbvOur4GyOyaPhYkQ2HdGXZR
        1YAtQrDnbHaYYDPcW8XouXB52LQDd9HDgwZulEc6PVTKBNY3RMvKRFNy8Z5eb5RSIa86KK
        fn26URGdeFXWE/3v4+BI5oJC9hwF2Y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-kMnkXG5BObmG28b1ZGB71g-1; Tue, 15 Jun 2021 05:29:32 -0400
X-MC-Unique: kMnkXG5BObmG28b1ZGB71g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C433B107ACF6;
        Tue, 15 Jun 2021 09:29:30 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC6F05D6AD;
        Tue, 15 Jun 2021 09:29:26 +0000 (UTC)
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
Subject: [PATCH V4 05/12] trace/hwlat: Support hotplug operations
Date:   Tue, 15 Jun 2021 11:28:44 +0200
Message-Id: <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
In-Reply-To: <cover.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 kernel/trace/trace.c       |  6 ++++++
 kernel/trace/trace_hwlat.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9299057feb56..c094865e2f71 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5064,7 +5064,13 @@ int tracing_set_cpumask(struct trace_array *tr,
 	arch_spin_unlock(&tr->max_lock);
 	local_irq_enable();
 
+	/*
+	 * tracing_cpumask is read by tracers that support CPU
+	 * hotplug.
+	 */
+	get_online_cpus();
 	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
+	put_online_cpus();
 
 	return 0;
 }
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 6c6918e86087..9fcfd588c4f6 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -490,6 +490,35 @@ static int start_cpu_kthread(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * hwlat_cpu_init - CPU hotplug online callback function
+ */
+static int hwlat_cpu_init(unsigned int cpu)
+{
+	struct trace_array *tr = hwlat_trace;
+
+	if (!hwlat_busy)
+		return 0;
+
+	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
+		return 0;
+
+	return start_cpu_kthread(cpu);
+}
+
+/*
+ * hwlat_cpu_die - CPU hotplug offline callback function
+ */
+static int hwlat_cpu_die(unsigned int cpu)
+{
+	if (!hwlat_busy)
+		return 0;
+
+	stop_cpu_kthread(cpu);
+
+	return 0;
+}
+
 /*
  * start_per_cpu_kthreads - Kick off the hardware latency sampling/detector kthreads
  *
@@ -903,6 +932,11 @@ __init static int init_hwlat_tracer(void)
 	if (ret)
 		return ret;
 
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "trace/hwlat:online",
+				hwlat_cpu_init, hwlat_cpu_die);
+	if (ret < 0)
+		pr_warn(BANNER "Error to init cpu hotplug support\n");
+
 	init_tracefs();
 
 	return 0;
-- 
2.31.1

