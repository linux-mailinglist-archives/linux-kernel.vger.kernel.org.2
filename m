Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9C426AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhJHMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241795AbhJHMbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4736260FD8;
        Fri,  8 Oct 2021 12:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696168;
        bh=8KEq6p7WetumdXoHhpIIywuWI4pHhMiVHABA49TNKEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlIth+cPvKMGPoy44bX7uS9Zx6f1dW4W7I7mMO4gM4knLY4ejOFezNcwFVtcfUuHl
         n8zueouGrKXoVLVaUBBgO8KMZrJlReZ+M9fEkJ/M7StH7rC+q0UAw/ZK23wZWLLtAW
         c6X0IHj8jmknLGNRGtp0ANBMNUKhYhRd7nFyMro4VChWk8vY73Jp6+xmG1ZZxY3k0e
         JxZcNZ/OxwtuzjHic1Ezg+8dyz+DrexuI+Xxtx0AE7rbAbEVcL36sa69genddR23Wd
         kl0PVrDHqfAAlF8ganiNSJ5t0BXATj2lqHP2wEIhZzkivXODaH/zRQ9ymdA4iBPrrY
         AbcdkYfzN89Ng==
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
Subject: [PATCH 8/8] ARM: Recover kretprobe modified return address in stacktrace
Date:   Fri,  8 Oct 2021 21:29:26 +0900
Message-Id: <163369616584.636038.13479045721903402698.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163369609308.636038.15295764725220907794.stgit@devnote2>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
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
 arch/arm/Kconfig                  |    1 +
 arch/arm/include/asm/stacktrace.h |    5 +++++
 arch/arm/kernel/return_address.c  |    2 ++
 arch/arm/kernel/stacktrace.c      |    8 ++++++++
 4 files changed, 16 insertions(+)

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
index 2d76a2e29f05..3c23abe935f2 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -3,6 +3,7 @@
 #define __ASM_STACKTRACE_H
 
 #include <asm/ptrace.h>
+#include <linux/llist.h>
 
 struct stackframe {
 	/*
@@ -13,6 +14,8 @@ struct stackframe {
 	unsigned long sp;
 	unsigned long lr;
 	unsigned long pc;
+	struct llist_node *kr_cur;
+	struct task_struct *tsk;
 };
 
 static __always_inline
@@ -22,6 +25,8 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 		frame->sp = regs->ARM_sp;
 		frame->lr = regs->ARM_lr;
 		frame->pc = regs->ARM_pc;
+		frame->kr_cur = NULL;
+		frame->tsk = current;
 }
 
 extern int unwind_frame(struct stackframe *frame);
diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index 7b42ac010fdf..6fea64d74ebc 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -42,6 +42,8 @@ void *return_address(unsigned int level)
 	frame.sp = current_stack_pointer;
 	frame.lr = (unsigned long)__builtin_return_address(0);
 	frame.pc = (unsigned long)return_address;
+	frame.tsk = current;
+	frame.kr_cur = NULL;
 
 	walk_stackframe(&frame, save_return_addr, &data);
 
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index db798eac7431..7022dda02b93 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/export.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/stacktrace.h>
@@ -65,6 +66,9 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
 #endif
+	if (is_kretprobe_trampoline(frame->pc))
+		frame->pc = kretprobe_find_ret_addr(frame->tsk,
+					(void *)frame->fp, &frame->kr_cur);
 
 	return 0;
 }
@@ -156,6 +160,8 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
 		frame.lr = (unsigned long)__builtin_return_address(0);
 		frame.pc = (unsigned long)__save_stack_trace;
 	}
+	frame.kr_cur = NULL;
+	frame.tsk = tsk;
 
 	walk_stackframe(&frame, save_trace, &data);
 }
@@ -173,6 +179,8 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	frame.sp = regs->ARM_sp;
 	frame.lr = regs->ARM_lr;
 	frame.pc = regs->ARM_pc;
+	frame.kr_cur = NULL;
+	frame.tsk = current;
 
 	walk_stackframe(&frame, save_trace, &data);
 }

