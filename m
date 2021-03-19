Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF13424DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCSSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhCSSiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DB26191B;
        Fri, 19 Mar 2021 18:38:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0W-0017hI-6S; Fri, 19 Mar 2021 14:38:00 -0400
Message-ID: <20210319183426.840228082@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [for-next][PATCH 00/13] tracing: Updates for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 9a6944fee68e25084130386c608c5ac8db487581

Cao jin (1):
      bootconfig: Update prototype of setup_boot_config()

Colin Ian King (1):
      ftrace: Fix spelling mistake "disabed" -> "disabled"

Steven Rostedt (VMware) (10):
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

Xu Wang (1):
      tools/latency-collector: Remove unneeded semicolon

----
 arch/csky/kernel/probes/ftrace.c          |   2 +-
 arch/riscv/kernel/probes/ftrace.c         |   2 +-
 arch/x86/kernel/kprobes/ftrace.c          |   2 +-
 include/linux/ring_buffer.h               |   3 +-
 include/linux/seq_buf.h                   |  25 ++++
 include/linux/trace_events.h              |   5 +-
 init/main.c                               |   6 +-
 kernel/trace/ring_buffer.c                | 138 ++++++++++++++---
 kernel/trace/trace.c                      | 238 +++++++++++++++++++++++++++---
 kernel/trace/trace.h                      |  12 +-
 kernel/trace/trace_events.c               | 210 ++++++++++++++++++++++++++
 kernel/trace/trace_events_hist.c          | 100 ++++++++-----
 kernel/trace/trace_events_trigger.c       |  45 +++---
 kernel/trace/trace_output.c               |   2 +-
 kernel/trace/trace_printk.c               |  11 ++
 tools/tracing/latency/latency-collector.c |   4 +-
 16 files changed, 697 insertions(+), 108 deletions(-)

