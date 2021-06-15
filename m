Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47963A7A85
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhFOJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231262AbhFOJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ddDGAncBsIbSDpDEwrQeyMoy5+E2nrkF5TMzoiroJvQ=;
        b=TsEkiv+JopuwzFrO4bic5Caa1XdNx6Ty4un5MRm+k9erulBb7V8KmDOfxKQAxoZ7bJLAPS
        Lmel3+euxtWOeQECgUNiJJ+tB8Tjm7kxRj2AGlaKFPyUQwQmLwV3rUmvvVDA11CK6fn8Qa
        zwBLl5hJX9zq+IPV1pBwfcgQ1I7j5Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-wADnIl3GPcO137S60aXM2A-1; Tue, 15 Jun 2021 05:29:17 -0400
X-MC-Unique: wADnIl3GPcO137S60aXM2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 552E5100A97C;
        Tue, 15 Jun 2021 09:29:08 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 269F35B698;
        Tue, 15 Jun 2021 09:29:02 +0000 (UTC)
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
Subject: [PATCH V4 00/12] hwlat improvements and osnoise/timerlat tracers
Date:   Tue, 15 Jun 2021 11:28:39 +0200
Message-Id: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes a set of improvements and new features for the
tracing subsystem to facilitate the debugging of low latency
deployments.

Currently, hwlat runs on a single CPU at a time, migrating across a
set of CPUs in a round-robin fashion. This series improves hwlat 
to allow hwlat to run on multiple CPUs in parallel, increasing the
chances of detecting a hardware latency, at the cost of using more
CPU time.

It also proposes a new tracer named osnoise, that aims to help users
of isolcpus= (or a similar method) to measure how much noise the OS
and the hardware add to the isolated application. The osnoise tracer
bases on the hwlat detector code. The difference is that, instead of
sampling with interrupts disabled, the osnoise tracer samples the CPU with
interrupts and preemption enabled. In this way, the sampling thread will
suffer any source of noise from the OS. The detection and classification
of the type of noise are then made by observing the entry points of NMIs,
IRQs, SoftIRQs, and threads. If none of these sources of noise is detected,
the tool associates the noise with the hardware. The tool periodically
prints a status, printing the total noise of the period, the max single
noise observed, the percentage of CPU available for the task, along with
the counters of each source of the noise. To debug the sources of noise,
the tracer also adds a set of tracepoints that print any NMI, IRQ, SofIRQ,
and thread occurrence. These tracepoints print the starting time and the
noise's net duration at the end of the noise. In this way, it reduces the
number of tracepoints (one instead of two) and the need to manually
accounting the contribution of each noise independently.

Finaly, the timerlat tracer aims to help the preemptive kernel developers
to find sources of wakeup latencies of real-time threads. The tracer
creates a per-cpu kernel thread with real-time priority. The tracer thread
sets a periodic timer to wakeup itself, and goes to sleep waiting for the
timer to fire. At the wakeup, the thread then computes a wakeup latency
value as the difference between the current time and the absolute time
that the timer was set to expire. The tracer prints two lines at every
activation. The first is the timer latency observed at the hardirq context
before the activation of the thread. The second is the timer latency
observed by the thread, which is the same level that cyclictest reports.
The ACTIVATION ID field serves to relate the irq execution to its
respective thread execution. The tracer is build on top of osnoise tracer,
and the osnoise: events can be used to trace the source of interference
from NMI, IRQs and other threads. It also enables the capture of the
stacktrace at the IRQ context, which helps to identify the code path
that can cause thread delay.

Changes from v3:
 - Remove /** from comments (Rostedt)
 - Support hotplug operations (Rostedt)
 - Change the name of ull_config to trace_min_max - and
   improve patch description (Rostedt)
 - Remove leftovers from older versions (Juri Lelli)
 - Remove printk from main loop - use trace buffer instead
   (Rostedt)
 - Move the arch specific code to arch/*/kernel/trace.c (Rostedt)
 - Improve timerlat documentation (Rostedt)
 - Add () around params usage of "value" on __print_ns_to_secs(value)
   (Rostedt)
 - Rename osnoise/stop_tracing* files (Rostedt)
 - Reduce the size of the per-cpu data to store stack tracers on
   timerlat (Rostedt)
 - Add osn_* prefix to structures (Rostedt)
 - Fix stop tracing to work with trace instances (Rostedt)
 - Changing osnoise/cpus restarts the threads accordingly (Rostedt)
 - Lots of cosmetics/typos changes (Rostedt)

Changes from v2:
 - osnoise sample reports in nanoseconds (as all other osnoise tracepoints)
   (Bristot)
 - Remove divisions from osnoise main loop (Bristot)
 - Make the tracers work well when starting via kernel-cmdline
   (Red Hat's performance team need)
 - Rename main/interrupt functions (Bristot)
 - Fix timerlat reset (Juri Lelli)
 - Fix timerlat start (Juri Lelli)

Changes from v1:
 - Remove `` from RST (Corbet)
 - Add RST files to the index (Corbet)
 - Fix text and typos (Rostedt)
 - Remove the cpus from hwlat (Rostedt)
 - Remove the disable_migrate/fallback to mode none on hwlat (Rostedt)
 - Add a generic way to read/write u64 and use it on
   hwlat/osnoise/timerlat (Rostedt)
 - Make osnoise/timerlat to work properly with trace-cmd/tracer
   instances (Rostedt)
 - osnoise using the tracing_threshold (Rostedt)
 - Rearrange tracepoint structure to avoid "holes" (Rostedt)

*** BLURB HERE ***

Daniel Bristot de Oliveira (11):
  trace/hwlat: Fix Clark's email
  trace/hwlat: Implement the mode config option
  trace/hwlat: Switch disable_migrate to mode none
  trace/hwlat: Implement the per-cpu mode
  trace/hwlat: Support hotplug operations
  trace: Add a generic function to read/write u64 values from tracefs
  trace/hwlat: Use trace_min_max_param for width and window params
  trace/hwlat: Remove printk from sampling loop
  trace: Add osnoise tracer
  trace: Add timerlat tracer
  trace/osnoise: Support hotplug operations

Steven Rostedt (1):
  trace: Add __print_ns_to_secs() and __print_ns_without_secs() helpers

 Documentation/trace/hwlat_detector.rst  |   13 +-
 Documentation/trace/index.rst           |    2 +
 Documentation/trace/osnoise-tracer.rst  |  152 ++
 Documentation/trace/timerlat-tracer.rst |  181 ++
 arch/x86/kernel/Makefile                |    1 +
 arch/x86/kernel/trace.c                 |  238 +++
 include/linux/ftrace_irq.h              |   13 +
 include/trace/events/osnoise.h          |  142 ++
 include/trace/trace_events.h            |   25 +
 kernel/trace/Kconfig                    |   62 +
 kernel/trace/Makefile                   |    1 +
 kernel/trace/trace.c                    |   92 ++
 kernel/trace/trace.h                    |   29 +-
 kernel/trace/trace_entries.h            |   41 +
 kernel/trace/trace_hwlat.c              |  494 ++++--
 kernel/trace/trace_osnoise.c            | 2004 +++++++++++++++++++++++
 kernel/trace/trace_osnoise.h            |    9 +
 kernel/trace/trace_output.c             |  119 +-
 18 files changed, 3469 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/trace/osnoise-tracer.rst
 create mode 100644 Documentation/trace/timerlat-tracer.rst
 create mode 100644 arch/x86/kernel/trace.c
 create mode 100644 include/trace/events/osnoise.h
 create mode 100644 kernel/trace/trace_osnoise.c
 create mode 100644 kernel/trace/trace_osnoise.h

-- 
2.31.1

