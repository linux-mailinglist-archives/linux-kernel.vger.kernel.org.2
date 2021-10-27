Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA243CE56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbhJ0QM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhJ0QM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70B760C51;
        Wed, 27 Oct 2021 16:10:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV1-000xlX-ST;
        Wed, 27 Oct 2021 12:09:59 -0400
Message-ID: <20211027160940.084904334@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/15] tracing: More updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: d33cc657372366a8959f099c619a208b4c5dc664


Kalesh Singh (7):
      tracing: Add support for creating hist trigger variables from literal
      tracing: Add division and multiplication support for hist triggers
      tracing: Fix operator precedence for hist triggers expression
      tracing/histogram: Simplify handling of .sym-offset in expressions
      tracing/histogram: Covert expr to const if both operands are constants
      tracing/histogram: Optimize division by a power of 2
      tracing/histogram: Document expression arithmetic and constants

Masami Hiramatsu (2):
      lib/bootconfig: Fix the xbc_get_info kerneldoc
      selftests/ftrace: Stop tracing while reading the trace file by default

Tiezhu Yang (4):
      samples/kretprobes: Fix return value if register_kretprobe() failed
      docs, kprobes: Remove invalid URL and add new reference
      test_kprobes: Move it from kernel/ to lib/
      MAINTAINERS: Update KPROBES and TRACING entries

王贇 (2):
      ftrace: disable preemption when recursion locked
      ftrace: do CPU checking after preemption disabled

----
 Documentation/trace/histogram.rst               |  14 +
 Documentation/trace/kprobes.rst                 |   2 +-
 MAINTAINERS                                     |   5 +-
 arch/csky/kernel/probes/ftrace.c                |   2 -
 arch/parisc/kernel/ftrace.c                     |   2 -
 arch/powerpc/kernel/kprobes-ftrace.c            |   2 -
 arch/riscv/kernel/probes/ftrace.c               |   2 -
 arch/x86/kernel/kprobes/ftrace.c                |   2 -
 include/linux/trace_recursion.h                 |  11 +-
 kernel/Makefile                                 |   1 -
 kernel/livepatch/patch.c                        |  12 +-
 kernel/trace/ftrace.c                           |  15 +-
 kernel/trace/trace_event_perf.c                 |   6 +-
 kernel/trace/trace_events_hist.c                | 400 +++++++++++++++++++-----
 kernel/trace/trace_functions.c                  |   5 -
 lib/Makefile                                    |   1 +
 lib/bootconfig.c                                |   4 +-
 {kernel => lib}/test_kprobes.c                  |   0
 samples/kprobes/kretprobe_example.c             |   2 +-
 tools/testing/selftests/ftrace/ftracetest       |   2 +-
 tools/testing/selftests/ftrace/test.d/functions |  12 +
 21 files changed, 384 insertions(+), 118 deletions(-)
 rename {kernel => lib}/test_kprobes.c (100%)
