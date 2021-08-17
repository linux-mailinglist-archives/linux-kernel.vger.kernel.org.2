Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB59B3EF2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhHQTnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhHQTnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0ADA61008;
        Tue, 17 Aug 2021 19:43:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zG-004TL0-MU; Tue, 17 Aug 2021 15:43:02 -0400
Message-ID: <20210817194207.947725935@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [for-next][PATCH 00/19] tracing: Updates for 5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: db396be6ddc4b953db3a725e19945fd4f151cfe9


Huang Shijie (1):
      tracing: Fix a typo in tracepoint.h

Masahiro Yamada (2):
      tracing: Simplify the Kconfig dependency of FTRACE
      tracing: Refactor TRACE_IRQFLAGS_SUPPORT in Kconfig

Masami Hiramatsu (10):
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

Steven Rostedt (VMware) (5):
      tracing: Add linear buckets to histogram logic
      tracing/histogram: Update the documentation for the buckets modifier
      tracing: Have histogram types be constant when possible
      tracing: Allow execnames to be passed as args for synthetic events
      MAINTAINERS: Add an entry for os noise/latency

zhaoxiao (1):
      tracepoint: Fix kerneldoc comments

----
 Documentation/trace/boottime-trace.rst             |  85 +++++-
 Documentation/trace/histogram.rst                  |  92 ++++++-
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
 include/linux/tracepoint.h                         |   2 +-
 kernel/trace/Kconfig                               |   6 +-
 kernel/trace/trace.c                               |   1 +
 kernel/trace/trace_boot.c                          | 302 ++++++++++++++++++++-
 kernel/trace/trace_events_hist.c                   | 143 ++++++++--
 kernel/tracepoint.c                                |   4 +-
 tools/bootconfig/scripts/bconf2ftrace.sh           | 101 +++++++
 tools/bootconfig/scripts/ftrace2bconf.sh           |  24 +-
 tools/bootconfig/scripts/xbc.sh                    |   4 +-
 .../ktest/examples/bootconfigs/boottrace.bconf     |  20 +-
 .../ktest/examples/bootconfigs/verify-boottrace.sh |   2 +-
 41 files changed, 753 insertions(+), 132 deletions(-)
