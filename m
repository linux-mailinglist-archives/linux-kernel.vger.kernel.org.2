Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0A402F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346170AbhIGT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45194 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346252AbhIGT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:37 -0400
Message-ID: <20210907195004.376238631@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dvhy36iNQ8gVAccd/xnnAOVMij+NkUaKYJV5qKiSZ+k=;
        b=0bKNr3cZhq6ML5E1jCmUZQHqVNTIH4EFAtaAbNcbjrdccQFGRYA49cZ8UHcGJ9Ps/T0qAV
        N7GUg5GiHgkBt8RS5OroswrVBJHffek9Hs6tx7a6PFzb+KKRzTkgMYS7JK68N2P1jfjeEB
        h2v0tcPZwRLJ/e6Kg5OJJIf1fxDlnjpr3cO71i4n9aSP6Ws2e/MAC6uPdewE/qdGORRTi2
        E0mkTSilZiYp2QNqNxn8kNnrcHj1BJ4CE+4kN0vEAZk8ZFREox1G+jUu2013bCxScJx0Xg
        Dei1voBB3l2mF3zAyfn9QK2MV20WvsNw64V0IZoOA/AxXwDQ5y1Px7TCnAKL1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dvhy36iNQ8gVAccd/xnnAOVMij+NkUaKYJV5qKiSZ+k=;
        b=t8X/78qm49tgf3b22s7MGlhynDHcuv6Dg10VTlMSGECAvxhL6Yl78NExJfT6/v36PgghEB
        Pnj5lDBAL6TV3vCg==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V2 11/20] x86/fpu: Dont use MCE safe fixups for writing FPU
 state to user space
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:29 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes cannot raise #MC, so no point in pretending that the code can handle
in kernel #MC recovery.

Reported-by: Peter Ziljstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/fpu/internal.h |   48 ++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -92,7 +92,7 @@ extern void save_fpregs_to_fpstate(struc
  * Returns 0 on success or the trap number when the operation raises an
  * exception.
  */
-#define user_insn(insn, output, input...)				\
+#define user_insn_mce_safe(insn, output, input...)			\
 ({									\
 	int err;							\
 									\
@@ -107,6 +107,25 @@ extern void save_fpregs_to_fpstate(struc
 	err;								\
 })
 
+#define user_insn(insn, output, input...)				\
+({									\
+	int err;							\
+									\
+	might_fault();							\
+									\
+	asm volatile(ASM_STAC "\n"					\
+		     "1: " #insn "\n"					\
+		     "2: " ASM_CLAC "\n"				\
+		     ".section .fixup,\"ax\"\n"				\
+		     "3:  movl $-1,%[err]\n"				\
+		     "    jmp  2b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : [err] "=a" (err), output				\
+		     : "0"(0), input);					\
+	err;								\
+})
+
 #define kernel_insn_err(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -161,9 +180,9 @@ static inline int fxrstor_safe(struct fx
 static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
-		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+		return user_insn_mce_safe(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
-		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
+		return user_insn_mce_safe(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline void frstor(struct fregs_state *fx)
@@ -178,7 +197,7 @@ static inline int frstor_safe(struct fre
 
 static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
 {
-	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
+	return user_insn_mce_safe(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline void fxsave(struct fxregs_state *fx)
@@ -200,7 +219,7 @@ static inline void fxsave(struct fxregs_
  * After this @err contains 0 on success or the trap number when the
  * operation raises an exception.
  */
-#define XSTATE_OP(op, st, lmask, hmask, err)				\
+#define XSTATE_OP_MCE_SAFE(op, st, lmask, hmask, err)			\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
@@ -209,6 +228,19 @@ static inline void fxsave(struct fxregs_
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define XSTATE_OP(op, st, lmask, hmask, err)				\
+	asm volatile("1:" op "\n\t"					\
+		     "xor %[err], %[err]\n"				\
+		     "2:\n\t"						\
+		     ".section .fixup,\"ax\"\n"				\
+		     "3:  movl $-1,%[err]\n"				\
+		     "    jmp  2b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : [err] "=a" (err)					\
+		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
+		     : "memory")
+
 /*
  * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
  * format and supervisor states in addition to modified optimization in
@@ -360,15 +392,15 @@ static inline int xrstor_from_user_sigfr
 	int err;
 
 	stac();
-	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	XSTATE_OP_MCE_SAFE(XRSTOR, xstate, lmask, hmask, err);
 	clac();
 
 	return err;
 }
 
 /*
- * Restore xstate from kernel space xsave area, return an error code instead of
- * an exception.
+ * Restore xstate from kernel space xsave area, return an error code when
+ * the operation raises an exception.
  */
 static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 {

