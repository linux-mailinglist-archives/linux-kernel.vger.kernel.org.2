Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F843B4E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFZNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhFZNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2BA61584;
        Sat, 26 Jun 2021 13:05:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx806-000Edg-KM; Sat, 26 Jun 2021 09:05:34 -0400
Message-ID: <20210626130404.033700863@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 00/24] tracing: Last minute updates for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes for 5.14.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 1f1b9e5899a2c96b354cac917f532c1917990ab6


Daniel Bristot de Oliveira (12):
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

Masami Hiramatsu (5):
      bootconfig: Change array value to use child node
      bootconfig: Support mixing a value and subkeys under a key
      tools/bootconfig: Support mixed value and subkey test cases
      docs: bootconfig: Update for mixing value and subkeys
      bootconfig: Share the checksum function with tools

Steven Rostedt (1):
      trace: Add __print_ns_to_secs() and __print_ns_without_secs() helpers

Steven Rostedt (VMware) (7):
      tracing: Simplify the max length test when using the filtering temp buffer
      tracing: Add better comments for the filtering temp buffer use case
      tracing: Add tp_printk_stop_on_boot option
      tracing: Have ftrace_dump_on_oops kernel parameter take numbers
      bootconfig/tracing/ktest: Add ktest examples of testing bootconfig
      tracing: Add LATENCY_FS_NOTIFY to define if latency_fsnotify() is defined
      Merge branch 'trace/ftrace/core' into trace/for-next

----
 Documentation/admin-guide/bootconfig.rst           |   30 +-
 Documentation/admin-guide/kernel-parameters.txt    |   13 +
 Documentation/trace/hwlat_detector.rst             |   13 +-
 Documentation/trace/index.rst                      |    2 +
 Documentation/trace/osnoise-tracer.rst             |  152 ++
 Documentation/trace/timerlat-tracer.rst            |  181 ++
 arch/x86/kernel/Makefile                           |    1 +
 arch/x86/kernel/trace.c                            |  237 +++
 fs/proc/bootconfig.c                               |    2 +-
 include/linux/bootconfig.h                         |   58 +-
 include/linux/ftrace_irq.h                         |   13 +
 include/linux/trace.h                              |    5 +
 include/trace/events/osnoise.h                     |  142 ++
 include/trace/trace_events.h                       |   25 +
 init/main.c                                        |   12 +-
 kernel/trace/Kconfig                               |   62 +
 kernel/trace/Makefile                              |    1 +
 kernel/trace/trace.c                               |  172 +-
 kernel/trace/trace.h                               |   35 +-
 kernel/trace/trace_entries.h                       |   41 +
 kernel/trace/trace_hwlat.c                         |  534 +++--
 kernel/trace/trace_osnoise.c                       | 2053 ++++++++++++++++++++
 kernel/trace/trace_output.c                        |  119 +-
 lib/bootconfig.c                                   |   76 +-
 tools/bootconfig/main.c                            |   62 +-
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
 41 files changed, 4211 insertions(+), 235 deletions(-)
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
