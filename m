Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944E35867D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhDHOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231520AbhDHOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617891242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b/b1nCZ2uLyZxoPrCwQ5iyco26ypzNeHMmm1NuRI7aI=;
        b=LhhXBJwrwDuSMLPhsdc6WELfQJ7fQslGw2g6xnsVvU2z1JyWCakDItbjtfuywKH0jJEWhN
        65/+WPND3crsl4RGMx+DJECjOwb6F8w8/9K5/K84LAfoU3R6z+Bim6ByQn7dOQK0dq06Vl
        xXBNJMSNXy/tvG7NvK/Tc6zIXcFwolA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-yzDUTnE2NiyH9TQWnPBS0Q-1; Thu, 08 Apr 2021 10:14:01 -0400
X-MC-Unique: yzDUTnE2NiyH9TQWnPBS0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2A3D107ACF2;
        Thu,  8 Apr 2021 14:13:59 +0000 (UTC)
Received: from x1.com (ovpn-112-230.rdu2.redhat.com [10.10.112.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66BD560636;
        Thu,  8 Apr 2021 14:13:43 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 0/5] hwlat improvements and osnoise tracer
Date:   Thu,  8 Apr 2021 16:13:18 +0200
Message-Id: <cover.1617889883.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes a set of improvements and new features for the
tracing subsystem to facilitate the debugging of low latency
deployments.

Currently, hwlat runs on a single CPU at a time, migrating across a
set of CPUs in a round-robin fashion. The first three patches are
changes made to allow hwlat to run on multiple CPUs in parallel,
increasing the chances of detecting a hardware latency.

The fourth patch is a helper to print a timestamp in a u64 in
seconds.nanoseconds format on tracepoints.

The fifth patch proposes a new tracer named osnoise and aims to help
users of isolcpus= (or a similar method) to measure how much noise the
OS and the hardware add to the isolated application. The osnoise tracer
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

Daniel Bristot de Oliveira (4):
  tracing/hwlat: Add a cpus file specific for hwlat_detector
  tracing/hwlat: Implement the mode config option
  tracing/hwlat: Implement the per-cpu mode
  tracing: Add the osnoise tracer

Steven Rostedt (1):
  tracing: Add __print_ns_to_secs() and __print_ns_without_secs()
    helpers

 Documentation/trace/hwlat_detector.rst |   29 +-
 Documentation/trace/osnoise_tracer.rst |  149 ++
 include/linux/ftrace_irq.h             |   16 +
 include/trace/events/osnoise.h         |  141 ++
 include/trace/trace_events.h           |   25 +
 kernel/trace/Kconfig                   |   34 +
 kernel/trace/Makefile                  |    1 +
 kernel/trace/trace.h                   |    9 +-
 kernel/trace/trace_entries.h           |   27 +
 kernel/trace/trace_hwlat.c             |  445 +++++-
 kernel/trace/trace_osnoise.c           | 1714 ++++++++++++++++++++++++
 kernel/trace/trace_output.c            |   72 +-
 12 files changed, 2604 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/trace/osnoise_tracer.rst
 create mode 100644 include/trace/events/osnoise.h
 create mode 100644 kernel/trace/trace_osnoise.c

-- 
2.30.2

