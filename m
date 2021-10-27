Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB443CFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbhJ0Ran (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhJ0Ram (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:30:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3AC660E74;
        Wed, 27 Oct 2021 17:28:15 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:28:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] ftrace/nds32: Update the proto for ftrace_trace_function
 to match ftrace_stub
Message-ID: <20211027132813.1e365f18@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Fix nds32le build when DYNAMIC_FTRACE is disabled

A randconfig found that nds32le architecture fails to build due
to a prototype mismatch between a ftrace function pointer and
the function it was to be assigned to. That function pointer prototype
missed being updated when all the ftrace callbacks were updated.


Please pull the latest trace-v5.15-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-rc6

Tag SHA1: 832b54f439525d3b853698ac77fa1be977452a3b
Head SHA1: 4e84dc47bb48accbbeeba4e6bb3f31aa7895323c


Steven Rostedt (VMware) (1):
      ftrace/nds32: Update the proto for ftrace_trace_function to match ftrace_stub

----
 arch/nds32/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 4e84dc47bb48accbbeeba4e6bb3f31aa7895323c
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Oct 27 12:51:01 2021 -0400

    ftrace/nds32: Update the proto for ftrace_trace_function to match ftrace_stub
    
    The ftrace callback prototype was changed to pass a special ftrace_regs
    instead of pt_regs as the last parameter, but the static ftrace for nds32
    missed updating ftrace_trace_function and this caused a warning when
    compared to ftrace_stub:
    
    ../arch/nds32/kernel/ftrace.c: In function '_mcount':
    ../arch/nds32/kernel/ftrace.c:24:35: error: comparison of distinct pointer types lacks a cast [-Werror]
       24 |         if (ftrace_trace_function != ftrace_stub)
          |                                   ^~
    
    Link: https://lore.kernel.org/all/20211027055554.19372-1-rdunlap@infradead.org/
    Link: https://lkml.kernel.org/r/20211027125101.33449969@gandalf.local.home
    
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Nick Hu <nickhu@andestech.com>
    Cc: Greentime Hu <green.hu@gmail.com>
    Cc: Vincent Chen <deanbo422@gmail.com>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: stable@vger.kernel.org
    Fixes: d19ad0775dcd6 ("ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs")
    Reported-by: Randy Dunlap <rdunlap@infradead.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index 0e23e3a8df6b..d55b73b18149 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -6,7 +6,7 @@
 
 #ifndef CONFIG_DYNAMIC_FTRACE
 extern void (*ftrace_trace_function)(unsigned long, unsigned long,
-				     struct ftrace_ops*, struct pt_regs*);
+				     struct ftrace_ops*, struct ftrace_regs*);
 extern void ftrace_graph_caller(void);
 
 noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
