Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3E308357
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhA2BmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhA2BmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:42:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F75D64DF1;
        Fri, 29 Jan 2021 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611884483;
        bh=7PzGkfKU1mQu1KwINpqtyWbafw/zM/V9VnkvLvCV8Lw=;
        h=From:To:Cc:Subject:Date:From;
        b=LxnspWp5bVkCGCUlg8bUlGSrwrNeMDEHGyKlN0A318tV8U8TwS0WP9MmBJhjALf6r
         rJ/yf6phlU3UGRjd3F6C7WUfbQ8Crt1/pLyt+e/GqMqzQWE1DzfjeXDeSNyekLXzl9
         JgJYrjvAWTRLlP19YxtX7PVZmiZjGv9alNRKMAmv1i3q3/3VcS/lra/5C1acJ3sGws
         tOiOuw1xE3SmdiUqNZhhn3xCkyyESvvVyktEAPD43eblcZli8N3cmNBuR1G4lq3eyj
         65bZTC6rEqp+Brp7WQmbqJ/2PgwqP8FWFo9ggn8d3wGGyv6Qy86l1iA6+L67N+09t1
         89bqFa40atUng==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/ptrace: Clean up PTRACE_GETREGS/PTRACE_PUTREGS regset selection
Date:   Thu, 28 Jan 2021 17:41:21 -0800
Message-Id: <9268050ac1fb3db6b4ec20d3ef696cc44fa3e9d0.1611884439.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_user_regset_view() is fundamentally broken, but it's ABI for
PTRACE_GETREGSET and PTRACE_SETREGSET.

We shouldn't be using it for PTRACE_GETREGS or PTRACE_SETREGS,
though.  A native 64-bit ptrace() call and an x32 ptrace() call
should use the 64-bit regset views, and a 32-bit ptrace() call
(native or compat) should use the 32-bit regset.
task_user_regset_view() almost does this except that it will
malfunction if a ptracer is itself ptraced and the outer ptracer
modifies CS on entry to a ptrace() syscall.  Hopefully that has
never happened.  (The compat ptrace() code already hardcoded the
32-bit regset, so this patch has no effect on that path.)

Fix it and deobfuscate the code by hardcoding the 64-bit view in the
x32 ptrace() and selecting the view based on the kernel config in
the native ptrace().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Every time I look at ptrace, it grosses me out.  This makes it slightly
more comprehensible.

 arch/x86/kernel/ptrace.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index bedca011459c..ed8f153cd302 100644
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
@@ -1309,6 +1320,16 @@ void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
 }
 
+/*
+ * This is used by PTRACE_GETREGSET and PTRACE_SETREGSET to decide which
+ * regset format to use based on the register state of the tracee.
+ * This makes no sense whatsoever, but there appears to be existing user
+ * code that relies on it.
+ *
+ * The best way to fix it in the long run would probably be to add
+ * new improved ptrace() APIs to read and write registers reliably.
+ * Good luck.
+ */
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_IA32_EMULATION
-- 
2.29.2

