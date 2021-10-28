Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D743F1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhJ1VeN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Oct 2021 17:34:13 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:26527 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231586AbhJ1Vd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:33:56 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-pRYjeT-vM5aM9mtpobKxyw-1; Thu, 28 Oct 2021 17:31:23 -0400
X-MC-Unique: pRYjeT-vM5aM9mtpobKxyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99614100A640;
        Thu, 28 Oct 2021 21:31:21 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33225100EBBE;
        Thu, 28 Oct 2021 21:31:16 +0000 (UTC)
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
Subject: [PATCH V7 8/9] trace/osnoise: Remove STACKTRACE ifdefs from inside functions
Date:   Thu, 28 Oct 2021 23:29:36 +0200
Message-Id: <2cab388e4faaf3fc3496a1c18ec09a8bc7c36c3f.1635452903.git.bristot@kernel.org>
In-Reply-To: <cover.1635452903.git.bristot@kernel.org>
References: <cover.1635452903.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_STACKTRACE from inside functions, avoiding
compilation problems in the future.

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
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 44 ++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0c3a93f51b08..eaa6396e3262 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -635,13 +635,19 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
 /*
  * timerlat_dump_stack - dump a stack trace previously saved
  */
-static void timerlat_dump_stack(void)
+static void timerlat_dump_stack(u64 latency)
 {
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
 	struct trace_stack *fstack;
 	unsigned int size;
 
+	/*
+	 * 0 is disabled, so it will never be > than latency.
+	 */
+	if (osnoise_data.print_stack > latency)
+		return;
+
 	preempt_disable_notrace();
 	fstack = this_cpu_ptr(&trace_stack);
 	size = fstack->stack_size;
@@ -655,8 +661,8 @@ static void timerlat_dump_stack(void)
 	rcu_read_unlock();
 	preempt_enable_notrace();
 }
-#else
-#define timerlat_dump_stack() do {} while (0)
+#else /* CONFIG_STACKTRACE */
+#define timerlat_dump_stack(u64 latency) do {} while (0)
 #define timerlat_save_stack(a) do {} while (0)
 #endif /* CONFIG_STACKTRACE */
 #endif /* CONFIG_TIMERLAT_TRACER */
@@ -1619,11 +1625,7 @@ static int timerlat_main(void *data)
 
 		trace_timerlat_sample(&s);
 
-#ifdef CONFIG_STACKTRACE
-		if (osnoise_data.print_stack)
-			if (osnoise_data.print_stack <= time_to_us(diff))
-				timerlat_dump_stack();
-#endif /* CONFIG_STACKTRACE */
+		timerlat_dump_stack(time_to_us(diff));
 
 		tlat->tracing_thread = false;
 		if (osnoise_data.stop_tracing_total)
@@ -1984,26 +1986,38 @@ static const struct file_operations cpus_fops = {
 };
 
 #ifdef CONFIG_TIMERLAT_TRACER
-/*
- * init_timerlat_tracefs - A function to initialize the timerlat interface files
- */
-static int init_timerlat_tracefs(struct dentry *top_dir)
+#ifdef CONFIG_STACKTRACE
+static int init_timerlat_stack_tracefs(struct dentry *top_dir)
 {
 	struct dentry *tmp;
 
-#ifdef CONFIG_STACKTRACE
 	tmp = tracefs_create_file("print_stack", 0640, top_dir,
 				  &osnoise_print_stack, &trace_min_max_fops);
 	if (!tmp)
 		return -ENOMEM;
-#endif
+
+	return 0;
+}
+#else /* CONFIG_STACKTRACE */
+static int init_timerlat_stack_tracefs(struct dentry *top_dir)
+{
+	return 0;
+}
+#endif /* CONFIG_STACKTRACE */
+
+/*
+ * init_timerlat_tracefs - A function to initialize the timerlat interface files
+ */
+static int init_timerlat_tracefs(struct dentry *top_dir)
+{
+	struct dentry *tmp;
 
 	tmp = tracefs_create_file("timerlat_period_us", 0640, top_dir,
 				  &timerlat_period, &trace_min_max_fops);
 	if (!tmp)
 		return -ENOMEM;
 
-	return 0;
+	return init_timerlat_stack_tracefs(top_dir);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
 static int init_timerlat_tracefs(struct dentry *top_dir)
-- 
2.31.1

