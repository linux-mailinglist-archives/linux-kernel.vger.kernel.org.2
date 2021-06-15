Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A213A7A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhFOJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbhFOJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwNKe3WxWxy0f/+f2nxBRdc1zhNlAJVkW/ilLyIm1AU=;
        b=dXQyEHXdgmwo/QiISxVeZpu3ZKW7OkdF4aq0/tc7vV393VNhLErffS7uHCK21ngtKBqKaR
        SH5zCJdbDl8SsfewkbAh5LbQw6Tfo2kJuOiRUtqN/wU0SRnv95BZkjhP3uZSE4VjaIoLuY
        ZiBUUx1xCoe6aAf8oEV0ViZPkdwu6Wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-_6iglnf6MnOIbqjQR0YBPg-1; Tue, 15 Jun 2021 05:30:01 -0400
X-MC-Unique: _6iglnf6MnOIbqjQR0YBPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B4D9F92A;
        Tue, 15 Jun 2021 09:29:59 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB315D6AD;
        Tue, 15 Jun 2021 09:29:55 +0000 (UTC)
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
Subject: [PATCH V4 11/12] trace: Add timerlat tracer
Date:   Tue, 15 Jun 2021 11:28:50 +0200
Message-Id: <7cc6c8d33bd437585810304fe4b28944f9d10647.1623746916.git.bristot@redhat.com>
In-Reply-To: <cover.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timerlat tracer aims to help the preemptive kernel developers to
found souces of wakeup latencies of real-time threads. Like cyclictest,
the tracer sets a periodic timer that wakes up a thread. The thread then
computes a *wakeup latency* value as the difference between the *current
time* and the *absolute time* that the timer was set to expire. The main
goal of timerlat is tracing in such a way to help kernel developers.

Usage

Write the ASCII text "timerlat" into the current_tracer file of the
tracing system (generally mounted at /sys/kernel/tracing).

For example:

        [root@f32 ~]# cd /sys/kernel/tracing/
        [root@f32 tracing]# echo timerlat > current_tracer

It is possible to follow the trace by reading the trace trace file:

  [root@f32 tracing]# cat trace
  # tracer: timerlat
  #
  #                              _-----=> irqs-off
  #                             / _----=> need-resched
  #                            | / _---=> hardirq/softirq
  #                            || / _--=> preempt-depth
  #                            || /
  #                            ||||             ACTIVATION
  #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
  #            | |         |   ||||      |         |                  |                       |
          <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
           <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
          <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
           <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
          <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
           <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
          <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
           <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns

The tracer creates a per-cpu kernel thread with real-time priority that
prints two lines at every activation. The first is the *timer latency*
observed at the *hardirq* context before the activation of the thread.
The second is the *timer latency* observed by the thread, which is the
same level that cyclictest reports. The ACTIVATION ID field
serves to relate the *irq* execution to its respective *thread* execution.

The irq/thread splitting is important to clarify at which context
the unexpected high value is coming from. The *irq* context can be
delayed by hardware related actions, such as SMIs, NMIs, IRQs
or by a thread masking interrupts. Once the timer happens, the delay
can also be influenced by blocking caused by threads. For example, by
postponing the scheduler execution via preempt_disable(),  by the
scheduler execution, or by masking interrupts. Threads can
also be delayed by the interference from other threads and IRQs.

The timerlat can also take advantage of the osnoise: traceevents.
For example:

        [root@f32 ~]# cd /sys/kernel/tracing/
        [root@f32 tracing]# echo timerlat > current_tracer
        [root@f32 tracing]# echo osnoise > set_event
        [root@f32 tracing]# echo 25 > osnoise/stop_tracing_out_us
        [root@f32 tracing]# tail -10 trace
             cc1-87882   [005] d..h...   548.771078: #402268 context    irq timer_latency      1585 ns
             cc1-87882   [005] dNLh1..   548.771082: irq_noise: local_timer:236 start 548.771077442 duration 4597 ns
             cc1-87882   [005] dNLh2..   548.771083: irq_noise: reschedule:253 start 548.771083017 duration 56 ns
             cc1-87882   [005] dNLh2..   548.771086: irq_noise: call_function_single:251 start 548.771083811 duration 2048 ns
             cc1-87882   [005] dNLh2..   548.771088: irq_noise: call_function_single:251 start 548.771086814 duration 1495 ns
             cc1-87882   [005] dNLh2..   548.771091: irq_noise: call_function_single:251 start 548.771089194 duration 1558 ns
             cc1-87882   [005] dNLh2..   548.771094: irq_noise: call_function_single:251 start 548.771091719 duration 1932 ns
             cc1-87882   [005] dNLh2..   548.771096: irq_noise: call_function_single:251 start 548.771094696 duration 1050 ns
             cc1-87882   [005] d...3..   548.771101: thread_noise:      cc1:87882 start 548.771078243 duration 10909 ns
      timerlat/5-1035    [005] .......   548.771103: #402268 context thread timer_latency     25960 ns

For further information see: Documentation/trace/timerlat-tracer.rst

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
 Documentation/trace/index.rst           |   1 +
 Documentation/trace/timerlat-tracer.rst | 181 +++++++
 kernel/trace/Kconfig                    |  28 ++
 kernel/trace/trace.h                    |   2 +
 kernel/trace/trace_entries.h            |  16 +
 kernel/trace/trace_osnoise.c            | 626 ++++++++++++++++++++++--
 kernel/trace/trace_output.c             |  47 ++
 7 files changed, 870 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/trace/timerlat-tracer.rst

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 608107b27cc0..3769b9b7aed8 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -24,6 +24,7 @@ Linux Tracing Technologies
    boottime-trace
    hwlat_detector
    osnoise-tracer
+   timerlat-tracer
    intel_th
    ring-buffer-design
    stm
diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
new file mode 100644
index 000000000000..091055010081
--- /dev/null
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -0,0 +1,181 @@
+###############
+Timerlat tracer
+###############
+
+The timerlat tracer aims to help the preemptive kernel developers to
+find souces of wakeup latencies of real-time threads. Like cyclictest,
+the tracer sets a periodic timer that wakes up a thread. The thread then
+computes a *wakeup latency* value as the difference between the *current
+time* and the *absolute time* that the timer was set to expire. The main
+goal of timerlat is tracing in such a way to help kernel developers.
+
+Usage
+-----
+
+Write the ASCII text "timerlat" into the current_tracer file of the
+tracing system (generally mounted at /sys/kernel/tracing).
+
+For example::
+
+        [root@f32 ~]# cd /sys/kernel/tracing/
+        [root@f32 tracing]# echo timerlat > current_tracer
+
+It is possible to follow the trace by reading the trace trace file::
+
+  [root@f32 tracing]# cat trace
+  # tracer: timerlat
+  #
+  #                              _-----=> irqs-off
+  #                             / _----=> need-resched
+  #                            | / _---=> hardirq/softirq
+  #                            || / _--=> preempt-depth
+  #                            || /
+  #                            ||||             ACTIVATION
+  #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
+  #            | |         |   ||||      |         |                  |                       |
+          <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
+           <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
+          <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
+           <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
+          <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
+           <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
+          <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
+           <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
+
+
+The tracer creates a per-cpu kernel thread with real-time priority that
+prints two lines at every activation. The first is the *timer latency*
+observed at the *hardirq* context before the activation of the thread.
+The second is the *timer latency* observed by the thread. The ACTIVATION
+ID field serves to relate the *irq* execution to its respective *thread*
+execution.
+
+The *irq*/*thread* splitting is important to clarify at which context
+the unexpected high value is coming from. The *irq* context can be
+delayed by hardware related actions, such as SMIs, NMIs, IRQs
+or by a thread masking interrupts. Once the timer happens, the delay
+can also be influenced by blocking caused by threads. For example, by
+postponing the scheduler execution via preempt_disable(), by the
+scheduler execution, or by masking interrupts. Threads can
+also be delayed by the interference from other threads and IRQs.
+
+Tracer options
+---------------------
+
+The timerlat tracer is built on top of osnoise tracer.
+So its configuration is also done in the osnoise/ config
+directory. The timerlat configs are:
+
+ - cpus: CPUs at which a timerlat thread will execute.
+ - timerlat_period_us: the period of the timerlat thread.
+ - osnoise/stop_tracing_in_us: stop the system tracing if a
+   timer latency at the *irq* context higher than the configured
+   value happens. Writing 0 disables this option.
+ - stop_tracing_out_us: stop the system tracing if a
+   timer latency at the *thread* context higher than the configured
+   value happens. Writing 0 disables this option.
+ - print_stack: save the stack of the IRQ ocurrence, and print
+   it afte the *thread context* event".
+
+timerlat and osnoise
+----------------------------
+
+The timerlat can also take advantage of the osnoise: traceevents.
+For example::
+
+        [root@f32 ~]# cd /sys/kernel/tracing/
+        [root@f32 tracing]# echo timerlat > current_tracer
+        [root@f32 tracing]# echo 1 > events/osnoise/enable
+        [root@f32 tracing]# echo 25 > osnoise/stop_tracing_out_us
+        [root@f32 tracing]# tail -10 trace
+             cc1-87882   [005] d..h...   548.771078: #402268 context    irq timer_latency     13585 ns
+             cc1-87882   [005] dNLh1..   548.771082: irq_noise: local_timer:236 start 548.771077442 duration 7597 ns
+             cc1-87882   [005] dNLh2..   548.771099: irq_noise: qxl:21 start 548.771085017 duration 7139 ns
+             cc1-87882   [005] d...3..   548.771102: thread_noise:      cc1:87882 start 548.771078243 duration 9909 ns
+      timerlat/5-1035    [005] .......   548.771104: #402268 context thread timer_latency     39960 ns
+
+In this case, the root cause of the timer latency does not point to a
+single cause, but to multiple ones. Firstly, the timer IRQ was delayed
+for 13 us, which may point to a long IRQ disabled section (see IRQ
+stacktrace section). Then the timer interrupt that wakes up the timerlat
+thread took 7597 ns, and the qxl:21 device IRQ took 7139 ns. Finally,
+the cc1 thread noise took 9909 ns of time before the context switch.
+Such pieces of evidence are useful for the developer to use other
+tracing methods to figure out how to debug and optimize the system.
+
+It is worth mentioning that the *duration* values reported
+by the osnoise: events are *net* values. For example, the
+thread_noise does not include the duration of the overhead caused
+by the IRQ execution (which indeed accounted for 12736 ns). But
+the values reported by the timerlat tracer (timerlat_latency)
+are *gross* values.
+
+The art below illustrates a CPU timeline and how the timerlat tracer
+observes it at the top and the osnoise: events at the bottom. Each "-"
+in the timelines means circa 1 us, and the time moves ==>::
+
+      External     timer irq                   thread
+       clock        latency                    latency
+       event        13585 ns                   39960 ns
+         |             ^                         ^
+         v             |                         |
+         |-------------|                         |
+         |-------------+-------------------------|
+                       ^                         ^
+  ========================================================================
+                    [tmr irq]  [dev irq]
+  [another thread...^       v..^       v.......][timerlat/ thread]  <-- CPU timeline
+  =========================================================================
+                    |-------|  |-------|
+                            |--^       v-------|
+                            |          |       |
+                            |          |       + thread_noise: 9909 ns
+                            |          +-> irq_noise: 6139 ns
+                            +-> irq_noise: 7597 ns
+
+IRQ stacktrace
+---------------------------
+
+The osnoise/print_stack option is helpful for the cases in which a thread
+noise causes the major factor for the timer latency, because of preempt or
+irq disabled. For example::
+
+        [root@f32 tracing]# echo 500 > osnoise/stop_tracing_out_us
+        [root@f32 tracing]# echo 500 > osnoise/print_stack
+        [root@f32 tracing]# echo timerlat > current_tracer
+        [root@f32 tracing]# tail -21 per_cpu/cpu7/trace
+          insmod-1026    [007] dN.h1..   200.201948: irq_noise: local_timer:236 start 200.201939376 duration 7872 ns
+          insmod-1026    [007] d..h1..   200.202587: #29800 context    irq timer_latency      1616 ns
+          insmod-1026    [007] dN.h2..   200.202598: irq_noise: local_timer:236 start 200.202586162 duration 11855 ns
+          insmod-1026    [007] dN.h3..   200.202947: irq_noise: local_timer:236 start 200.202939174 duration 7318 ns
+          insmod-1026    [007] d...3..   200.203444: thread_noise:   insmod:1026 start 200.202586933 duration 838681 ns
+      timerlat/7-1001    [007] .......   200.203445: #29800 context thread timer_latency    859978 ns
+      timerlat/7-1001    [007] ....1..   200.203446: <stack trace>
+  => timerlat_irq
+  => __hrtimer_run_queues
+  => hrtimer_interrupt
+  => __sysvec_apic_timer_interrupt
+  => asm_call_irq_on_stack
+  => sysvec_apic_timer_interrupt
+  => asm_sysvec_apic_timer_interrupt
+  => delay_tsc
+  => dummy_load_1ms_pd_init
+  => do_one_initcall
+  => do_init_module
+  => __do_sys_finit_module
+  => do_syscall_64
+  => entry_SYSCALL_64_after_hwframe
+
+In this case, it is possible to see that the thread added the highest
+contribution to the *timer latency* and the stack trace, saved during
+the timerlat IRQ handler, points to a function named
+dummy_load_1ms_pd_init, which had the following code (on purpose)::
+
+	static int __init dummy_load_1ms_pd_init(void)
+	{
+		preempt_disable();
+		mdelay(1);
+		preempt_enable();
+		return 0;
+
+	}
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 41582ae4682b..d567b1717c4c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -390,6 +390,34 @@ config OSNOISE_TRACER
 	  To enable this tracer, echo in "osnoise" into the current_tracer
           file.
 
+config TIMERLAT_TRACER
+	bool "Timerlat tracer"
+	select OSNOISE_TRACER
+	select GENERIC_TRACER
+	help
+	  The timerlat tracer aims to help the preemptive kernel developers
+	  to find sources of wakeup latencies of real-time threads.
+
+	  The tracer creates a per-cpu kernel thread with real-time priority.
+	  The tracer thread sets a periodic timer to wakeup itself, and goes
+	  to sleep waiting for the timer to fire. At the wakeup, the thread
+	  then computes a wakeup latency value as the difference between
+	  the current time and the absolute time that the timer was set
+	  to expire.
+
+	  The tracer prints two lines at every activation. The first is the
+	  timer latency observed at the hardirq context before the
+	  activation of the thread. The second is the timer latency observed
+	  by the thread, which is the same level that cyclictest reports. The
+	  ACTIVATION ID field serves to relate the irq execution to its
+	  respective thread execution.
+
+	  The tracer is build on top of osnoise tracer, and the osnoise:
+	  events can be used to trace the source of interference from NMI,
+	  IRQs and other threads. It also enables the capture of the
+	  stacktrace at the IRQ context, which helps to identify the code
+	  path that can cause thread delay.
+
 config MMIOTRACE
 	bool "Memory mapped IO tracing"
 	depends on HAVE_MMIOTRACE_SUPPORT && PCI
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 760129d5f576..116d1b4c813a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -45,6 +45,7 @@ enum trace_type {
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_OSNOISE,
+	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
 
@@ -448,6 +449,7 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct bputs_entry, TRACE_BPUTS);	\
 		IF_ASSIGN(var, ent, struct hwlat_entry, TRACE_HWLAT);	\
 		IF_ASSIGN(var, ent, struct osnoise_entry, TRACE_OSNOISE);\
+		IF_ASSIGN(var, ent, struct timerlat_entry, TRACE_TIMERLAT);\
 		IF_ASSIGN(var, ent, struct raw_data_entry, TRACE_RAW_DATA);\
 		IF_ASSIGN(var, ent, struct trace_mmiotrace_rw,		\
 			  TRACE_MMIO_RW);				\
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 158c0984b59b..cd41e863b51c 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -385,3 +385,19 @@ FTRACE_ENTRY(osnoise, osnoise_entry,
 		 __entry->softirq_count,
 		 __entry->thread_count)
 );
+
+FTRACE_ENTRY(timerlat, timerlat_entry,
+
+	TRACE_TIMERLAT,
+
+	F_STRUCT(
+		__field(	unsigned int,		seqnum		)
+		__field(	int,			context		)
+		__field(	u64,			timer_latency	)
+	),
+
+	F_printk("seq:%u\tcontext:%d\ttimer_latency:%llu\n",
+		 __entry->seqnum,
+		 __entry->context,
+		 __entry->timer_latency)
+);
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 60693cb57f28..2c1e2a074b1e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * OS Noise Tracer: computes the OS Noise suffered by a running thread.
+ * Timerlat Tracer: measures the wakeup latency of a timer triggered IRQ and thread.
  *
  * Based on "hwlat_detector" tracer by:
  *   Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
@@ -21,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/sched/clock.h>
+#include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
 #include "trace.h"
 #include "trace_osnoise.h"
@@ -46,6 +48,9 @@ static struct trace_array	*osnoise_trace;
 #define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
 #define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
 
+#define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
+#define DEFAULT_TIMERLAT_PRIO	95			/* FIFO 95 */
+
 /*
  * NMI runtime info.
  */
@@ -63,6 +68,8 @@ struct osn_irq {
 	u64	delta_start;
 };
 
+#define IRQ_CONTEXT	0
+#define THREAD_CONTEXT	1
 /*
  * sofirq runtime info.
  */
@@ -109,32 +116,76 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+#ifdef CONFIG_TIMERLAT_TRACER
 /*
- * osn_var_reset - Reset the values of the given osnoise_variables
+ * Runtime information for the timer mode.
+ */
+struct timerlat_variables {
+	struct task_struct	*kthread;
+	struct hrtimer		timer;
+	u64			rel_period;
+	u64			abs_period;
+	bool			tracing_thread;
+	u64			count;
+};
+
+DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+
+/*
+ * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
+ */
+static inline struct timerlat_variables *this_cpu_tmr_var(void)
+{
+	return this_cpu_ptr(&per_cpu_timerlat_var);
+}
+
+/*
+ * tlat_var_reset - Reset the values of the given timerlat_variables
  */
-static inline void osn_var_reset(struct osnoise_variables *osn_var)
+static inline void tlat_var_reset(void)
 {
+	struct timerlat_variables *tlat_var;
+	int cpu;
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
 	 */
-	memset(osn_var, 0, sizeof(*osn_var));
+	for_each_cpu(cpu, cpu_online_mask) {
+		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
+		memset(tlat_var, 0, sizeof(*tlat_var));
+	}
 }
+#else /* CONFIG_TIMERLAT_TRACER */
+#define tlat_var_reset()	do {} while (0)
+#endif /* CONFIG_TIMERLAT_TRACER */
 
 /*
- * osn_var_reset_all - Reset the value of all per-cpu osnoise_variables
+ * osn_var_reset - Reset the values of the given osnoise_variables
  */
-static inline void osn_var_reset_all(void)
+static inline void osn_var_reset(void)
 {
 	struct osnoise_variables *osn_var;
 	int cpu;
 
+	/*
+	 * So far, all the values are initialized as 0, so
+	 * zeroing the structure is perfect.
+	 */
 	for_each_cpu(cpu, cpu_online_mask) {
 		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
-		osn_var_reset(osn_var);
+		memset(osn_var, 0, sizeof(*osn_var));
 	}
 }
 
+/*
+ * osn_var_reset_all - Reset the value of all per-cpu osnoise_variables
+ */
+static inline void osn_var_reset_all(void)
+{
+	osn_var_reset();
+	tlat_var_reset();
+}
+
 /*
  * Tells NMIs to call back to the osnoise tracer to record timestamps.
  */
@@ -155,6 +206,18 @@ struct osnoise_sample {
 	int			thread_count;	/* # threads during this sample */
 };
 
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * timerlat sample structure definition. Used to store the statistics of
+ * a sample run.
+ */
+struct timerlat_sample {
+	u64			timer_latency;	/* timer_latency */
+	unsigned int		seqnum;		/* unique sequence */
+	int			context;	/* timer context */
+};
+#endif
+
 /*
  * Protect the interface.
  */
@@ -166,14 +229,24 @@ struct mutex interface_lock;
 static struct osnoise_data {
 	u64	sample_period;		/* total sampling period */
 	u64	sample_runtime;		/* active sampling portion of period */
-	u64	stop_tracing;		/* stop trace in the inside operation (loop) */
-	u64	stop_tracing_total;	/* stop trace in the outside operation (report) */
+	u64	stop_tracing;		/* stop trace in the internal operation (loop/irq) */
+	u64	stop_tracing_total;	/* stop trace in the final operation (report/thread) */
+#ifdef CONFIG_TIMERLAT_TRACER
+	u64	timerlat_period;	/* timerlat period */
+	u64	print_stack;		/* print IRQ stack if total > */
+	int	timerlat_tracer;	/* timerlat tracer */
+#endif
 	bool	tainted;		/* infor users and developers about a problem */
 } osnoise_data = {
 	.sample_period			= DEFAULT_SAMPLE_PERIOD,
 	.sample_runtime			= DEFAULT_SAMPLE_RUNTIME,
 	.stop_tracing			= 0,
 	.stop_tracing_total		= 0,
+#ifdef CONFIG_TIMERLAT_TRACER
+	.print_stack			= 0,
+	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
+	.timerlat_tracer		= 0,
+#endif
 };
 
 /*
@@ -247,6 +320,128 @@ static void trace_osnoise_sample(struct osnoise_sample *sample)
 		trace_buffer_unlock_commit_nostack(buffer, event);
 }
 
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * Print the timerlat header info.
+ */
+static void print_timerlat_headers(struct seq_file *s)
+{
+	seq_puts(s, "#                                _-----=> irqs-off\n");
+	seq_puts(s, "#                               / _----=> need-resched\n");
+	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
+	seq_puts(s, "#                              || / _--=> preempt-depth\n");
+	seq_puts(s, "#                              || /\n");
+	seq_puts(s, "#                              ||||             ACTIVATION\n");
+	seq_puts(s, "#           TASK-PID      CPU# ||||   TIMESTAMP    ID     ");
+	seq_puts(s, "       CONTEXT                LATENCY\n");
+	seq_puts(s, "#              | |         |   ||||      |         |      ");
+	seq_puts(s, "            |                       |\n");
+}
+
+/*
+ * Record an timerlat_sample into the tracer buffer.
+ */
+static void trace_timerlat_sample(struct timerlat_sample *sample)
+{
+	struct trace_array *tr = osnoise_trace;
+	struct trace_event_call *call = &event_osnoise;
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct ring_buffer_event *event;
+	struct timerlat_entry *entry;
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_TIMERLAT, sizeof(*entry),
+					  tracing_gen_ctx());
+	if (!event)
+		return;
+	entry	= ring_buffer_event_data(event);
+	entry->seqnum			= sample->seqnum;
+	entry->context			= sample->context;
+	entry->timer_latency		= sample->timer_latency;
+
+	if (!call_filter_check_discard(call, entry, buffer, event))
+		trace_buffer_unlock_commit_nostack(buffer, event);
+}
+
+#ifdef CONFIG_STACKTRACE
+
+#define	MAX_CALLS	256
+
+/*
+ * Stack trace will take place only at IRQ level, so, no need
+ * to control nesting here.
+ */
+struct trace_stack {
+	int		stack_size;
+	int		nr_entries;
+	unsigned long	calls[MAX_CALLS];
+};
+
+static DEFINE_PER_CPU(struct trace_stack, trace_stack);
+
+/*
+ * timerlat_save_stack - save a stack trace without printing
+ *
+ * Save the current stack trace without printing. The
+ * stack will be printed later, after the end of the measurement.
+ */
+static void timerlat_save_stack(int skip)
+{
+	unsigned int size, nr_entries;
+	struct trace_stack *fstack;
+
+	fstack = this_cpu_ptr(&trace_stack);
+
+	size = ARRAY_SIZE(fstack->calls);
+
+	nr_entries = stack_trace_save(fstack->calls, size, skip);
+
+	fstack->stack_size = nr_entries * sizeof(unsigned long);
+	fstack->nr_entries = nr_entries;
+
+	return;
+
+}
+/*
+ * timerlat_dump_stack - dump a stack trace previously saved
+ *
+ * Dump a saved stack trace into the trace buffer.
+ */
+static void timerlat_dump_stack(void)
+{
+	struct trace_event_call *call = &event_osnoise;
+	struct trace_array *tr = osnoise_trace;
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct ring_buffer_event *event;
+	struct trace_stack *fstack;
+	struct stack_entry *entry;
+	unsigned int size;
+
+	preempt_disable_notrace();
+	fstack = this_cpu_ptr(&trace_stack);
+	size = fstack->stack_size;
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_STACK, sizeof(*entry) + size,
+					  tracing_gen_ctx());
+	if (!event)
+		goto out;
+
+	entry = ring_buffer_event_data(event);
+
+	memcpy(&entry->caller, fstack->calls, size);
+	entry->size = fstack->nr_entries;
+
+	if (!call_filter_check_discard(call, entry, buffer, event))
+		trace_buffer_unlock_commit_nostack(buffer, event);
+
+out:
+	preempt_enable_notrace();
+}
+#else
+#define timerlat_dump_stack() do {} while (0)
+#define timerlat_save_stack(a) do {} while (0)
+#endif /* CONFIG_STACKTRACE */
+#endif /* CONFIG_TIMERLAT_TRACER */
+
 /*
  * Macros to encapsulate the time capturing infrastructure.
  */
@@ -388,6 +583,30 @@ set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
 	return int_counter;
 }
 
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * copy_int_safe_time - Copy *src into *desc aware of interference
+ */
+static u64
+copy_int_safe_time(struct osnoise_variables *osn_var, u64 *dst, u64 *src)
+{
+	u64 int_counter;
+
+	do {
+		int_counter = local_read(&osn_var->int_counter);
+		/* synchronize with interrupts */
+		barrier();
+
+		*dst = *src;
+
+		/* synchronize with interrupts */
+		barrier();
+	} while (int_counter != local_read(&osn_var->int_counter));
+
+	return int_counter;
+}
+#endif /* CONFIG_TIMERLAT_TRACER */
+
 /*
  * trace_osnoise_callback - NMI entry/exit callback
  *
@@ -580,6 +799,22 @@ void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
 	if (!osn_var->sampling)
 		return;
 
+#ifdef CONFIG_TIMERLAT_TRACER
+	/*
+	 * If the timerlat is enabled, but the irq handler did
+	 * not run yet enabling timerlat_tracer, do not trace.
+	 */
+	if (unlikely(osnoise_data.timerlat_tracer)) {
+		struct timerlat_variables *tlat_var;
+		tlat_var = this_cpu_tmr_var();
+		if (!tlat_var->tracing_thread) {
+			osn_var->softirq.arrival_time = 0;
+			osn_var->softirq.delta_start = 0;
+			return;
+		}
+	}
+#endif
+
 	duration = get_int_safe_duration(osn_var, &osn_var->softirq.delta_start);
 	trace_softirq_noise(vec_nr, osn_var->softirq.arrival_time, duration);
 	cond_move_thread_delta_start(osn_var, duration);
@@ -672,6 +907,18 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
 	if (!osn_var->sampling)
 		return;
 
+#ifdef CONFIG_TIMERLAT_TRACER
+	if (osnoise_data.timerlat_tracer) {
+		struct timerlat_variables *tlat_var;
+		tlat_var = this_cpu_tmr_var();
+		if (!tlat_var->tracing_thread) {
+			osn_var->thread.delta_start = 0;
+			osn_var->thread.arrival_time = 0;
+			return;
+		}
+	}
+#endif
+
 	duration = get_int_safe_duration(osn_var, &osn_var->thread.delta_start);
 
 	trace_thread_noise(t, osn_var->thread.arrival_time, duration);
@@ -962,6 +1209,195 @@ static int osnoise_main(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * timerlat_irq - hrtimer handler for timerlat.
+ */
+static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	struct trace_array *tr = osnoise_trace;
+	struct timerlat_variables *tlat;
+	struct timerlat_sample s;
+	u64 now;
+	u64 diff;
+
+	/*
+	 * I am not sure if the timer was armed for this CPU. So, get
+	 * the timerlat struct from the timer itself, not from this
+	 * CPU.
+	 */
+	tlat = container_of(timer, struct timerlat_variables, timer);
+
+	now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
+
+	/*
+	 * Enable the osnoise: events for thread an softirq.
+	 */
+	tlat->tracing_thread = true;
+
+	osn_var->thread.arrival_time = time_get();
+
+	/*
+	 * A hardirq is running: the timer IRQ. It is for sure preempting
+	 * a thread, and potentially preempting a softirq.
+	 *
+	 * At this point, it is not interesting to know the duration of the
+	 * preempted thread (and maybe softirq), but how much time they will
+	 * delay the beginning of the execution of the timer thread.
+	 *
+	 * To get the correct (net) delay added by the softirq, its delta_start
+	 * is set as the IRQ one. In this way, at the return of the IRQ, the delta
+	 * start of the sofitrq will be zeroed, accounting then only the time
+	 * after that.
+	 *
+	 * The thread follows the same principle. However, if a softirq is
+	 * running, the thread needs to receive the softirq delta_start. The
+	 * reason being is that the softirq will be the last to be unfolded,
+	 * resseting the thread delay to zero.
+	 */
+#ifndef CONFIG_PREEMPT_RT
+	if (osn_var->softirq.delta_start) {
+		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
+				   &osn_var->softirq.delta_start);
+
+		copy_int_safe_time(osn_var, &osn_var->softirq.delta_start,
+				    &osn_var->irq.delta_start);
+	} else {
+		copy_int_safe_time(osn_var, &osn_var->thread.delta_start,
+				    &osn_var->irq.delta_start);
+	}
+#else /* CONFIG_PREEMPT_RT */
+	/*
+	 * The sofirqs run as threads on RT, so there is not need
+	 * to keep track of it.
+	 */
+	copy_int_safe_time(osn_var, &osn_var->thread.delta_start, &osn_var->irq.delta_start);
+#endif /* CONFIG_PREEMPT_RT */
+
+	/*
+	 * Compute the current time with the expected time.
+	 */
+	diff = now - tlat->abs_period;
+
+	tlat->count++;
+	s.seqnum = tlat->count;
+	s.timer_latency = diff;
+	s.context = IRQ_CONTEXT;
+
+	trace_timerlat_sample(&s);
+
+	/* Keep a running maximum ever recorded os noise "latency" */
+	if (diff > tr->max_latency) {
+		tr->max_latency = diff;
+		latency_fsnotify(tr);
+	}
+
+	if (osnoise_data.stop_tracing)
+		if (time_to_us(diff) >= osnoise_data.stop_tracing)
+			osnoise_stop_tracing();
+
+	wake_up_process(tlat->kthread);
+
+	if (osnoise_data.print_stack)
+		timerlat_save_stack(0);
+
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * wait_next_period - Wait for the next period for timerlat
+ */
+static int wait_next_period(struct timerlat_variables *tlat)
+{
+	ktime_t next_abs_period, now;
+	u64 rel_period = osnoise_data.timerlat_period * 1000;
+
+	now = hrtimer_cb_get_time(&tlat->timer);
+	next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
+
+	/*
+	 * Save the next abs_period.
+	 */
+	tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
+
+	/*
+	 * If the new abs_period is in the past, skip the activation.
+	 */
+	while (ktime_compare(now, next_abs_period) > 0) {
+		next_abs_period = ns_to_ktime(tlat->abs_period + rel_period);
+		tlat->abs_period = (u64) ktime_to_ns(next_abs_period);
+	}
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	hrtimer_start(&tlat->timer, next_abs_period, HRTIMER_MODE_ABS_PINNED_HARD);
+	schedule();
+	return 1;
+}
+
+/*
+ * timerlat_main- Timerlat main
+ */
+static int timerlat_main(void *data)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	struct timerlat_variables *tlat = this_cpu_tmr_var();
+	struct timerlat_sample s;
+	struct sched_param sp;
+	u64 now, diff;
+
+	/*
+	 * Make the thread RT, that is how cyclictest is usually used.
+	 */
+	sp.sched_priority = DEFAULT_TIMERLAT_PRIO;
+	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
+
+	tlat->count = 0;
+	tlat->tracing_thread = false;
+
+	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+	tlat->timer.function = timerlat_irq;
+	tlat->kthread = current;
+	osn_var->pid = current->pid;
+	/*
+	 * Anotate the arrival time.
+	 */
+	tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
+
+	wait_next_period(tlat);
+
+	osn_var->sampling = 1;
+
+	while (!kthread_should_stop()) {
+		now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
+		diff = now - tlat->abs_period;
+
+		s.seqnum = tlat->count;
+		s.timer_latency = diff;
+		s.context = THREAD_CONTEXT;
+
+		trace_timerlat_sample(&s);
+
+#ifdef CONFIG_STACKTRACE
+	if (osnoise_data.print_stack)
+		if (osnoise_data.print_stack <= time_to_us(diff))
+			timerlat_dump_stack();
+#endif /* CONFIG_STACKTRACE */
+
+		tlat->tracing_thread = false;
+		if (osnoise_data.stop_tracing_total)
+			if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
+				osnoise_stop_tracing();
+
+		wait_next_period(tlat);
+	}
+
+	hrtimer_cancel(&tlat->timer);
+	return 0;
+}
+#endif /* CONFIG_TIMERLAT_TRACER */
+
 /*
  * stop_per_cpu_kthread - stop per-cpu threads
  *
@@ -992,6 +1428,7 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	struct cpumask *current_mask = &save_cpumask;
 	struct task_struct *kthread;
 	char comm[24];
+	void *main = osnoise_main;
 	int cpu;
 
 	get_online_cpus();
@@ -1009,9 +1446,17 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 
 	for_each_cpu(cpu, current_mask) {
+#ifdef CONFIG_TIMERLAT_TRACER
+		if (osnoise_data.timerlat_tracer) {
+			snprintf(comm, 24, "timerlat/%d", cpu);
+			main = timerlat_main;
+		} else {
+			snprintf(comm, 24, "osnoise/%d", cpu);
+		}
+#else
 		snprintf(comm, 24, "osnoise/%d", cpu);
-
-		kthread = kthread_create_on_cpu(osnoise_main, NULL, cpu, comm);
+#endif
+		kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
 
 		if (IS_ERR(kthread)) {
 			pr_err(BANNER "could not start sampling thread\n");
@@ -1177,6 +1622,31 @@ static struct trace_min_max_param osnoise_stop_tracing_total = {
 	.min	= NULL,
 };
 
+#ifdef CONFIG_TIMERLAT_TRACER
+/*
+ * osnoise/print_stack: print the stacktrace of the IRQ handler if the total
+ * latency is higher than val.
+ */
+static struct trace_min_max_param osnoise_print_stack = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.print_stack,
+	.max	= NULL,
+	.min	= NULL,
+};
+
+/*
+ * osnoise/timerlat_period: min 100 us, max 1 s
+ */
+u64 timerlat_min_period = 100;
+u64 timerlat_max_period = 1000000;
+static struct trace_min_max_param timerlat_period = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.timerlat_period,
+	.max	= &timerlat_max_period,
+	.min	= &timerlat_min_period,
+};
+#endif
+
 static const struct file_operations cpus_fops = {
 	.open		= tracing_open_generic,
 	.read		= osnoise_cpus_read,
@@ -1187,10 +1657,9 @@ static const struct file_operations cpus_fops = {
 /*
  * init_tracefs - A function to initialize the tracefs interface files
  *
- * This function creates entries in tracefs for "osnoise". It creates the
- * "osnoise" directory in the tracing directory, and within that
- * directory is the count, runtime and period files to change and view
- * those values.
+ * This function creates entries in tracefs for "osnoise" and "timerlat".
+ * It creates these directories in the tracing directory, and within that
+ * directory the use can change and view the configs.
  */
 static int init_tracefs(void)
 {
@@ -1204,7 +1673,7 @@ static int init_tracefs(void)
 
 	top_dir = tracefs_create_dir("osnoise", NULL);
 	if (!top_dir)
-		return -ENOMEM;
+		return 0;
 
 	tmp = tracefs_create_file("period_us", 0640, top_dir,
 				  &osnoise_period, &trace_min_max_fops);
@@ -1229,6 +1698,19 @@ static int init_tracefs(void)
 	tmp = trace_create_file("cpus", 0644, top_dir, NULL, &cpus_fops);
 	if (!tmp)
 		goto err;
+#ifdef CONFIG_TIMERLAT_TRACER
+#ifdef CONFIG_STACKTRACE
+	tmp = tracefs_create_file("print_stack", 0640, top_dir,
+				  &osnoise_print_stack, &trace_min_max_fops);
+	if (!tmp)
+		goto err;
+#endif
+
+	tmp = tracefs_create_file("timerlat_period_us", 0640, top_dir,
+				  &timerlat_period, &trace_min_max_fops);
+	if (!tmp)
+		goto err;
+#endif
 
 	return 0;
 
@@ -1269,18 +1751,15 @@ static int osnoise_hook_events(void)
 	return -EINVAL;
 }
 
-static void osnoise_tracer_start(struct trace_array *tr)
+static int __osnoise_tracer_start(struct trace_array *tr)
 {
 	int retval;
 
-	if (osnoise_busy)
-		return;
-
 	osn_var_reset_all();
 
 	retval = osnoise_hook_events();
 	if (retval)
-		goto out_err;
+		return retval;
 	/*
 	 * Make sure NMIs see reseted values.
 	 */
@@ -1288,15 +1767,27 @@ static void osnoise_tracer_start(struct trace_array *tr)
 	trace_osnoise_callback_enabled = true;
 
 	retval = start_per_cpu_kthreads(tr);
-	/*
-	 * all fine!
-	 */
-	if (!retval)
+	if (retval) {
+		unhook_irq_events();
+		return retval;
+	}
+
+	osnoise_busy = true;
+
+	return 0;
+}
+
+static void osnoise_tracer_start(struct trace_array *tr)
+{
+	int retval;
+
+	if (osnoise_busy)
 		return;
 
-out_err:
-	unhook_irq_events();
-	pr_err(BANNER "Error starting osnoise tracer\n");
+	retval = __osnoise_tracer_start(tr);
+	if (retval)
+		pr_err(BANNER "Error starting osnoise tracer\n");
+
 }
 
 static void osnoise_tracer_stop(struct trace_array *tr)
@@ -1318,18 +1809,16 @@ static void osnoise_tracer_stop(struct trace_array *tr)
 
 static int osnoise_tracer_init(struct trace_array *tr)
 {
+
 	/* Only allow one instance to enable this */
 	if (osnoise_busy)
 		return -EBUSY;
 
 	osnoise_trace = tr;
-
 	tr->max_latency = 0;
 
 	osnoise_tracer_start(tr);
 
-	osnoise_busy = true;
-
 	return 0;
 }
 
@@ -1348,6 +1837,71 @@ static struct tracer osnoise_tracer __read_mostly = {
 	.allow_instances = true,
 };
 
+#ifdef CONFIG_TIMERLAT_TRACER
+static void timerlat_tracer_start(struct trace_array *tr)
+{
+	int retval;
+
+	if (osnoise_busy)
+		return;
+
+	osnoise_data.timerlat_tracer = 1;
+
+	retval = __osnoise_tracer_start(tr);
+	if (retval)
+		goto out_err;
+
+	return;
+out_err:
+	pr_err(BANNER "Error starting timerlat tracer\n");
+}
+
+static void timerlat_tracer_stop(struct trace_array *tr)
+{
+	int cpu;
+
+	if (!osnoise_busy)
+		return;
+
+	for_each_online_cpu(cpu)
+		per_cpu(per_cpu_osnoise_var, cpu).sampling = 0;
+
+	osnoise_tracer_stop(tr);
+
+	osnoise_data.timerlat_tracer = 0;
+}
+
+static int timerlat_tracer_init(struct trace_array *tr)
+{
+	/* Only allow one instance to enable this */
+	if (osnoise_busy)
+		return -EBUSY;
+
+	osnoise_trace = tr;
+
+	tr->max_latency = 0;
+
+	timerlat_tracer_start(tr);
+
+	return 0;
+}
+
+static void timerlat_tracer_reset(struct trace_array *tr)
+{
+	timerlat_tracer_stop(tr);
+}
+
+static struct tracer timerlat_tracer __read_mostly = {
+	.name		= "timerlat",
+	.init		= timerlat_tracer_init,
+	.reset		= timerlat_tracer_reset,
+	.start		= timerlat_tracer_start,
+	.stop		= timerlat_tracer_stop,
+	.print_header	= print_timerlat_headers,
+	.allow_instances = true,
+};
+#endif /* CONFIG_TIMERLAT_TRACER */
+
 __init static int init_osnoise_tracer(void)
 {
 	int ret;
@@ -1357,8 +1911,18 @@ __init static int init_osnoise_tracer(void)
 	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
 
 	ret = register_tracer(&osnoise_tracer);
-	if (ret)
+	if (ret) {
+		pr_err(BANNER "Error registering osnoise!\n");
 		return ret;
+	}
+
+#ifdef CONFIG_TIMERLAT_TRACER
+	ret = register_tracer(&timerlat_tracer);
+	if (ret) {
+		pr_err(BANNER "Error registering timerlat\n");
+		return ret;
+	}
+#endif
 
 	init_tracefs();
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 642b6584eba5..a0bf446bb034 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1301,6 +1301,52 @@ static struct trace_event trace_osnoise_event = {
 	.funcs		= &trace_osnoise_funcs,
 };
 
+/* TRACE_TIMERLAT */
+static enum print_line_t
+trace_timerlat_print(struct trace_iterator *iter, int flags,
+		     struct trace_event *event)
+{
+	struct trace_entry *entry = iter->ent;
+	struct trace_seq *s = &iter->seq;
+	struct timerlat_entry *field;
+
+	trace_assign_type(field, entry);
+
+	trace_seq_printf(s, "#%-5u context %6s timer_latency %9llu ns\n",
+			 field->seqnum,
+			 field->context ? "thread" : "irq",
+			 field->timer_latency);
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t
+trace_timerlat_raw(struct trace_iterator *iter, int flags,
+		   struct trace_event *event)
+{
+	struct timerlat_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(s, "%u %d %llu\n",
+			 field->seqnum,
+			 field->context,
+			 field->timer_latency);
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_timerlat_funcs = {
+	.trace		= trace_timerlat_print,
+	.raw		= trace_timerlat_raw,
+};
+
+static struct trace_event trace_timerlat_event = {
+	.type		= TRACE_TIMERLAT,
+	.funcs		= &trace_timerlat_funcs,
+};
+
 /* TRACE_BPUTS */
 static enum print_line_t
 trace_bputs_print(struct trace_iterator *iter, int flags,
@@ -1512,6 +1558,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_print_event,
 	&trace_hwlat_event,
 	&trace_osnoise_event,
+	&trace_timerlat_event,
 	&trace_raw_data_event,
 	&trace_func_repeats_event,
 	NULL
-- 
2.31.1

