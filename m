Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAE3B1A25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFWMaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFWM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6494C061A2E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:53 -0700 (PDT)
Message-Id: <20210623121457.601480369@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pnQhqdFvG/Q/2sic6ZfLToQAmFk68RhcVdYpy1gTvxg=;
        b=nJ3Yv/6pF36BbRsoP4vo5pPgd3tJrL5n5SE/js+4ajTxpagz+kVASP54MRaMrsB5u0jqcB
        wjf8eLExQrNC6vx8E1AKWZfWScm+BzelKax4H3zKM9E28XuCmXpjRQKDW1FpNWSLjepSsX
        0TB1V/Ug5BkgMLcc1ui6vzCavTFa4/LnfF0JbKW8KA/aWMG5mSaZqlY+kwHAx6jFB0Heqi
        8zOlBV2WWtPlOnDxmASlxTs80QBss2Q3ioB1gKbQYy9939aZTks0nE1bfYZwiRYn6P1ps1
        i9mFNkLtvHWAR7j+2XOR3svvoywDqkOibBIgxlmcbyIwrAkMCNVRz35rcekYdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pnQhqdFvG/Q/2sic6ZfLToQAmFk68RhcVdYpy1gTvxg=;
        b=O+NXIdhKPj7vo6/SqfGeSBh8fM2PCyT986oeCFvX8lUtykD0NOjePxgiBrA43ywFrDy+a3
        l7j5XdUGuwnyirAg==
Date:   Wed, 23 Jun 2021 14:02:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 63/65] x86/fpu: Return proper error codes from user access
 functions
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When *RSTOR from user memory raises an exception there is no way to
differentiate them. That's bad because it forces the slow path even when
the failure was not a fault. If the operation raised eg. #GP then going
through the slow path is pointless.

Use _ASM_EXTABLE_FAULT() which stores the trap number and let the exception
fixup return the negated trap number as error.

This allows to separate the fast path and let it handle faults directly and
avoid the slow path for all other exceptions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Fixup XSTATE_OP() as well (Boris)
---
 arch/x86/include/asm/fpu/internal.h |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -88,6 +88,7 @@ static inline void fpstate_init_soft(str
 #endif
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
+/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -95,14 +96,14 @@ extern void save_fpregs_to_fpstate(struc
 	might_fault();							\
 									\
 	asm volatile(ASM_STAC "\n"					\
-		     "1:" #insn "\n\t"					\
+		     "1: " #insn "\n"					\
 		     "2: " ASM_CLAC "\n"				\
 		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
+		     "3:  negl %%eax\n"					\
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err), output				\
+		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
 })
@@ -196,16 +197,20 @@ static inline void fxsave(struct fxregs_
 #define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
 
+/*
+ * After this @err contains 0 on success or the negated trap number when
+ * the operation raises an exception. For faults this results in -EFAULT.
+ */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
 		     ".pushsection .fixup,\"ax\"\n\t"			\
-		     "3: movl $-2,%[err]\n\t"				\
+		     "3: negl %%eax\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err)					\
+		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 

