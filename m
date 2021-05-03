Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF173715D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhECNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234170AbhECNSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:18:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9A56121D;
        Mon,  3 May 2021 13:17:15 +0000 (UTC)
Date:   Mon, 3 May 2021 09:17:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Cao jin <jojing64@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [ GIT PULL] tracing: Updates for 5.13
Message-ID: <20210503091713.1aa7a7b7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing updates for 5.13

[
  Note, this has one merge of my trace/ftrace/urgent branch to pull
  in the changes to the ftrace_page allocation fix, in order to
  apply your changes on top of it (commit db42523b4f3e83).

  This is the first time I'm sending a pull request with a merge
  in it. I'm hoping my scripts did everything correctly. Might want
  to check it a bit more than usual.

  The "Fixes" section below contains two last minute bugs that were
  reported, which is why I'm late on my pull request.
]

New feature:

 The "func-no-repeats" option in tracefs/options directory. When set
 the function tracer will detect if the current function being traced
 is the same as the previous one, and instead of recording it, it will
 keep track of the number of times that the function is repeated in a row.
 And when another function is recorded, it will write a new event that
 shows the function that repeated, the number of times it repeated and
 the time stamp of when the last repeated function occurred.

Enhancements:

 In order to implement the above "func-no-repeats" option, the ring
 buffer timestamp can now give the accurate timestamp of the event
 as it is being recorded, instead of having to record an absolute
 timestamp for all events. This helps the histogram code which no longer
 needs to waste ring buffer space.

 New validation logic to make sure all trace events that access
 dereferenced pointers do so in a safe way, and will warn otherwise.

Fixes:

 No longer limit the PIDs of tasks that are recorded for "saved_cmdlines"
 to PID_MAX_DEFAULT (32768), as systemd now allows for a much larger
 range. This caused the mapping of PIDs to the task names to be dropped
 for all tasks with a PID greater than 32768.

 Change trace_clock_global() to never block. This caused a deadlock.

Clean ups:

 Typos, prototype fixes, and removing of duplicate or unused code.

 Better management of ftrace_page allocations.


Please pull the latest trace-v5.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.13

Tag SHA1: fc7dae88ef9304be9df419919a36a90362207ba0
Head SHA1: aafe104aa9096827a429bc1358f8260ee565b7cc


Bhaskar Chowdhury (1):
      kernel: trace: Mundane typo fixes in the file trace_events_filter.c

Cao jin (1):
      bootconfig: Update prototype of setup_boot_config()

Colin Ian King (1):
      ftrace: Fix spelling mistake "disabed" -> "disabled"

Ingo Molnar (1):
      tracing: Fix various typos in comments

Linus Torvalds (1):
      ftrace: Store the order of pages allocated in ftrace_page

Qiujun Huang (2):
      tracing: A minor cleanup for create_system_filter()
      tracing: Update create_system_filter() kernel-doc comment

Steven Rostedt (VMware) (17):
      ring-buffer: Separate out internal use of ring_buffer_event_time_stamp()
      ring-buffer: Add a event_stamp to cpu_buffer for each level of nesting
      tracing: Pass buffer of event to trigger operations
      ring-buffer: Allow ring_buffer_event_time_stamp() to return time stamp of all events
      tracing: Use a no_filter_buffering_ref to stop using the filter buffer
      ring-buffer: Add verifier for using ring_buffer_event_time_stamp()
      tracing: Add tracing_event_time_stamp() API
      tracing: Add check of trace event print fmts for dereferencing pointers
      seq_buf: Add seq_buf_terminate() API
      tracing: Add a verifier to check string pointers for trace events
      scripts/recordmcount.pl: Make indent spacing consistent
      scripts/recordmcount.pl: Make vim and emacs indent the same
      Merge branch 'trace/ftrace/urgent' into HEAD
      ftrace: Simplify the calculation of page number for ftrace_page->records some more
      ftrace: Reuse the output of the function tracer for func_repeats
      tracing: Map all PIDs to command lines
      tracing: Restructure trace_clock_global() to never block

Wan Jiabing (1):
      tracing: Remove duplicate struct declaration in trace_events.h

Xu Wang (1):
      tools/latency-collector: Remove unneeded semicolon

Yordan Karadzhov (VMware) (7):
      tracing: Remove unused argument from "ring_buffer_time_stamp()
      tracing: Define static void trace_print_time()
      tracing: Define new ftrace event "func_repeats"
      tracing: Add "last_func_repeats" to struct trace_array
      tracing: Add method for recording "func_repeats" events
      tracing: Unify the logic for function tracing options
      tracing: Add "func_no_repeats" option for function tracing

----
 arch/csky/kernel/probes/ftrace.c          |   2 +-
 arch/microblaze/include/asm/ftrace.h      |   2 +-
 arch/nds32/kernel/ftrace.c                |   2 +-
 arch/powerpc/include/asm/ftrace.h         |   4 +-
 arch/riscv/kernel/probes/ftrace.c         |   2 +-
 arch/sh/kernel/ftrace.c                   |   2 +-
 arch/sparc/include/asm/ftrace.h           |   2 +-
 arch/x86/kernel/kprobes/ftrace.c          |   2 +-
 fs/tracefs/inode.c                        |   2 +-
 include/linux/ftrace.h                    |   4 +-
 include/linux/ring_buffer.h               |   5 +-
 include/linux/seq_buf.h                   |  25 +++
 include/linux/trace_events.h              |   8 +-
 include/linux/tracepoint.h                |   2 +-
 include/trace/events/io_uring.h           |   2 +-
 include/trace/events/rcu.h                |   2 +-
 include/trace/events/sched.h              |   2 +-
 include/trace/events/timer.h              |   2 +-
 init/main.c                               |   6 +-
 kernel/trace/bpf_trace.c                  |   5 +-
 kernel/trace/fgraph.c                     |   4 +-
 kernel/trace/ftrace.c                     |  53 ++---
 kernel/trace/ring_buffer.c                | 142 +++++++++---
 kernel/trace/synth_event_gen_test.c       |   2 +-
 kernel/trace/trace.c                      | 348 ++++++++++++++++++++++++------
 kernel/trace/trace.h                      |  35 ++-
 kernel/trace/trace_clock.c                |  44 ++--
 kernel/trace/trace_dynevent.c             |   6 +-
 kernel/trace/trace_entries.h              |  22 ++
 kernel/trace/trace_event_perf.c           |   2 +-
 kernel/trace/trace_events.c               | 214 +++++++++++++++++-
 kernel/trace/trace_events_filter.c        |  18 +-
 kernel/trace/trace_events_hist.c          | 100 ++++++---
 kernel/trace/trace_events_synth.c         |   2 +-
 kernel/trace/trace_events_trigger.c       |  45 ++--
 kernel/trace/trace_functions.c            | 223 ++++++++++++++++---
 kernel/trace/trace_functions_graph.c      |   2 +-
 kernel/trace/trace_hwlat.c                |   4 +-
 kernel/trace/trace_kprobe.c               |   2 +-
 kernel/trace/trace_output.c               |  93 ++++++--
 kernel/trace/trace_printk.c               |  11 +
 kernel/trace/trace_probe.c                |   6 +-
 kernel/trace/trace_probe.h                |   2 +-
 kernel/trace/trace_probe_tmpl.h           |   2 +-
 kernel/trace/trace_selftest.c             |   4 +-
 kernel/trace/trace_seq.c                  |  12 +-
 scripts/recordmcount.pl                   |  26 +--
 tools/tracing/latency/latency-collector.c |   4 +-
 48 files changed, 1198 insertions(+), 313 deletions(-)
---------------------------
