Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00FA369BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbhDWVIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244103AbhDWVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619212025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=boyz8PmU4zFsvOh+sYGuCOk45aKrYi01cTRSl/GdVBo=;
        b=PcZ1s+3iUe/abqVwpafNDyCgizbNoY8U56eObzqZ53UDyHeNyC6Io6LNJBqtF6hqXmG+S2
        Ue4Fr9JN9UK5wToXjwUYoAfpCHh1tzD626SwcnuAr/1g21+VBMYm13c7HFD4M5DZohm+h7
        lEe7GQYro86vx/S/075dlyw+K49SlDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-qF4NWDhXOGGmoTl4JSMtcA-1; Fri, 23 Apr 2021 17:07:02 -0400
X-MC-Unique: qF4NWDhXOGGmoTl4JSMtcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BB6018397A5;
        Fri, 23 Apr 2021 21:07:01 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C685560C21;
        Fri, 23 Apr 2021 21:06:54 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH V2 8/9] tracing: Add osnoise tracer
Date:   Fri, 23 Apr 2021 23:05:43 +0200
Message-Id: <211dede2e0a822bc6efd14051ea5d36104b1e370.1619210818.git.bristot@redhat.com>
In-Reply-To: <cover.1619210818.git.bristot@redhat.com>
References: <cover.1619210818.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the context of high-performance computing (HPC), the Operating System
Noise (*osnoise*) refers to the interference experienced by an application
due to activities inside the operating system. In the context of Linux,
NMIs, IRQs, SoftIRQs, and any other system thread can cause noise to the
system. Moreover, hardware-related jobs can also cause noise, for example,
via SMIs.

The osnoise tracer leverages the hwlat_detector by running a similar
loop with preemption, SoftIRQs and IRQs enabled, thus allowing all
the sources of *osnoise* during its execution. Using the same approach
of hwlat, osnoise takes note of the entry and exit point of any
source of interferences, increasing a per-cpu interference counter. The
osnoise tracer also saves an interference counter for each source of
interference. The interference counter for NMI, IRQs, SoftIRQs, and
threads is increased anytime the tool observes these interferences' entry
events. When a noise happens without any interference from the operating
system level, the hardware noise counter increases, pointing to a
hardware-related noise. In this way, osnoise can account for any
source of interference. At the end of the period, the osnoise tracer
prints the sum of all noise, the max single noise, the percentage of CPU
available for the thread, and the counters for the noise sources.

Usage

Write the ASCII text "osnoise" into the current_tracer file of the
tracing system (generally mounted at /sys/kernel/tracing).

For example::

        [root@f32 ~]# cd /sys/kernel/tracing/
        [root@f32 tracing]# echo osnoise > current_tracer

It is possible to follow the trace by reading the trace trace file::

        [root@f32 tracing]# cat trace
        # tracer: osnoise
        #
        #                                _-----=> irqs-off
        #                               / _----=> need-resched
        #                              | / _---=> hardirq/softirq
        #                              || / _--=> preempt-depth                            MAX
        #                              || /                                             SINGLE     Interference counters:
        #                              ||||               RUNTIME      NOISE   % OF CPU  NOISE    +-----------------------------+
        #           TASK-PID      CPU# ||||   TIMESTAMP    IN US       IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD
        #              | |         |   ||||      |           |             |    |            |      |      |      |      |      |
                   <...>-859     [000] ....    81.637220: 1000000        190  99.98100       9     18      0   1007     18      1
                   <...>-860     [001] ....    81.638154: 1000000        656  99.93440      74     23      0   1006     16      3
                   <...>-861     [002] ....    81.638193: 1000000       5675  99.43250     202      6      0   1013     25     21
                   <...>-862     [003] ....    81.638242: 1000000        125  99.98750      45      1      0   1011     23      0
                   <...>-863     [004] ....    81.638260: 1000000       1721  99.82790     168      7      0   1002     49     41
                   <...>-864     [005] ....    81.638286: 1000000        263  99.97370      57      6      0   1006     26      2
                   <...>-865     [006] ....    81.638302: 1000000        109  99.98910      21      3      0   1006     18      1
                   <...>-866     [007] ....    81.638326: 1000000       7816  99.21840     107      8      0   1016     39     19

In addition to the regular trace fields (from TASK-PID to TIMESTAMP), the
tracer prints a message at the end of each period for each CPU that is
running an osnoise/CPU thread. The osnoise specific fields report:

 - The RUNTIME IN USE reports the amount of time in microseconds that
   the osnoise thread kept looping reading the time.
 - The NOISE IN US reports the sum of noise in microseconds observed
   by the osnoise tracer during the associated runtime.
 - The % OF CPU AVAILABLE reports the percentage of CPU available for
   the osnoise thread during the runtime window.
 - The MAX SINGLE NOISE IN US reports the maximum single noise observed
   during the runtime window.
 - The Interference counters display how many each of the respective
   interference happened during the runtime window.

Note that the example above shows a high number of HW noise samples.
The reason being is that this sample was taken on a virtual machine,
and the host interference is detected as a hardware interference.

Tracer options

The tracer has a set of options inside the osnoise directory, they are:

 - osnoise/cpus: CPUs at which a osnoise thread will execute.
 - osnoise/period_us: the period of the osnoise thread.
 - osnoise/runtime_us: how long an osnoise thread will look for noise.
 - osnoise/stop_tracing_in_us: stop the system tracing if a single noise
   higher than the configured value happens. Writing 0 disables this
   option.
 - osnoise/stop_tracing_out_us: stop the system tracing if total noise
   higher than the configured value happens. Writing 0 disables this
   option.
 - tracing_threshold: the minimum delta between two time() reads to be
   considered as noise, in us. When set to 0, the minimum valid value
   will be used, which is currently 1 us.

Additional Tracing

In addition to the tracer, a set of tracepoints were added to
facilitate the identification of the osnoise source.

 - osnoise:sample_threshold: printed anytime a noise is higher than
   the configurable tolerance_ns.
 - osnoise:nmi_noise: noise from NMI, including the duration.
 - osnoise:irq_noise: noise from an IRQ, including the duration.
 - osnoise:softirq_noise: noise from a SoftIRQ, including the
   duration.
 - osnoise:thread_noise: noise from a thread, including the duration.

Note that all the values are *net values*. For example, if while osnoise
is running, another thread preempts the osnoise thread, it will start a
thread_noise duration at the start. Then, an IRQ takes place, preempting
the thread_noise, starting a irq_noise. When the IRQ ends its execution,
it will compute its duration, and this duration will be subtracted from
the thread_noise, in such a way as to avoid the double accounting of the
IRQ execution. This logic is valid for all sources of noise.

Here is one example of the usage of these tracepoints::

       osnoise/8-961     [008] d.h.  5789.857532: irq_noise: local_timer:236 start 5789.857529929 duration 1845 ns
       osnoise/8-961     [008] dNh.  5789.858408: irq_noise: local_timer:236 start 5789.858404871 duration 2848 ns
     migration/8-54      [008] d...  5789.858413: thread_noise: migration/8:54 start 5789.858409300 duration 3068 ns
       osnoise/8-961     [008] ....  5789.858413: sample_threshold: start 5789.858404555 duration 8 us interferences 2

In this example, a noise sample of 8 microseconds was reported in the last
line, pointing to two interferences. Looking backward in the trace, the
two previous entries were about the migration thread running after a
timer IRQ execution. The first event is not part of the noise because
it took place one millisecond before.

It is worth noticing that the sum of the duration reported in the
tracepoints is smaller than eight us reported in the sample_threshold.
The reason roots in the overhead of the entry and exit code that happens
before and after any interference execution. This justifies the dual
approach: measuring thread and tracing.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 Documentation/trace/index.rst          |    1 +
 Documentation/trace/osnoise-tracer.rst |  152 +++
 include/linux/ftrace_irq.h             |   13 +
 include/trace/events/osnoise.h         |  142 +++
 kernel/trace/Kconfig                   |   34 +
 kernel/trace/Makefile                  |    1 +
 kernel/trace/trace.h                   |    9 +-
 kernel/trace/trace_entries.h           |   25 +
 kernel/trace/trace_osnoise.c           | 1555 ++++++++++++++++++++++++
 kernel/trace/trace_output.c            |   72 +-
 10 files changed, 2000 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/trace/osnoise-tracer.rst
 create mode 100644 include/trace/events/osnoise.h
 create mode 100644 kernel/trace/trace_osnoise.c

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index f634b36fd3aa..608107b27cc0 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -23,6 +23,7 @@ Linux Tracing Technologies
    histogram-design
    boottime-trace
    hwlat_detector
+   osnoise-tracer
    intel_th
    ring-buffer-design
    stm
diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
new file mode 100644
index 000000000000..a9f9859a3e29
--- /dev/null
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -0,0 +1,152 @@
+==============
+OSNOISE Tracer
+==============
+
+In the context of high-performance computing (HPC), the Operating System
+Noise (*osnoise*) refers to the interference experienced by an application
+due to activities inside the operating system. In the context of Linux,
+NMIs, IRQs, SoftIRQs, and any other system thread can cause noise to the
+system. Moreover, hardware-related jobs can also cause noise, for example,
+via SMIs.
+
+hwlat_detector is one of the tools used to identify the most complex
+source of noise: *hardware noise*.
+
+In a nutshell, the hwlat_detector creates a thread that runs
+periodically for a given period. At the beginning of a period, the thread
+disables interrupt and starts sampling. While running, the hwlatd
+thread reads the time in a loop. As interrupts are disabled, threads,
+IRQs, and SoftIRQs cannot interfere with the hwlatd thread. Hence, the
+cause of any gap between two different reads of the time roots either on
+NMI or in the hardware itself. At the end of the period, hwlatd enables
+interrupts and reports the max observed gap between the reads. It also
+prints a NMI occurrence counter. If the output does not report NMI
+executions, the user can conclude that the hardware is the culprit for
+the latency. The hwlat detects the NMI execution by observing
+the entry and exit of a NMI.
+
+The osnoise tracer leverages the hwlat_detector by running a
+similar loop with preemption, SoftIRQs and IRQs enabled, thus allowing
+all the sources of *osnoise* during its execution. Using the same approach
+of hwlat, osnoise takes note of the entry and exit point of any
+source of interferences, increasing a per-cpu interference counter. The
+osnoise tracer also saves an interference counter for each source of
+interference. The interference counter for NMI, IRQs, SoftIRQs, and
+threads is increased anytime the tool observes these interferences' entry
+events. When a noise happens without any interference from the operating
+system level, the hardware noise counter increases, pointing to a
+hardware-related noise. In this way, osnoise can account for any
+source of interference. At the end of the period, the osnoise tracer
+prints the sum of all noise, the max single noise, the percentage of CPU
+available for the thread, and the counters for the noise sources.
+
+Usage
+-----
+
+Write the ASCII text "osnoise" into the current_tracer file of the
+tracing system (generally mounted at /sys/kernel/tracing).
+
+For example::
+
+        [root@f32 ~]# cd /sys/kernel/tracing/
+        [root@f32 tracing]# echo osnoise > current_tracer
+
+It is possible to follow the trace by reading the trace trace file::
+
+        [root@f32 tracing]# cat trace
+        # tracer: osnoise
+        #
+        #                                _-----=> irqs-off
+        #                               / _----=> need-resched
+        #                              | / _---=> hardirq/softirq
+        #                              || / _--=> preempt-depth                            MAX
+        #                              || /                                             SINGLE     Interference counters:
+        #                              ||||               RUNTIME      NOISE   % OF CPU  NOISE    +-----------------------------+
+        #           TASK-PID      CPU# ||||   TIMESTAMP    IN US       IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD
+        #              | |         |   ||||      |           |             |    |            |      |      |      |      |      |
+                   <...>-859     [000] ....    81.637220: 1000000        190  99.98100       9     18      0   1007     18      1
+                   <...>-860     [001] ....    81.638154: 1000000        656  99.93440      74     23      0   1006     16      3
+                   <...>-861     [002] ....    81.638193: 1000000       5675  99.43250     202      6      0   1013     25     21
+                   <...>-862     [003] ....    81.638242: 1000000        125  99.98750      45      1      0   1011     23      0
+                   <...>-863     [004] ....    81.638260: 1000000       1721  99.82790     168      7      0   1002     49     41
+                   <...>-864     [005] ....    81.638286: 1000000        263  99.97370      57      6      0   1006     26      2
+                   <...>-865     [006] ....    81.638302: 1000000        109  99.98910      21      3      0   1006     18      1
+                   <...>-866     [007] ....    81.638326: 1000000       7816  99.21840     107      8      0   1016     39     19
+
+In addition to the regular trace fields (from TASK-PID to TIMESTAMP), the
+tracer prints a message at the end of each period for each CPU that is
+running an osnoise/ thread. The osnoise specific fields report:
+
+ - The RUNTIME IN USE reports the amount of time in microseconds that
+   the osnoise thread kept looping reading the time.
+ - The NOISE IN US reports the sum of noise in microseconds observed
+   by the osnoise tracer during the associated runtime.
+ - The % OF CPU AVAILABLE reports the percentage of CPU available for
+   the osnoise thread during the runtime window.
+ - The MAX SINGLE NOISE IN US reports the maximum single noise observed
+   during the runtime window.
+ - The Interference counters display how many each of the respective
+   interference happened during the runtime window.
+
+Note that the example above shows a high number of HW noise samples.
+The reason being is that this sample was taken on a virtual machine,
+and the host interference is detected as a hardware interference.
+
+Tracer options
+---------------------
+
+The tracer has a set of options inside the osnoise directory, they are:
+
+ - osnoise/cpus: CPUs at which a osnoise thread will execute.
+ - osnoise/period_us: the period of the osnoise thread.
+ - osnoise/runtime_us: how long an osnoise thread will look for noise.
+ - osnoise/stop_tracing_in_us: stop the system tracing if a single noise
+   higher than the configured value happens. Writing 0 disables this
+   option.
+ - osnoise/stop_tracing_out_us: stop the system tracing if total noise
+   higher than the configured value happens. Writing 0 disables this
+   option.
+ - tracing_threshold: the minimum delta between two time() reads to be
+   considered as noise, in us. When set to 0, the minimum valid value
+   will be used, which is currently 1 us.
+
+Additional Tracing
+------------------
+
+In addition to the tracer, a set of tracepoints were added to
+facilitate the identification of the osnoise source.
+
+ - osnoise:sample_threshold: printed anytime a noise is higher than
+   the configurable tolerance_ns.
+ - osnoise:nmi_noise: noise from NMI, including the duration.
+ - osnoise:irq_noise: noise from an IRQ, including the duration.
+ - osnoise:softirq_noise: noise from a SoftIRQ, including the
+   duration.
+ - osnoise:thread_noise: noise from a thread, including the duration.
+
+Note that all the values are *net values*. For example, if while osnoise
+is running, another thread preempts the osnoise thread, it will start a
+thread_noise duration at the start. Then, an IRQ takes place, preempting
+the thread_noise, starting a irq_noise. When the IRQ ends its execution,
+it will compute its duration, and this duration will be subtracted from
+the thread_noise, in such a way as to avoid the double accounting of the
+IRQ execution. This logic is valid for all sources of noise.
+
+Here is one example of the usage of these tracepoints::
+
+       osnoise/8-961     [008] d.h.  5789.857532: irq_noise: local_timer:236 start 5789.857529929 duration 1845 ns
+       osnoise/8-961     [008] dNh.  5789.858408: irq_noise: local_timer:236 start 5789.858404871 duration 2848 ns
+     migration/8-54      [008] d...  5789.858413: thread_noise: migration/8:54 start 5789.858409300 duration 3068 ns
+       osnoise/8-961     [008] ....  5789.858413: sample_threshold: start 5789.858404555 duration 8 us interferences 2
+
+In this example, a noise sample of 8 microseconds was reported in the last
+line, pointing to two interferences. Looking backward in the trace, the
+two previous entries were about the migration thread running after a
+timer IRQ execution. The first event is not part of the noise because
+it took place one millisecond before.
+
+It is worth noticing that the sum of the duration reported in the
+tracepoints is smaller than eight us reported in the sample_threshold.
+The reason roots in the overhead of the entry and exit code that happens
+before and after any interference execution. This justifies the dual
+approach: measuring thread and tracing.
diff --git a/include/linux/ftrace_irq.h b/include/linux/ftrace_irq.h
index 0abd9a1d2852..f6faa31289ba 100644
--- a/include/linux/ftrace_irq.h
+++ b/include/linux/ftrace_irq.h
@@ -7,12 +7,21 @@ extern bool trace_hwlat_callback_enabled;
 extern void trace_hwlat_callback(bool enter);
 #endif
 
+#ifdef CONFIG_OSNOISE_TRACER
+extern bool trace_osnoise_callback_enabled;
+extern void trace_osnoise_callback(bool enter);
+#endif
+
 static inline void ftrace_nmi_enter(void)
 {
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
 		trace_hwlat_callback(true);
 #endif
+#ifdef CONFIG_OSNOISE_TRACER
+	if (trace_osnoise_callback_enabled)
+		trace_osnoise_callback(true);
+#endif
 }
 
 static inline void ftrace_nmi_exit(void)
@@ -21,6 +30,10 @@ static inline void ftrace_nmi_exit(void)
 	if (trace_hwlat_callback_enabled)
 		trace_hwlat_callback(false);
 #endif
+#ifdef CONFIG_OSNOISE_TRACER
+	if (trace_osnoise_callback_enabled)
+		trace_osnoise_callback(false);
+#endif
 }
 
 #endif /* _LINUX_FTRACE_IRQ_H */
diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
new file mode 100644
index 000000000000..acf699243a38
--- /dev/null
+++ b/include/trace/events/osnoise.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM osnoise
+
+#if !defined(_OSNOISE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _OSNOISE_TRACE_H
+
+#include <linux/tracepoint.h>
+TRACE_EVENT(thread_noise,
+
+	TP_PROTO(struct task_struct *t, u64 start, u64 duration),
+
+	TP_ARGS(t, start, duration),
+
+	TP_STRUCT__entry(
+		__array(	char,		comm,	TASK_COMM_LEN)
+		__field(	u64,		start	)
+		__field(	u64,		duration)
+		__field(	pid_t,		pid	)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
+		__entry->pid = t->pid;
+		__entry->start = start;
+		__entry->duration = duration;
+	),
+
+	TP_printk("%8s:%d start %llu.%09u duration %llu ns",
+		__entry->comm,
+		__entry->pid,
+		__print_ns_to_secs(__entry->start),
+		__print_ns_without_secs(__entry->start),
+		__entry->duration)
+);
+
+TRACE_EVENT(softirq_noise,
+
+	TP_PROTO(int vector, u64 start, u64 duration),
+
+	TP_ARGS(vector, start, duration),
+
+	TP_STRUCT__entry(
+		__field(	u64,		start	)
+		__field(	u64,		duration)
+		__field(	int,		vector	)
+	),
+
+	TP_fast_assign(
+		__entry->vector = vector;
+		__entry->start = start;
+		__entry->duration = duration;
+	),
+
+	TP_printk("%8s:%d start %llu.%09u duration %llu ns",
+		show_softirq_name(__entry->vector),
+		__entry->vector,
+		__print_ns_to_secs(__entry->start),
+		__print_ns_without_secs(__entry->start),
+		__entry->duration)
+);
+
+TRACE_EVENT(irq_noise,
+
+	TP_PROTO(int vector, const char *desc, u64 start, u64 duration),
+
+	TP_ARGS(vector, desc, start, duration),
+
+	TP_STRUCT__entry(
+		__field(	u64,		start	)
+		__field(	u64,		duration)
+		__string(	desc,		desc    )
+		__field(	int,		vector	)
+
+	),
+
+	TP_fast_assign(
+		__assign_str(desc, desc);
+		__entry->vector = vector;
+		__entry->start = start;
+		__entry->duration = duration;
+	),
+
+	TP_printk("%s:%d start %llu.%09u duration %llu ns",
+		__get_str(desc),
+		__entry->vector,
+		__print_ns_to_secs(__entry->start),
+		__print_ns_without_secs(__entry->start),
+		__entry->duration)
+);
+
+TRACE_EVENT(nmi_noise,
+
+	TP_PROTO(u64 start, u64 duration),
+
+	TP_ARGS(start, duration),
+
+	TP_STRUCT__entry(
+		__field(	u64,		start	)
+		__field(	u64,		duration)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->duration = duration;
+	),
+
+	TP_printk("start %llu.%09u duration %llu ns",
+		__print_ns_to_secs(__entry->start),
+		__print_ns_without_secs(__entry->start),
+		__entry->duration)
+);
+
+TRACE_EVENT(sample_threshold,
+
+	TP_PROTO(u64 start, u64 duration, u64 interference),
+
+	TP_ARGS(start, duration, interference),
+
+	TP_STRUCT__entry(
+		__field(	u64,		start	)
+		__field(	u64,		duration)
+		__field(	u64,		interference)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->duration = duration;
+		__entry->interference = interference;
+	),
+
+	TP_printk("start %llu.%09u duration %llu us interferences %llu",
+		__print_ns_to_secs(__entry->start),
+		__print_ns_without_secs(__entry->start),
+		__entry->duration,
+		__entry->interference)
+);
+
+#endif /* _TRACE_OSNOISE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 7fa82778c3e6..41582ae4682b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -356,6 +356,40 @@ config HWLAT_TRACER
 	 file. Every time a latency is greater than tracing_thresh, it will
 	 be recorded into the ring buffer.
 
+config OSNOISE_TRACER
+	bool "OS Noise tracer"
+	select GENERIC_TRACER
+	help
+	  In the context of high-performance computing (HPC), the Operating
+	  System Noise (osnoise) refers to the interference experienced by an
+	  application due to activities inside the operating system. In the
+	  context of Linux, NMIs, IRQs, SoftIRQs, and any other system thread
+	  can cause noise to the system. Moreover, hardware-related jobs can
+	  also cause noise, for example, via SMIs.
+
+	  The osnoise tracer leverages the hwlat_detector by running a similar
+	  loop with preemption, SoftIRQs and IRQs enabled, thus allowing all
+	  the sources of osnoise during its execution. The osnoise tracer takes
+	  note of the entry and exit point of any source of interferences,
+	  increasing a per-cpu interference counter. It saves an interference
+	  counter for each source of interference. The interference counter for
+	  NMI, IRQs, SoftIRQs, and threads is increased anytime the tool
+	  observes these interferences' entry events. When a noise happens
+	  without any interference from the operating system level, the
+	  hardware noise counter increases, pointing to a hardware-related
+	  noise. In this way, osnoise can account for any source of
+	  interference. At the end of the period, the osnoise tracer prints
+	  the sum of all noise, the max single noise, the percentage of CPU
+	  available for the thread, and the counters for the noise sources.
+
+	  In addition to the tracer, a set of tracepoints were added to
+	  facilitate the identification of the osnoise source.
+
+	  The output will appear in the trace and trace_pipe files.
+
+	  To enable this tracer, echo in "osnoise" into the current_tracer
+          file.
+
 config MMIOTRACE
 	bool "Memory mapped IO tracing"
 	depends on HAVE_MMIOTRACE_SUPPORT && PCI
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index b28d3e5013cd..b1c47ccf4f73 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
 obj-$(CONFIG_HWLAT_TRACER) += trace_hwlat.o
+obj-$(CONFIG_OSNOISE_TRACER) += trace_osnoise.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5a47c27b768f..55ff73c636dc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -44,6 +44,7 @@ enum trace_type {
 	TRACE_BLK,
 	TRACE_BPUTS,
 	TRACE_HWLAT,
+	TRACE_OSNOISE,
 	TRACE_RAW_DATA,
 
 	__TRACE_LAST_TYPE,
@@ -285,7 +286,8 @@ struct trace_array {
 	struct array_buffer	max_buffer;
 	bool			allocated_snapshot;
 #endif
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
+#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
+	|| defined(CONFIG_OSNOISE_TRACER)
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
@@ -431,6 +433,7 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct bprint_entry, TRACE_BPRINT);	\
 		IF_ASSIGN(var, ent, struct bputs_entry, TRACE_BPUTS);	\
 		IF_ASSIGN(var, ent, struct hwlat_entry, TRACE_HWLAT);	\
+		IF_ASSIGN(var, ent, struct osnoise_entry, TRACE_OSNOISE);\
 		IF_ASSIGN(var, ent, struct raw_data_entry, TRACE_RAW_DATA);\
 		IF_ASSIGN(var, ent, struct trace_mmiotrace_rw,		\
 			  TRACE_MMIO_RW);				\
@@ -656,8 +659,8 @@ void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
-	defined(CONFIG_FSNOTIFY)
+#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) \
+	|| defined(CONFIG_OSNOISE_TRACER) && defined(CONFIG_FSNOTIFY)
 
 void latency_fsnotify(struct trace_array *tr);
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 4547ac59da61..ef85654597a6 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -338,3 +338,28 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		 __entry->nmi_total_ts,
 		 __entry->nmi_count)
 );
+
+FTRACE_ENTRY(osnoise, osnoise_entry,
+
+	TRACE_OSNOISE,
+
+	F_STRUCT(
+		__field(	u64,			noise		)
+		__field(	u64,			runtime		)
+		__field(	u64,			max_sample	)
+		__field(	unsigned int,		hw_count	)
+		__field(	unsigned int,		nmi_count	)
+		__field(	unsigned int,		irq_count	)
+		__field(	unsigned int,		softirq_count	)
+		__field(	unsigned int,		thread_count	)
+	),
+
+	F_printk("noise:%llu\tmax_sample:%llu\thw:%u\tnmi:%u\tirq:%u\tsoftirq:%u\tthread:%u\n",
+		 __entry->noise,
+		 __entry->max_sample,
+		 __entry->hw_count,
+		 __entry->nmi_count,
+		 __entry->irq_count,
+		 __entry->softirq_count,
+		 __entry->thread_count)
+);
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
new file mode 100644
index 000000000000..2bccdd1a9f87
--- /dev/null
+++ b/kernel/trace/trace_osnoise.c
@@ -0,0 +1,1555 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OS Noise Tracer: computes the OS Noise suffered by a running thread.
+ *
+ * Based on "hwlat_detector" tracer by:
+ *   Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
+ *   Copyright (C) 2013-2016 Steven Rostedt, Red Hat, Inc. <srostedt@redhat.com>
+ *   With feedback from Clark Williams <williams@redhat.com>
+ *
+ * And also based on the rtsl tracer presented on:
+ *  DE OLIVEIRA, Daniel Bristot, et al. Demystifying the real-time linux
+ *  scheduling latency. In: 32nd Euromicro Conference on Real-Time Systems
+ *  (ECRTS 2020). Schloss Dagstuhl-Leibniz-Zentrum fur Informatik, 2020.
+ *
+ * Copyright (C) 2021 Daniel Bristot de Oliveira, Red Hat, Inc. <bristot@redhat.com>
+ */
+#include <linux/kthread.h>
+#include <linux/tracefs.h>
+#include <linux/uaccess.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/sched/clock.h>
+#include <linux/sched.h>
+#include "trace.h"
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/trace/irq_vectors.h>
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+#include <trace/events/irq.h>
+#include <trace/events/sched.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/osnoise.h>
+
+static struct trace_array	*osnoise_trace;
+
+/*
+ * Default values.
+ */
+#define BANNER			"osnoise: "
+#define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
+#define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
+
+/*
+ * NMI runtime info.
+ */
+struct nmi {
+	u64 count;
+	u64 delta_start;
+};
+
+/*
+ * IRQ runtime info.
+ */
+struct irq {
+	u64 count;
+	u64 arrival_time;
+	u64 delta_start;
+};
+
+/*
+ * SofIRQ runtime info.
+ */
+struct softirq {
+	u64 count;
+	u64 arrival_time;
+	u64 delta_start;
+};
+
+/*
+ * Thread runtime info.
+ */
+struct thread {
+	u64 count;
+	u64 arrival_time;
+	u64 delta_start;
+};
+
+/*
+ * Runtime information: this structure saves the runtime information used by
+ * one sampling thread.
+ */
+struct osnoise_variables {
+	struct task_struct *kthread;
+	bool sampling;
+	pid_t pid;
+	struct nmi nmi;
+	struct irq irq;
+	struct softirq softirq;
+	struct thread thread;
+	local_t int_counter;
+};
+
+/*
+ * Per-cpu runtime information.
+ */
+DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+
+/**
+ * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
+ */
+static inline struct osnoise_variables *this_cpu_osn_var(void)
+{
+	return this_cpu_ptr(&per_cpu_osnoise_var);
+}
+
+/**
+ * osn_var_reset - Reset the values of the given osnoise_variables
+ */
+static inline void osn_var_reset(struct osnoise_variables *osn_var)
+{
+	/*
+	 * So far, all the values are initialized as 0, so
+	 * zeroing the structure is perfect.
+	 */
+	memset(osn_var, 0, sizeof(struct osnoise_variables));
+}
+
+/**
+ * osn_var_reset_all - Reset the value of all per-cpu osnoise_variables
+ */
+static inline void osn_var_reset_all(void)
+{
+	struct osnoise_variables *osn_var;
+	int cpu;
+
+	for_each_cpu(cpu, cpu_online_mask) {
+		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
+		osn_var_reset(osn_var);
+	}
+}
+
+/*
+ * Tells NMIs to call back to the osnoise tracer to record timestamps.
+ */
+bool trace_osnoise_callback_enabled;
+
+/*
+ * osnoise sample structure definition. Used to store the statistics of a
+ * sample run.
+ */
+struct osnoise_sample {
+	u64			runtime;	/* runtime */
+	u64			noise;		/* noise */
+	u64			max_sample;	/* max single noise sample */
+	int			hw_count;	/* # HW (incl. hypervisor) interference */
+	int			nmi_count;	/* # NMIs during this sample */
+	int			irq_count;	/* # IRQs during this sample */
+	int			softirq_count;	/* # SoftIRQs during this sample */
+	int			thread_count;	/* # Threads during this sample */
+};
+
+/*
+ * Protect the interface.
+ */
+struct mutex interface_lock;
+
+/*
+ * Tracer data.
+ */
+static struct osnoise_data {
+	u64	sample_period;		/* total sampling period */
+	u64	sample_runtime;		/* active sampling portion of period */
+	u64	stop_tracing_in;	/* stop trace in the inside operation (loop) */
+	u64	stop_tracing_out;	/* stop trace in the outside operation (report) */
+} osnoise_data = {
+	.sample_period			= DEFAULT_SAMPLE_PERIOD,
+	.sample_runtime			= DEFAULT_SAMPLE_RUNTIME,
+	.stop_tracing_in		= 0,
+	.stop_tracing_out		= 0,
+};
+
+/*
+ * Boolean variable used to inform that the tracer is currently sampling.
+ */
+static bool osnoise_busy;
+
+/*
+ * Print the osnoise header info.
+ */
+static void print_osnoise_headers(struct seq_file *s)
+{
+	seq_puts(s, "#                                _-----=> irqs-off\n");
+	seq_puts(s, "#                               / _----=> need-resched\n");
+	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
+	seq_puts(s, "#                              || / _--=> preempt-depth     ");
+	seq_puts(s, "                       MAX\n");
+
+	seq_puts(s, "#                              || /                         ");
+	seq_puts(s, "                    SINGLE      Interference counters:\n");
+
+	seq_puts(s, "#                              ||||               RUNTIME   ");
+	seq_puts(s, "   NOISE  %% OF CPU  NOISE    +-----------------------------+\n");
+
+	seq_puts(s, "#           TASK-PID      CPU# ||||   TIMESTAMP    IN US    ");
+	seq_puts(s, "   IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD\n");
+
+	seq_puts(s, "#              | |         |   ||||      |           |      ");
+	seq_puts(s, "       |    |            |      |      |      |      |      |\n");
+}
+
+/*
+ * Record an osnoise_sample into the tracer buffer.
+ */
+static void trace_osnoise_sample(struct osnoise_sample *sample)
+{
+	struct trace_array *tr = osnoise_trace;
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_event_call *call = &event_osnoise;
+	struct ring_buffer_event *event;
+	struct osnoise_entry *entry;
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_OSNOISE, sizeof(*entry),
+					  tracing_gen_ctx());
+	if (!event)
+		return;
+	entry	= ring_buffer_event_data(event);
+	entry->runtime		= sample->runtime;
+	entry->noise		= sample->noise;
+	entry->max_sample	= sample->max_sample;
+	entry->hw_count		= sample->hw_count;
+	entry->nmi_count	= sample->nmi_count;
+	entry->irq_count	= sample->irq_count;
+	entry->softirq_count	= sample->softirq_count;
+	entry->thread_count	= sample->thread_count;
+
+	if (!call_filter_check_discard(call, entry, buffer, event))
+		trace_buffer_unlock_commit_nostack(buffer, event);
+}
+
+/**
+ * Macros to encapsulate the time capturing infrastructure.
+ */
+#define time_get()	trace_clock_local()
+#define time_to_us(x)	div_u64(x, 1000)
+#define time_sub(a, b)	((a) - (b))
+
+/**
+ * cond_move_irq_delta_start - Forward the delta_start of a running IRQ
+ *
+ * If an IRQ is preempted by an NMI, its delta_start is pushed forward
+ * to discount the NMI interference.
+ *
+ * See get_int_safe_duration().
+ */
+static inline void
+cond_move_irq_delta_start(struct osnoise_variables *osn_var, u64 duration)
+{
+	if (osn_var->irq.delta_start)
+		osn_var->irq.delta_start += duration;
+}
+
+#ifndef CONFIG_PREEMPT_RT
+/**
+ * cond_move_softirq_delta_start - Forward the delta_start of a running SoftIRQ
+ *
+ * If a SoftIRQ is preempted by an IRQ or NMI, its delta_start is pushed
+ * forward to discount the interference.
+ *
+ * See get_int_safe_duration().
+ */
+static inline void
+cond_move_softirq_delta_start(struct osnoise_variables *osn_var, u64 duration)
+{
+	if (osn_var->softirq.delta_start)
+		osn_var->softirq.delta_start += duration;
+}
+#else /* CONFIG_PREEMPT_RT */
+#define cond_move_softirq_delta_start(osn_var, duration) do {} while (0)
+#endif
+
+/**
+ * cond_move_thread_delta_start - Forward the delta_start of a running thread
+ *
+ * If a noisy thread is preempted by an Softirq, IRQ or NMI, its delta_start
+ * is pushed forward to discount the interference.
+ *
+ * See get_int_safe_duration().
+ */
+static inline void
+cond_move_thread_delta_start(struct osnoise_variables *osn_var, u64 duration)
+{
+	if (osn_var->thread.delta_start)
+		osn_var->thread.delta_start += duration;
+}
+
+/**
+ * get_int_safe_duration - Get the duration of a window
+ *
+ * The irq, softirq and thread varaibles need to have its duration without
+ * the interference from higher priority interrupts. Instead of keeping a
+ * variable to discount the interrupt interference from these variables, the
+ * starting time of these variables are pushed forward with the interrupt's
+ * duration. In this way, a single variable is used to:
+ *
+ *   - Know if a given window is being measured.
+ *   - Account its duration.
+ *   - Discount the interference.
+ *
+ * To avoid getting inconsistent values, e.g.,:
+ *
+ *	now = time_get()
+ *		--->	interrupt!
+ *			delta_start -= int duration;
+ *		<---
+ *	duration = now - delta_start;
+ *
+ *	result: negative duration if the variable duration before the
+ *	interrupt was smaller than the interrupt execution.
+ *
+ * A counter of interrupts is used. If the counter increased, try
+ * to capture an interference safe duration.
+ */
+static inline s64
+get_int_safe_duration(struct osnoise_variables *osn_var, u64 *delta_start)
+{
+	u64 int_counter, now;
+	s64 duration;
+
+	do {
+		int_counter = local_read(&osn_var->int_counter);
+		/* synchronize with interrupts */
+		barrier();
+
+		now = time_get();
+		duration = (now - *delta_start);
+
+		/* synchronize with interrupts */
+		barrier();
+	} while (int_counter != local_read(&osn_var->int_counter));
+
+	/*
+	 * This is an evidence of race conditions that cause
+	 * a value to be "discounted" too much.
+	 */
+	if (duration < 0)
+		pr_err("int safe negative!\n");
+
+	*delta_start = 0;
+
+	return duration;
+}
+
+/**
+ *
+ * set_int_safe_time - Save the current time on *time, aware of interference
+ *
+ * Get the time, taking into consideration a possible interference from
+ * higher priority interrupts.
+ *
+ * See get_int_safe_duration() for an explanation.
+ */
+static u64
+set_int_safe_time(struct osnoise_variables *osn_var, u64 *time)
+{
+	u64 int_counter;
+
+	do {
+		int_counter = local_read(&osn_var->int_counter);
+		/* synchronize with interrupts */
+		barrier();
+
+		*time = time_get();
+
+		/* synchronize with interrupts */
+		barrier();
+	} while (int_counter != local_read(&osn_var->int_counter));
+
+	return int_counter;
+}
+
+/**
+ * trace_osnoise_callback - NMI entry/exit callback
+ *
+ * This function is called at the entry and exit NMI code. The bool enter
+ * distinguishes between either case. This function is used to note a NMI
+ * occurrence, compute the noise caused by the NMI, and to remove the noise
+ * it is potentially causing on other interference variables.
+ */
+void trace_osnoise_callback(bool enter)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	u64 duration;
+
+	if (!osn_var->sampling)
+		return;
+
+	/*
+	 * Currently trace_clock_local() calls sched_clock() and the
+	 * generic version is not NMI safe.
+	 */
+	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
+		if (enter) {
+			osn_var->nmi.delta_start = time_get();
+			local_inc(&osn_var->int_counter);
+		} else {
+			duration = time_get() - osn_var->nmi.delta_start;
+
+			trace_nmi_noise(osn_var->nmi.delta_start, duration);
+
+			cond_move_irq_delta_start(osn_var, duration);
+			cond_move_softirq_delta_start(osn_var, duration);
+			cond_move_thread_delta_start(osn_var, duration);
+		}
+	}
+
+	if (enter)
+		osn_var->nmi.count++;
+}
+
+/**
+ * __trace_irq_entry - Note the starting of an IRQ
+ *
+ * Save the starting time of an IRQ. As IRQs are non-preemptive to other IRQs,
+ * it is safe to use a single variable (ons_var->irq) to save the statistics.
+ * The arrival_time is used to report... the arrival time. The delta_start
+ * is used to compute the duration at the IRQ exit handler. See
+ * cond_move_irq_delta_start().
+ */
+static inline void __trace_irq_entry(int id)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+
+	if (!osn_var->sampling)
+		return;
+	/*
+	 * This value will be used in the report, but not to compute
+	 * the execution time, so it is safe to get it unsafe.
+	 */
+	osn_var->irq.arrival_time = time_get();
+	set_int_safe_time(osn_var, &osn_var->irq.delta_start);
+	osn_var->irq.count++;
+
+	local_inc(&osn_var->int_counter);
+}
+
+/**
+ * __trace_irq_exit - Note the end of an IRQ, sava data and trace
+ *
+ * Computes the duration of the IRQ noise, and trace it. Also discounts the
+ * interference from other sources of noise could be currently being accounted.
+ */
+static inline void __trace_irq_exit(int id, const char *desc)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	int duration;
+
+	if (!osn_var->sampling)
+		return;
+
+	duration = get_int_safe_duration(osn_var, &osn_var->irq.delta_start);
+	trace_irq_noise(id, desc, osn_var->irq.arrival_time, duration);
+	osn_var->irq.arrival_time = 0;
+	cond_move_softirq_delta_start(osn_var, duration);
+	cond_move_thread_delta_start(osn_var, duration);
+}
+
+/**
+ * trace_irqentry_callback - Callback to the irq:irq_entry traceevent
+ *
+ * Used to note the starting of an IRQ occurece.
+ */
+void trace_irqentry_callback(void *data, int irq, struct irqaction *action)
+{
+	__trace_irq_entry(irq);
+}
+
+/**
+ * trace_irqexit_callback - Callback to the irq:irq_exit traceevent
+ *
+ * Used to note the end of an IRQ occurece.
+ */
+void trace_irqexit_callback(void *data, int irq, struct irqaction *action, int ret)
+{
+	__trace_irq_exit(irq, action->name);
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/**
+ * trace_intel_irq_entry - record intel specific IRQ entry
+ */
+void trace_intel_irq_entry(void *data, int vector)
+{
+	__trace_irq_entry(vector);
+}
+
+/**
+ * trace_intel_irq_exit - record intel specific IRQ exit
+ */
+void trace_intel_irq_exit(void *data, int vector)
+{
+	char *vector_desc = (char *) data;
+
+	__trace_irq_exit(vector, vector_desc);
+}
+
+/**
+ * register_intel_irq_tp - Register intel specific IRQ entry tracepoints
+ */
+static int register_intel_irq_tp(void)
+{
+	int ret;
+
+	ret = register_trace_local_timer_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_err;
+
+	ret = register_trace_local_timer_exit(trace_intel_irq_exit, "local_timer");
+	if (ret)
+		goto out_timer_entry;
+
+#ifdef CONFIG_X86_THERMAL_VECTOR
+	ret = register_trace_thermal_apic_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_timer_exit;
+
+	ret = register_trace_thermal_apic_exit(trace_intel_irq_exit, "thermal_apic");
+	if (ret)
+		goto out_thermal_entry;
+#endif /* CONFIG_X86_THERMAL_VECTOR */
+
+#ifdef CONFIG_X86_MCE_AMD
+	ret = register_trace_deferred_error_apic_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_thermal_exit;
+
+	ret = register_trace_deferred_error_apic_exit(trace_intel_irq_exit, "deferred_error");
+	if (ret)
+		goto out_deferred_entry;
+#endif
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+	ret = register_trace_threshold_apic_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_deferred_exit;
+
+	ret = register_trace_threshold_apic_exit(trace_intel_irq_exit, "threshold_apic");
+	if (ret)
+		goto out_threshold_entry;
+#endif /* CONFIG_X86_MCE_THRESHOLD */
+
+#ifdef CONFIG_SMP
+	ret = register_trace_call_function_single_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_threshold_exit;
+
+	ret = register_trace_call_function_single_exit(trace_intel_irq_exit,
+						       "call_function_single");
+	if (ret)
+		goto out_call_function_single_entry;
+
+	ret = register_trace_call_function_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_call_function_single_exit;
+
+	ret = register_trace_call_function_exit(trace_intel_irq_exit, "call_function");
+	if (ret)
+		goto out_call_function_entry;
+
+	ret = register_trace_reschedule_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_call_function_exit;
+
+	ret = register_trace_reschedule_exit(trace_intel_irq_exit, "reschedule");
+	if (ret)
+		goto out_reschedule_entry;
+#endif /* CONFIG_SMP */
+
+#ifdef CONFIG_IRQ_WORK
+	ret = register_trace_irq_work_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_reschedule_exit;
+
+	ret = register_trace_irq_work_exit(trace_intel_irq_exit, "irq_work");
+	if (ret)
+		goto out_irq_work_entry;
+#endif
+
+	ret = register_trace_x86_platform_ipi_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_irq_work_exit;
+
+	ret = register_trace_x86_platform_ipi_exit(trace_intel_irq_exit, "x86_platform_ipi");
+	if (ret)
+		goto out_x86_ipi_entry;
+
+	ret = register_trace_error_apic_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_x86_ipi_exit;
+
+	ret = register_trace_error_apic_exit(trace_intel_irq_exit, "error_apic");
+	if (ret)
+		goto out_error_apic_entry;
+
+	ret = register_trace_spurious_apic_entry(trace_intel_irq_entry, NULL);
+	if (ret)
+		goto out_error_apic_exit;
+
+	ret = register_trace_spurious_apic_exit(trace_intel_irq_exit, "spurious_apic");
+	if (ret)
+		goto out_spurious_apic_entry;
+
+	return 0;
+
+out_spurious_apic_entry:
+	unregister_trace_spurious_apic_entry(trace_intel_irq_entry, NULL);
+out_error_apic_exit:
+	unregister_trace_error_apic_exit(trace_intel_irq_exit, "error_apic");
+out_error_apic_entry:
+	unregister_trace_error_apic_entry(trace_intel_irq_entry, NULL);
+out_x86_ipi_exit:
+	unregister_trace_x86_platform_ipi_exit(trace_intel_irq_exit, "x86_platform_ipi");
+out_x86_ipi_entry:
+	unregister_trace_x86_platform_ipi_entry(trace_intel_irq_entry, NULL);
+out_irq_work_exit:
+
+#ifdef CONFIG_IRQ_WORK
+	unregister_trace_irq_work_exit(trace_intel_irq_exit, "irq_work");
+out_irq_work_entry:
+	unregister_trace_irq_work_entry(trace_intel_irq_entry, NULL);
+out_reschedule_exit:
+#endif
+
+#ifdef CONFIG_SMP
+	unregister_trace_reschedule_exit(trace_intel_irq_exit, "reschedule");
+out_reschedule_entry:
+	unregister_trace_reschedule_entry(trace_intel_irq_entry, NULL);
+out_call_function_exit:
+	unregister_trace_call_function_exit(trace_intel_irq_exit, "call_function");
+out_call_function_entry:
+	unregister_trace_call_function_entry(trace_intel_irq_entry, NULL);
+out_call_function_single_exit:
+	unregister_trace_call_function_single_exit(trace_intel_irq_exit, "call_function_single");
+out_call_function_single_entry:
+	unregister_trace_call_function_single_entry(trace_intel_irq_entry, NULL);
+out_threshold_exit:
+#endif
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+	unregister_trace_threshold_apic_exit(trace_intel_irq_exit, "threshold_apic");
+out_threshold_entry:
+	unregister_trace_threshold_apic_entry(trace_intel_irq_entry, NULL);
+out_deferred_exit:
+#endif
+
+#ifdef CONFIG_X86_MCE_AMD
+	unregister_trace_deferred_error_apic_exit(trace_intel_irq_exit, "deferred_error");
+out_deferred_entry:
+	unregister_trace_deferred_error_apic_entry(trace_intel_irq_entry, NULL);
+out_thermal_exit:
+#endif /* CONFIG_X86_MCE_AMD */
+
+#ifdef CONFIG_X86_THERMAL_VECTOR
+	unregister_trace_thermal_apic_exit(trace_intel_irq_exit, "thermal_apic");
+out_thermal_entry:
+	unregister_trace_thermal_apic_entry(trace_intel_irq_entry, NULL);
+out_timer_exit:
+#endif /* CONFIG_X86_THERMAL_VECTOR */
+
+	unregister_trace_local_timer_exit(trace_intel_irq_exit, "local_timer");
+out_timer_entry:
+	unregister_trace_local_timer_entry(trace_intel_irq_entry, NULL);
+out_err:
+	return -EINVAL;
+}
+
+static void unregister_intel_irq_tp(void)
+{
+	unregister_trace_spurious_apic_exit(trace_intel_irq_exit, "spurious_apic");
+	unregister_trace_spurious_apic_entry(trace_intel_irq_entry, NULL);
+	unregister_trace_error_apic_exit(trace_intel_irq_exit, "error_apic");
+	unregister_trace_error_apic_entry(trace_intel_irq_entry, NULL);
+	unregister_trace_x86_platform_ipi_exit(trace_intel_irq_exit, "x86_platform_ipi");
+	unregister_trace_x86_platform_ipi_entry(trace_intel_irq_entry, NULL);
+
+#ifdef CONFIG_IRQ_WORK
+	unregister_trace_irq_work_exit(trace_intel_irq_exit, "irq_work");
+	unregister_trace_irq_work_entry(trace_intel_irq_entry, NULL);
+#endif
+
+#ifdef CONFIG_SMP
+	unregister_trace_reschedule_exit(trace_intel_irq_exit, "reschedule");
+	unregister_trace_reschedule_entry(trace_intel_irq_entry, NULL);
+	unregister_trace_call_function_exit(trace_intel_irq_exit, "call_function");
+	unregister_trace_call_function_entry(trace_intel_irq_entry, NULL);
+	unregister_trace_call_function_single_exit(trace_intel_irq_exit, "call_function_single");
+	unregister_trace_call_function_single_entry(trace_intel_irq_entry, NULL);
+#endif
+
+#ifdef CONFIG_X86_MCE_THRESHOLD
+	unregister_trace_threshold_apic_exit(trace_intel_irq_exit, "threshold_apic");
+	unregister_trace_threshold_apic_entry(trace_intel_irq_entry, NULL);
+#endif
+
+#ifdef CONFIG_X86_MCE_AMD
+	unregister_trace_deferred_error_apic_exit(trace_intel_irq_exit, "deferred_error");
+	unregister_trace_deferred_error_apic_entry(trace_intel_irq_entry, NULL);
+#endif
+
+#ifdef CONFIG_X86_THERMAL_VECTOR
+	unregister_trace_thermal_apic_exit(trace_intel_irq_exit, "thermal_apic");
+	unregister_trace_thermal_apic_entry(trace_intel_irq_entry, NULL);
+#endif /* CONFIG_X86_THERMAL_VECTOR */
+
+	unregister_trace_local_timer_exit(trace_intel_irq_exit, "local_timer");
+	unregister_trace_local_timer_entry(trace_intel_irq_entry, NULL);
+}
+
+#else /* CONFIG_X86_LOCAL_APIC */
+#define register_intel_irq_tp() do {} while (0)
+#define unregister_intel_irq_tp() do {} while (0)
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+/**
+ * hook_irq_events - Hook IRQ handling events
+ *
+ * This function hooks the IRQ related callbacks to the respective trace
+ * events.
+ */
+int hook_irq_events(void)
+{
+	int ret;
+
+	ret = register_trace_irq_handler_entry(trace_irqentry_callback, NULL);
+	if (ret)
+		goto out_err;
+
+	ret = register_trace_irq_handler_exit(trace_irqexit_callback, NULL);
+	if (ret)
+		goto out_unregister_entry;
+
+	ret = register_intel_irq_tp();
+	if (ret)
+		goto out_irq_exit;
+
+	return 0;
+
+out_irq_exit:
+	unregister_trace_irq_handler_exit(trace_irqexit_callback, NULL);
+out_unregister_entry:
+	unregister_trace_irq_handler_entry(trace_irqentry_callback, NULL);
+out_err:
+	return -EINVAL;
+}
+
+/**
+ * unhook_irq_events - Unhook IRQ handling events
+ *
+ * This function unhooks the IRQ related callbacks to the respective trace
+ * events.
+ */
+void unhook_irq_events(void)
+{
+	unregister_intel_irq_tp();
+	unregister_trace_irq_handler_exit(trace_irqexit_callback, NULL);
+	unregister_trace_irq_handler_entry(trace_irqentry_callback, NULL);
+}
+
+#ifndef CONFIG_PREEMPT_RT
+/**
+ * trace_softirq_entry_callback - Note the starting of a SoftIRQ
+ *
+ * Save the starting time of a SoftIRQ. As SoftIRQs are non-preemptive to
+ * other SoftIRQs, it is safe to use a single variable (ons_var->softirq)
+ * to save the statistics. The arrival_time is used to report... the
+ * arrival time. The delta_start is used to compute the duration at the
+ * SoftIRQ exit handler. See cond_move_softirq_delta_start().
+ */
+void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+
+	if (!osn_var->sampling)
+		return;
+	/*
+	 * This value will be used in the report, but not to compute
+	 * the execution time, so it is safe to get it unsafe.
+	 */
+	osn_var->softirq.arrival_time = time_get();
+	set_int_safe_time(osn_var, &osn_var->softirq.delta_start);
+	osn_var->softirq.count++;
+
+	local_inc(&osn_var->int_counter);
+}
+
+/**
+ * trace_softirq_exit_callback - Note the end of an SoftIRQ
+ *
+ * Computes the duration of the SoftIRQ noise, and trace it. Also discounts the
+ * interference from other sources of noise could be currently being accounted.
+ */
+void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	int duration;
+
+	if (!osn_var->sampling)
+		return;
+
+	duration = get_int_safe_duration(osn_var, &osn_var->softirq.delta_start);
+	trace_softirq_noise(vec_nr, osn_var->softirq.arrival_time, duration);
+	cond_move_thread_delta_start(osn_var, duration);
+	osn_var->softirq.arrival_time = 0;
+}
+
+/**
+ * hook_softirq_events - Hook SoftIRQ handling events
+ *
+ * This function hooks the SoftIRQ related callbacks to the respective trace
+ * events.
+ */
+static int hook_softirq_events(void)
+{
+	int ret;
+
+	ret = register_trace_softirq_entry(trace_softirq_entry_callback, NULL);
+	if (ret)
+		goto out_err;
+
+	ret = register_trace_softirq_exit(trace_softirq_exit_callback, NULL);
+	if (ret)
+		goto out_unreg_entry;
+
+	return 0;
+
+out_unreg_entry:
+	unregister_trace_softirq_entry(trace_softirq_entry_callback, NULL);
+out_err:
+	return -EINVAL;
+}
+
+/**
+ * unhook_softirq_events - Unhook SoftIRQ handling events
+ *
+ * This function hooks the SoftIRQ related callbacks to the respective trace
+ * events.
+ */
+static void unhook_softirq_events(void)
+{
+	unregister_trace_softirq_entry(trace_softirq_entry_callback, NULL);
+	unregister_trace_softirq_exit(trace_softirq_exit_callback, NULL);
+}
+#else /* CONFIG_PREEMPT_RT */
+/*
+ * SoftIRQ are threads on the PREEMPT_RT mode.
+ */
+static int hook_softirq_events(void)
+{
+	return 0;
+}
+static void unhook_softirq_events(void)
+{
+}
+#endif
+
+/**
+ * thread_entry - Record the starting of a thread noise window
+ *
+ * It saves the context switch time for a noisy thread, and increments
+ * the interference counters.
+ */
+static void
+thread_entry(struct osnoise_variables *osn_var, struct task_struct *t)
+{
+	if (!osn_var->sampling)
+		return;
+	/*
+	 * The arrival time will be used in the report, but not to compute
+	 * the execution time, so it is safe to get it unsafe.
+	 */
+	osn_var->thread.arrival_time = time_get();
+
+	set_int_safe_time(osn_var, &osn_var->thread.delta_start);
+
+	osn_var->thread.count++;
+	local_inc(&osn_var->int_counter);
+}
+
+/**
+ * thread_exit - Report the end of a thread noise window
+ *
+ * It computes the total noise from a thread, tracing if needed.
+ */
+static void
+thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
+{
+	int duration;
+
+	if (!osn_var->sampling)
+		return;
+
+	duration = get_int_safe_duration(osn_var, &osn_var->thread.delta_start);
+
+	trace_thread_noise(t, osn_var->thread.arrival_time, duration);
+
+	osn_var->thread.arrival_time = 0;
+}
+
+/**
+ * trace_sched_switch - sched:sched_switch trace event handler
+ *
+ * This function is hooked to the sched:sched_switch trace event, and it is
+ * used to record the beginning and to report the end of a thread noise window.
+ */
+void
+trace_sched_switch_callback(void *data, bool preempt, struct task_struct *p,
+			    struct task_struct *n)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+
+	if (p->pid != osn_var->pid)
+		thread_exit(osn_var, p);
+
+	if (n->pid != osn_var->pid)
+		thread_entry(osn_var, n);
+}
+
+/**
+ * hook_thread_events - Hook the insturmentation for thread noise
+ *
+ * Hook the osnoise tracer callbacks to handle the noise from other
+ * threads on the necessary kernel events.
+ */
+int hook_thread_events(void)
+{
+	int ret;
+
+	ret = register_trace_sched_switch(trace_sched_switch_callback, NULL);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * unhook_thread_events - *nhook the insturmentation for thread noise
+ *
+ * Unook the osnoise tracer callbacks to handle the noise from other
+ * threads on the necessary kernel events.
+ */
+void unhook_thread_events(void)
+{
+	unregister_trace_sched_switch(trace_sched_switch_callback, NULL);
+}
+
+/**
+ * save_osn_sample_stats - Save the osnoise_sample statistics
+ *
+ * Save the osnoise_sample statistics before the sampling phase. These
+ * values will be used later to compute the diff betwneen the statistics
+ * before and after the osnoise sampling.
+ */
+void save_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *s)
+{
+	s->nmi_count = osn_var->nmi.count;
+	s->irq_count = osn_var->irq.count;
+	s->softirq_count = osn_var->softirq.count;
+	s->thread_count = osn_var->thread.count;
+}
+
+/**
+ * diff_osn_sample_stats - Compute the osnoise_sample statistics
+ *
+ * After a sample period, compute the difference on the osnoise_sample
+ * statistics. The struct osnoise_sample *s contains the statistics saved via
+ * save_osn_sample_stats() before the osnoise sampling.
+ */
+void diff_osn_sample_stats(struct osnoise_variables *osn_var, struct osnoise_sample *s)
+{
+	s->nmi_count = osn_var->nmi.count - s->nmi_count;
+	s->irq_count = osn_var->irq.count - s->irq_count;
+	s->softirq_count = osn_var->softirq.count - s->softirq_count;
+	s->thread_count = osn_var->thread.count - s->thread_count;
+}
+
+/**
+ * osnoise_stop_tracing - Stop tracing and the tracer.
+ */
+static void osnoise_stop_tracing(void)
+{
+	tracing_off();
+}
+
+/**
+ * run_osnoise - Sample the time and look for osnoise
+ *
+ * Used to capture the time, looking for potential osnoise latency repeatedly.
+ * Different from hwlat_detector, it is called with preemption and interrupts
+ * enabled. This allows irqs, softirqs and threads to run, interfering on the
+ * osnoise sampling thread, as they would do with a regular thread.
+ */
+static int run_osnoise(void)
+{
+	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	u64 noise = 0, sum_noise = 0, max_noise = 0;
+	struct trace_array *tr = osnoise_trace;
+	u64 start, sample, last_sample;
+	u64 last_int_count, int_count;
+	s64 total, last_total = 0;
+	struct osnoise_sample s;
+	unsigned int threshold;
+	int hw_count = 0;
+	int ret = -1;
+
+	/*
+	 * Considers the current thread as the workload.
+	 */
+	osn_var->pid = current->pid;
+
+	/*
+	 * Save the current stats for the diff
+	 */
+	save_osn_sample_stats(osn_var, &s);
+
+	/*
+	 * threshold should be at least 1 us.
+	 */
+	threshold = tracing_thresh ? tracing_thresh : 1000;
+
+	/*
+	 * Make sure NMIs see sampling first
+	 */
+	osn_var->sampling = true;
+	barrier();
+
+	/*
+	 * Start timestemp
+	 */
+	start = time_get();
+
+	/*
+	 * "previous" loop
+	 */
+	last_int_count = set_int_safe_time(osn_var, &last_sample);
+
+	do {
+		/*
+		 * Get sample!
+		 */
+		int_count = set_int_safe_time(osn_var, &sample);
+
+		noise = time_sub(sample, last_sample);
+
+		/*
+		 * This shouldn't happen.
+		 */
+		if (noise < 0) {
+			pr_err(BANNER "time running backwards\n");
+			goto out;
+		}
+
+		/*
+		 * Sample runtime.
+		 */
+		total = time_to_us(time_sub(sample, start));
+
+		/*
+		 * Check for possible overflows.
+		 */
+		if (total < last_total) {
+			pr_err("Time total overflowed\n");
+			break;
+		}
+
+		last_total = total;
+
+		if (noise >= threshold) {
+			int interference = int_count - last_int_count;
+			int noise_us = time_to_us(noise);
+
+			if (noise > max_noise)
+				max_noise = noise;
+
+			if (!interference)
+				hw_count++;
+
+			sum_noise += noise;
+
+			trace_sample_threshold(last_sample, noise_us, interference);
+
+			if (osnoise_data.stop_tracing_in)
+				if (noise_us > osnoise_data.stop_tracing_in)
+					osnoise_stop_tracing();
+		}
+
+		/*
+		 * For the non-preemptive kernel config: let threads runs, if
+		 * they so wish.
+		 */
+		cond_resched();
+
+		last_sample = sample;
+		last_int_count = int_count;
+
+	} while (total < osnoise_data.sample_runtime && !kthread_should_stop());
+
+	/*
+	 * Finish the above in the view for interrupts.
+	 */
+	barrier();
+
+	osn_var->sampling = false;
+
+	/*
+	 * Make sure sampling data is no longer updated.
+	 */
+	barrier();
+
+	/*
+	 * Save noise info.
+	 */
+	s.noise = time_to_us(sum_noise);
+	s.runtime = total;
+	s.max_sample = time_to_us(max_noise);
+	s.hw_count = hw_count;
+
+	/* Save interference stats info */
+	diff_osn_sample_stats(osn_var, &s);
+
+	trace_osnoise_sample(&s);
+
+	/* Keep a running maximum ever recorded osnoise "latency" */
+	if (max_noise > tr->max_latency) {
+		tr->max_latency = max_noise;
+		latency_fsnotify(tr);
+	}
+
+	if (osnoise_data.stop_tracing_out)
+		if (s.noise > osnoise_data.stop_tracing_out)
+			osnoise_stop_tracing();
+
+	return 0;
+out:
+	return ret;
+}
+
+static struct cpumask osnoise_cpumask;
+static struct cpumask save_cpumask;
+
+/*
+ * kthread_fn - The osnoise detection kernel thread
+ *
+ * Calls run_osnoise() function to measure the osnoise for the configured runtime,
+ * every period.
+ */
+static int kthread_fn(void *data)
+{
+	s64 interval;
+
+	while (!kthread_should_stop()) {
+
+		run_osnoise();
+
+		mutex_lock(&interface_lock);
+		interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
+		mutex_unlock(&interface_lock);
+
+		do_div(interval, USEC_PER_MSEC);
+
+		/*
+		 * differently from hwlat_detector, the osnoise tracer can run
+		 * without a pause because preemption is on.
+		 */
+		if (interval < 1)
+			continue;
+
+		if (msleep_interruptible(interval))
+			break;
+	}
+
+	return 0;
+}
+
+/**
+ * stop_per_cpu_kthread - stop per-cpu threads
+ *
+ * Stop the osnoise sampling htread. Use this on unload and at system
+ * shutdown.
+ */
+static void stop_per_cpu_kthreads(void)
+{
+	struct task_struct *kthread;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+		if (kthread)
+			kthread_stop(kthread);
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+	}
+}
+
+/**
+ * start_per_cpu_kthread - Kick off per-cpu osnoise sampling kthreads
+ *
+ * This starts the kernel thread that will look for osnoise on many
+ * cpus.
+ */
+static int start_per_cpu_kthreads(struct trace_array *tr)
+{
+	struct cpumask *current_mask = &save_cpumask;
+	struct task_struct *kthread;
+	char comm[24];
+	int cpu;
+
+	get_online_cpus();
+	/*
+	 * Run only on CPUs in which trace and osnoise are allowed to run.
+	 */
+	cpumask_and(current_mask, tr->tracing_cpumask, &osnoise_cpumask);
+	/*
+	 * And the CPU is online.
+	 */
+	cpumask_and(current_mask, cpu_online_mask, current_mask);
+	put_online_cpus();
+
+	for_each_online_cpu(cpu)
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+
+	for_each_cpu(cpu, current_mask) {
+		snprintf(comm, 24, "osnoise/%d", cpu);
+
+		kthread = kthread_create_on_cpu(kthread_fn, NULL, cpu, comm);
+
+		if (IS_ERR(kthread)) {
+			pr_err(BANNER "could not start sampling thread\n");
+			stop_per_cpu_kthreads();
+			return -ENOMEM;
+		}
+
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = kthread;
+		wake_up_process(kthread);
+	}
+
+	return 0;
+}
+
+/*
+ * osnoise_cpus_read - Read function for reading the "cpus" file
+ * @filp: The active open file structure
+ * @ubuf: The userspace provided buffer to read value into
+ * @cnt: The maximum number of bytes to read
+ * @ppos: The current "file" position
+ *
+ * Prints the "cpus" output into the user-provided buffer.
+ */
+static ssize_t
+osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
+		  loff_t *ppos)
+{
+	char *mask_str;
+	int len;
+
+	len = snprintf(NULL, 0, "%*pbl\n",
+		       cpumask_pr_args(&osnoise_cpumask)) + 1;
+	mask_str = kmalloc(len, GFP_KERNEL);
+	if (!mask_str)
+		return -ENOMEM;
+
+	len = snprintf(mask_str, len, "%*pbl\n",
+		       cpumask_pr_args(&osnoise_cpumask));
+	if (len >= count) {
+		count = -EINVAL;
+		goto out_err;
+	}
+	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
+
+out_err:
+	kfree(mask_str);
+
+	return count;
+}
+
+/**
+ * osnoise_cpus_write - Write function for "cpus" entry
+ * @filp: The active open file structure
+ * @ubuf: The user buffer that contains the value to write
+ * @cnt: The maximum number of bytes to write to "file"
+ * @ppos: The current position in @file
+ *
+ * This function provides a write implementation for the "cpus"
+ * interface to the osnoise trace. By default, it lists all  CPUs,
+ * in this way, allowing osnoise threads to run on any online CPU
+ * of the system. It serves to restrict the execution of osnoise to the
+ * set of CPUs writing via this interface. Note that osnoise also
+ * respects the "tracing_cpumask." Hence, osnoise threads will run only
+ * on the set of CPUs allowed here AND on "tracing_cpumask." Why not
+ * have just "tracing_cpumask?" Because the user might be interested
+ * in tracing what is running on other CPUs. For instance, one might
+ * run osnoise in one HT CPU while observing what is running on the
+ * sibling HT CPU.
+ */
+static ssize_t
+osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
+		   loff_t *ppos)
+{
+	cpumask_var_t osnoise_cpumask_new;
+	char buf[256];
+	int err;
+
+	if (count >= 256)
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+
+	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpulist_parse(buf, osnoise_cpumask_new);
+	if (err)
+		goto err_free;
+
+	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
+
+	free_cpumask_var(osnoise_cpumask_new);
+	return count;
+
+err_free:
+	free_cpumask_var(osnoise_cpumask_new);
+
+	return err;
+}
+
+/*
+ * osnoise/runtime_us: cannot be greater than the period.
+ */
+static struct trace_ull_config osnoise_runtime = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.sample_runtime,
+	.max	= &osnoise_data.sample_period,
+	.min	= NULL,
+};
+
+/*
+ * osnoise/period_us: cannot be smaller than the runtime.
+ */
+static struct trace_ull_config osnoise_period = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.sample_period,
+	.max	= NULL,
+	.min	= &osnoise_data.sample_runtime,
+};
+
+/*
+ * osnoise/stop_tracing_in_us: no limit.
+ */
+static struct trace_ull_config osnoise_stop_single = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.stop_tracing_in,
+	.max	= NULL,
+	.min	= NULL,
+};
+
+/*
+ * osnoise/stop_tracing_out_us: no limit.
+ */
+static struct trace_ull_config osnoise_stop_total = {
+	.lock	= &interface_lock,
+	.val	= &osnoise_data.stop_tracing_out,
+	.max	= NULL,
+	.min	= NULL,
+};
+
+static const struct file_operations cpus_fops = {
+	.open		= tracing_open_generic,
+	.read		= osnoise_cpus_read,
+	.write		= osnoise_cpus_write,
+	.llseek		= generic_file_llseek,
+};
+
+/**
+ * init_tracefs - A function to initialize the tracefs interface files
+ *
+ * This function creates entries in tracefs for "osnoise". It creates the
+ * "osnoise" directory in the tracing directory, and within that
+ * directory is the count, runtime and period files to change and view
+ * those values.
+ */
+static int init_tracefs(void)
+{
+	struct dentry *top_dir;
+	struct dentry *tmp;
+	int ret;
+
+	ret = tracing_init_dentry();
+	if (ret)
+		return -ENOMEM;
+
+	top_dir = tracefs_create_dir("osnoise", NULL);
+	if (!top_dir)
+		return -ENOMEM;
+
+	tmp = tracefs_create_file("period_us", 0640, top_dir,
+				  &osnoise_period, &trace_ull_config_fops);
+	if (!tmp)
+		goto err;
+
+	tmp = tracefs_create_file("runtime_us", 0644, top_dir,
+				  &osnoise_runtime, &trace_ull_config_fops);
+	if (!tmp)
+		goto err;
+
+	tmp = tracefs_create_file("stop_tracing_in_us", 0640, top_dir,
+				  &osnoise_stop_single, &trace_ull_config_fops);
+	if (!tmp)
+		goto err;
+
+	tmp = tracefs_create_file("stop_tracing_out_us", 0640, top_dir,
+				  &osnoise_stop_total, &trace_ull_config_fops);
+	if (!tmp)
+		goto err;
+
+	tmp = trace_create_file("cpus", 0644, top_dir, NULL, &cpus_fops);
+	if (!tmp)
+		goto err;
+
+	return 0;
+
+err:
+	tracefs_remove(top_dir);
+	return -ENOMEM;
+}
+
+static int osnoise_hook_events(void)
+{
+	int retval;
+
+	/*
+	 * Trace is already hooked, we are re-enabling from
+	 * a stop_tracing_*.
+	 */
+	if (trace_osnoise_callback_enabled)
+		return 0;
+
+	retval = hook_irq_events();
+	if (retval)
+		return -EINVAL;
+
+	retval = hook_softirq_events();
+	if (retval)
+		goto out_unhook_irq;
+
+	retval = hook_thread_events();
+	/*
+	 * All fine!
+	 */
+	if (!retval)
+		return 0;
+
+	unhook_softirq_events();
+out_unhook_irq:
+	unhook_irq_events();
+	return -EINVAL;
+}
+
+static void osnoise_tracer_start(struct trace_array *tr)
+{
+	int retval;
+
+	if (osnoise_busy)
+		return;
+
+	osn_var_reset_all();
+
+	retval = osnoise_hook_events();
+	if (retval)
+		goto out_err;
+	/*
+	 * Make sure NMIs see reseted values.
+	 */
+	barrier();
+	trace_osnoise_callback_enabled = true;
+
+	retval = start_per_cpu_kthreads(tr);
+	/*
+	 * all fine!
+	 */
+	if (!retval)
+		return;
+
+out_err:
+	unhook_irq_events();
+	pr_err(BANNER "Error starting osnoise tracer\n");
+}
+
+static void osnoise_tracer_stop(struct trace_array *tr)
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
+static int osnoise_tracer_init(struct trace_array *tr)
+{
+	/* Only allow one instance to enable this */
+	if (osnoise_busy)
+		return -EBUSY;
+
+	osnoise_trace = tr;
+
+	tr->max_latency = 0;
+
+	osnoise_tracer_start(tr);
+
+	osnoise_busy = true;
+
+	return 0;
+}
+
+static void osnoise_tracer_reset(struct trace_array *tr)
+{
+	osnoise_tracer_stop(tr);
+}
+
+static struct tracer osnoise_tracer __read_mostly = {
+	.name		= "osnoise",
+	.init		= osnoise_tracer_init,
+	.reset		= osnoise_tracer_reset,
+	.start		= osnoise_tracer_start,
+	.stop		= osnoise_tracer_stop,
+	.print_header	= print_osnoise_headers,
+	.allow_instances = true,
+};
+
+__init static int init_osnoise_tracer(void)
+{
+	int ret;
+
+	mutex_init(&interface_lock);
+
+	ret = register_tracer(&osnoise_tracer);
+	if (ret)
+		return ret;
+
+	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
+
+	init_tracefs();
+
+	return 0;
+}
+late_initcall(init_osnoise_tracer);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 61255bad7e01..edeb127fcdea 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1189,7 +1189,6 @@ trace_hwlat_print(struct trace_iterator *iter, int flags,
 	return trace_handle_return(s);
 }
 
-
 static enum print_line_t
 trace_hwlat_raw(struct trace_iterator *iter, int flags,
 		struct trace_event *event)
@@ -1219,6 +1218,76 @@ static struct trace_event trace_hwlat_event = {
 	.funcs		= &trace_hwlat_funcs,
 };
 
+/* TRACE_OSNOISE */
+static enum print_line_t
+trace_osnoise_print(struct trace_iterator *iter, int flags,
+		    struct trace_event *event)
+{
+	struct trace_entry *entry = iter->ent;
+	struct trace_seq *s = &iter->seq;
+	struct osnoise_entry *field;
+	u64 ratio, ratio_dec;
+	u64 net_runtime;
+
+	trace_assign_type(field, entry);
+
+	/*
+	 * compute the available % of cpu time.
+	 */
+	net_runtime = field->runtime - field->noise;
+	ratio = net_runtime * 10000000;
+	do_div(ratio, field->runtime);
+	ratio_dec = do_div(ratio, 100000);
+
+	trace_seq_printf(s, "%llu %10llu %3llu.%05llu %7llu",
+			 field->runtime,
+			 field->noise,
+			 ratio, ratio_dec,
+			 field->max_sample);
+
+	trace_seq_printf(s, " %6u", field->hw_count);
+	trace_seq_printf(s, " %6u", field->nmi_count);
+	trace_seq_printf(s, " %6u", field->irq_count);
+	trace_seq_printf(s, " %6u", field->softirq_count);
+	trace_seq_printf(s, " %6u", field->thread_count);
+
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t
+trace_osnoise_raw(struct trace_iterator *iter, int flags,
+		  struct trace_event *event)
+{
+	struct osnoise_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(s, "%lld %llu %llu %u %u %u %u %u\n",
+			 field->runtime,
+			 field->noise,
+			 field->max_sample,
+			 field->hw_count,
+			 field->nmi_count,
+			 field->irq_count,
+			 field->softirq_count,
+			 field->thread_count);
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_osnoise_funcs = {
+	.trace		= trace_osnoise_print,
+	.raw		= trace_osnoise_raw,
+};
+
+static struct trace_event trace_osnoise_event = {
+	.type		= TRACE_OSNOISE,
+	.funcs		= &trace_osnoise_funcs,
+};
+
 /* TRACE_BPUTS */
 static enum print_line_t
 trace_bputs_print(struct trace_iterator *iter, int flags,
@@ -1384,6 +1453,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_bprint_event,
 	&trace_print_event,
 	&trace_hwlat_event,
+	&trace_osnoise_event,
 	&trace_raw_data_event,
 	NULL
 };
-- 
2.26.3

