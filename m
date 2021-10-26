Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34643B43C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhJZOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbhJZOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:35:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAAC061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:33:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e65so14324295pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05YlvHibiMOMvwzoDA39PNq3lRzEdaNMkSmYjEK8nNg=;
        b=BywlJ/QJHyZxWQ82JpbTBBwlU8MhnsjgO0jYOPm0sKMAJdPSE/u70ybHDgN9uX7oY/
         06v1TXl+Dx1AgJgNEStQABYnV7aL95HRMrSpmCxGQ76XdTBaCXQZeqMmYiI/TtZknoPd
         omEW6Ve5TGemOWQKT5Hk6pzqtMiL/0ESVfnn5AwJVusC/mLAKnyey+jVGqAazRVXB3jt
         6xT4VVk5IHuTrUlYT1MjN85wZ9NU3Yz1TyfjbUJpLxz5VX3gRO7yj11wNqXgEcmU6kop
         JB4NTKoQ33v4ReZyJ6L6AOSAIX4CWAclOoNzN/oBsQEebkA1VPWJzJzp8X7eKHXnK++T
         Up+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05YlvHibiMOMvwzoDA39PNq3lRzEdaNMkSmYjEK8nNg=;
        b=UySVIz0vMN2kVKXelQ068cRVNOYpmA+v1uDqis9VX/GF78FuRnc6P2/4M1Sp9UQbbK
         4i4JvoFd1DpMGFDR/FmkGP2V3fhz+xj1P4UR2R04MpGslcDcWcjkj1wDwlpZtOeW1Uhw
         cG+LDbTyy+OlcJEeY4BlJ1HathGr5DQKNK0/APWqH3IL1Icv/EDTc1x91WcuEBxph3qa
         4q+8rrEBsKpHDOFUYv2ZDSWTCOgmIELy2zAxQ9soP55OdZrPdn5BIARtMvWofAcf1EeM
         Be+AWhWI8KJNEX0uowAoTMlzQ+ua4XN/8LbzaakepCOo4Dl0VHsSsV0pbxsga8MRuz8v
         WzZg==
X-Gm-Message-State: AOAM531Q0Ajei6nvtldrzkJUzKQD5BAgel9DvC344LMbZl2T5WP0zIlK
        90fVSQIe/pjZzqZzfkHqstO5giOxGEY=
X-Google-Smtp-Source: ABdhPJx6ucsjnWcQCwLu0YI8gy0ipOWy5QNZRYy9AQM9XW+7aEMoblX1nFtoWZTxIz7PzlFju2nNmw==
X-Received: by 2002:a63:9516:: with SMTP id p22mr15540827pgd.297.1635258787318;
        Tue, 26 Oct 2021 07:33:07 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id l6sm13823481pfc.126.2021.10.26.07.33.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:33:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH V4 25/50] x86/entry: Use idtentry macro for entry_INT80_compat
Date:   Tue, 26 Oct 2021 22:32:34 +0800
Message-Id: <20211026143301.18895-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

entry_INT80_compat is identical to idtentry macro except a special
handling for %rax in the prolog.

Add the prolog to idtentry and use idtentry for entry_INT80_compat.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        |  18 ++++++
 arch/x86/entry/entry_64_compat.S | 103 -------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/proto.h     |   4 --
 4 files changed, 65 insertions(+), 107 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 23de2a789e3d..79934c5ee9a1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -372,6 +372,24 @@ SYM_CODE_START(\asmsym)
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
 	.endif
 
+	.if \vector == IA32_SYSCALL_VECTOR
+		/*
+		 * User tracing code (ptrace or signal handlers) might assume
+		 * that the saved RAX contains a 32-bit number when we're
+		 * invoking a 32-bit syscall.  Just in case the high bits are
+		 * nonzero, zero-extend the syscall number.  (This could almost
+		 * certainly be deleted with no ill effects.)
+		 */
+		movl	%eax, %eax
+
+		/*
+		 * do_int80_syscall_32() expects regs->orig_ax to be user ax,
+		 * and regs->ax to be $-ENOSYS.
+		 */
+		movq	%rax, (%rsp)
+		movq	$-ENOSYS, %rax
+	.endif
+
 	.if \vector == X86_TRAP_BP
 		/*
 		 * If coming from kernel space, create a 6-word gap to allow the
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 2a4d9532dfd5..ad20302246e4 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -311,106 +311,3 @@ sysret32_from_system_call:
 	swapgs
 	sysretl
 SYM_CODE_END(entry_SYSCALL_compat)
-
-/*
- * 32-bit legacy system call entry.
- *
- * 32-bit x86 Linux system calls traditionally used the INT $0x80
- * instruction.  INT $0x80 lands here.
- *
- * This entry point can be used by 32-bit and 64-bit programs to perform
- * 32-bit system calls.  Instances of INT $0x80 can be found inline in
- * various programs and libraries.  It is also used by the vDSO's
- * __kernel_vsyscall fallback for hardware that doesn't support a faster
- * entry method.  Restarted 32-bit system calls also fall back to INT
- * $0x80 regardless of what instruction was originally used to do the
- * system call.
- *
- * This is considered a slow path.  It is not used by most libc
- * implementations on modern hardware except during process startup.
- *
- * Arguments:
- * eax  system call number
- * ebx  arg1
- * ecx  arg2
- * edx  arg3
- * esi  arg4
- * edi  arg5
- * ebp  arg6
- */
-SYM_CODE_START(entry_INT80_compat)
-	UNWIND_HINT_EMPTY
-	/*
-	 * Interrupts are off on entry.
-	 */
-	ASM_CLAC			/* Do this early to minimize exposure */
-	SWAPGS
-
-	/*
-	 * User tracing code (ptrace or signal handlers) might assume that
-	 * the saved RAX contains a 32-bit number when we're invoking a 32-bit
-	 * syscall.  Just in case the high bits are nonzero, zero-extend
-	 * the syscall number.  (This could almost certainly be deleted
-	 * with no ill effects.)
-	 */
-	movl	%eax, %eax
-
-	/* switch to thread stack expects orig_ax and rdi to be pushed */
-	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-
-	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-
-	/* In the Xen PV case we already run on the thread stack. */
-	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
-
-	movq	%rsp, %rdi
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq	6*8(%rdi)		/* regs->ss */
-	pushq	5*8(%rdi)		/* regs->rsp */
-	pushq	4*8(%rdi)		/* regs->eflags */
-	pushq	3*8(%rdi)		/* regs->cs */
-	pushq	2*8(%rdi)		/* regs->ip */
-	pushq	1*8(%rdi)		/* regs->orig_ax */
-	pushq	(%rdi)			/* pt_regs->di */
-.Lint80_keep_stack:
-
-	pushq	%rsi			/* pt_regs->si */
-	xorl	%esi, %esi		/* nospec   si */
-	pushq	%rdx			/* pt_regs->dx */
-	xorl	%edx, %edx		/* nospec   dx */
-	pushq	%rcx			/* pt_regs->cx */
-	xorl	%ecx, %ecx		/* nospec   cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10*/
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   %r12                    /* pt_regs->r12 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   %r13                    /* pt_regs->r13 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   %r14                    /* pt_regs->r14 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   %r15                    /* pt_regs->r15 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
-	UNWIND_HINT_REGS
-
-	cld
-
-	movq	%rsp, %rdi
-	call	do_int80_syscall_32
-	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode",	\
-		"jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
-SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 6779def97591..49fabc3e3f0d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -207,6 +207,20 @@ __visible noinstr void func(struct pt_regs *regs,			\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
 
+/**
+ * DECLARE_IDTENTRY_IA32_EMULATION - Declare functions for int80
+ * @vector:	Vector number (ignored for C)
+ * @asm_func:	Function name of the entry point
+ * @cfunc:	The C handler called from the ASM entry point (ignored for C)
+ *
+ * Declares two functions:
+ * - The ASM entry point: asm_func
+ * - The XEN PV trap entry point: xen_##asm_func (maybe unused)
+ */
+#define DECLARE_IDTENTRY_IA32_EMULATION(vector, asm_func, cfunc)	\
+	asmlinkage void asm_func(void);					\
+	asmlinkage void xen_##asm_func(void)
+
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
  * @vector:	Vector number (ignored for C)
@@ -433,6 +447,35 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
 	idtentry vector asm_##func func has_error_code=1
 
+/*
+ * 32-bit legacy system call entry.
+ *
+ * 32-bit x86 Linux system calls traditionally used the INT $0x80
+ * instruction.  INT $0x80 lands here.
+ *
+ * This entry point can be used by 32-bit and 64-bit programs to perform
+ * 32-bit system calls.  Instances of INT $0x80 can be found inline in
+ * various programs and libraries.  It is also used by the vDSO's
+ * __kernel_vsyscall fallback for hardware that doesn't support a faster
+ * entry method.  Restarted 32-bit system calls also fall back to INT
+ * $0x80 regardless of what instruction was originally used to do the
+ * system call.
+ *
+ * This is considered a slow path.  It is not used by most libc
+ * implementations on modern hardware except during process startup.
+ *
+ * Arguments:
+ * eax  system call number
+ * ebx  arg1
+ * ecx  arg2
+ * edx  arg3
+ * esi  arg4
+ * edi  arg5
+ * ebp  arg6
+ */
+#define DECLARE_IDTENTRY_IA32_EMULATION(vector, asm_func, cfunc)	\
+	idtentry vector asm_func cfunc has_error_code=0
+
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
 
@@ -634,6 +677,10 @@ DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
 DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	spurious_interrupt);
 #endif
 
+#ifdef CONFIG_IA32_EMULATION
+DECLARE_IDTENTRY_IA32_EMULATION(IA32_SYSCALL_VECTOR,	entry_INT80_compat, do_int80_syscall_32);
+#endif
+
 /* System vector entry points */
 #ifdef CONFIG_X86_LOCAL_APIC
 DECLARE_IDTENTRY_SYSVEC(ERROR_APIC_VECTOR,		sysvec_error_interrupt);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index ee07b3cae213..7ca5619352e2 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -29,10 +29,6 @@ void entry_SYSENTER_compat(void);
 void __end_entry_SYSENTER_compat(void);
 void entry_SYSCALL_compat(void);
 void entry_SYSCALL_compat_safe_stack(void);
-void entry_INT80_compat(void);
-#ifdef CONFIG_XEN_PV
-void xen_entry_INT80_compat(void);
-#endif
 #endif
 
 void x86_configure_nx(void);
-- 
2.19.1.6.gb485710b

