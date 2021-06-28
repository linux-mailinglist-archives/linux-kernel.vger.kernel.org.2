Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F333B5B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhF1JtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 05:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232565AbhF1JtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624873616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JiDhVp52A6956L3vtS59eezfSNj0aQ9ulQDbO2eblLM=;
        b=ipYWwfp40uWGze6hytv/DrzYjfC8GNSBge3DJrTGGGVWeAw7Y+hGTdcYNqLvfEVrL2/zKa
        z1aoOHpmqmV2rbnhJ5eKmGycAV4MU/fQ3/fQZX83EuabCfq3oXe0q6SoIJbsJ5uD/iCv79
        AZFmgQY4tE3wcVPfuKOcluffxycuIuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-xuzCk4TDMhevs3nANv7dPA-1; Mon, 28 Jun 2021 05:46:54 -0400
X-MC-Unique: xuzCk4TDMhevs3nANv7dPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1221C804146;
        Mon, 28 Jun 2021 09:46:53 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-121.rdu2.redhat.com [10.10.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D2BE60C9F;
        Mon, 28 Jun 2021 09:46:50 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] trace/osnoise: Fix 'no previous prototype' warnings
Date:   Mon, 28 Jun 2021 11:45:47 +0200
Message-Id: <e40d3cb4be8bde921f4b40fa6a095cf85ab807bd.1624872608.git.bristot@redhat.com>
In-Reply-To: <cover.1624872608.git.bristot@redhat.com>
References: <cover.1624872608.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported some osnoise functions with "no previous
prototype."

Fix these warnings by making local functions static, and by adding:

 void osnoise_trace_irq_entry(int id);
 void osnoise_trace_irq_exit(int id, const char *desc);

to include/linux/trace.h.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
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
index 38aa5e208ffd..e2401659b0e5 100644
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
2.31.1

