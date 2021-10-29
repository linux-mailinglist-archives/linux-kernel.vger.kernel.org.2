Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF54402AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhJ2TDw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Oct 2021 15:03:52 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:28548 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230302AbhJ2TDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:03:50 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-3hm4FlH5M5mUBR4ZoRQ7lg-1; Fri, 29 Oct 2021 15:01:19 -0400
X-MC-Unique: 3hm4FlH5M5mUBR4ZoRQ7lg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7F845074C;
        Fri, 29 Oct 2021 19:01:17 +0000 (UTC)
Received: from x1.com (unknown [10.22.10.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6D95D9CA;
        Fri, 29 Oct 2021 19:00:54 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 3/9] tracing/osnoise: Split workload start from the tracer start
Date:   Fri, 29 Oct 2021 21:00:29 +0200
Message-Id: <dd012a192270bd49037c46866769c303d727ac96.1635533292.git.bristot@kernel.org>
In-Reply-To: <cover.1635533292.git.bristot@kernel.org>
References: <cover.1635533292.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation from supporting multiple trace instances, create
workload start/stop specific functions.

No functional change.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 59 ++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f941a322ca89..4381a06af916 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1545,7 +1545,7 @@ static int start_kthread(unsigned int cpu)
  * This starts the kernel thread that will look for osnoise on many
  * cpus.
  */
-static int start_per_cpu_kthreads(struct trace_array *tr)
+static int start_per_cpu_kthreads(void)
 {
 	struct cpumask *current_mask = &save_cpumask;
 	int retval = 0;
@@ -1677,8 +1677,8 @@ osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
 	return count;
 }
 
-static void osnoise_tracer_start(struct trace_array *tr);
-static void osnoise_tracer_stop(struct trace_array *tr);
+static int osnoise_workload_start(void);
+static void osnoise_workload_stop(void);
 
 /*
  * osnoise_cpus_write - Write function for "cpus" entry
@@ -1700,7 +1700,6 @@ static ssize_t
 osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 		   loff_t *ppos)
 {
-	struct trace_array *tr = osnoise_trace;
 	cpumask_var_t osnoise_cpumask_new;
 	int running, err;
 	char buf[256];
@@ -1725,7 +1724,7 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	mutex_lock(&trace_types_lock);
 	running = osnoise_busy;
 	if (running)
-		osnoise_tracer_stop(tr);
+		osnoise_workload_stop();
 
 	mutex_lock(&interface_lock);
 	/*
@@ -1739,7 +1738,7 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	mutex_unlock(&interface_lock);
 
 	if (running)
-		osnoise_tracer_start(tr);
+		osnoise_workload_start();
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(osnoise_cpumask_new);
@@ -1920,7 +1919,10 @@ static int osnoise_hook_events(void)
 	return -EINVAL;
 }
 
-static int __osnoise_tracer_start(struct trace_array *tr)
+/*
+ * osnoise_workload_start - start the workload and hook to events
+ */
+static int osnoise_workload_start(void)
 {
 	int retval;
 
@@ -1937,7 +1939,7 @@ static int __osnoise_tracer_start(struct trace_array *tr)
 	barrier();
 	trace_osnoise_callback_enabled = true;
 
-	retval = start_per_cpu_kthreads(tr);
+	retval = start_per_cpu_kthreads();
 	if (retval) {
 		unhook_irq_events();
 		return retval;
@@ -1948,20 +1950,10 @@ static int __osnoise_tracer_start(struct trace_array *tr)
 	return 0;
 }
 
-static void osnoise_tracer_start(struct trace_array *tr)
-{
-	int retval;
-
-	if (osnoise_busy)
-		return;
-
-	retval = __osnoise_tracer_start(tr);
-	if (retval)
-		pr_err(BANNER "Error starting osnoise tracer\n");
-
-}
-
-static void osnoise_tracer_stop(struct trace_array *tr)
+/*
+ * osnoise_workload_stop - stop the workload and unhook the events
+ */
+static void osnoise_workload_stop(void)
 {
 	if (!osnoise_busy)
 		return;
@@ -1982,6 +1974,27 @@ static void osnoise_tracer_stop(struct trace_array *tr)
 	osnoise_busy = false;
 }
 
+static void osnoise_tracer_start(struct trace_array *tr)
+{
+	int retval;
+
+	if (osnoise_busy)
+		return;
+
+	retval = osnoise_workload_start();
+	if (retval)
+		pr_err(BANNER "Error starting osnoise tracer\n");
+
+}
+
+static void osnoise_tracer_stop(struct trace_array *tr)
+{
+	if (!osnoise_busy)
+		return;
+
+	osnoise_workload_stop();
+}
+
 static int osnoise_tracer_init(struct trace_array *tr)
 {
 
@@ -2022,7 +2035,7 @@ static void timerlat_tracer_start(struct trace_array *tr)
 
 	osnoise_data.timerlat_tracer = 1;
 
-	retval = __osnoise_tracer_start(tr);
+	retval = osnoise_workload_start();
 	if (retval)
 		goto out_err;
 
-- 
2.31.1

