Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956A43A6F08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhFNTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhFNTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:31:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F68C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:29:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623698988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNMe5vnWIIxKK0IQfZ+yYtUxFfgblHYHdncMDW3vgrw=;
        b=CNSzaXGyiC5tp/blqzeMiihsw2cN+zpTAcsKEIrLLfi3ArObvoOhi0WUanS1TJ/n2x5QFW
        bnvKAgdAWUr2vOCwMEeV5rLZlSUXdUxhxd5im7KugPxtItTiJ5vM0+w9EvpLAdBwrFFMw5
        Uj9PmAA91KRcALmfUToFq2ueEz1GGyk8nzxwMC0iMeLPUDzTub0Mdp09KtF3mvypSp7B3A
        BPWeJ1GocCpEpiuHT4W58ng/wnMdjEgzmEQNg/Bb+0zDETaebuztRaoXJUAcYch2UbowMq
        AuQE9vB9VUViS+G9gfw7BXLVbbiLTFuXrmjtXm6oO9gcHUCT2tuYNg4hfZqf1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623698988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNMe5vnWIIxKK0IQfZ+yYtUxFfgblHYHdncMDW3vgrw=;
        b=ZZnoWxHJCqiNquEHXP25oDzOAYHj34EiLGlp1XLKFKGlenV1dUpB66oJUZb/n4XgnOzzRa
        Wo6sn+irCeK0sIBw==
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
Subject: [patch V2-A 47/52] x86/fpu: Hook up PKRU into ptrace()
In-Reply-To: <20210614155358.495410783@linutronix.de>
References: <20210614154408.673478623@linutronix.de> <20210614155358.495410783@linutronix.de>
Date:   Mon, 14 Jun 2021 21:29:48 +0200
Message-ID: <87czsoutw3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
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
---
V2-A: Managed to post the unfixed variant of this in V2.  Seems the
      script magic to catch unrefreshed patches before posting still has
      a weak spot. Other than that I blame the heat.
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
-void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave,
+void copy_uabi_xstate_to_membuf(struct membuf to, struct task_struct *tsk,
 				enum xstate_copy_mode mode);
 
 #endif
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -43,7 +43,7 @@ int xfpregs_get(struct task_struct *targ
 				    sizeof(fpu->state.fxsave));
 	}
 
-	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave, XSTATE_COPY_FX);
+	copy_uabi_xstate_to_membuf(to, target, XSTATE_COPY_FX);
 	return 0;
 }
 
@@ -92,14 +92,12 @@ int xfpregs_set(struct task_struct *targ
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
+	fpu__prepare_read(&target->thread.fpu);
 
-	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
+	copy_uabi_xstate_to_membuf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
@@ -302,7 +300,7 @@ int fpregs_get(struct task_struct *targe
 		struct membuf mb = { .p = &fxsave, .left = sizeof(fxsave) };
 
 		/* Handle init state optimized xstate correctly */
-		copy_uabi_xstate_to_membuf(mb, &fpu->state.xsave, XSTATE_COPY_FP);
+		copy_uabi_xstate_to_membuf(mb, target, XSTATE_COPY_FP);
 		fx = &fxsave;
 	} else {
 		fx = &fpu->state.fxsave;
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -973,7 +973,7 @@ static void copy_feature(bool from_xstat
 /**
  * copy_uabi_xstate_to_membuf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
- * @xsave:	The kernel xstate buffer to copy from
+ * @tsk:	The task from which to copy the saved xstate
  * @copy_mode:	The requested copy mode
  *
  * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
@@ -982,10 +982,11 @@ static void copy_feature(bool from_xstat
  *
  * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave,
+void copy_uabi_xstate_to_membuf(struct membuf to, struct task_struct *tsk,
 				enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
 	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
@@ -1059,11 +1060,21 @@ void copy_uabi_xstate_to_membuf(struct m
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
