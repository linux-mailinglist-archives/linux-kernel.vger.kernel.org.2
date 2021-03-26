Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E556234B15C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCZVaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhCZV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:29:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7E661A24;
        Fri, 26 Mar 2021 21:29:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lPu1F-002DPn-Kb; Fri, 26 Mar 2021 17:29:25 -0400
Message-ID: <20210326212848.385566448@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 17:28:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: More updates for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 70193038a6ec9bbf10990a126432b0cbf56aa339


Bhaskar Chowdhury (1):
      kernel: trace: Mundane typo fixes in the file trace_events_filter.c

Ingo Molnar (1):
      tracing: Fix various typos in comments

Qiujun Huang (2):
      tracing: A minor cleanup for create_system_filter()
      tracing: Update create_system_filter() kernel-doc comment

Steven Rostedt (VMware) (2):
      scripts/recordmcount.pl: Make indent spacing consistent
      scripts/recordmcount.pl: Make vim and emacs indent the same

----
 arch/microblaze/include/asm/ftrace.h |  2 +-
 arch/nds32/kernel/ftrace.c           |  2 +-
 arch/powerpc/include/asm/ftrace.h    |  4 ++--
 arch/sh/kernel/ftrace.c              |  2 +-
 arch/sparc/include/asm/ftrace.h      |  2 +-
 fs/tracefs/inode.c                   |  2 +-
 include/linux/ftrace.h               |  4 ++--
 include/linux/trace_events.h         |  2 +-
 include/linux/tracepoint.h           |  2 +-
 include/trace/events/io_uring.h      |  2 +-
 include/trace/events/rcu.h           |  2 +-
 include/trace/events/sched.h         |  2 +-
 include/trace/events/timer.h         |  2 +-
 kernel/trace/bpf_trace.c             |  5 +++--
 kernel/trace/fgraph.c                |  4 ++--
 kernel/trace/ftrace.c                |  8 ++++----
 kernel/trace/ring_buffer.c           |  2 +-
 kernel/trace/synth_event_gen_test.c  |  2 +-
 kernel/trace/trace.c                 | 18 +++++++++---------
 kernel/trace/trace.h                 |  4 ++--
 kernel/trace/trace_event_perf.c      |  2 +-
 kernel/trace/trace_events.c          |  4 ++--
 kernel/trace/trace_events_filter.c   | 18 +++++++++---------
 kernel/trace/trace_events_synth.c    |  2 +-
 kernel/trace/trace_functions_graph.c |  2 +-
 kernel/trace/trace_hwlat.c           |  4 ++--
 kernel/trace/trace_kprobe.c          |  2 +-
 kernel/trace/trace_probe.c           |  6 +++---
 kernel/trace/trace_probe.h           |  2 +-
 kernel/trace/trace_probe_tmpl.h      |  2 +-
 kernel/trace/trace_selftest.c        |  4 ++--
 kernel/trace/trace_seq.c             | 12 ++++++------
 scripts/recordmcount.pl              | 26 ++++++++++++++------------
 33 files changed, 81 insertions(+), 78 deletions(-)
