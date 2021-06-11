Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F63A46C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFKQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhFKQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:05 -0400
Message-Id: <20210611163111.820639606@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rEOdnmtxdHloi4IqPGpq/qcAB9VFJtekuQtcbqmO9oo=;
        b=e8mZWLkpHiwVZQN62Z12rdtKmugB4lJwjKEQdE+7hlyUeZW3tem0urRsbxt1UwS3DQ07tx
        9qVUc4+0lQlvqHjhbl2i2ChGJWlXptiJJ83L6DbqD27VmTJv9PG0UhGGiHEPnYhIvIZWgj
        AknGkMKA0mg69dZtHZlh+UpeMRCHklkCjmCNSRHV4v4oVilTpuFXOAy1/8GMPjNVXl42UR
        5dv9helM6Oc7KOW2aWZKxud65q56IA9x6YJ9dqwsU1QfkWtKqdStB2u2K0FugCnh8ymdg+
        F+FHFIt3Vxs5wgB/kCUV1LUBwXU0BmBSVSyBILbwZLFrU2uykvT9h6K6JSQoSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rEOdnmtxdHloi4IqPGpq/qcAB9VFJtekuQtcbqmO9oo=;
        b=pBXcadbPM4+Yl/zO2UB3HCe7D9x40JhWYIdZbNI2UlI1eHvGoI+lOSt7mlFxFaAkCwJGCS
        ZVtPbfiN20oNcjAw==
Date:   Fri, 11 Jun 2021 18:15:31 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy components
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xstateregs_get() does not longer use fpstate_sanitize_xstate() and the only
callers are the regset functions for the legacy FP/SSE components.

Move the function to the callsites and remove the extended features part.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    2 
 arch/x86/kernel/fpu/regset.c        |   41 ++++++++++++++++--
 arch/x86/kernel/fpu/xstate.c        |   79 ------------------------------------
 3 files changed, 37 insertions(+), 85 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -87,8 +87,6 @@ extern void fpstate_init_soft(struct swr
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
-extern void fpstate_sanitize_xstate(struct fpu *fpu);
-
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -11,6 +11,39 @@
 
 #include <linux/sched/task_stack.h>
 
+/*
+ * When executing XSAVEOPT (or other optimized XSAVE instructions), if
+ * a processor implementation detects that an FPU state component is still
+ * (or is again) in its initialized state, it may clear the corresponding
+ * bit in the header.xfeatures field, and can skip the writeout of registers
+ * to the corresponding memory layout.
+ *
+ * This means that when the bit is zero, the state component might still
+ * contain some previous - non-initialized register state.
+ *
+ * This is required for the legacy regset functions.
+ */
+static void fpstate_sanitize_legacy(struct fpu *fpu)
+{
+	struct fxregs_state *fx = &fpu->state.fxsave;
+	u64 xfeatures;
+
+	if (!use_xsaveopt())
+		return;
+
+	xfeatures = fpu->state.xsave.header.xfeatures;
+
+	/* If FP is in init state, reinitialize it */
+	if (!(xfeatures & XFEATURE_MASK_FP)) {
+		memset(fx, 0, sizeof(*fx));
+		fx->cwd = 0x37f;
+	}
+
+	/* If SSE is in init state, clear the storage */
+	if (!(xfeatures & XFEATURE_MASK_SSE))
+		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
+}
+
 
 /*
  * The xstateregs_active() routine is the same as the regset_fpregs_active() routine,
@@ -39,7 +72,7 @@ int xfpregs_get(struct task_struct *targ
 		return -ENODEV;
 
 	fpu__prepare_read(fpu);
-	fpstate_sanitize_xstate(fpu);
+	fpstate_sanitize_legacy(fpu);
 
 	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
 }
@@ -55,7 +88,7 @@ int xfpregs_set(struct task_struct *targ
 		return -ENODEV;
 
 	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	fpstate_sanitize_legacy(fpu);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 &fpu->state.fxsave, 0, -1);
@@ -276,7 +309,7 @@ int fpregs_get(struct task_struct *targe
 				    sizeof(struct fregs_state));
 	}
 
-	fpstate_sanitize_xstate(fpu);
+	fpstate_sanitize_legacy(fpu);
 
 	if (to.left == sizeof(env)) {
 		convert_from_fxsr(to.p, target);
@@ -296,7 +329,7 @@ int fpregs_set(struct task_struct *targe
 	int ret;
 
 	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
+	fpstate_sanitize_legacy(fpu);
 
 	if (!boot_cpu_has(X86_FEATURE_FPU))
 		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -129,85 +129,6 @@ static bool xfeature_is_supervisor(int x
 }
 
 /*
- * When executing XSAVEOPT (or other optimized XSAVE instructions), if
- * a processor implementation detects that an FPU state component is still
- * (or is again) in its initialized state, it may clear the corresponding
- * bit in the header.xfeatures field, and can skip the writeout of registers
- * to the corresponding memory layout.
- *
- * This means that when the bit is zero, the state component might still contain
- * some previous - non-initialized register state.
- *
- * Before writing xstate information to user-space we sanitize those components,
- * to always ensure that the memory layout of a feature will be in the init state
- * if the corresponding header bit is zero. This is to ensure that user-space doesn't
- * see some stale state in the memory layout during signal handling, debugging etc.
- */
-void fpstate_sanitize_xstate(struct fpu *fpu)
-{
-	struct fxregs_state *fx = &fpu->state.fxsave;
-	int feature_bit;
-	u64 xfeatures;
-
-	if (!use_xsaveopt())
-		return;
-
-	xfeatures = fpu->state.xsave.header.xfeatures;
-
-	/*
-	 * None of the feature bits are in init state. So nothing else
-	 * to do for us, as the memory layout is up to date.
-	 */
-	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
-		return;
-
-	/*
-	 * FP is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_FP)) {
-		fx->cwd = 0x37f;
-		fx->swd = 0;
-		fx->twd = 0;
-		fx->fop = 0;
-		fx->rip = 0;
-		fx->rdp = 0;
-		memset(fx->st_space, 0, sizeof(fx->st_space));
-	}
-
-	/*
-	 * SSE is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_SSE))
-		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
-
-	/*
-	 * First two features are FPU and SSE, which above we handled
-	 * in a special way already:
-	 */
-	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
-
-	/*
-	 * Update all the remaining memory layouts according to their
-	 * standard xstate layout, if their header bit is in the init
-	 * state:
-	 */
-	while (xfeatures) {
-		if (xfeatures & 0x1) {
-			int offset = xstate_comp_offsets[feature_bit];
-			int size = xstate_sizes[feature_bit];
-
-			memcpy((void *)fx + offset,
-			       (void *)&init_fpstate.xsave + offset,
-			       size);
-		}
-
-		xfeatures >>= 1;
-		feature_bit++;
-	}
-}
-
-/*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
  */

