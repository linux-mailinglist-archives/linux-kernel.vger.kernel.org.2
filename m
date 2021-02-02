Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E87E30CE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhBBWCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234181AbhBBWCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:02:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1575664E22;
        Tue,  2 Feb 2021 22:01:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l73jc-0096xr-R6; Tue, 02 Feb 2021 17:01:20 -0500
Message-ID: <20210202215949.848582355@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Feb 2021 16:59:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Fixes for 5.11-rc5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes:

 - Initialize tracing-graph-pause at task creation, not start of
   function tracing. Causes the pause counter to be corrupted.
 - Set "pause-on-trace" for latency tracers as that option breaks
   their output (regression).
 - Fix the wrong error return for setting kretprobes on future
   modules (before they are loaded).
 - Fix re-registering the same kretprobe.
 - Add missing value check for added RCU variable reload.

Alexey Kardashevskiy (1):
      tracepoint: Fix race between tracing and removing tracepoint

Masami Hiramatsu (1):
      tracing/kprobe: Fix to support kretprobe events on unloaded modules

Steven Rostedt (VMware) (1):
      fgraph: Initialize tracing_graph_pause at task creation

Viktor Rosendahl (1):
      tracing: Use pause-on-trace with the latency tracers

Wang ShaoBo (1):
      kretprobe: Avoid re-registration of the same kretprobe earlier

----
 include/linux/kprobes.h      |  2 +-
 include/linux/tracepoint.h   | 12 +++++++-----
 init/init_task.c             |  3 ++-
 kernel/kprobes.c             | 36 ++++++++++++++++++++++++++++--------
 kernel/trace/fgraph.c        |  2 --
 kernel/trace/trace_irqsoff.c |  4 ++++
 kernel/trace/trace_kprobe.c  | 10 ++++++----
 7 files changed, 48 insertions(+), 21 deletions(-)
