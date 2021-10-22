Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E5437F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhJVUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59428611BD;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sw-000QBU-5c;
        Fri, 22 Oct 2021 16:48:38 -0400
Message-ID: <20211022204756.099054287@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:47:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/40] tracing: Updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, this code now passes all my tests!

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: fed240d9c9743815fcbc0ca5c0913292ce1f25e2


Arnd Bergmann (1):
      tracing: use %ps format string to print symbols

Carles Pey (1):
      ftrace: Add unit test for removing trace function

Changbin Du (1):
      tracing: in_irq() cleanup

Jiri Olsa (6):
      x86/ftrace: Remove extra orig rax move
      tracing: Add trampoline/graph selftest
      ftrace: Add ftrace_add_rec_direct function
      ftrace: Add multi direct register/unregister interface
      ftrace: Add multi direct modify interface
      ftrace/samples: Add multi direct interface test module

Kalesh Singh (1):
      tracing/cfi: Fix cmp_entries_* functions signature mismatch

Masami Hiramatsu (16):
      bootconfig: Allocate xbc_data inside xbc_init()
      bootconfig: Add xbc_get_info() for the node information
      tools/bootconfig: Run test script when build all
      bootconfig: Rename xbc_destroy_all() to xbc_exit()
      bootconfig: Split parse-tree part from xbc_init
      bootconfig: Remove unused debug function
      tools/bootconfig: Print all error message in stderr
      bootconfig: Replace u16 and u32 with uint16_t and uint32_t
      bootconfig: Cleanup dummy headers in tools/bootconfig
      x86/unwind: Compile kretprobe fixup code only if CONFIG_KRETPROBES=y
      arm64: kprobes: Record frame pointer with kretprobe instance
      arm64: kprobes: Make a frame pointer on __kretprobe_trampoline
      arm64: Recover kretprobe modified return address in stacktrace
      ARM: clang: Do not rely on lr register for stacktrace
      ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
      ARM: Recover kretprobe modified return address in stacktrace

Steven Rostedt (VMware) (12):
      tracing: Initialize upper and lower vars in pid_list_refill_irq()
      tracefs: Have tracefs directories not set OTH permission bits by default
      tracing: Disable "other" permission bits in the tracefs files
      tracing: Use linker magic instead of recasting ftrace_ops_list_func()
      tracing: Reuse logic from perf's get_recursion_context()
      tracing/perf: Add interrupt_context_level() helper
      x86/ftrace: Remove fault protection code in prepare_ftrace_return
      ftrace/x86_64: Have function graph tracer depend on DYNAMIC_FTRACE
      x86/ftrace: Make function graph use ftrace directly
      tracing: Fix selftest config check for function graph start up test
      ftrace/direct: Do not disable when switching direct callers
      tracing: Explain the trace recursion transition bit better

Sven Schnelle (1):
      kprobes: convert tests to kunit

Weizhao Ouyang (1):
      ftrace: Cleanup ftrace_dyn_arch_init()

----
 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/stacktrace.h             |   9 +
 arch/arm/kernel/ftrace.c                      |   5 -
 arch/arm/kernel/return_address.c              |   4 +
 arch/arm/kernel/stacktrace.c                  |  17 +-
 arch/arm/probes/kprobes/core.c                |  28 ++-
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/stacktrace.h           |   4 +
 arch/arm64/kernel/ftrace.c                    |   5 -
 arch/arm64/kernel/probes/kprobes.c            |   4 +-
 arch/arm64/kernel/probes/kprobes_trampoline.S |   4 +
 arch/arm64/kernel/stacktrace.c                |   7 +
 arch/csky/kernel/ftrace.c                     |   5 -
 arch/ia64/kernel/ftrace.c                     |   6 -
 arch/microblaze/kernel/ftrace.c               |   5 -
 arch/nds32/kernel/ftrace.c                    |   5 -
 arch/parisc/kernel/ftrace.c                   |   5 -
 arch/riscv/kernel/ftrace.c                    |   5 -
 arch/s390/kernel/ftrace.c                     |   5 -
 arch/sh/kernel/ftrace.c                       |   5 -
 arch/sparc/kernel/ftrace.c                    |   5 -
 arch/x86/Kconfig                              |   2 +-
 arch/x86/include/asm/ftrace.h                 |   9 +-
 arch/x86/include/asm/unwind.h                 |   6 +
 arch/x86/kernel/ftrace.c                      |  76 +++---
 arch/x86/kernel/ftrace_64.S                   |  30 +--
 fs/tracefs/inode.c                            |   3 +-
 include/asm-generic/vmlinux.lds.h             |  10 +-
 include/linux/bootconfig.h                    |  31 ++-
 include/linux/ftrace.h                        |  38 ++-
 include/linux/preempt.h                       |  21 ++
 include/linux/trace_recursion.h               |  16 +-
 init/main.c                                   |  16 +-
 kernel/events/internal.h                      |   7 +-
 kernel/kprobes.c                              |   3 -
 kernel/test_kprobes.c                         | 222 +++++-------------
 kernel/trace/fgraph.c                         |   6 +-
 kernel/trace/ftrace.c                         | 325 ++++++++++++++++++++++----
 kernel/trace/pid_list.c                       |   4 +-
 kernel/trace/ring_buffer.c                    |   9 +-
 kernel/trace/trace.c                          |  73 +++---
 kernel/trace/trace.h                          |   5 +-
 kernel/trace/trace_dynevent.c                 |   2 +-
 kernel/trace/trace_events.c                   |  42 ++--
 kernel/trace/trace_events_hist.c              |  15 +-
 kernel/trace/trace_events_synth.c             |   4 +-
 kernel/trace/trace_functions_graph.c          |   4 +-
 kernel/trace/trace_hwlat.c                    |   6 +-
 kernel/trace/trace_kprobe.c                   |   8 +-
 kernel/trace/trace_osnoise.c                  |  14 +-
 kernel/trace/trace_printk.c                   |   2 +-
 kernel/trace/trace_recursion_record.c         |   4 +-
 kernel/trace/trace_selftest.c                 |  92 +++++++-
 kernel/trace/trace_stack.c                    |   6 +-
 kernel/trace/trace_stat.c                     |   6 +-
 kernel/trace/trace_uprobe.c                   |   4 +-
 kernel/trace/tracing_map.c                    |  40 ++--
 lib/Kconfig.debug                             |   3 +-
 lib/bootconfig.c                              | 231 +++++++++++-------
 samples/ftrace/Makefile                       |   1 +
 samples/ftrace/ftrace-direct-multi.c          |  52 +++++
 tools/bootconfig/Makefile                     |   4 +-
 tools/bootconfig/include/linux/bootconfig.h   |  45 +++-
 tools/bootconfig/include/linux/bug.h          |  12 -
 tools/bootconfig/include/linux/ctype.h        |   7 -
 tools/bootconfig/include/linux/errno.h        |   7 -
 tools/bootconfig/include/linux/kernel.h       |  18 --
 tools/bootconfig/include/linux/memblock.h     |  11 -
 tools/bootconfig/include/linux/printk.h       |  14 --
 tools/bootconfig/include/linux/string.h       |  32 ---
 tools/bootconfig/main.c                       |  32 +--
 71 files changed, 1033 insertions(+), 732 deletions(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi.c
 delete mode 100644 tools/bootconfig/include/linux/bug.h
 delete mode 100644 tools/bootconfig/include/linux/ctype.h
 delete mode 100644 tools/bootconfig/include/linux/errno.h
 delete mode 100644 tools/bootconfig/include/linux/kernel.h
 delete mode 100644 tools/bootconfig/include/linux/memblock.h
 delete mode 100644 tools/bootconfig/include/linux/printk.h
 delete mode 100644 tools/bootconfig/include/linux/string.h
