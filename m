Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EEB43B70C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhJZQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234019AbhJZQ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331CE60527;
        Tue, 26 Oct 2021 16:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEp-000qNF-FR;
        Tue, 26 Oct 2021 12:23:47 -0400
Message-ID: <20211026162315.297389528@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: More updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 384c54408efaa4b3298f42e54b8048b8045f253a


Daniel Bristot de Oliveira (4):
      trace/osnoise: Fix an ifdef comment
      tracing/doc: Fix typos on the timerlat tracer documentation
      trace/osnoise: Add migrate-disabled field to the osnoise header
      trace/timerlat: Add migrate-disabled field to the timerlat header

Masami Hiramatsu (2):
      lib/bootconfig: Make xbc_alloc_mem() and xbc_free_mem() as __init function
      kprobes: Add a test case for stacktrace from kretprobe handler

Mathieu Desnoyers (1):
      tracing: Fix missing trace_boot_init_histograms kstrdup NULL checks

Song Liu (1):
      perf/core: allow ftrace for functions in kernel/event/core.c

Viktor Rosendahl (1):
      tools/latency-collector: Use correct size when writing queue_full_warning

Wang ShaoBo (1):
      tracing/hwlat: Make some internal symbols static

chongjiapeng (1):
      ftrace: Make ftrace_profile_pages_init static

linux-sh@vger.kernel.org (1):
      ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed image still link

----
 Documentation/trace/timerlat-tracer.rst   |  24 ++---
 arch/Kconfig                              |   8 ++
 arch/sh/boot/compressed/misc.c            |   3 +
 arch/x86/Kconfig                          |   1 +
 arch/x86/kernel/trace.c                   |   2 +-
 kernel/events/Makefile                    |   5 -
 kernel/test_kprobes.c                     | 162 ++++++++++++++++++++++++++++++
 kernel/trace/ftrace.c                     |   2 +-
 kernel/trace/trace_boot.c                 |   4 +
 kernel/trace/trace_hwlat.c                |   4 +-
 kernel/trace/trace_osnoise.c              |  25 ++---
 lib/bootconfig.c                          |   4 +-
 tools/tracing/latency/latency-collector.c |   2 +-
 13 files changed, 210 insertions(+), 36 deletions(-)
