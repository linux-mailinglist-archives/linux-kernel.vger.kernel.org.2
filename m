Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2B3B4E99
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFZNIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFZNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 109D461C39;
        Sat, 26 Jun 2021 13:05:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx808-000EiA-3k; Sat, 26 Jun 2021 09:05:36 -0400
Message-ID: <20210626130535.954924248@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 08/24] tracing: Add tp_printk_stop_on_boot option
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a kernel command line option that disables printing of events to
console at late_initcall_sync(). This is useful when needing to see
specific events written to console on boot up, but not wanting it when
user space starts, as user space may make the console so noisy that the
system becomes inoperable.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 13 ++++++
 kernel/trace/trace.c                          | 40 ++++++++++++++-----
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..0fcc725105cd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5605,12 +5605,25 @@
 			Note, echoing 1 into this file without the
 			tracepoint_printk kernel cmdline option has no effect.
 
+			The tp_printk_stop_on_boot (see below) can also be used
+			to stop the printing of events to console at
+			late_initcall_sync.
+
 			** CAUTION **
 
 			Having tracepoints sent to printk() and activating high
 			frequency tracepoints such as irq or sched, can cause
 			the system to live lock.
 
+	tp_printk_stop_on_boot[FTRACE]
+			When tp_printk (above) is set, it can cause a lot of noise
+			on the console. It may be useful to only include the
+			printing of events during boot up, as user space may
+			make the system inoperable.
+
+			This command line option will stop the printing of events
+			to console at the late_initcall_sync() time frame.
+
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a0d66a056e59..bbc63ac5b47f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -86,6 +86,7 @@ void __init disable_tracing_selftest(const char *reason)
 /* Pipe tracepoints to printk */
 struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
+static bool tracepoint_printk_stop_on_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
 /* For tracers that don't implement custom flags */
@@ -256,6 +257,13 @@ static int __init set_tracepoint_printk(char *str)
 }
 __setup("tp_printk", set_tracepoint_printk);
 
+static int __init set_tracepoint_printk_stop(char *str)
+{
+	tracepoint_printk_stop_on_boot = true;
+	return 1;
+}
+__setup("tp_printk_stop_on_boot", set_tracepoint_printk_stop);
+
 unsigned long long ns2usecs(u64 nsec)
 {
 	nsec += 500;
@@ -9578,6 +9586,8 @@ static __init int tracer_init_tracefs(void)
 	return 0;
 }
 
+fs_initcall(tracer_init_tracefs);
+
 static int trace_panic_handler(struct notifier_block *this,
 			       unsigned long event, void *unused)
 {
@@ -9998,7 +10008,7 @@ void __init trace_init(void)
 	trace_event_init();
 }
 
-__init static int clear_boot_tracer(void)
+__init static void clear_boot_tracer(void)
 {
 	/*
 	 * The default tracer at boot buffer is an init section.
@@ -10008,26 +10018,21 @@ __init static int clear_boot_tracer(void)
 	 * about to be freed.
 	 */
 	if (!default_bootup_tracer)
-		return 0;
+		return;
 
 	printk(KERN_INFO "ftrace bootup tracer '%s' not registered.\n",
 	       default_bootup_tracer);
 	default_bootup_tracer = NULL;
-
-	return 0;
 }
 
-fs_initcall(tracer_init_tracefs);
-late_initcall_sync(clear_boot_tracer);
-
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
-__init static int tracing_set_default_clock(void)
+__init static void tracing_set_default_clock(void)
 {
 	/* sched_clock_stable() is determined in late_initcall */
 	if (!trace_boot_clock && !sched_clock_stable()) {
 		if (security_locked_down(LOCKDOWN_TRACEFS)) {
 			pr_warn("Can not set tracing clock due to lockdown\n");
-			return -EPERM;
+			return;
 		}
 
 		printk(KERN_WARNING
@@ -10037,8 +10042,21 @@ __init static int tracing_set_default_clock(void)
 		       "on the kernel command line\n");
 		tracing_set_clock(&global_trace, "global");
 	}
+}
+#else
+static inline void tracing_set_default_clock(void) { }
+#endif
 
+__init static int late_trace_init(void)
+{
+	if (tracepoint_printk && tracepoint_printk_stop_on_boot) {
+		static_key_disable(&tracepoint_printk_key.key);
+		tracepoint_printk = 0;
+	}
+
+	tracing_set_default_clock();
+	clear_boot_tracer();
 	return 0;
 }
-late_initcall_sync(tracing_set_default_clock);
-#endif
+
+late_initcall_sync(late_trace_init);
-- 
2.30.2
