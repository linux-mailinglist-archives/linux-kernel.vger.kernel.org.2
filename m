Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205F1409EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbhIMU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244023AbhIMU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631566494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L1oBX38tP7V16rD8wHDMXdOSupyTUB5kAz0woWzUIcY=;
        b=bCm8dgWFcF5UzgKiVfnQmIYxZIHMpfIQgj5ZzphF8g4xjXVzMHy+KTLjAQaFiM2Q+in778
        5nBiuL4tbR0XzJ35Of1Fc3mxxXY95lnS5/3xXX8pTJ2jnnYVYgNXrN4skP+G4ZWdozUXNV
        4cT87CPUKORE+sd1G9N9dLyBHOKAVGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-DnfBfRK3NC-LNp9lpBeq1w-1; Mon, 13 Sep 2021 16:54:51 -0400
X-MC-Unique: DnfBfRK3NC-LNp9lpBeq1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 410DC801B3D;
        Mon, 13 Sep 2021 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0683A1002388;
        Mon, 13 Sep 2021 20:54:48 +0000 (UTC)
From:   Denys Vlasenko <dvlasenk@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Denys Vlasenko <dvlasenk@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/entry: move ptregs->rsp and IF fixups to asm, remove do_SYSENTER_32()
Date:   Mon, 13 Sep 2021 22:54:46 +0200
Message-Id: <20210913205446.10342-1-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes two loads, one store, and one level of function calls
from both 32- and 64-bit SYSENTER32 code paths:

do_SYSENTER_32() does two fixups:

    /* SYSENTER loses RSP, but the vDSO saved it in RBP. */
    regs->sp = regs->bp;
but we can just do this when we form regs->sp on the stack in the first place.

    /* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
    regs->flags |= X86_EFLAGS_IF;
but we already load regs->flags in asm code and peek at its bits in order
to clear TF et al. We can set IF and update regs->flags right there,
avoiding loading it again.

With this changed, do_SYSENTER_32() does not do anything except calling
do_fast_syscall_32(), so get rid of it.

While at it, tweak some outdated comments.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
---
 arch/x86/entry/common.c          | 12 ------------
 arch/x86/entry/entry_32.S        | 13 +++++++++----
 arch/x86/entry/entry_64_compat.S | 19 ++++++++++++-------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..7639b0fc7e8a 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -233,18 +233,6 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
 }
-
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
-{
-	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
-	regs->sp = regs->bp;
-
-	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
-	regs->flags |= X86_EFLAGS_IF;
-
-	return do_fast_syscall_32(regs);
-}
 #endif
 
 SYSCALL_DEFINE0(ni_syscall)
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ccb9d32768f3..e14b13e9c3e1 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -837,7 +837,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
-	pushl	$0			/* pt_regs->sp (placeholder) */
+	/* SYSENTER loses RSP, but the vDSO saved it in EBP. */
+	pushl	%ebp			/* pt_regs->sp */
 	pushfl				/* pt_regs->flags (except IF = 0) */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
@@ -845,7 +846,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
 
 	/*
-	 * SYSENTER doesn't filter flags, so we need to clear NT, AC
+	 * SYSENTER filters only IF and VM, so we need to clear NT, AC
 	 * and TF ourselves.  To save a few cycles, we can check whether
 	 * either was set instead of doing an unconditional popfq.
 	 * This needs to happen before enabling interrupts so that
@@ -863,12 +864,16 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	 * we're keeping that code behind a branch which will predict as
 	 * not-taken and therefore its instructions won't be fetched.
 	 */
-	testl	$X86_EFLAGS_NT|X86_EFLAGS_AC|X86_EFLAGS_TF, PT_EFLAGS(%esp)
+	movl	PT_EFLAGS(%esp), %eax
+	testl	$X86_EFLAGS_NT|X86_EFLAGS_AC|X86_EFLAGS_TF, %eax
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
+	/* SYSENTER cleared IF.  Assume it was set in usermode. */
+	orl	$X86_EFLAGS_IF, %eax
+	movl	%eax, PT_EFLAGS(%esp)
 
 	movl	%esp, %eax
-	call	do_SYSENTER_32
+	call	do_fast_syscall_32
 	testl	%eax, %eax
 	jz	.Lsyscall_32_done
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 0051cf5c792d..71a9bc09b14d 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -59,13 +59,14 @@ SYM_CODE_START(entry_SYSENTER_compat)
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
-	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
+	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
+	pushq	%rbp			/* pt_regs->sp */
 
 	/*
 	 * Push flags.  This is nasty.  First, interrupts are currently
-	 * off, but we need pt_regs->flags to have IF set.  Second, if TS
+	 * off, but we need pt_regs->flags to have IF set.  Second, if TF
 	 * was set in usermode, it's still set, and we're singlestepping
-	 * through this code.  do_SYSENTER_32() will fix up IF.
+	 * through this code.  We fix up IF before do_fast_syscall_32().
 	 */
 	pushfq				/* pt_regs->flags (except IF = 0) */
 	pushq	$__USER32_CS		/* pt_regs->cs */
@@ -113,7 +114,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	cld
 
 	/*
-	 * SYSENTER doesn't filter flags, so we need to clear NT and AC
+	 * SYSENTER filters only IF and VM, so we need to clear NT and AC
 	 * ourselves.  To save a few cycles, we can check whether
 	 * either was set instead of doing an unconditional popfq.
 	 * This needs to happen before enabling interrupts so that
@@ -131,12 +132,16 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	 * we're keeping that code behind a branch which will predict as
 	 * not-taken and therefore its instructions won't be fetched.
 	 */
-	testl	$X86_EFLAGS_NT|X86_EFLAGS_AC|X86_EFLAGS_TF, EFLAGS(%rsp)
+	movl	EFLAGS(%rsp), %edi
+	testl	$X86_EFLAGS_NT|X86_EFLAGS_AC|X86_EFLAGS_TF, %edi
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
+	/* SYSENTER cleared IF.  Assume it was set in usermode. */
+	orl	$X86_EFLAGS_IF, %edi
+	movl	%edi, EFLAGS(%rsp)
 
 	movq	%rsp, %rdi
-	call	do_SYSENTER_32
+	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
@@ -189,7 +194,7 @@ SYM_CODE_END(entry_SYSENTER_compat)
  * eax  system call number
  * ecx  return address
  * ebx  arg1
- * ebp  arg2	(note: not saved in the stack frame, should not be touched)
+ * ebp  arg2
  * edx  arg3
  * esi  arg4
  * edi  arg5
-- 
2.30.0

