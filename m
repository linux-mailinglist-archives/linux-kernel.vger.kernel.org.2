Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2D3B1A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhFWM2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFWM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:57 -0400
Message-Id: <20210623121456.508770763@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8vVUCO1Y1lBdQOGuPUm4O23Rc9HcCuQc+sg4uh9f8X8=;
        b=Uh4RMVcxTQqux6NiWt0UmJvTXxxjeZdpjcCLu/hFdqBofMyhc+Xbvd0YP32sh5wWqjPHZR
        8NX3I7JKrU7DE/8qgJMGccmadWk1KkpSiH/aWlW+KSp9wb+T3opjQdZyC6MAujpgrTaQ7N
        U2pxiDN3LOmBDECUNbzJn+3/U0CCZfqu28EGv6Fv8DKJQVbwMcP8n5j+Bk9wKZp1YyNoLU
        YuFSav6hrJf5piIRIsBhjBz7/34/YDvXu9jyHp4VEwJ0mrybTLtp86mYxAsdgqSkiElKFi
        teo+cZ4FMsGpkBPadc6eIaIVg63JL0pRIu8e4HijB5lBWtMdwbSUXBORofE0Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=8vVUCO1Y1lBdQOGuPUm4O23Rc9HcCuQc+sg4uh9f8X8=;
        b=L3cJ2aQxtPUWACG8Tup6/Yq4Rkcvb0dH3YSaOVEd+J8l1WG3YMwu6IjP4eLcpyfh4FuZQT
        srX8c8AExeNRp3BA==
Date:   Wed, 23 Jun 2021 14:02:19 +0200
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
Subject: [patch V4 52/65] x86/fpu: Hook up PKRU into ptrace()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

One nice thing about having PKRU be XSAVE-managed is that it gets naturally
exposed into the XSAVE-using ABIs.  Now that XSAVE will not be used to
manage PKRU, these ABIs need to be manually enabled to deal with PKRU.

ptrace() uses copy_uabi_xstate_to_kernel() to collect the tracee's
XSTATE. As PKRU is not in the task's XSTATE buffer, use task->thread.pkru
for filling in up the ptrace buffer.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/xstate.h |    2 +-
 arch/x86/kernel/fpu/regset.c      |   10 ++++------
 arch/x86/kernel/fpu/xstate.c      |   25 ++++++++++++++++++-------
 3 files changed, 23 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -139,7 +139,7 @@ enum xstate_copy_mode {
 };
 
 struct membuf;
-void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode mode);
 
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -78,7 +78,7 @@ int xfpregs_get(struct task_struct *targ
 				    sizeof(fpu->state.fxsave));
 	}
 
-	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_FX);
+	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_FX);
 	return 0;
 }
 
@@ -127,14 +127,12 @@ int xfpregs_set(struct task_struct *targ
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
-
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(fpu);
+	sync_fpstate(&target->thread.fpu);
 
-	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
+	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
@@ -337,7 +335,7 @@ int fpregs_get(struct task_struct *targe
 		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
 		/* Handle init state optimized xstate correctly */
-		copy_xstate_to_uabi_buf(mb, &fpu->state.xsave, XSTATE_COPY_FP);
+		copy_xstate_to_uabi_buf(mb, target, XSTATE_COPY_FP);
 		fx = &fxsave;
 	} else {
 		fx = &fpu->state.fxsave;
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -962,7 +962,7 @@ static void copy_feature(bool from_xstat
 /**
  * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @xsave:	The kernel xstate buffer to copy from
+ * @tsk:	The task from which to copy the saved xstate
  * @copy_mode:	The requested copy mode
  *
  * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
@@ -971,10 +971,11 @@ static void copy_feature(bool from_xstat
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
 	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
@@ -1048,11 +1049,21 @@ void copy_xstate_to_uabi_buf(struct memb
 		if (zerofrom < xstate_offsets[i])
 			membuf_zero(&to, xstate_offsets[i] - zerofrom);
 
-		copy_feature(header.xfeatures & BIT_ULL(i), &to,
-			     __raw_xsave_addr(xsave, i),
-			     __raw_xsave_addr(xinit, i),
-			     xstate_sizes[i]);
-
+		if (i == XFEATURE_PKRU) {
+			struct pkru_state pkru = {0};
+			/*
+			 * PKRU is not necessarily up to date in the
+			 * thread's XSAVE buffer.  Fill this part from the
+			 * per-thread storage.
+			 */
+			pkru.pkru = tsk->thread.pkru;
+			membuf_write(&to, &pkru, sizeof(pkru));
+		} else {
+			copy_feature(header.xfeatures & BIT_ULL(i), &to,
+				     __raw_xsave_addr(xsave, i),
+				     __raw_xsave_addr(xinit, i),
+				     xstate_sizes[i]);
+		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
 		 * target buffer for gap zeroing.

