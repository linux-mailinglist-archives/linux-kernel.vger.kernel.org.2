Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74B437FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhJVUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234379AbhJVUvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA80613DA;
        Fri, 22 Oct 2021 20:48:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T3-000QWO-5T;
        Fri, 22 Oct 2021 16:48:45 -0400
Message-ID: <20211022204845.011753459@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 37/40] arm64: Recover kretprobe modified return address in stacktrace
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the kretprobe replaces the function return address with
the kretprobe_trampoline on the stack, stack unwinder shows it
instead of the correct return address.

This checks whether the next return address is the
__kretprobe_trampoline(), and if so, try to find the correct
return address from the kretprobe instance list. For this purpose
this adds 'kr_cur' loop cursor to memorize the current kretprobe
instance.

With this fix, now arm64 can enable
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
kprobe self tests.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/Kconfig                  | 1 +
 arch/arm64/include/asm/stacktrace.h | 4 ++++
 arch/arm64/kernel/stacktrace.c      | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..edde5171ffb2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -11,6 +11,7 @@ config ARM64
 	select ACPI_PPTT if ACPI
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 8aebc00c1718..a4e046ef4568 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/types.h>
+#include <linux/llist.h>
 
 #include <asm/memory.h>
 #include <asm/ptrace.h>
@@ -59,6 +60,9 @@ struct stackframe {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int graph;
 #endif
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *kr_cur;
+#endif
 };
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 8982a2b78acf..c30624fff6ac 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -41,6 +41,9 @@ void start_backtrace(struct stackframe *frame, unsigned long fp,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame->graph = 0;
 #endif
+#ifdef CONFIG_KRETPROBES
+	frame->kr_cur = NULL;
+#endif
 
 	/*
 	 * Prime the first unwind.
@@ -129,6 +132,10 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 		frame->pc = ret_stack->ret;
 	}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+#ifdef CONFIG_KRETPROBES
+	if (is_kretprobe_trampoline(frame->pc))
+		frame->pc = kretprobe_find_ret_addr(tsk, (void *)frame->fp, &frame->kr_cur);
+#endif
 
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
 
-- 
2.33.0
