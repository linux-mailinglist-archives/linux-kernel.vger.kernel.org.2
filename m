Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE7403AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351718AbhIHNbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349455AbhIHNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:29:28 -0700 (PDT)
Message-ID: <20210908132525.506192488@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AvbRPIfTOzQnWqE9aostc6o/Hm9dg3uaXQRIqLuYkpI=;
        b=ToJdDc8NU8dc+iUz3+GNe5TUQDDbpBZVihwa9SCyjsEq7jDJUQiXp30QR4vVVY5+7LGw/3
        LT7iq3nVIrHmUH2NSSAkBJXRnQymfKE+W/UjSbTFgRDmUrihmJF/+ze+0G4wkv5DK0X6Eg
        Py4tW7W+YhBiz8ynViPEnYOYOV499jUh5UxbH/J16oxQImbxQacNcYfWJX/Z4pmtsg7C7Z
        J7C6dQH0Mzel9qPqY9CkJpGzPmkFJsEUEJajPGyNZeSTrosmebhYb4zBo6GskTNGSb0jlm
        7z8HdUI59e3rAvPjm7JqoevYEH2C2dRWVkO/6diA6+sTDi8828JvNXIIMY3ajw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AvbRPIfTOzQnWqE9aostc6o/Hm9dg3uaXQRIqLuYkpI=;
        b=E+xNVoL1/rbsCuF8dPjOeQi57wAGiOV/Xh2xLPkZRLqzdyP4VsyNRjg72alud07RcF5Cbl
        KtCdT56i264dL8DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 10/20] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:26 +0200 (CEST)
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

