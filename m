Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17F402F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbhIGT5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346130AbhIGT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A51C0617A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:29 -0700 (PDT)
Message-ID: <20210907195004.322583086@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AvbRPIfTOzQnWqE9aostc6o/Hm9dg3uaXQRIqLuYkpI=;
        b=Zjee9v7GYxkAe9Xr7XD3JlwxC0wDcfsdPAXV9GQ4rH8iRfI+SSyXZGdmBFws2/UQrDBuGQ
        /b4Ad+zT/OhjG6gL6BygT1J5FQzUMdeijknIndPL3j0IQeDEkEHjNf6lscbVstt78bVTqA
        70KIBzV7IkC5Tr4+dYkgdDGFjjsHlKvXns99QXxnpAU9/2NpF9sietD38ugigwJQiUNH5h
        qZ4N8qql6VzoyaUudk4s60Xz9x6MVAkflw6cZw4MOrS67vKizPdJBIHzvee637Uo3mdSyV
        ACpfZ0P89EoLs1130fT52LH2W9dH1v6Kc3f1Up8JHzXGN02IvuqvNgL1T0cicA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AvbRPIfTOzQnWqE9aostc6o/Hm9dg3uaXQRIqLuYkpI=;
        b=bqphmoPDmKJGXjx4tKPmoO6NuX9iMHSBwltWzF774nOJ+HOWw7EEd2P1diXo7nbLFZJgFP
        LeP09BiH6SY7q7CQ==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 10/20] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:28 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU restore from a signal frame can trigger various exceptions. The
exceptions are caught with an exception table entry. The handler of this
entry stores the trap number in EAX. The FPU specific fixup negates that
trap number to convert it into an negative error code.

Any other exception than #PF is fatal and recovery is not possible. This
relies on the fact that the #PF exception number is the same as EFAULT, but
that's not really obvious.

Remove the negation from the exception fixup as it really has no value and
check for X86_TRAP_PF at the call site.

There is still confusion due to the return code conversion for the error
case which will be cleaned up separately.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove the negation (Al)
---
 arch/x86/include/asm/fpu/internal.h |   21 ++++++++-------------
 arch/x86/kernel/fpu/signal.c        |    5 +++--
 2 files changed, 11 insertions(+), 15 deletions(-)
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -88,7 +88,10 @@ static inline void fpstate_init_soft(str
 #endif
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
-/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
+/*
+ * Returns 0 on success or the trap number when the operation raises an
+ * exception.
+ */
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -98,11 +101,7 @@ extern void save_fpregs_to_fpstate(struc
 	asm volatile(ASM_STAC "\n"					\
 		     "1: " #insn "\n"					\
 		     "2: " ASM_CLAC "\n"				\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  negl %%eax\n"					\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -198,18 +197,14 @@ static inline void fxsave(struct fxregs_
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
 
 /*
- * After this @err contains 0 on success or the negated trap number when
- * the operation raises an exception. For faults this results in -EFAULT.
+ * After this @err contains 0 on success or the trap number when the
+ * operation raises an exception.
  */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
-		     ".pushsection .fixup,\"ax\"\n\t"			\
-		     "3: negl %%eax\n\t"				\
-		     "jmp 2b\n\t"					\
-		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -13,6 +13,7 @@
 #include <asm/fpu/xstate.h>
 
 #include <asm/sigframe.h>
+#include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
 
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
@@ -275,7 +276,7 @@ static int restore_fpregs_from_user(void
 		fpregs_unlock();
 
 		/* Try to handle #PF, but anything else is fatal. */
-		if (ret != -EFAULT)
+		if (ret != X86_TRAP_PF)
 			return -EINVAL;
 
 		ret = fault_in_pages_readable(buf, size);
@@ -405,7 +406,7 @@ static int __fpu_restore_sig(void __user
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpu->state.xsave.header.xfeatures &= mask;
-		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
+		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all) ? -EINVAL : 0;
 	} else {
 		ret = fxrstor_safe(&fpu->state.fxsave);
 	}

