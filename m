Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42D93BA1B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhGBNxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232386AbhGBNxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:53:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8E3613F4;
        Fri,  2 Jul 2021 13:50:48 +0000 (UTC)
Date:   Fri, 2 Jul 2021 09:50:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Austin Kim <austin.kim@lge.com>,
        Chunguang Xu <brookxu@tencent.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ed Tsai <ed.tsai@mediatek.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Burton <paulburton@google.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        zuoqilin <zuoqilin@yulong.com>
Subject: [GIT PULL] tracing: Updates for 5.14
Message-ID: <20210702095047.75807884@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing updates for 5.14:

 - Added option for per CPU threads to the hwlat tracer

 - Have hwlat tracer handle hotplug CPUs

 - New tracer: osnoise, that detects latency caused by interrupts, softirqs
   and scheduling of other tasks.

 - Added timerlat tracer that creates a thread and measures in detail what
   sources of latency it has for wake ups.

 - Removed the "success" field of the sched_wakeup trace event.
   This has been hardcoded as "1" since 2015, no tooling should be looking
   at it now. If one exists, we can revert this commit, fix that tool and
   try to remove it again in the future.

 - tgid mapping fixed to handle more than PID_MAX_DEFAULT pids/tgids.

 - New boot command line option "tp_printk_stop", as tp_printk causes trace
   events to write to console. When user space starts, this can easily live
   lock the system. Having a boot option to stop just after boot up is
   useful to prevent that from happening.

 - Have ftrace_dump_on_oops boot command line option take numbers that match
   the numbers shown in /proc/sys/kernel/ftrace_dump_on_oops.

 - Bootconfig clean ups, fixes and enhancements.

 - New ktest script that tests bootconfig options.

 - Add tracepoint_probe_register_may_exist() to register a tracepoint
   without triggering a WARN*() if it already exists. BPF has a path from
   user space that can do this. All other paths are considered a bug.

 - Small clean ups and fixes


Please pull the latest trace-v5.14 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.14

Tag SHA1: fd54c81c736b4d69af9e1dd011c9182c1e529f08
Head SHA1: 4030a6e6a6a4a42ff8c18414c9e0c93e24cc70b8


Austin Kim (1):
      tracing: Change variable type as bool for clean-up

Chunguang Xu (1):
      trace: replace WB_REASON_FOREIGN_FLUSH with a string

Colin Ian King (2):
      tracing: Remove redundant initialization of variable ret
      tracing: Fix spelling in osnoise tracer "interferences" -> "interference"

Daniel Bristot de Oliveira (18):
      trace/hwlat: Fix Clark's email
      trace/hwlat: Implement the mode config option
      trace/hwlat: Switch disable_migrate to mode none
      trace/hwlat: Implement the per-cpu mode
      trace: Add a generic function to read/write u64 values from tracefs
      trace/hwlat: Use trace_min_max_param for width and window params
      trace/hwlat: Remove printk from sampling loop
      trace: Add osnoise tracer
      trace: Add timerlat tracer
      trace/hwlat: Protect kdata->kthread with get/put_online_cpus
      trace/hwlat: Support hotplug operations
      trace/osnoise: Support hotplug operations
      trace/osnoise: Fix 'no previous prototype' warnings
      trace/osnoise: Make interval u64 on osnoise_main
      trace/osnoise: Fix return value on osnoise_init_hotplug_support
      Documentation: Fix a typo on trace/osnoise-tracer
      trace/osnoise: Make 'noise' variable s64 in run_osnoise()
      trace/timerlat: Fix indentation on timerlat_main()

Ed Tsai (1):
      sched/tracing: Remove the redundant 'success' in the sched tracepoint

Hyeonggon Yoo (1):
      tracing: Add WARN_ON_ONCE when returned value is negative

Jiapeng Chong (1):
      tracing: Remove redundant assignment to event_var

Joe Perches (1):
      treewide: Add missing semicolons to __assign_str uses

Masami Hiramatsu (7):
      tracing/boot: Add per-group/all events enablement
      Documentation: tracing: Add per-group/all events enablement desciption
      bootconfig: Change array value to use child node
      bootconfig: Support mixing a value and subkeys under a key
      tools/bootconfig: Support mixed value and subkey test cases
      docs: bootconfig: Update for mixing value and subkeys
      bootconfig: Share the checksum function with tools

Paul Burton (2):
      tracing: Simplify & fix saved_tgids logic
      tracing: Resize tgid_map to pid_max, not PID_MAX_DEFAULT

Qiujun Huang (1):
      tracing: Fix set_named_trigger_data() kernel-doc comment

Steven Rostedt (1):
      trace: Add __print_ns_to_secs() and __print_ns_without_secs() helpers

Steven Rostedt (VMware) (8):
      tracing: Simplify the max length test when using the filtering temp buffer
      tracing: Add better comments for the filtering temp buffer use case
      tracing: Add tp_printk_stop_on_boot option
      tracing: Have ftrace_dump_on_oops kernel parameter take numbers
      bootconfig/tracing/ktest: Add ktest examples of testing bootconfig
      tracing: Add LATENCY_FS_NOTIFY to define if latency_fsnotify() is defined
      tracing: Have osnoise_main() add a quiescent state for task rcu
      tracepoint: Add tracepoint_probe_register_may_exist() for BPF tracing

Wei Ming Chen (1):
      ring-buffer: Use fallthrough pseudo-keyword

Yun Zhou (2):
      seq_buf: Fix overflow in seq_buf_putmem_hex()
      seq_buf: Make trace_seq_putmem_hex() support data longer than 8

zuoqilin (1):
      tools/bootconfig: Simplify expression

----
 Documentation/admin-guide/bootconfig.rst           |   30 +-
 Documentation/admin-guide/kernel-parameters.txt    |   13 +
 Documentation/trace/boottime-trace.rst             |    6 +
 Documentation/trace/hwlat_detector.rst             |   13 +-
 Documentation/trace/index.rst                      |    2 +
 Documentation/trace/osnoise-tracer.rst             |  152 ++
 Documentation/trace/timerlat-tracer.rst            |  181 ++
 arch/x86/kernel/Makefile                           |    1 +
 arch/x86/kernel/trace.c                            |  234 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   14 +-
 drivers/gpu/drm/lima/lima_trace.h                  |    2 +-
 drivers/infiniband/hw/hfi1/trace_misc.h            |    4 +-
 drivers/infiniband/hw/hfi1/trace_rc.h              |    4 +-
 drivers/infiniband/hw/hfi1/trace_tid.h             |    6 +-
 drivers/infiniband/hw/hfi1/trace_tx.h              |    8 +-
 drivers/infiniband/sw/rdmavt/trace_cq.h            |    4 +-
 drivers/infiniband/sw/rdmavt/trace_mr.h            |    2 +-
 drivers/infiniband/sw/rdmavt/trace_qp.h            |    4 +-
 drivers/infiniband/sw/rdmavt/trace_rc.h            |    2 +-
 drivers/infiniband/sw/rdmavt/trace_tx.h            |    4 +-
 drivers/misc/mei/mei-trace.h                       |    6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  |   12 +-
 drivers/net/fjes/fjes_trace.h                      |    4 +-
 drivers/usb/cdns3/cdnsp-trace.h                    |    2 +-
 fs/nfs/nfs4trace.h                                 |    6 +-
 fs/nfs/nfstrace.h                                  |    4 +-
 fs/proc/bootconfig.c                               |    2 +-
 include/linux/bootconfig.h                         |   58 +-
 include/linux/ftrace_irq.h                         |   13 +
 include/linux/trace.h                              |    7 +
 include/linux/tracepoint.h                         |   10 +
 include/trace/events/btrfs.h                       |    2 +-
 include/trace/events/dma_fence.h                   |    4 +-
 include/trace/events/osnoise.h                     |  142 ++
 include/trace/events/rpcgss.h                      |    4 +-
 include/trace/events/sched.h                       |    2 -
 include/trace/events/sunrpc.h                      |   40 +-
 include/trace/events/writeback.h                   |    3 +-
 include/trace/trace_events.h                       |   25 +
 init/main.c                                        |   12 +-
 kernel/trace/Kconfig                               |   62 +
 kernel/trace/Makefile                              |    1 +
 kernel/trace/bpf_trace.c                           |    3 +-
 kernel/trace/ring_buffer.c                         |    2 +-
 kernel/trace/trace.c                               |  265 ++-
 kernel/trace/trace.h                               |   35 +-
 kernel/trace/trace_boot.c                          |   27 +-
 kernel/trace/trace_entries.h                       |   41 +
 kernel/trace/trace_events_hist.c                   |    3 +-
 kernel/trace/trace_events_trigger.c                |    3 +-
 kernel/trace/trace_hwlat.c                         |  534 +++--
 kernel/trace/trace_osnoise.c                       | 2059 ++++++++++++++++++++
 kernel/trace/trace_output.c                        |  119 +-
 kernel/trace/trace_sched_wakeup.c                  |   24 +-
 kernel/tracepoint.c                                |   33 +-
 lib/bootconfig.c                                   |   76 +-
 lib/seq_buf.c                                      |    8 +-
 tools/bootconfig/main.c                            |   64 +-
 tools/bootconfig/samples/bad-override.bconf        |    3 -
 tools/bootconfig/samples/bad-override2.bconf       |    3 -
 tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
 .../{bad-mixed-kv1.bconf => good-mixed-kv1.bconf}  |    0
 .../{bad-mixed-kv2.bconf => good-mixed-kv2.bconf}  |    0
 tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 +
 tools/bootconfig/samples/good-mixed-override.bconf |    4 +
 .../ktest/examples/bootconfigs/boottrace.bconf     |   49 +
 .../ktest/examples/bootconfigs/config-bootconfig   |    1 +
 .../ktest/examples/bootconfigs/functiongraph.bconf |   15 +
 .../ktest/examples/bootconfigs/tracing.bconf       |   33 +
 .../ktest/examples/bootconfigs/verify-boottrace.sh |   84 +
 .../examples/bootconfigs/verify-functiongraph.sh   |   61 +
 .../ktest/examples/bootconfigs/verify-tracing.sh   |   72 +
 .../testing/ktest/examples/include/bootconfig.conf |   69 +
 tools/testing/ktest/examples/kvm.conf              |    1 +
 74 files changed, 4439 insertions(+), 369 deletions(-)
 create mode 100644 Documentation/trace/osnoise-tracer.rst
 create mode 100644 Documentation/trace/timerlat-tracer.rst
 create mode 100644 arch/x86/kernel/trace.c
 create mode 100644 include/trace/events/osnoise.h
 create mode 100644 kernel/trace/trace_osnoise.c
 delete mode 100644 tools/bootconfig/samples/bad-override.bconf
 delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
 rename tools/bootconfig/samples/{bad-mixed-kv1.bconf => good-mixed-kv1.bconf} (100%)
 rename tools/bootconfig/samples/{bad-mixed-kv2.bconf => good-mixed-kv2.bconf} (100%)
 create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf
 create mode 100644 tools/testing/ktest/examples/bootconfigs/boottrace.bconf
 create mode 100644 tools/testing/ktest/examples/bootconfigs/config-bootconfig
 create mode 100644 tools/testing/ktest/examples/bootconfigs/functiongraph.bconf
 create mode 100644 tools/testing/ktest/examples/bootconfigs/tracing.bconf
 create mode 100755 tools/testing/ktest/examples/bootconfigs/verify-boottrace.sh
 create mode 100755 tools/testing/ktest/examples/bootconfigs/verify-functiongraph.sh
 create mode 100755 tools/testing/ktest/examples/bootconfigs/verify-tracing.sh
 create mode 100644 tools/testing/ktest/examples/include/bootconfig.conf
---------------------------
