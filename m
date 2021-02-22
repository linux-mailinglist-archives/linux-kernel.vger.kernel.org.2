Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832EF320EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 01:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBVASH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 19:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBVASF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 19:18:05 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6649E64E24;
        Mon, 22 Feb 2021 00:17:23 +0000 (UTC)
Date:   Sun, 21 Feb 2021 19:17:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bean Huo <beanhuo@micron.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Song Chen <chensong_2000@189.cn>, Tom Rix <trix@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: [GIT PULL] tracing: Updates for 5.12
Message-ID: <20210221191721.7126befa@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates for 5.12

 - Update to the way irqs and preemption is tracked via the trace event PC field

 - Fix handling of unregistering event failing due to allocating memory.
   This is only triggered by failure injection, as it is pretty much guaranteed
   to have less than a page allocation succeed.

 - Do not show the useless "filter" or "enable" files for the "ftrace" trace
   system, as they have no effect on doing anything.

 - Add a warning if kprobes are registered more than once.

 - Synthetic events now have their fields parsed by semicolons.
   Old formats without semicolons will still work, but new features will
   require them.

 - New option to allow trace events to show %p without hashing in trace file.
   The trace file can only be read by root, and reading the raw event buffer
   did not have any pointers hashed, so this does not expose anything new.

 - New directory in tools called tools/tracing, where a new tool that reads
   sequential latency reports from the ftrace latency tracers.

 - Other minor fixes and cleanups.


Please pull the latest trace-v5.12 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.12

Tag SHA1: 608220f252f14f04170ccc894267897e9b5740b8
Head SHA1: c85c9a2c6e368dc94907e63babb18a9788e5c9b6


Bean Huo (1):
      tracing: Fix a kernel doc warning

Bhaskar Chowdhury (1):
      tracing: Fix spelling of controlling in uprobes

Colin Ian King (1):
      tracing: Fix spelling mistake in Kconfig "infinit" -> "infinite"

Jinyang He (1):
      ftrace: Remove unused ftrace_force_update()

Masami Hiramatsu (6):
      kprobes: Warn if the kprobe is reregistered
      tracing/dynevent: Delegate parsing to create function
      tracing: Show real address for trace event arguments
      tracing: Update the stage 3 of trace event macro comment
      tracing: Add ptr-hash option to show the hashed pointer value
      kprobes: Fix to delay the kprobes jump optimization

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

Steven Rostedt (VMware) (6):
      tracepoint: Do not fail unregistering a probe due to memory failure
      tracing: Do not create "enable" or "filter" files for ftrace event subsystem
      tracepoints: Remove unnecessary "data_args" macro parameter
      tracepoints: Do not punish non static call users
      tracepoints: Code clean up
      tracing: Make hash-ptr option default

Tom Rix (2):
      tracing: Add printf attribute to log function
      tracing: Remove definition of DEBUG in trace_mmiotrace.c

Tom Zanussi (5):
      tracing: Rework synthetic event command parsing
      tracing: Update synth command errors
      tracing: Add a backward-compatibility check for synthetic event creation
      selftests/ftrace: Update synthetic event syntax errors
      selftests/ftrace: Add '!event' synthetic event syntax check

Viktor Rosendahl (1):
      tracing/tools: Add the latency-collector to tools directory

----
 Documentation/trace/ftrace.rst                     |    6 +
 include/linux/ftrace.h                             |    2 -
 include/linux/trace.h                              |    3 +-
 include/linux/trace_events.h                       |   75 +-
 include/linux/tracepoint.h                         |   54 +-
 include/trace/trace_events.h                       |   31 +-
 kernel/kprobes.c                                   |   44 +-
 kernel/trace/Kconfig                               |    6 +-
 kernel/trace/blktrace.c                            |   17 +-
 kernel/trace/preemptirq_delay_test.c               |   14 +
 kernel/trace/ring_buffer.c                         |   41 +-
 kernel/trace/trace.c                               |  283 +--
 kernel/trace/trace.h                               |   63 +-
 kernel/trace/trace_branch.c                        |    6 +-
 kernel/trace/trace_dynevent.c                      |   35 +-
 kernel/trace/trace_dynevent.h                      |    4 +-
 kernel/trace/trace_event_perf.c                    |    5 +-
 kernel/trace/trace_events.c                        |   40 +-
 kernel/trace/trace_events_inject.c                 |    6 +-
 kernel/trace/trace_events_synth.c                  |  320 ++-
 kernel/trace/trace_functions.c                     |   31 +-
 kernel/trace/trace_functions_graph.c               |   32 +-
 kernel/trace/trace_hwlat.c                         |    7 +-
 kernel/trace/trace_irqsoff.c                       |   86 +-
 kernel/trace/trace_kprobe.c                        |   43 +-
 kernel/trace/trace_mmiotrace.c                     |   16 +-
 kernel/trace/trace_output.c                        |   12 +-
 kernel/trace/trace_probe.c                         |   17 +
 kernel/trace/trace_probe.h                         |    1 +
 kernel/trace/trace_sched_wakeup.c                  |   71 +-
 kernel/trace/trace_syscalls.c                      |   20 +-
 kernel/trace/trace_uprobe.c                        |   23 +-
 kernel/tracepoint.c                                |   91 +-
 tools/Makefile                                     |   14 +-
 .../inter-event/trigger-synthetic-event-syntax.tc  |    4 +
 .../trigger-synthetic_event_syntax_errors.tc       |   35 +-
 tools/tracing/Makefile                             |   19 +
 tools/tracing/latency/.gitignore                   |    2 +
 tools/tracing/latency/Makefile                     |   24 +
 tools/tracing/latency/latency-collector.c          | 2108 ++++++++++++++++++++
 40 files changed, 3083 insertions(+), 628 deletions(-)
 create mode 100644 tools/tracing/Makefile
 create mode 100644 tools/tracing/latency/.gitignore
 create mode 100644 tools/tracing/latency/Makefile
 create mode 100644 tools/tracing/latency/latency-collector.c
---------------------------
