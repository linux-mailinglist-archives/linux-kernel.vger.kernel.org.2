Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856E642FFCF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbhJPDFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239692AbhJPDFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:05:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFED361108;
        Sat, 16 Oct 2021 03:02:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mbZyF-006ZR5-Ri; Fri, 15 Oct 2021 23:02:51 -0400
Message-ID: <20211016030222.926060517@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 15 Oct 2021 23:02:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: Fixes for 5.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 5.15:

 - Fix defined but not use warning/error for osnoise function

 - Fix memory leak in event probe

 - Fix memblock leak in bootconfig

 - Fix the API of event probes to be like kprobes

 - Added test to check removal of event probe API

 - Fix recordmcount.pl for nds32 failed build



Colin Ian King (1):
      tracing: Fix missing * in comment block

Jackie Liu (1):
      tracing: Fix missing osnoise tracer on max_latency

Masami Hiramatsu (1):
      bootconfig: init: Fix memblock leak in xbc_make_cmdline()

Steven Rostedt (1):
      nds32/ftrace: Fix Error: invalid operands (*UND* and *UND* sections) for `^'

Steven Rostedt (VMware) (2):
      tracing: Fix event probe removal from dynamic events
      selftests/ftrace: Update test for more eprobe removal process

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leak in eprobe_register()

----
 init/main.c                                        |  1 +
 kernel/trace/trace.c                               | 11 ++--
 kernel/trace/trace_eprobe.c                        | 61 ++++++++++++++++++++--
 kernel/trace/trace_events_hist.c                   |  2 +-
 scripts/recordmcount.pl                            |  2 +-
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    | 54 ++++++++++++++++++-
 6 files changed, 117 insertions(+), 14 deletions(-)
