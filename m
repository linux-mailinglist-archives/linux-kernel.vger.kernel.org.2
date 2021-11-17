Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77357454834
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhKQOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:11:18 -0500
Received: from foss.arm.com ([217.140.110.172]:57388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238251AbhKQOLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:11:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B396143B;
        Wed, 17 Nov 2021 06:08:16 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E80393F70D;
        Wed, 17 Nov 2021 06:08:13 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, borntraeger@de.ibm.com, bp@alien8.de,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 8/9] arm64: Make dump_backtrace() use arch_stack_walk()
Date:   Wed, 17 Nov 2021 14:07:36 +0000
Message-Id: <20211117140737.44420-9-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117140737.44420-1-mark.rutland@arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

To enable RELIABLE_STACKTRACE and LIVEPATCH on arm64, we need to
substantially rework arm64's unwinding code. As part of this, we want to
minimize the set of unwind interfaces we expose, and avoid open-coding
of unwind logic.

Currently, dump_backtrace() walks the stack of the current task or a
blocked task by calling stact_backtrace() and iterating unwind steps
using unwind_frame(). This can be written more simply in terms of
arch_stack_walk(), considering three distinct cases:

1) When unwinding a blocked task, start_backtrace() is called with the
   blocked task's saved PC and FP, and the unwind proceeds immediately
   from this point without skipping any entries. This is functionally
   equivalent to calling arch_stack_walk() with the blocked task, which
   will start with the task's saved PC and FP.

   There is no functional change to this case.

2) When unwinding the current task without regs, start_backtrace() is
   called with dump_backtrace() as the PC and __builtin_frame_address(0)
   as the next frame, and the unwind proceeds immediately without
   skipping. This is *almost* functionally equivalent to calling
   arch_stack_walk() for the current task, which will start with its
   caller (i.e. an offset into dump_backtrace()) as the PC, and the
   callers frame record as the next frame.

   The only difference being that dump_backtrace() will be reported with
   an offset (which is strictly more correct than currently). Otherwise
   there is no functional cahnge to this case.

3) When unwinding the current task with regs, start_backtrace() is
   called with dump_backtrace() as the PC and __builtin_frame_address(0)
   as the next frame, and the unwind is performed silently until the
   next frame is the frame pointed to by regs->fp. Reporting starts
   from regs->pc and continues from the frame in regs->fp.

   Historically, this pre-unwind was necessary to correctly record
   return addresses rewritten by the ftrace graph calller, but this is
   no longer necessary as these are now recovered using the FP since
   commit:

   c6d3cd32fd0064af ("arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR")

   This pre-unwind is not necessary to recover return addresses
   rewritten by kretprobes, which historically were not recovered, and
   are now recovered using the FP since commit:

   cd9bc2c9258816dc ("arm64: Recover kretprobe modified return address in stacktrace")

   Thus, this is functionally equivalent to calling arch_stack_walk()
   with the current task and regs, which will start with regs->pc as the
   PC and regs->fp as the next frame, without a pre-unwind.

This patch makes dump_backtrace() use arch_stack_walk(). This simplifies
dump_backtrace() and will permit subsequent changes to the unwind code.

Aside from the improved reporting when unwinding current without regs,
there should be no functional change as a result of this patch.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
[Mark: elaborate commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/stacktrace.c | 44 ++++++------------------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index e6ba6b000564..9fc771a05306 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -156,24 +156,20 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 }
 NOKPROBE_SYMBOL(walk_stackframe);
 
-static void dump_backtrace_entry(unsigned long where, const char *loglvl)
+static bool dump_backtrace_entry(void *arg, unsigned long where)
 {
+	char *loglvl = arg;
 	printk("%s %pSb\n", loglvl, (void *)where);
+	return true;
 }
 
 void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		    const char *loglvl)
 {
-	struct stackframe frame;
-	int skip = 0;
-
 	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
 
-	if (regs) {
-		if (user_mode(regs))
-			return;
-		skip = 1;
-	}
+	if (regs && user_mode(regs))
+		return;
 
 	if (!tsk)
 		tsk = current;
@@ -181,36 +177,8 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 	if (!try_get_task_stack(tsk))
 		return;
 
-	if (tsk == current) {
-		start_backtrace(&frame,
-				(unsigned long)__builtin_frame_address(0),
-				(unsigned long)dump_backtrace);
-	} else {
-		/*
-		 * task blocked in __switch_to
-		 */
-		start_backtrace(&frame,
-				thread_saved_fp(tsk),
-				thread_saved_pc(tsk));
-	}
-
 	printk("%sCall trace:\n", loglvl);
-	do {
-		/* skip until specified stack frame */
-		if (!skip) {
-			dump_backtrace_entry(frame.pc, loglvl);
-		} else if (frame.fp == regs->regs[29]) {
-			skip = 0;
-			/*
-			 * Mostly, this is the case where this function is
-			 * called in panic/abort. As exception handler's
-			 * stack frame does not contain the corresponding pc
-			 * at which an exception has taken place, use regs->pc
-			 * instead.
-			 */
-			dump_backtrace_entry(regs->pc, loglvl);
-		}
-	} while (!unwind_frame(tsk, &frame));
+	arch_stack_walk(dump_backtrace_entry, (void *)loglvl, tsk, regs);
 
 	put_task_stack(tsk);
 }
-- 
2.11.0

