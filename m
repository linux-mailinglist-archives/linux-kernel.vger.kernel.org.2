Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67E4422EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhKAV6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Nov 2021 17:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhKAV6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:58:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2925760F56;
        Mon,  1 Nov 2021 21:55:47 +0000 (UTC)
Date:   Mon, 1 Nov 2021 17:55:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Carles Pey <carles.pey@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Song Liu <songliubraving@fb.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Weizhao Ouyang <o451686892@gmail.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] tracing: Updates for 5.16
Message-ID: <20211101175544.00fc0d57@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Note, I'm pushing this early as these are my well tested patches and
there's some dependencies in here that I believe that Heiko needs for his
s390 tree and so does Gustavo for some of his work.

I have some more changes to the osnoise and timerlat tracing that I'm still
testing, and will hopefully post those later this week. Those are not
intrusive to other parts of the kernel as they only deal with osnoise and
timerlat which most people currently have disabled in their configs.

Also, this pull request will conflict with your tree against a fix I had
for trace recursions. I did the conflict resolution and pushed it to my
ftrace/conflicts branch if you want to reference it.

Tracing updates for 5.16:

- kprobes: Restructured stack unwinder to show properly on x86 when a stack
  dump happens from a kretprobe callback.

- Fix to bootconfig parsing

- Have tracefs allow owner and group permissions by default (only denying
  others). There's been pressure to allow non root to tracefs in a
  controlled fashion, and using groups is probably the safest.

- Bootconfig memory management updates.

- Bootconfig clean up to have the tools directory be less dependent on
  changes in the kernel tree.

- Allow perf to be traced by function tracer.

- Rewrite of function graph tracer to be a callback from the function tracer
  instead of having its own trampoline (this change will happen on an arch
  by arch basis, and currently only x86_64 implements it).

- Allow multiple direct trampolines (bpf hooks to functions) be batched
  together in one synchronization.

- Allow histogram triggers to add variables that can perform calculations
  against the event's fields.

- Use the linker to determine architecture callbacks from the ftrace
  trampoline to allow for proper parameter prototypes and prevent warnings
  from the compiler.

- Extend histogram triggers to key off of variables.

- Have trace recursion use bit magic to determine preempt context over if
  branches.

- Have trace recursion disable preemption as all use cases do anyway.

- Added testing for verification of tracing utilities.

- Various small clean ups and fixes.


Please pull the latest trace-v5.16 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16

Tag SHA1: 4de9e3324159cf9be30835fd948f2b2876317d8e
Head SHA1: feea69ec121f067073868cebe0cb9d003e64ad80


Arnd Bergmann (1):
      tracing: use %ps format string to print symbols

Carles Pey (1):
      ftrace: Add unit test for removing trace function

Changbin Du (1):
      tracing: in_irq() cleanup

Daniel Bristot de Oliveira (4):
      trace/osnoise: Fix an ifdef comment
      tracing/doc: Fix typos on the timerlat tracer documentation
      trace/osnoise: Add migrate-disabled field to the osnoise header
      trace/timerlat: Add migrate-disabled field to the timerlat header

Jiri Olsa (6):
      x86/ftrace: Remove extra orig rax move
      tracing: Add trampoline/graph selftest
      ftrace: Add ftrace_add_rec_direct function
      ftrace: Add multi direct register/unregister interface
      ftrace: Add multi direct modify interface
      ftrace/samples: Add multi direct interface test module

Josh Poimboeuf (3):
      objtool: Add frame-pointer-specific function ignore
      objtool: Ignore unwind hints for ignored functions
      x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline()

Kalesh Singh (9):
      tracing/cfi: Fix cmp_entries_* functions signature mismatch
      tracing: Add support for creating hist trigger variables from literal
      tracing: Add division and multiplication support for hist triggers
      tracing: Fix operator precedence for hist triggers expression
      tracing/histogram: Simplify handling of .sym-offset in expressions
      tracing/histogram: Covert expr to const if both operands are constants
      tracing/histogram: Optimize division by a power of 2
      tracing/histogram: Document expression arithmetic and constants
      tracing/histogram: Fix documentation inline emphasis warning

Masami Hiramatsu (39):
      kprobes: treewide: Cleanup the error messages for kprobes
      kprobes: Fix coding style issues
      kprobes: Use IS_ENABLED() instead of kprobes_built_in()
      kprobes: Add assertions for required lock
      kprobes: treewide: Use 'kprobe_opcode_t *' for the code address in get_optimized_kprobe()
      kprobes: Use bool type for functions which returns boolean value
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: treewide: Make it harder to refer kretprobe_trampoline directly
      kprobes: Add kretprobe_find_ret_addr() for searching return address
      ARC: Add instruction_pointer_set() API
      ia64: Add instruction_pointer_set() API
      arm: kprobes: Make space for instruction pointer on stack
      kprobes: Enable stacktrace from pt_regs in kretprobe handler
      x86/kprobes: Push a fake return address at kretprobe_trampoline
      x86/unwind: Recover kretprobe trampoline entry
      tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
      x86/kprobes: Fixup return address in generic trampoline handler
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
      lib/bootconfig: Make xbc_alloc_mem() and xbc_free_mem() as __init function
      kprobes: Add a test case for stacktrace from kretprobe handler
      lib/bootconfig: Fix the xbc_get_info kerneldoc
      selftests/ftrace: Stop tracing while reading the trace file by default

Mathieu Desnoyers (1):
      tracing: Fix missing trace_boot_init_histograms kstrdup NULL checks

Punit Agrawal (5):
      kprobes: Do not use local variable when creating debugfs file
      kprobes: Use helper to parse boolean input from userspace
      kprobe: Simplify prepare_kprobe() by dropping redundant version
      csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
      kprobes: Make arch_check_ftrace_location static

Robin H. Johnson (2):
      tracing: Show size of requested perf buffer
      tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Song Liu (1):
      perf/core: allow ftrace for functions in kernel/event/core.c

Steven Rostedt (VMware) (16):
      tracing: Place trace_pid_list logic into abstract functions
      tracing: Create a sparse bitmask for pid filtering
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
      ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed image still link
      bootconfig: Initialize ret in xbc_parse_tree()

Sven Schnelle (1):
      kprobes: convert tests to kunit

Tiezhu Yang (4):
      samples/kretprobes: Fix return value if register_kretprobe() failed
      docs, kprobes: Remove invalid URL and add new reference
      test_kprobes: Move it from kernel/ to lib/
      MAINTAINERS: Update KPROBES and TRACING entries

Viktor Rosendahl (1):
      tools/latency-collector: Use correct size when writing queue_full_warning

Wang ShaoBo (1):
      tracing/hwlat: Make some internal symbols static

Weizhao Ouyang (1):
      ftrace: Cleanup ftrace_dyn_arch_init()

chongjiapeng (1):
      ftrace: Make ftrace_profile_pages_init static

kernel test robot (1):
      tracing/histogram: Fix semicolon.cocci warnings

王贇 (2):
      ftrace: disable preemption when recursion locked
      ftrace: do CPU checking after preemption disabled

----
 Documentation/trace/histogram.rst               |  14 +
 Documentation/trace/kprobes.rst                 |   2 +-
 Documentation/trace/timerlat-tracer.rst         |  24 +-
 MAINTAINERS                                     |   5 +-
 arch/Kconfig                                    |   8 +
 arch/arc/include/asm/kprobes.h                  |   2 +-
 arch/arc/include/asm/ptrace.h                   |   5 +
 arch/arc/kernel/kprobes.c                       |  13 +-
 arch/arm/Kconfig                                |   1 +
 arch/arm/include/asm/stacktrace.h               |   9 +
 arch/arm/kernel/ftrace.c                        |   5 -
 arch/arm/kernel/return_address.c                |   4 +
 arch/arm/kernel/stacktrace.c                    |  17 +-
 arch/arm/probes/kprobes/core.c                  |  43 +-
 arch/arm/probes/kprobes/opt-arm.c               |   7 +-
 arch/arm64/Kconfig                              |   1 +
 arch/arm64/include/asm/kprobes.h                |   2 +-
 arch/arm64/include/asm/stacktrace.h             |   4 +
 arch/arm64/kernel/ftrace.c                      |   5 -
 arch/arm64/kernel/probes/kprobes.c              |  12 +-
 arch/arm64/kernel/probes/kprobes_trampoline.S   |   8 +-
 arch/arm64/kernel/stacktrace.c                  |   7 +
 arch/csky/include/asm/kprobes.h                 |   2 +-
 arch/csky/kernel/ftrace.c                       |   5 -
 arch/csky/kernel/probes/ftrace.c                |   9 -
 arch/csky/kernel/probes/kprobes.c               |  14 +-
 arch/csky/kernel/probes/kprobes_trampoline.S    |   4 +-
 arch/ia64/include/asm/ptrace.h                  |   5 +
 arch/ia64/kernel/ftrace.c                       |   6 -
 arch/ia64/kernel/kprobes.c                      |  15 +-
 arch/microblaze/kernel/ftrace.c                 |   5 -
 arch/mips/kernel/kprobes.c                      |  26 +-
 arch/nds32/kernel/ftrace.c                      |   5 -
 arch/parisc/kernel/ftrace.c                     |   7 -
 arch/parisc/kernel/kprobes.c                    |   6 +-
 arch/powerpc/include/asm/kprobes.h              |   2 +-
 arch/powerpc/kernel/kprobes-ftrace.c            |   2 -
 arch/powerpc/kernel/kprobes.c                   |  29 +-
 arch/powerpc/kernel/optprobes.c                 |   8 +-
 arch/powerpc/kernel/stacktrace.c                |   2 +-
 arch/riscv/include/asm/kprobes.h                |   2 +-
 arch/riscv/kernel/ftrace.c                      |   5 -
 arch/riscv/kernel/probes/ftrace.c               |   2 -
 arch/riscv/kernel/probes/kprobes.c              |  15 +-
 arch/riscv/kernel/probes/kprobes_trampoline.S   |   4 +-
 arch/s390/include/asm/kprobes.h                 |   2 +-
 arch/s390/kernel/ftrace.c                       |   5 -
 arch/s390/kernel/kprobes.c                      |  16 +-
 arch/s390/kernel/stacktrace.c                   |   2 +-
 arch/sh/boot/compressed/misc.c                  |   3 +
 arch/sh/include/asm/kprobes.h                   |   2 +-
 arch/sh/kernel/ftrace.c                         |   5 -
 arch/sh/kernel/kprobes.c                        |  12 +-
 arch/sparc/include/asm/kprobes.h                |   2 +-
 arch/sparc/kernel/ftrace.c                      |   5 -
 arch/sparc/kernel/kprobes.c                     |  12 +-
 arch/x86/Kconfig                                |   3 +-
 arch/x86/include/asm/ftrace.h                   |   9 +-
 arch/x86/include/asm/kprobes.h                  |   1 -
 arch/x86/include/asm/unwind.h                   |  29 ++
 arch/x86/include/asm/unwind_hints.h             |   5 +
 arch/x86/kernel/ftrace.c                        |  76 ++--
 arch/x86/kernel/ftrace_64.S                     |  30 +-
 arch/x86/kernel/kprobes/core.c                  |  71 +++-
 arch/x86/kernel/kprobes/ftrace.c                |   2 -
 arch/x86/kernel/kprobes/opt.c                   |   6 +-
 arch/x86/kernel/trace.c                         |   2 +-
 arch/x86/kernel/unwind_frame.c                  |   3 +-
 arch/x86/kernel/unwind_guess.c                  |   3 +-
 arch/x86/kernel/unwind_orc.c                    |  21 +-
 fs/tracefs/inode.c                              |   3 +-
 include/asm-generic/vmlinux.lds.h               |  10 +-
 include/linux/bootconfig.h                      |  31 +-
 include/linux/ftrace.h                          |  38 +-
 include/linux/kprobes.h                         | 113 ++++--
 include/linux/objtool.h                         |  12 +
 include/linux/preempt.h                         |  21 +
 include/linux/trace_events.h                    |   2 +-
 include/linux/trace_recursion.h                 |  27 +-
 init/main.c                                     |  16 +-
 kernel/Makefile                                 |   1 -
 kernel/events/Makefile                          |   5 -
 kernel/events/internal.h                        |   7 +-
 kernel/kprobes.c                                | 505 +++++++++++++-----------
 kernel/livepatch/patch.c                        |  12 +-
 kernel/test_kprobes.c                           | 313 ---------------
 kernel/trace/Makefile                           |   1 +
 kernel/trace/fgraph.c                           |   6 +-
 kernel/trace/ftrace.c                           | 348 +++++++++++++---
 kernel/trace/pid_list.c                         | 495 +++++++++++++++++++++++
 kernel/trace/pid_list.h                         |  88 +++++
 kernel/trace/ring_buffer.c                      |   9 +-
 kernel/trace/trace.c                            | 151 +++----
 kernel/trace/trace.h                            |  19 +-
 kernel/trace/trace_boot.c                       |   4 +
 kernel/trace/trace_dynevent.c                   |   2 +-
 kernel/trace/trace_event_perf.c                 |   9 +-
 kernel/trace/trace_events.c                     |  48 +--
 kernel/trace/trace_events_hist.c                | 415 +++++++++++++++----
 kernel/trace/trace_events_synth.c               |   4 +-
 kernel/trace/trace_functions.c                  |   5 -
 kernel/trace/trace_functions_graph.c            |   4 +-
 kernel/trace/trace_hwlat.c                      |  10 +-
 kernel/trace/trace_kprobe.c                     |  10 +-
 kernel/trace/trace_osnoise.c                    |  39 +-
 kernel/trace/trace_output.c                     |  17 +-
 kernel/trace/trace_printk.c                     |   2 +-
 kernel/trace/trace_recursion_record.c           |   4 +-
 kernel/trace/trace_selftest.c                   |  92 ++++-
 kernel/trace/trace_stack.c                      |   6 +-
 kernel/trace/trace_stat.c                       |   6 +-
 kernel/trace/trace_uprobe.c                     |   4 +-
 kernel/trace/tracing_map.c                      |  40 +-
 lib/Kconfig.debug                               |   3 +-
 lib/Makefile                                    |   1 +
 lib/bootconfig.c                                | 231 ++++++-----
 lib/error-inject.c                              |   3 +-
 lib/test_kprobes.c                              | 371 +++++++++++++++++
 samples/ftrace/Makefile                         |   1 +
 samples/ftrace/ftrace-direct-multi.c            |  52 +++
 samples/kprobes/kretprobe_example.c             |   2 +-
 tools/bootconfig/Makefile                       |   4 +-
 tools/bootconfig/include/linux/bootconfig.h     |  45 ++-
 tools/bootconfig/include/linux/bug.h            |  12 -
 tools/bootconfig/include/linux/ctype.h          |   7 -
 tools/bootconfig/include/linux/errno.h          |   7 -
 tools/bootconfig/include/linux/kernel.h         |  18 -
 tools/bootconfig/include/linux/memblock.h       |  11 -
 tools/bootconfig/include/linux/printk.h         |  14 -
 tools/bootconfig/include/linux/string.h         |  32 --
 tools/bootconfig/main.c                         |  32 +-
 tools/include/linux/objtool.h                   |  12 +
 tools/objtool/check.c                           |   2 +-
 tools/testing/selftests/ftrace/ftracetest       |   2 +-
 tools/testing/selftests/ftrace/test.d/functions |  12 +
 tools/tracing/latency/latency-collector.c       |   2 +-
 136 files changed, 3007 insertions(+), 1528 deletions(-)
 delete mode 100644 kernel/test_kprobes.c
 create mode 100644 kernel/trace/pid_list.c
 create mode 100644 kernel/trace/pid_list.h
 create mode 100644 lib/test_kprobes.c
 create mode 100644 samples/ftrace/ftrace-direct-multi.c
 delete mode 100644 tools/bootconfig/include/linux/bug.h
 delete mode 100644 tools/bootconfig/include/linux/ctype.h
 delete mode 100644 tools/bootconfig/include/linux/errno.h
 delete mode 100644 tools/bootconfig/include/linux/kernel.h
 delete mode 100644 tools/bootconfig/include/linux/memblock.h
 delete mode 100644 tools/bootconfig/include/linux/printk.h
 delete mode 100644 tools/bootconfig/include/linux/string.h
---------------------------
