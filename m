Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A691A403AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351791AbhIHNbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346134AbhIHNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:31 -0400
Message-ID: <20210908132525.387464538@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=txLTAvfCrpbPpD4W1xlvr75l/SIzjME+EBlmu+C3LU0=;
        b=uTJ8GU2yc3dhezOKZ4H4CCXHmzo1/oohk70/BYpEB9uz4P6ldKcIb26Eg7aBZjSLdRf7ZR
        IpX11CW/l2p/Ne/Au+nknXI92K2Ra4IIf8iFHvWJeGlNOylv+RQ5Qq5ySDKHWK1Iz8dHna
        YoUXQUwpUt1Gj10KzD+kRV5q5J9+fYqsQAjt23oAxD0ww9eCIZLoPyECUhpFxlqlBx3NQW
        lG5ac57o3K1Ax1Kt4hWzYUG52Ilxa7qy6zfEyb+ydh9uS4+uQQZjzVvC+legExbB2Yu/s1
        delOq3n4wi8uPlVNpB+SkXvLCGGpNHOhS0+P+b6JE8ZbSQy4Da4Oc+3wS5B0Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=txLTAvfCrpbPpD4W1xlvr75l/SIzjME+EBlmu+C3LU0=;
        b=JdTH2csqDgXFb9CY7GEjj9ZcYtas3rkYLwS+R9EZhqDs558BR3PoIq5YYazIqi3avwZIm/
        vA+TZrRbowGQA8BQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 08/20] x86/fpu: Use EX_TYPE_FAULT_MCE_SAFE for exception fixups
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:23 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros used for restoring FPU state from a user space buffer can handle
all exceptions including #MC. They need to return the trap number in the
error case as the code which invokes them needs to distinguish the cause of
the failure. It aborts the operation for anything except #PF.

Use the new EX_TYPE_FAULT_MCE_SAFE exception table fixup type to document
the nature of the fixup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -102,7 +102,7 @@ extern void save_fpregs_to_fpstate(struc
 		     "3:  negl %%eax\n"					\
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -209,7 +209,7 @@ static inline void fxsave(struct fxregs_
 		     "3: negl %%eax\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")

