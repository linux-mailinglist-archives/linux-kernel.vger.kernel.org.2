Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7B3F2DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhHTOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240260AbhHTOMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:12:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455C7610FF;
        Fri, 20 Aug 2021 14:12:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mH5FZ-004oIw-3v; Fri, 20 Aug 2021 10:12:01 -0400
Message-ID: <20210820141109.993445617@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 10:11:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 0/9] tracing: More updates for 5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 8e242060c6a4947e8ae7d29794af6a581db08841


Masami Hiramatsu (1):
      tracing/probes: Reject events which have the same name of existing one

Sebastian Andrzej Siewior (1):
      tracing: Replace deprecated CPU-hotplug functions.

Steven Rostedt (VMware) (7):
      tracing: Add DYNAMIC flag for dynamic events
      tracing: Have dynamic events have a ref counter
      tracing/probe: Have traceprobe_parse_probe_arg() take a const arg
      tracing/probes: Allow for dot delimiter as well as slash for system names
      tracing/probes: Use struct_size() instead of defining custom macros
      tracing/probe: Change traceprobe_set_print_fmt() to take a type
      tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs

----
 include/linux/trace_events.h        | 48 ++++++++++++++++++-
 kernel/trace/ring_buffer.c          |  8 ++--
 kernel/trace/trace.c                |  4 +-
 kernel/trace/trace_dynevent.c       | 38 +++++++++++++++
 kernel/trace/trace_dynevent.h       |  4 +-
 kernel/trace/trace_event_perf.c     |  6 +--
 kernel/trace/trace_events.c         | 22 +++++----
 kernel/trace/trace_events_synth.c   | 21 +++++----
 kernel/trace/trace_events_trigger.c |  6 +--
 kernel/trace/trace_hwlat.c          | 28 +++++------
 kernel/trace/trace_kprobe.c         | 41 ++++++++--------
 kernel/trace/trace_osnoise.c        | 16 +++----
 kernel/trace/trace_probe.c          | 93 +++++++++++++++++++++++++++----------
 kernel/trace/trace_probe.h          | 10 +++-
 kernel/trace/trace_probe_tmpl.h     |  6 +--
 kernel/trace/trace_uprobe.c         | 40 ++++++++--------
 16 files changed, 271 insertions(+), 120 deletions(-)
