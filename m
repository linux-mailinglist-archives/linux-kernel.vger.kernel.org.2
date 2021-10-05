Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F024229E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhJEOEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235553AbhJEOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:02:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A163D61AF0;
        Tue,  5 Oct 2021 13:58:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxi-0055sB-MZ; Tue, 05 Oct 2021 09:58:30 -0400
Message-ID: <20211005135830.538671740@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:58:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [for-linus][PATCH 27/27] x86/kprobes: Fixup return address in generic trampoline handler
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

In x86, the fake return address on the stack saved by
__kretprobe_trampoline() will be replaced with the real return
address after returning from trampoline_handler(). Before fixing
the return address, the real return address can be found in the
'current->kretprobe_instances'.

However, since there is a window between updating the
'current->kretprobe_instances' and fixing the address on the stack,
if an interrupt happens at that timing and the interrupt handler
does stacktrace, it may fail to unwind because it can not get
the correct return address from 'current->kretprobe_instances'.

This will eliminate that window by fixing the return address
right before updating 'current->kretprobe_instances'.

Link: https://lkml.kernel.org/r/163163057094.489837.9044470370440745866.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/kprobes/core.c | 18 ++++++++++++++++--
 include/linux/kprobes.h        |  3 +++
 kernel/kprobes.c               | 11 +++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7e1111c19605..fce99e249d61 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1065,6 +1065,16 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline);
  */
 STACK_FRAME_NON_STANDARD_FP(__kretprobe_trampoline);
 
+/* This is called from kretprobe_trampoline_handler(). */
+void arch_kretprobe_fixup_return(struct pt_regs *regs,
+				 kprobe_opcode_t *correct_ret_addr)
+{
+	unsigned long *frame_pointer = &regs->sp + 1;
+
+	/* Replace fake return address with real one. */
+	*frame_pointer = (unsigned long)correct_ret_addr;
+}
+
 /*
  * Called from __kretprobe_trampoline
  */
@@ -1082,8 +1092,12 @@ __used __visible void trampoline_handler(struct pt_regs *regs)
 	regs->sp += sizeof(long);
 	frame_pointer = &regs->sp + 1;
 
-	/* Replace fake return address with real one. */
-	*frame_pointer = kretprobe_trampoline_handler(regs, frame_pointer);
+	/*
+	 * The return address at 'frame_pointer' is recovered by the
+	 * arch_kretprobe_fixup_return() which called from the
+	 * kretprobe_trampoline_handler().
+	 */
+	kretprobe_trampoline_handler(regs, frame_pointer);
 
 	/*
 	 * Copy FLAGS to 'pt_regs::sp' so that __kretprobe_trapmoline()
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 6d47a9da1e0a..e974caf39d3e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -188,6 +188,9 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
 
+void arch_kretprobe_fixup_return(struct pt_regs *regs,
+				 kprobe_opcode_t *correct_ret_addr);
+
 void __kretprobe_trampoline(void);
 /*
  * Since some architecture uses structured function pointer,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ebc587b9a346..b62af9fc3607 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1922,6 +1922,15 @@ unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 }
 NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
 
+void __weak arch_kretprobe_fixup_return(struct pt_regs *regs,
+					kprobe_opcode_t *correct_ret_addr)
+{
+	/*
+	 * Do nothing by default. Please fill this to update the fake return
+	 * address on the stack with the correct one on each arch if possible.
+	 */
+}
+
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer)
 {
@@ -1967,6 +1976,8 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		first = first->next;
 	}
 
+	arch_kretprobe_fixup_return(regs, correct_ret_addr);
+
 	/* Unlink all nodes for this frame. */
 	first = current->kretprobe_instances.first;
 	current->kretprobe_instances.first = node->next;
-- 
2.32.0
