Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8248430DF31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhBCQHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234813AbhBCQGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:06:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C2164F8C;
        Wed,  3 Feb 2021 16:05:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf6-009J56-Np; Wed, 03 Feb 2021 11:05:48 -0500
Message-ID: <20210203160517.982448432@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/15] tracing: Updates for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean Huo (1):
      tracing: Fix a kernel doc warning

Bhaskar Chowdhury (1):
      tracing: Fix spelling of controlling in uprobes

Colin Ian King (1):
      tracing: Fix spelling mistake in Kconfig "infinit" -> "infinite"

Qiujun Huang (4):
      tracing: Update trace_ignore_this_task() kernel-doc comment
      tracing: Remove get/put_cpu() from function_trace_init
      ring-buffer: Remove cpu_buffer argument from the rb_inc_page()
      ring-buffer: Drop unneeded check in ring_buffer_resize()

Sebastian Andrzej Siewior (4):
      tracing: Merge irqflags + preempt counter.
      tracing: Inline tracing_gen_ctx_flags()
      tracing: Use in_serving_softirq() to deduct softirq status.
      tracing: Remove NULL check from current in tracing_generic_entry_update().

Song Chen (1):
      kernel: trace: preemptirq_delay_test: add cpu affinity

Steven Rostedt (VMware) (1):
      tracepoint: Do not fail unregistering a probe due to memory failure

Tom Rix (2):
      tracing: Add printf attribute to log function
      tracing: Remove definition of DEBUG in trace_mmiotrace.c

----
 include/linux/trace.h                |   3 +-
 include/linux/trace_events.h         |  71 ++++++++++++--
 kernel/trace/Kconfig                 |   6 +-
 kernel/trace/blktrace.c              |  17 ++--
 kernel/trace/preemptirq_delay_test.c |  14 +++
 kernel/trace/ring_buffer.c           |  41 ++++----
 kernel/trace/trace.c                 | 183 ++++++++++++++++-------------------
 kernel/trace/trace.h                 |  57 ++++-------
 kernel/trace/trace_branch.c          |   6 +-
 kernel/trace/trace_event_perf.c      |   5 +-
 kernel/trace/trace_events.c          |  18 ++--
 kernel/trace/trace_events_inject.c   |   6 +-
 kernel/trace/trace_functions.c       |  31 +++---
 kernel/trace/trace_functions_graph.c |  32 +++---
 kernel/trace/trace_hwlat.c           |   7 +-
 kernel/trace/trace_irqsoff.c         |  86 +++++++---------
 kernel/trace/trace_kprobe.c          |  10 +-
 kernel/trace/trace_mmiotrace.c       |  16 +--
 kernel/trace/trace_sched_wakeup.c    |  71 +++++++-------
 kernel/trace/trace_syscalls.c        |  20 ++--
 kernel/trace/trace_uprobe.c          |   6 +-
 kernel/tracepoint.c                  |  80 ++++++++++++---
 22 files changed, 408 insertions(+), 378 deletions(-)
