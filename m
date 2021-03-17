Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB733F7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhCQSN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232935AbhCQSMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6791564F33;
        Wed, 17 Mar 2021 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616004772;
        bh=Icp/cYoFHMBtskkD1rj4x9Ue/4Wu0XZnKNzIx2xWvHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGsKoYw9AUYS7NYxd9zYfjNmR3e4L/M6HeCAgQKnApcUIaJKV+AZ/TFXSWXsV6O9c
         0zch8Jpvnf1Fu5IE1akAuh6bOkm1TKUX9QLbjdfKckDuo5T2kKqZCfS8t6QoPAlOVg
         tTafwWPK7j0S+viZFtKwcrd7TP5SeQsI87Uqu4i/NDBbf0WMv335vDWxjNy+ohwSi5
         6mB0oU27r0TNHo+D7+Nvhew72FfbJqr1FZZ45pcWc+7ai6uGeQLMzHoISJ0Hpkj4rk
         GL8Ln8qXf8ydjJRr8PYC98E9mHE7V4TL/nhuiemgD5vlQa48zEWk1OZ4D8axeUt4vD
         mLoikWuoTrIwg==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 3/9] x86/entry: Convert ret_from_fork to C
Date:   Wed, 17 Mar 2021 11:12:42 -0700
Message-Id: <f7ed7fa5b222afa2d2820e1d8c83fdc3fdd57af2.1616004689.git.luto@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret_from_fork is written in asm, slightly differently, for x86_32 and
x86_64.  Convert it to C.

This is a straight conversion without any particular cleverness.  As a
further cleanup, the code that sets up the ret_from_fork argument registers
could be adjusted to put the arguments in the correct registers.

This will cause the ORC unwinder to find pt_regs even for kernel threads on
x86_64.  This seems harmless.

The 32-bit comment above the now-deleted schedule_tail_wrapper was
obsolete: the encode_frame_pointer mechanism (see copy_thread()) solves the
same problem more cleanly.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c          | 23 ++++++++++++++
 arch/x86/entry/entry_32.S        | 51 +++++---------------------------
 arch/x86/entry/entry_64.S        | 33 +++++----------------
 arch/x86/include/asm/switch_to.h |  2 +-
 arch/x86/kernel/process.c        |  2 +-
 arch/x86/kernel/process_32.c     |  2 +-
 arch/x86/kernel/unwind_orc.c     |  2 +-
 7 files changed, 43 insertions(+), 72 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 95776f16c1cb..ef1c65938a6b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -214,6 +214,29 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
+void ret_from_fork(struct task_struct *prev,
+		   int (*kernel_thread_fn)(void *),
+		   void *kernel_thread_arg,
+		   struct pt_regs *user_regs);
+
+__visible void noinstr ret_from_fork(struct task_struct *prev,
+				     int (*kernel_thread_fn)(void *),
+				     void *kernel_thread_arg,
+				     struct pt_regs *user_regs)
+{
+	instrumentation_begin();
+
+	schedule_tail(prev);
+
+	if (kernel_thread_fn) {
+		kernel_thread_fn(kernel_thread_arg);
+		user_regs->ax = 0;
+	}
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(user_regs);
+}
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017e6161..7113d259727f 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -805,26 +805,6 @@ SYM_CODE_START(__switch_to_asm)
 SYM_CODE_END(__switch_to_asm)
 .popsection
 
-/*
- * The unwinder expects the last frame on the stack to always be at the same
- * offset from the end of the page, which allows it to validate the stack.
- * Calling schedule_tail() directly would break that convention because its an
- * asmlinkage function so its argument has to be pushed on the stack.  This
- * wrapper creates a proper "end of stack" frame header before the call.
- */
-.pushsection .text, "ax"
-SYM_FUNC_START(schedule_tail_wrapper)
-	FRAME_BEGIN
-
-	pushl	%eax
-	call	schedule_tail
-	popl	%eax
-
-	FRAME_END
-	ret
-SYM_FUNC_END(schedule_tail_wrapper)
-.popsection
-
 /*
  * A newly forked process directly context switches into this address.
  *
@@ -833,29 +813,14 @@ SYM_FUNC_END(schedule_tail_wrapper)
  * edi: kernel thread arg
  */
 .pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
-	call	schedule_tail_wrapper
-
-	testl	%ebx, %ebx
-	jnz	1f		/* kernel threads are uncommon */
-
-2:
-	/* When we fork, we trace the syscall return in the child, too. */
-	movl    %esp, %eax
-	call    syscall_exit_to_user_mode
-	jmp     .Lsyscall_32_done
-
-	/* kernel thread */
-1:	movl	%edi, %eax
-	CALL_NOSPEC ebx
-	/*
-	 * A kernel thread is allowed to return here after successfully
-	 * calling kernel_execve().  Exit to userspace to complete the execve()
-	 * syscall.
-	 */
-	movl	$0, PT_EAX(%esp)
-	jmp	2b
-SYM_CODE_END(ret_from_fork)
+SYM_CODE_START(asm_ret_from_fork)
+	movl	%ebx, %edx
+	movl	%edi, %ecx
+	pushl	%esp
+	call	ret_from_fork
+	addl	$4, %esp
+	jmp	.Lsyscall_32_done
+SYM_CODE_END(asm_ret_from_fork)
 .popsection
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad08703c4ad..0f7df8861ac1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -273,35 +273,18 @@ SYM_FUNC_END(__switch_to_asm)
  * rax: prev task we switched from
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
+ * rbp: encoded frame pointer for the fp unwinder
  */
 .pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
-	UNWIND_HINT_EMPTY
-	movq	%rax, %rdi
-	call	schedule_tail			/* rdi: 'prev' task parameter */
-
-	testq	%rbx, %rbx			/* from kernel_thread? */
-	jnz	1f				/* kernel threads are uncommon */
-
-2:
+SYM_CODE_START(asm_ret_from_fork)
 	UNWIND_HINT_REGS
-	movq	%rsp, %rdi
-	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
+	movq	%rax, %rdi
+	movq	%rbx, %rsi
+	movq	%r12, %rdx
+	movq	%rsp, %rcx
+	call	ret_from_fork
 	jmp	swapgs_restore_regs_and_return_to_usermode
-
-1:
-	/* kernel thread */
-	UNWIND_HINT_EMPTY
-	movq	%r12, %rdi
-	CALL_NOSPEC rbx
-	/*
-	 * A kernel thread is allowed to return here after successfully
-	 * calling kernel_execve().  Exit to userspace to complete the execve()
-	 * syscall.
-	 */
-	movq	$0, RAX(%rsp)
-	jmp	2b
-SYM_CODE_END(ret_from_fork)
+SYM_CODE_END(asm_ret_from_fork)
 .popsection
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 9f69cc497f4b..fcb9b02a1269 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -12,7 +12,7 @@ struct task_struct *__switch_to_asm(struct task_struct *prev,
 __visible struct task_struct *__switch_to(struct task_struct *prev,
 					  struct task_struct *next);
 
-asmlinkage void ret_from_fork(void);
+asmlinkage void asm_ret_from_fork(void);
 
 /*
  * This is the structure pointed to by thread.sp for an inactive task.  The
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f6f16df04cb9..34efbca08738 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -135,7 +135,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame = &fork_frame->frame;
 
 	frame->bp = encode_frame_pointer(childregs);
-	frame->ret_addr = (unsigned long) ret_from_fork;
+	frame->ret_addr = (unsigned long) asm_ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e1281c..bf8aa15ac652 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -151,7 +151,7 @@ EXPORT_SYMBOL_GPL(start_thread);
  * more flexibility.
  *
  * The return value (in %ax) will be the "prev" task after
- * the task-switch, and shows up in ret_from_fork in entry.S,
+ * the task-switch, and shows up in asm_ret_from_fork in entry_32.S,
  * for example.
  */
 __visible __notrace_funcgraph struct task_struct *
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 73f800100066..c6e7235c6d9f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -659,7 +659,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
-		state->signal = (void *)state->ip == ret_from_fork;
+		state->signal = (void *)state->ip == asm_ret_from_fork;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
-- 
2.30.2

