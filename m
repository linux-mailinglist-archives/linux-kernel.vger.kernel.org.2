Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0E42FFCE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhJPDFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239627AbhJPDFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:05:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0DD60F59;
        Sat, 16 Oct 2021 03:02:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mbZyG-006ZSF-8Y; Fri, 15 Oct 2021 23:02:52 -0400
Message-ID: <20211016030252.100986733@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 15 Oct 2021 23:02:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Subject: [for-linus][PATCH 2/7] tracing: Fix memory leak in eprobe_register()
References: <20211016030222.926060517@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>

kmemleak report:
unreferenced object 0xffff900a70ec7ec0 (size 32):
  comm "ftracetest", pid 2770, jiffies 4295042510 (age 311.464s)
  hex dump (first 32 bytes):
    c8 31 23 45 0a 90 ff ff 40 85 c7 6e 0a 90 ff ff  .1#E....@..n....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009d3751fd>] kmem_cache_alloc_trace+0x2a2/0x440
    [<0000000088b8124b>] eprobe_register+0x1e3/0x350
    [<000000002a9a0517>] __ftrace_event_enable_disable+0x7c/0x240
    [<0000000019109321>] event_enable_write+0x93/0xe0
    [<000000007d85b320>] vfs_write+0xb9/0x260
    [<00000000b94c5e41>] ksys_write+0x67/0xe0
    [<000000005a08c81d>] __x64_sys_write+0x1a/0x20
    [<00000000240bf576>] do_syscall_64+0x3b/0xc0
    [<0000000043d5d9f6>] entry_SYSCALL_64_after_hwframe+0x44/0xae

unreferenced object 0xffff900a56bbf280 (size 128):
  comm "ftracetest", pid 2770, jiffies 4295042510 (age 311.464s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff 00 00 00 00 01 00 00 00  ................
    80 69 3b b2 ff ff ff ff 20 69 3b b2 ff ff ff ff  .i;..... i;.....
  backtrace:
    [<000000009d3751fd>] kmem_cache_alloc_trace+0x2a2/0x440
    [<00000000c4e90fad>] eprobe_register+0x1fc/0x350
    [<000000002a9a0517>] __ftrace_event_enable_disable+0x7c/0x240
    [<0000000019109321>] event_enable_write+0x93/0xe0
    [<000000007d85b320>] vfs_write+0xb9/0x260
    [<00000000b94c5e41>] ksys_write+0x67/0xe0
    [<000000005a08c81d>] __x64_sys_write+0x1a/0x20
    [<00000000240bf576>] do_syscall_64+0x3b/0xc0
    [<0000000043d5d9f6>] entry_SYSCALL_64_after_hwframe+0x44/0xae

In new_eprobe_trigger(), allocated edata and trigger variables are
never freed.

To fix, free memory in disable_eprobe().

Link: https://lkml.kernel.org/r/20211008071802.GA2098@cosmos

Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 3044b762cbd7..570d081929fb 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -632,6 +632,13 @@ static int disable_eprobe(struct trace_eprobe *ep,
 
 	trace_event_trigger_enable_disable(file, 0);
 	update_cond_flag(file);
+
+	/* Make sure nothing is using the edata or trigger */
+	tracepoint_synchronize_unregister();
+
+	kfree(edata);
+	kfree(trigger);
+
 	return 0;
 }
 
-- 
2.32.0
