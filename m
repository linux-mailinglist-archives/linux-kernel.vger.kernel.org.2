Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36930E210
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhBCSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhBCSKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:10:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FD9364F92;
        Wed,  3 Feb 2021 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612375803;
        bh=ezVrT4aCog+5w29W1RlxMcLllX7Aun8R1GSYs29xX6A=;
        h=From:To:Cc:Subject:Date:From;
        b=NjNGDhYkDkgvpOw1aNa/fT8DIxScOgSOZdKfqmFaCECkawKh8cTMNjmpcJf/4GBmN
         HResyY53+wuRQLc338UijyiEkODJmXsyq+kJQRCrz+3Is4yayKuminMFQUvloGSGrY
         mivAPFF1jgMsnLAIssbmS/LV7oVr6z96n30oFUyRbtYG92Fs+2YqJJYVbF/uGriZ9T
         cFVypYLp/2ORwlhOSr6QEkPJX0CTUfHxoUheMSHpzynjrk5vpPhleouIGdBGXnS/PL
         j30OHze0bHZWj2gLTYVG53WsUJr1DxW8SVT4NybyptEFohsOUfcXSF6WXFQ4obM90R
         zWR3jGhovpVkQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] x86/ptrace: Clean up PTRACE_GETREGS/PTRACE_PUTREGS regset selection
Date:   Wed,  3 Feb 2021 10:09:58 -0800
Message-Id: <9daa791d0c7eaebd59c5bc2b2af1b0e7bebe707d.1612375698.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_user_regset_view() has nonsensical semantics, but those semantics
appear to be relied on by existing users of PTRACE_GETREGSET and
PTRACE_SETREGSET.  (See added comments in this patch for details.)

It shouldn't be used for PTRACE_GETREGS or PTRACE_SETREGS, though.  A
native 64-bit ptrace() call and an x32 ptrace() call using GETREGS or
SETREGS wants the 64-bit regset views, and a 32-bit ptrace() call
(native or compat) should use the 32-bit regset.
task_user_regset_view() almost does this except that it will
malfunction if a ptracer is itself ptraced and the outer ptracer
modifies CS on entry to a ptrace() syscall.  Hopefully that has never
happened.  (The compat ptrace() code already hardcoded the 32-bit
regset, so this patch has no effect on that path.)

Improve the situation and deobfuscate the code by hardcoding the
64-bit view in the x32 ptrace() and selecting the view based on the
kernel config in the native ptrace().

I tried to figure out the history behind this API.  I naïvely assumed
that PTRAGE_GETREGSET and PTRACE_SETREGSET were ancient APIs that
predated compat, but no.  They were introduced by commit 2225a122ae26
("ptrace: Add support for generic PTRACE_GETREGSET/PTRACE_SETREGSET")
in 2010, and they are simply a poor design.  ELF core dumps have the
ELF e_machine field and a bunch of register sets in ELF notes, and the
pair (e_machine, NT_XXX) indicates the format of the regset blob.  But
the new PTRACE_GET/SETREGSET API coopted the NT_XXX numbering without
any way to specify which e_machine was in effect.  This is especially
bad on x86, where a process can freely switch between 32-bit and
64-bit mode, and, in fact, the PTRAGE_SETREGSET call itself can cause
this switch to happen.  Oops.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ptrace.c | 46 +++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index bedca011459c..87a4143aa7d7 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -704,6 +704,9 @@ void ptrace_disable(struct task_struct *child)
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static const struct user_regset_view user_x86_32_view; /* Initialized below. */
 #endif
+#ifdef CONFIG_X86_64
+static const struct user_regset_view user_x86_64_view; /* Initialized below. */
+#endif
 
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
@@ -711,6 +714,14 @@ long arch_ptrace(struct task_struct *child, long request,
 	int ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
 
+#ifdef CONFIG_X86_64
+	/* This is native 64-bit ptrace() */
+	const struct user_regset_view *regset_view = &user_x86_64_view;
+#else
+	/* This is native 32-bit ptrace() */
+	const struct user_regset_view *regset_view = &user_x86_32_view;
+#endif
+
 	switch (request) {
 	/* read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
@@ -749,28 +760,28 @@ long arch_ptrace(struct task_struct *child, long request,
 
 	case PTRACE_GETREGS:	/* Get all gp regs from the child. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   regset_view,
 					   REGSET_GENERAL,
 					   0, sizeof(struct user_regs_struct),
 					   datap);
 
 	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     regset_view,
 					     REGSET_GENERAL,
 					     0, sizeof(struct user_regs_struct),
 					     datap);
 
 	case PTRACE_GETFPREGS:	/* Get the child FPU state. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   regset_view,
 					   REGSET_FP,
 					   0, sizeof(struct user_i387_struct),
 					   datap);
 
 	case PTRACE_SETFPREGS:	/* Set the child FPU state. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     regset_view,
 					     REGSET_FP,
 					     0, sizeof(struct user_i387_struct),
 					     datap);
@@ -1152,28 +1163,28 @@ static long x32_arch_ptrace(struct task_struct *child,
 
 	case PTRACE_GETREGS:	/* Get all gp regs from the child. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   &user_x86_64_view,
 					   REGSET_GENERAL,
 					   0, sizeof(struct user_regs_struct),
 					   datap);
 
 	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     &user_x86_64_view,
 					     REGSET_GENERAL,
 					     0, sizeof(struct user_regs_struct),
 					     datap);
 
 	case PTRACE_GETFPREGS:	/* Get the child FPU state. */
 		return copy_regset_to_user(child,
-					   task_user_regset_view(current),
+					   &user_x86_64_view,
 					   REGSET_FP,
 					   0, sizeof(struct user_i387_struct),
 					   datap);
 
 	case PTRACE_SETFPREGS:	/* Set the child FPU state. */
 		return copy_regset_from_user(child,
-					     task_user_regset_view(current),
+					     &user_x86_64_view,
 					     REGSET_FP,
 					     0, sizeof(struct user_i387_struct),
 					     datap);
@@ -1309,6 +1320,25 @@ void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
 }
 
+/*
+ * This is used by the core dump code to decide which regset to dump.  The
+ * core dump code writes out the resulting .e_machine and the corresponding
+ * regsets.  This is suboptimal if the task is messing around with its CS.L
+ * field, but at worst the core dump will end up missing some information.
+ *
+ * Unfortunately, it is also used by the broken PTRACE_GETREGSET and
+ * PTRACE_SETREGSET APIs.  These APIs look at the .regsets field but have
+ * no way to make sure that the e_machine they use matches the caller's
+ * expectations.  The result is that the data format returned by
+ * PTRACE_GETREGSET depends on the returned CS field (and even the offset
+ * of the returned CS field depends on its value!) and the data format
+ * accepted by PTRACE_SETREGSET is determined by the old CS value.  The
+ * upshot is that it is basically impossible to use these APIs correctly.
+ *
+ * The best way to fix it in the long run would probably be to add new
+ * improved ptrace() APIs to read and write registers reliably, possibly by
+ * allowing userspace to select the ELF e_machine variant that they expect.
+ */
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_IA32_EMULATION
-- 
2.29.2

