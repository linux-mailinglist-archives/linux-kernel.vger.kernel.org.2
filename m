Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2E369BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbhDWVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232466AbhDWVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619211968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KUWNzg/cZ/ucXhaBruj2wL7eCNhxSMkRoedTIeePld0=;
        b=DOyGp03wJX+Ths0EpC1QbWLT9QYvQOmxnPxODIoOrtRiMqqbaPtoA47/jG940mMTWYZB7m
        p3AEOWhlsqrt5uu5+1b35/hReTaGkxULaw5SYeeRR8AugveTDFFNfE9moRcVkNbBhDQqPc
        WGvJNdIIqz5XD92e+7ZNuft3TvpY+dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-ER-rzzndOQKDa3fDpA56bw-1; Fri, 23 Apr 2021 17:06:07 -0400
X-MC-Unique: ER-rzzndOQKDa3fDpA56bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A905E343A3;
        Fri, 23 Apr 2021 21:06:05 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1863A5DEAD;
        Fri, 23 Apr 2021 21:05:52 +0000 (UTC)
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
Subject: [RFC PATCH V2 0/9] hwlat improvements and osnoise/timerlat tracers
Date:   Fri, 23 Apr 2021 23:05:35 +0200
Message-Id: <cover.1619210818.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Daniel Bristot de Oliveira (8):
  tracing/hwlat: Fix Clark's email
  tracing/hwlat: Implement the mode config option
  tracing/hwlat: Switch disable_migrate to mode none
  tracing/hwlat: Implement the per-cpu mode
  tracing/trace: Add a generic function to read/write u64 values from
    tracefs
  trace/hwlat: Use the generic function to read/write width and window
  tracing: Add osnoise tracer
  tracing: Add timerlat tracer

Steven Rostedt (1):
  tracing: Add __print_ns_to_secs() and __print_ns_without_secs()
    helpers

 Documentation/trace/hwlat_detector.rst  |   13 +-
 Documentation/trace/index.rst           |    2 +
 Documentation/trace/osnoise-tracer.rst  |  152 ++
 Documentation/trace/timerlat-tracer.rst |  158 ++
 include/linux/ftrace_irq.h              |   13 +
 include/trace/events/osnoise.h          |  142 ++
 include/trace/trace_events.h            |   25 +
 kernel/trace/Kconfig                    |   62 +
 kernel/trace/Makefile                   |    1 +
 kernel/trace/trace.c                    |   88 +-
 kernel/trace/trace.h                    |   31 +-
 kernel/trace/trace_entries.h            |   41 +
 kernel/trace/trace_hwlat.c              |  410 +++--
 kernel/trace/trace_osnoise.c            | 2118 +++++++++++++++++++++++
 kernel/trace/trace_output.c             |  119 +-
 15 files changed, 3227 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/trace/osnoise-tracer.rst
 create mode 100644 Documentation/trace/timerlat-tracer.rst
 create mode 100644 include/trace/events/osnoise.h
 create mode 100644 kernel/trace/trace_osnoise.c

-- 
2.26.3

