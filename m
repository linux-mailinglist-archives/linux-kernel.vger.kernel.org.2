Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B33B718C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhF2LvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233543AbhF2LvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4F661D36;
        Tue, 29 Jun 2021 11:48:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEV-000SYI-AU; Tue, 29 Jun 2021 07:48:51 -0400
Message-ID: <20210629114851.164791723@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 2/6] trace/osnoise: Fix no previous prototype warnings
References: <20210629114811.473560262@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

kernel test robot reported some osnoise functions with "no previous
prototype."

Fix these warnings by making local functions static, and by adding:

 void osnoise_trace_irq_entry(int id);
 void osnoise_trace_irq_exit(int id, const char *desc);

to include/linux/trace.h.

Link: https://lkml.kernel.org/r/e40d3cb4be8bde921f4b40fa6a095cf85ab807bd.1624872608.git.bristot@redhat.com

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/trace.c      |  3 ---
 include/linux/trace.h        |  2 ++
 kernel/trace/trace_osnoise.c | 20 +++++++++++---------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/trace.c b/arch/x86/kernel/trace.c
index 6912672c33a7..6b73b6f92ad3 100644
--- a/arch/x86/kernel/trace.c
+++ b/arch/x86/kernel/trace.c
@@ -2,9 +2,6 @@
 #include <linux/trace.h>
 
 #if defined(CONFIG_OSNOISE_TRACER) && defined(CONFIG_X86_LOCAL_APIC)
-extern void osnoise_trace_irq_entry(int id);
-extern void osnoise_trace_irq_exit(int id, const char *desc);
-
 /*
  * trace_intel_irq_entry - record intel specific IRQ entry
  */
diff --git a/include/linux/trace.h b/include/linux/trace.h
index 4e3858640c47..bf169612ffe1 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -45,6 +45,8 @@ int trace_array_destroy(struct trace_array *tr);
 /* For osnoise tracer */
 int osnoise_arch_register(void);
 void osnoise_arch_unregister(void);
+void osnoise_trace_irq_entry(int id);
+void osnoise_trace_irq_exit(int id, const char *desc);
 
 #endif	/* CONFIG_TRACING */
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 556d530af805..9c3109e3ffeb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -736,7 +736,7 @@ void __weak osnoise_arch_unregister(void)
  * This function hooks the IRQ related callbacks to the respective trace
  * events.
  */
-int hook_irq_events(void)
+static int hook_irq_events(void)
 {
 	int ret;
 
@@ -768,7 +768,7 @@ int hook_irq_events(void)
  * This function unhooks the IRQ related callbacks to the respective trace
  * events.
  */
-void unhook_irq_events(void)
+static void unhook_irq_events(void)
 {
 	osnoise_arch_unregister();
 	unregister_trace_irq_handler_exit(trace_irqexit_callback, NULL);
@@ -785,7 +785,7 @@ void unhook_irq_events(void)
  * arrival time. The delta_start is used to compute the duration at the
  * softirq exit handler. See cond_move_softirq_delta_start().
  */
-void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
+static void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
 
@@ -808,7 +808,7 @@ void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
  * Computes the duration of the softirq noise, and trace it. Also discounts the
  * interference from other sources of noise could be currently being accounted.
  */
-void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
+static void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
 	int duration;
@@ -949,7 +949,7 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
  * This function is hooked to the sched:sched_switch trace event, and it is
  * used to record the beginning and to report the end of a thread noise window.
  */
-void
+static void
 trace_sched_switch_callback(void *data, bool preempt, struct task_struct *p,
 			    struct task_struct *n)
 {
@@ -968,7 +968,7 @@ trace_sched_switch_callback(void *data, bool preempt, struct task_struct *p,
  * Hook the osnoise tracer callbacks to handle the noise from other
  * threads on the necessary kernel events.
  */
-int hook_thread_events(void)
+static int hook_thread_events(void)
 {
 	int ret;
 
@@ -985,7 +985,7 @@ int hook_thread_events(void)
  * Unook the osnoise tracer callbacks to handle the noise from other
  * threads on the necessary kernel events.
  */
-void unhook_thread_events(void)
+static void unhook_thread_events(void)
 {
 	unregister_trace_sched_switch(trace_sched_switch_callback, NULL);
 }
@@ -997,7 +997,8 @@ void unhook_thread_events(void)
  * values will be used later to compute the diff betwneen the statistics
  * before and after the osnoise sampling.
  */
-void save_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *s)
+static void
+save_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *s)
 {
 	s->nmi_count = osn_var->nmi.count;
 	s->irq_count = osn_var->irq.count;
@@ -1012,7 +1013,8 @@ void save_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sam
  * statistics. The struct osnoise_sample *s contains the statistics saved via
  * save_osn_sample_stats() before the osnoise sampling.
  */
-void diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *s)
+static void
+diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *s)
 {
 	s->nmi_count = osn_var->nmi.count - s->nmi_count;
 	s->irq_count = osn_var->irq.count - s->irq_count;
-- 
2.30.2
