Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5CB3D3AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhGWMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234853AbhGWMQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:16:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85A6B60E53;
        Fri, 23 Jul 2021 12:56:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m6ujB-001hfj-EJ; Fri, 23 Jul 2021 08:56:33 -0400
Message-ID: <20210723125454.570472450@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Jul 2021 08:54:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Haoran Luo <www@aegistudio.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [for-linus][PATCH 0/7] tracing: Fixes for 5.14-rc2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


- Fix deadloop in ring buffer because of using stale "read" variable

- Fix synthetic event use of field_pos as boolean and not an index

- Fixed histogram special var "cpu" overriding event fields called "cpu"

- Cleaned up error prone logic in alloc_synth_event()

- Removed call to synchronize_rcu_tasks_rude() when not needed

- Removed redundant initialization of a local variable "ret"

- Fixed kernel crash when updating tracepoint callbacks of different
  priorities.


Colin Ian King (1):
      ftrace: Remove redundant initialization of variable ret

Haoran Luo (1):
      tracing: Fix bug in rb_per_cpu_empty() that might cause deadloop.

Nicolas Saenz Julienne (1):
      ftrace: Avoid synchronize_rcu_tasks_rude() call when not necessary

Steven Rostedt (VMware) (4):
      tracing: Synthetic event field_pos is an index not a boolean
      tracing/histogram: Rename "cpu" to "common_cpu"
      tracing: Clean up alloc_synth_event()
      tracepoints: Update static_call before tp_funcs when adding a tracepoint

----
 Documentation/trace/histogram.rst |  2 +-
 kernel/trace/ftrace.c             |  5 +++--
 kernel/trace/ring_buffer.c        | 28 ++++++++++++++++++++++++----
 kernel/trace/trace.c              |  4 ++++
 kernel/trace/trace_events_hist.c  | 22 ++++++++++++++++------
 kernel/trace/trace_events_synth.c |  8 +++-----
 kernel/trace/trace_synth.h        |  2 +-
 kernel/tracepoint.c               |  2 +-
 8 files changed, 53 insertions(+), 20 deletions(-)
