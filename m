Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296F33EA6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhHLOpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:45:13 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.219]:39522 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236551AbhHLOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:45:10 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B64EC6799FB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:57:38 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id EBDGmVDpgMGeEEBDGmVXEx; Thu, 12 Aug 2021 08:57:38 -0500
X-Authority-Reason: nr=8
Received: from host-79-56-204-120.retail.telecomitalia.it ([79.56.204.120]:54910 helo=f34.bristot.me)
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mEBDF-004IPl-TA; Thu, 12 Aug 2021 08:57:38 -0500
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH 2/5] trace/osnoise: Split workload start from the tracer start
Date:   Thu, 12 Aug 2021 15:57:21 +0200
Message-Id: <d998f4eea839fb656bb7140563743aa427857952.1628775552.git.bristot@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628775552.git.bristot@kernel.org>
References: <cover.1628775552.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.56.204.120
X-Source-L: No
X-Exim-ID: 1mEBDF-004IPl-TA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-56-204-120.retail.telecomitalia.it (f34.bristot.me) [79.56.204.120]:54910
X-Source-Auth: kernel@bristot.me
X-Email-Count: 21
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
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
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira (Red Hat) <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 53 ++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index aadb0d110155..9b283038fad2 100644
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
 	int retval;
@@ -1678,8 +1678,8 @@ osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
 	return count;
 }
 
-static void osnoise_tracer_start(struct trace_array *tr);
-static void osnoise_tracer_stop(struct trace_array *tr);
+static int osnoise_workload_start(void);
+static void osnoise_workload_stop(void);
 
 /*
  * osnoise_cpus_write - Write function for "cpus" entry
@@ -1701,7 +1701,6 @@ static ssize_t
 osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 		   loff_t *ppos)
 {
-	struct trace_array *tr = osnoise_trace;
 	cpumask_var_t osnoise_cpumask_new;
 	int running, err;
 	char buf[256];
@@ -1726,7 +1725,7 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	mutex_lock(&trace_types_lock);
 	running = osnoise_busy;
 	if (running)
-		osnoise_tracer_stop(tr);
+		osnoise_workload_stop();
 
 	mutex_lock(&interface_lock);
 	/*
@@ -1740,7 +1739,7 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	mutex_unlock(&interface_lock);
 
 	if (running)
-		osnoise_tracer_start(tr);
+		osnoise_workload_start();
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(osnoise_cpumask_new);
@@ -1921,7 +1920,10 @@ static int osnoise_hook_events(void)
 	return -EINVAL;
 }
 
-static int __osnoise_tracer_start(struct trace_array *tr)
+/*
+ * osnoise_workload_start - start the workload and hook to events
+ */
+static int osnoise_workload_start(void)
 {
 	int retval;
 
@@ -1936,7 +1938,7 @@ static int __osnoise_tracer_start(struct trace_array *tr)
 	barrier();
 	trace_osnoise_callback_enabled = true;
 
-	retval = start_per_cpu_kthreads(tr);
+	retval = start_per_cpu_kthreads();
 	if (retval) {
 		unhook_irq_events();
 		return retval;
@@ -1947,6 +1949,26 @@ static int __osnoise_tracer_start(struct trace_array *tr)
 	return 0;
 }
 
+/*
+ * osnoise_workload_stop - stop the workload and unhook the events
+ */
+static void osnoise_workload_stop(void)
+{
+	if (!osnoise_busy)
+		return;
+
+	trace_osnoise_callback_enabled = false;
+	barrier();
+
+	stop_per_cpu_kthreads();
+
+	unhook_irq_events();
+	unhook_softirq_events();
+	unhook_thread_events();
+
+	osnoise_busy = false;
+}
+
 static void osnoise_tracer_start(struct trace_array *tr)
 {
 	int retval;
@@ -1954,7 +1976,7 @@ static void osnoise_tracer_start(struct trace_array *tr)
 	if (osnoise_busy)
 		return;
 
-	retval = __osnoise_tracer_start(tr);
+	retval = osnoise_workload_start();
 	if (retval)
 		pr_err(BANNER "Error starting osnoise tracer\n");
 
@@ -1965,16 +1987,7 @@ static void osnoise_tracer_stop(struct trace_array *tr)
 	if (!osnoise_busy)
 		return;
 
-	trace_osnoise_callback_enabled = false;
-	barrier();
-
-	stop_per_cpu_kthreads();
-
-	unhook_irq_events();
-	unhook_softirq_events();
-	unhook_thread_events();
-
-	osnoise_busy = false;
+	osnoise_workload_stop();
 }
 
 static int osnoise_tracer_init(struct trace_array *tr)
@@ -2017,7 +2030,7 @@ static void timerlat_tracer_start(struct trace_array *tr)
 
 	osnoise_data.timerlat_tracer = 1;
 
-	retval = __osnoise_tracer_start(tr);
+	retval = osnoise_workload_start();
 	if (retval)
 		goto out_err;
 
-- 
2.31.1

