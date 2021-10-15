Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CAC42F175
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbhJOMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235793AbhJOMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0BE360230;
        Fri, 15 Oct 2021 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302329;
        bh=6eQhPcwTPWL7PeCf0bKVrZpLNkk5pcOdMHPKs5Ym+g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0HJxPsoPmofnkEevWSCquKWYTveY+4/knPL9GnpoTUYrLgtm9PCbQV3VLBihKAXU
         90V8KNHFcWpAQHxPhFNz7FZsPGl9utoCpIIaXmLxz5PTFdc9ddu0BJT4vP4O/2f3xc
         nSnu1hJbSJSwkHoSfm5UVIN3GiXeNTKY3eXyDSOYeZVGM6Ov3PC3q7FJ8glFFq+OHF
         V8w+jqXnJ8HMw1d4Pqw191j7fHJSX9O7irtYBNvqAJ0WD7gpugeViu8dP1Thj+wVNy
         IbMwZtb1Aozkf9idA8lW0Wo6r0AddCvzNo1lLhRgcIAQ2i/Q8vWuSsJkCsp5Cbnx1U
         AujxEWst0a/aw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/10] ARM: Recover kretprobe modified return address in stacktrace
Date:   Fri, 15 Oct 2021 21:52:04 +0900
Message-Id: <163430232448.459050.59665093997557853.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163430224341.459050.2369208860773018092.stgit@devnote2>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Changes in v2:
  - Compile this code only when CONFIG_KRETPROBES=y
---
 arch/arm/Kconfig                  |    1 +
 arch/arm/include/asm/stacktrace.h |    9 +++++++++
 arch/arm/kernel/return_address.c  |    4 ++++
 arch/arm/kernel/stacktrace.c      |   14 ++++++++++++++
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

