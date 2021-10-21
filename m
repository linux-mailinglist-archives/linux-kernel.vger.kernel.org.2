Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F62435800
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJUA54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhJUA5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:57:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D30CA610A1;
        Thu, 21 Oct 2021 00:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634777738;
        bh=6eQhPcwTPWL7PeCf0bKVrZpLNkk5pcOdMHPKs5Ym+g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9+x5zv9WtTOsbivSG/pjdDt5mXIU4Mh1kZkh3pe4zBu2EZUZkLOouAku/qxKnN+w
         oxOA0ul/OOxEJehWzMLgycFjChl7dlhhlAB8vra4pgxDpVlwNYrNgZ82xvfHxZI4hO
         XA8XOLY++TmmE5w+F5lq+KS7A6gkTGaCMGMrK1AJUk0lLV4wvr/LdFy09xvkGX4hh7
         LLhuIE0CBl6TuD8lCvTxKCPm8S6UFmuWVU/KZliKcI08S/lLy41Gt3FcqdLOBxPJjA
         GYE3BS3YlC0RBzzFxhZlIZocyihVl3VtANM6xfI7duqGkt6zckxcC/SWqqg7kqKVPc
         cuoaDTjBN5DFw==
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
Subject: [PATCH v3 9/9] ARM: Recover kretprobe modified return address in stacktrace
Date:   Thu, 21 Oct 2021 09:55:35 +0900
Message-Id: <163477773485.264901.16493228156732269861.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163477765570.264901.3851692300287671122.stgit@devnote2>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
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

