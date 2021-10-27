Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7843CF09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbhJ0Qxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243023AbhJ0Qx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:53:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6239860F38;
        Wed, 27 Oct 2021 16:51:03 +0000 (UTC)
Date:   Wed, 27 Oct 2021 12:51:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] ftrace/nds32: Update the proto for ftrace_trace_function to
 match ftrace_stub
Message-ID: <20211027125101.33449969@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ftrace callback prototype was changed to pass a special ftrace_regs
instead of pt_regs as the last parameter, but the static ftrace for nds32
missed updating ftrace_trace_function and this caused a warning when
compared to ftrace_stub:

../arch/nds32/kernel/ftrace.c: In function '_mcount':
../arch/nds32/kernel/ftrace.c:24:35: error: comparison of distinct pointer types lacks a cast [-Werror]
   24 |         if (ftrace_trace_function != ftrace_stub)
      |                                   ^~

Link: https://lore.kernel.org/all/20211027055554.19372-1-rdunlap@infradead.org/

Cc: stable@vger.kernel.org
Fixes: d19ad0775dcd6 ("ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/nds32/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index f0ef4842d191..711bc8cd186d 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -6,7 +6,7 @@
 
 #ifndef CONFIG_DYNAMIC_FTRACE
 extern void (*ftrace_trace_function)(unsigned long, unsigned long,
-				     struct ftrace_ops*, struct pt_regs*);
+				     struct ftrace_ops*, struct ftrace_regs*);
 extern void ftrace_graph_caller(void);
 
 noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
-- 
2.31.1

