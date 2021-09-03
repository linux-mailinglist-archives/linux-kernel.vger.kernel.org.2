Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9E40029A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349640AbhICPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235662AbhICPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:51:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4BB610A2;
        Fri,  3 Sep 2021 15:50:15 +0000 (UTC)
Date:   Fri, 3 Sep 2021 11:50:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [GIT PULL] tracing: Changes for 5.15
Message-ID: <20210903115014.28dc0da6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates for 5.15:

 - Simplifying the Kconfig use of FTRACE and TRACE_IRQFLAGS_SUPPORT

 - bootconfig now can start histograms

 - bootconfig supports group/all enabling

 - histograms now can put values in linear size buckets

 - execnames can be passed to synthetic events

 - Introduction of "event probes" that attach to other events and
   can retrieve data from pointers of fields, or record fields
   as different types (a pointer to a string as a string instead
   of just a hex number)

 - Various fixes and clean ups


Please pull the latest trace-v5.15 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15

Tag SHA1: edba3f3e4e1b6564493440a725c3ae6c07dd998c
Head SHA1: 4420f5b1be7b117330526f3eabd13d840f510b15


Huang Shijie (1):
      tracing: Fix a typo in tracepoint.h

Masahiro Yamada (2):
      tracing: Simplify the Kconfig dependency of FTRACE
      tracing: Refactor TRACE_IRQFLAGS_SUPPORT in Kconfig

Masami Hiramatsu (11):
      tracing/boot: Fix a hist trigger dependency for boot time tracing
      tracing/boot: Add per-event histogram action options
      tracing/boot: Support multiple handlers for per-event histogram
      tracing/boot: Support multiple histograms for each event
      tracing/boot: Show correct histogram error command
      Documentation: tracing: Add histogram syntax to boot-time tracing
      tools/bootconfig: Support per-group/all event enabling option
      tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh
      tools/bootconfig: Use per-group/all enable option in ftrace2bconf script
      bootconfig/tracing/ktest: Update ktest example for boot-time tracing
      tracing/probes: Reject events which have the same name of existing one

Sebastian Andrzej Siewior (1):
      tracing: Replace deprecated CPU-hotplug functions.

Steven Rostedt (VMware) (18):
      tracing: Add linear buckets to histogram logic
      tracing/histogram: Update the documentation for the buckets modifier
      tracing: Have histogram types be constant when possible
      tracing: Allow execnames to be passed as args for synthetic events
      MAINTAINERS: Add an entry for os noise/latency
      tracing: Add DYNAMIC flag for dynamic events
      tracing: Have dynamic events have a ref counter
      tracing/probe: Have traceprobe_parse_probe_arg() take a const arg
      tracing/probes: Allow for dot delimiter as well as slash for system names
      tracing/probes: Use struct_size() instead of defining custom macros
      tracing/probe: Change traceprobe_set_print_fmt() to take a type
      tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs
      selftests/ftrace: Add clear_dynamic_events() to test cases
      selftests/ftrace: Fix requirement check of README file
      selftests/ftrace: Add test case to test adding and removing of event probe
      selftests/ftrace: Add selftest for testing eprobe events on synthetic events
      selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes
      tracing/doc: Fix table format in histogram code

Tzvetomir Stoyanov (VMware) (1):
      tracing: Add a probe that attaches to trace events

zhaoxiao (1):
      tracepoint: Fix kerneldoc comments

----
 Documentation/trace/boottime-trace.rst             |  85 +-
 Documentation/trace/histogram.rst                  | 110 ++-
 MAINTAINERS                                        |  14 +
 arch/Kconfig                                       |   3 +
 arch/arc/Kconfig                                   |   4 +-
 arch/arm/Kconfig                                   |   5 +-
 arch/arm64/Kconfig                                 |   4 +-
 arch/csky/Kconfig                                  |   4 +-
 arch/hexagon/Kconfig                               |   4 +-
 arch/microblaze/Kconfig                            |   1 +
 arch/microblaze/Kconfig.debug                      |   5 -
 arch/mips/Kconfig                                  |   1 +
 arch/mips/Kconfig.debug                            |   4 -
 arch/nds32/Kconfig                                 |   4 +-
 arch/nios2/Kconfig                                 |   3 -
 arch/openrisc/Kconfig                              |   4 +-
 arch/parisc/Kconfig                                |   1 +
 arch/parisc/Kconfig.debug                          |   3 -
 arch/powerpc/Kconfig                               |   5 +-
 arch/riscv/Kconfig                                 |   4 +-
 arch/s390/Kconfig                                  |   1 +
 arch/s390/Kconfig.debug                            |   3 -
 arch/sh/Kconfig                                    |   1 +
 arch/sh/Kconfig.debug                              |   3 -
 arch/sparc/Kconfig                                 |   1 +
 arch/sparc/Kconfig.debug                           |   4 -
 arch/um/Kconfig                                    |   5 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/Kconfig.debug                             |   3 -
 arch/xtensa/Kconfig                                |   4 +-
 include/linux/trace_events.h                       |  52 +-
 include/linux/tracepoint.h                         |   2 +-
 kernel/trace/Kconfig                               |   6 +-
 kernel/trace/Makefile                              |   1 +
 kernel/trace/ring_buffer.c                         |   8 +-
 kernel/trace/trace.c                               |  10 +-
 kernel/trace/trace.h                               |  18 +
 kernel/trace/trace_boot.c                          | 302 ++++++-
 kernel/trace/trace_dynevent.c                      |  38 +
 kernel/trace/trace_dynevent.h                      |   4 +-
 kernel/trace/trace_eprobe.c                        | 903 +++++++++++++++++++++
 kernel/trace/trace_event_perf.c                    |   6 +-
 kernel/trace/trace_events.c                        |  22 +-
 kernel/trace/trace_events_hist.c                   | 143 +++-
 kernel/trace/trace_events_synth.c                  |  21 +-
 kernel/trace/trace_events_trigger.c                |  20 +-
 kernel/trace/trace_hwlat.c                         |  28 +-
 kernel/trace/trace_kprobe.c                        |  49 +-
 kernel/trace/trace_osnoise.c                       |  16 +-
 kernel/trace/trace_probe.c                         | 109 ++-
 kernel/trace/trace_probe.h                         |  16 +-
 kernel/trace/trace_probe_tmpl.h                    |   6 +-
 kernel/trace/trace_uprobe.c                        |  40 +-
 kernel/tracepoint.c                                |   4 +-
 tools/bootconfig/scripts/bconf2ftrace.sh           | 101 +++
 tools/bootconfig/scripts/ftrace2bconf.sh           |  24 +-
 tools/bootconfig/scripts/xbc.sh                    |   4 +-
 .../ktest/examples/bootconfigs/boottrace.bconf     |  20 +-
 .../ktest/examples/bootconfigs/verify-boottrace.sh |   2 +-
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  40 +
 .../ftrace/test.d/dynevent/test_duplicates.tc      |  38 +
 tools/testing/selftests/ftrace/test.d/functions    |  24 +-
 .../inter-event/trigger-synthetic-eprobe.tc        |  53 ++
 63 files changed, 2149 insertions(+), 275 deletions(-)
 create mode 100644 kernel/trace/trace_eprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
---------------------------
