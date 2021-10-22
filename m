Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5DB437F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhJVUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233872AbhJVUvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880EB6139F;
        Fri, 22 Oct 2021 20:48:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T3-000QY5-My;
        Fri, 22 Oct 2021 16:48:45 -0400
Message-ID: <20211022204845.551479656@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 40/40] ARM: Recover kretprobe modified return address in stacktrace
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the kretprobe replaces the function return address with
the kretprobe_trampoline on the stack, arm unwinder shows it
instead of the correct return address.

This finds the correct return address from the per-task
kretprobe_instances list and verify it is in between the
caller fp and callee fp.

Note that this supports both GCC and clang if CONFIG_FRAME_POINTER=y
and CONFIG_ARM_UNWIND=n. For the ARM unwinder, this is still
not working correctly.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm/Kconfig                  |  1 +
 arch/arm/include/asm/stacktrace.h |  9 +++++++++
 arch/arm/kernel/return_address.c  |  4 ++++
 arch/arm/kernel/stacktrace.c      | 14 ++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc196421b2ce..bb4f1872967c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 2d76a2e29f05..8f54f9ad8a9b 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -3,6 +3,7 @@
 #define __ASM_STACKTRACE_H
 
 #include <asm/ptrace.h>
+#include <linux/llist.h>
 
 struct stackframe {
 	/*
@@ -13,6 +14,10 @@ struct stackframe {
 	unsigned long sp;
 	unsigned long lr;
 	unsigned long pc;
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *kr_cur;
+	struct task_struct *tsk;
+#endif
 };
 
 static __always_inline
@@ -22,6 +27,10 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 		frame->sp = regs->ARM_sp;
 		frame->lr = regs->ARM_lr;
 		frame->pc = regs->ARM_pc;
+#ifdef CONFIG_KRETPROBES
+		frame->kr_cur = NULL;
+		frame->tsk = current;
+#endif
 }
 
 extern int unwind_frame(struct stackframe *frame);
diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 7b42ac010fdf..00c11579406c 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -42,6 +42,10 @@ void *return_address(unsigned int level)
 	frame.sp = current_stack_pointer;
 	frame.lr = (unsigned long)__builtin_return_address(0);
 	frame.pc = (unsigned long)return_address;
+#ifdef CONFIG_KRETPROBES
+	frame.kr_cur = NULL;
+	frame.tsk = current;
+#endif
 
 	walk_stackframe(&frame, save_return_addr, &data);
 
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index db798eac7431..75e905508f27 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/export.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/stacktrace.h>
@@ -65,6 +66,11 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
 #endif
+#ifdef CONFIG_KRETPROBES
+	if (is_kretprobe_trampoline(frame->pc))
+		frame->pc = kretprobe_find_ret_addr(frame->tsk,
+					(void *)frame->fp, &frame->kr_cur);
+#endif
 
 	return 0;
 }
@@ -156,6 +162,10 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		frame.lr = (unsigned long)__builtin_return_address(0);
 		frame.pc = (unsigned long)__save_stack_trace;
 	}
+#ifdef CONFIG_KRETPROBES
+	frame.kr_cur = NULL;
+	frame.tsk = tsk;
+#endif
 
 	walk_stackframe(&frame, save_trace, &data);
 }
@@ -173,6 +183,10 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.sp = regs->ARM_sp;
 	frame.lr = regs->ARM_lr;
 	frame.pc = regs->ARM_pc;
+#ifdef CONFIG_KRETPROBES
+	frame.kr_cur = NULL;
+	frame.tsk = current;
+#endif
 
 	walk_stackframe(&frame, save_trace, &data);
 }
-- 
2.33.0
