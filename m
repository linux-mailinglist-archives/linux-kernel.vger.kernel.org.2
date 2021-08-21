Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA33F3B03
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhHUOaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 10:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhHUOav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:30:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83F761206;
        Sat, 21 Aug 2021 14:30:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHS0g-004wmN-PY; Sat, 21 Aug 2021 10:30:10 -0400
Message-ID: <20210821142904.655644298@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 21 Aug 2021 10:29:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [for-next][PATCH 0/6] tracing: Event probes for 5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 297e1dcdca3d7f268ccfb175d0a3534bb9481303


Steven Rostedt (VMware) (5):
      selftests/ftrace: Add clear_dynamic_events() to test cases
      selftests/ftrace: Fix requirement check of README file
      selftests/ftrace: Add test case to test adding and removing of event probe
      selftests/ftrace: Add selftest for testing eprobe events on synthetic events
      selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes

Tzvetomir Stoyanov (VMware) (1):
      tracing: Add a probe that attaches to trace events

----
 include/linux/trace_events.h                       |   4 +
 kernel/trace/Makefile                              |   1 +
 kernel/trace/trace.c                               |   5 +-
 kernel/trace/trace.h                               |  18 +
 kernel/trace/trace_eprobe.c                        | 903 +++++++++++++++++++++
 kernel/trace/trace_events_trigger.c                |  14 +-
 kernel/trace/trace_kprobe.c                        |   8 -
 kernel/trace/trace_probe.c                         |  16 +-
 kernel/trace/trace_probe.h                         |   6 +-
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  40 +
 .../ftrace/test.d/dynevent/test_duplicates.tc      |  38 +
 tools/testing/selftests/ftrace/test.d/functions    |  24 +-
 .../inter-event/trigger-synthetic-eprobe.tc        |  53 ++
 13 files changed, 1116 insertions(+), 14 deletions(-)
 create mode 100644 kernel/trace/trace_eprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
