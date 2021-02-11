Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F0318374
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBKCKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhBKCKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:10:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B597664EBB;
        Thu, 11 Feb 2021 02:09:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QS-00BATC-Gz; Wed, 10 Feb 2021 21:09:48 -0500
Message-ID: <20210211020927.829775774@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: Updates for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinyang He (1):
      ftrace: Remove unused ftrace_force_update()

Masami Hiramatsu (2):
      kprobes: Warn if the kprobe is reregistered
      tracing/dynevent: Delegate parsing to create function

Steven Rostedt (VMware) (4):
      tracing: Do not create "enable" or "filter" files for ftrace event subsystem
      tracepoints: Remove unnecessary "data_args" macro parameter
      tracepoints: Do not punish non static call users
      tracepoints: Code clean up

Tom Zanussi (5):
      tracing: Rework synthetic event command parsing
      tracing: Update synth command errors
      tracing: Add a backward-compatibility check for synthetic event creation
      selftests/ftrace: Update synthetic event syntax errors
      selftests/ftrace: Add '!event' synthetic event syntax check

----
 include/linux/ftrace.h                             |   2 -
 include/linux/tracepoint.h                         |  54 ++--
 kernel/kprobes.c                                   |  13 +-
 kernel/trace/trace.c                               |  23 +-
 kernel/trace/trace.h                               |   3 +-
 kernel/trace/trace_dynevent.c                      |  35 ++-
 kernel/trace/trace_dynevent.h                      |   4 +-
 kernel/trace/trace_events.c                        |  22 +-
 kernel/trace/trace_events_synth.c                  | 320 +++++++++++++++------
 kernel/trace/trace_kprobe.c                        |  33 ++-
 kernel/trace/trace_probe.c                         |  17 ++
 kernel/trace/trace_probe.h                         |   1 +
 kernel/trace/trace_uprobe.c                        |  17 +-
 kernel/tracepoint.c                                |  91 +++---
 .../inter-event/trigger-synthetic-event-syntax.tc  |   4 +
 .../trigger-synthetic_event_syntax_errors.tc       |  35 ++-
 16 files changed, 413 insertions(+), 261 deletions(-)
