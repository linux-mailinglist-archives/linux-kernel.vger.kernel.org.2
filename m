Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8642D0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhJNDRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhJNDRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:17:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65439C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x8so3175120plv.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ziZjbhk8BT0M+YtJUf8+KJKDTqKEqXLQXXRoPitasKI=;
        b=iWuXzaQWCMhU5v19VMpnlWp/Jum8n4MoQtULYxxJagOYZObl+bVS3CEPLl2rzQ6vVN
         eDVOVVEjcuu9jqTAUCmrq6SYz1tytz37yyjDnRXIhlY/r4QGegWVd7f6unmtKmxOYf9D
         aO5a+oJU8AlBuBcE3jibd6ItG4Hk4M1Q8gzFXdrGvgI1G+xArTZSVhrxkkG0NXDXhz8P
         xNwqNW0c9vM7JXMGH1L3OefuH8/opsYc9SYyvnVu+GFGz4Iwbj88Cq3x51w9pDKxQzG5
         goZ0hDwJgNPfmrw0Q9lQGZD1ChQ4myvSogoV5jze0Yrp4aJ9jg1fiBhcgXvAsnaNclTN
         m0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziZjbhk8BT0M+YtJUf8+KJKDTqKEqXLQXXRoPitasKI=;
        b=WIwit72o742khE++ZbOOJDiuviH46lW0Im3xVb42VDcxhc6DNE0lBb/SHxAXF6M+Cl
         UVyKbmjWhNtDW0EqUmtAtTcDPcowzDNC9rh77Fbnai0xh6u7sZBUEt/i9EVYb0hMpsgc
         bmDCt8u1FKOZv+Hgp8/ACG4XV/Rw8/jQZbkzLIUWNpren9dUbjkHg9CM5QqlHZw/nT+W
         nEeXXxUlMWerc+L7ZUjPbVt0GTBfK/Equ/o7xS85eZ1oQwTgDbpx9xwvCtYZZOy+8Ind
         HPusDzIrIwwChJOec9SGk6I4gk4eNfzEMC9omUjzjaEqnff8WYJUm+Lz3azS3OG2ZGXb
         c3eg==
X-Gm-Message-State: AOAM532YfSp5SldLUo9jHzk9ArsNBmpAAJ9GxKHmrxjYJRZgOF7Ahty8
        aXUyHcK6+E3RNtbnRwtm5Y/FxpRXjCw=
X-Google-Smtp-Source: ABdhPJzpkAN6dWN7KdDgWgpczxPhJkz1xZ6tOUDKx0cpvgpNGxI52fkzkbxcU59sU3BkgbKJoHIyPg==
X-Received: by 2002:a17:902:8494:b0:13b:9365:6f12 with SMTP id c20-20020a170902849400b0013b93656f12mr2783213plo.19.1634181295802;
        Wed, 13 Oct 2021 20:14:55 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id k22sm7642008pji.2.2021.10.13.20.14.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:14:55 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, Peter Anvin <hpa@zytor.com>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH V3 04/49] x86/xen: Add xenpv_restore_regs_and_return_to_usermode()
Date:   Thu, 14 Oct 2021 11:13:27 +0800
Message-Id: <20211014031413.14471-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

While in the native case, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is the
trampoline stack.  But XEN pv doesn't use trampoline stack, so
PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is also the kernel stack.  Hence source
and destination stacks are identical in that case, which means reusing
swapgs_restore_regs_and_return_to_usermode() in XEN pv would cause %rsp
to move up to the top of the kernel stack and leave the IRET frame below
%rsp, which is dangerous to be corrupted if #NMI / #MC hit as either of
these events occurring in the middle of the stack pushing would clobber
data on the (original) stack.

And swapgs_restore_regs_and_return_to_usermode() pushing the IRET frame
on to the original address is useless and error-prone when there is any
future attempt to modify the code.

Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Anvin <hpa@zytor.com>
Cc: xen-devel@lists.xenproject.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        |  9 ++++++---
 arch/x86/entry/entry_64_compat.S |  7 ++++---
 arch/x86/xen/xen-asm.S           | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9d468c8877e2..0dde5a253dda 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -119,7 +119,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * In the Xen PV case we must use iret anyway.
 	 */
 
-	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
+	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", \
 		X86_FEATURE_XENPV
 
 	movq	RCX(%rsp), %rcx
@@ -286,7 +286,8 @@ SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
 	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
-	jmp	swapgs_restore_regs_and_return_to_usermode
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode",	\
+		"jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 1:
 	/* kernel thread */
@@ -566,6 +567,7 @@ __irqentry_text_start:
 __irqentry_text_end:
 
 SYM_CODE_START_LOCAL(common_interrupt_return)
+SYM_INNER_LABEL(xenpv_restore_regs_and_return_to_usermode, SYM_L_WEAK) /* placeholder */
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates user mode. */
@@ -1055,7 +1057,8 @@ SYM_CODE_START_LOCAL(error_return)
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	restore_regs_and_return_to_kernel
-	jmp	swapgs_restore_regs_and_return_to_usermode
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode",	\
+		"jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 SYM_CODE_END(error_return)
 
 /*
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5c792d..2a4d9532dfd5 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -139,7 +139,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	call	do_SYSENTER_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+		    "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -256,7 +256,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
+		    "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
@@ -411,5 +411,6 @@ SYM_CODE_START(entry_INT80_compat)
 
 	movq	%rsp, %rdi
 	call	do_int80_syscall_32
-	jmp	swapgs_restore_regs_and_return_to_usermode
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode",	\
+		"jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 220dd9678494..032be1bab113 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <../entry/calling.h>
 
 .pushsection .noinstr.text, "ax"
 /*
@@ -192,6 +193,32 @@ SYM_CODE_START(xen_iret)
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
+/*
+ * XEN pv doesn't use trampoline stack, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is
+ * also the kernel stack.  Reusing swapgs_restore_regs_and_return_to_usermode()
+ * in XEN pv would cause %rsp to move up to the top of the kernel stack and
+ * leave the IRET frame below %rsp, which is dangerous to be corrupted if #NMI
+ * interrupts. And swapgs_restore_regs_and_return_to_usermode() pushing the IRET
+ * frame at the same address is useless.
+ */
+SYM_CODE_START(xenpv_restore_regs_and_return_to_usermode)
+	UNWIND_HINT_REGS
+#ifdef CONFIG_DEBUG_ENTRY
+	/* Assert that pt_regs indicates user mode. */
+	testb	$3, CS(%rsp)
+	jnz	1f
+	ud2
+1:
+#endif
+	POP_REGS
+
+	/* stackleak_erase() can work safely on the kernel stack. */
+	STACKLEAK_ERASE_NOCLOBBER
+
+	addq	$8, %rsp	/* skip regs->orig_ax */
+	jmp xen_iret
+SYM_CODE_END(xenpv_restore_regs_and_return_to_usermode)
+
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
  * means we have:
-- 
2.19.1.6.gb485710b

