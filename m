Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECE3A46E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhFKQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:48:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhFKQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:41 -0400
Message-Id: <20210611163114.992792767@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5bpDaqr/H2RwZdmUN/ak3+jz/3PqbIBBMRtXap7SkZ8=;
        b=3Fyc4LFqiu0JP+v6BMCqvfgZBqRhX98IidyLLSslpJnU/I1tFjgnmoWMNNNyPpK59ra62b
        UbOkrM0eZuO0ifSFuwPvmu3BmR+irRKSSTkbmJez1wEFLi8kN94F16NK4d7HdxW9VN3xP2
        Vg0AO/sTEmMR1WDTxvrySr4J2zIOjV5iwSsKaiT58cjEA6f44reNQYMJGwVoEUMNPQES9G
        muuXFncx4x1B6p5fC26mAb3JqUGsvAIJt6fJfBdFOAJ9D53jBnJD0FRq9gw2pNDsk+qiKy
        yFoD6cfQfC2bEh2FqVqJwGqj9bAGG0SE/n3CDa3lZk2N/JSB63DLfRL/S+AV0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5bpDaqr/H2RwZdmUN/ak3+jz/3PqbIBBMRtXap7SkZ8=;
        b=IlT+ETVZMrL4lM3/Er1sBmUcLF8U9NFWV2+NgNryDwRD8u3H4J8SdOApbK24dPIVCYR+D2
        kKrElke0gBFYUMDg==
Date:   Fri, 11 Jun 2021 18:16:00 +0200
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
Subject: [patch 37/41] x86/fpu: Hook up PKRU into ptrace()
References: <20210611161523.508908024@linutronix.de>
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
---

V4: Picked up from Dave's PKRU series, adopted to rename and dropped the
    copy_user_to_fpregs_zeroing() part because task->thread.pkru is only
    valid when the task is scheduled out. For current the authoritative
    source is the hardware.

---
 arch/x86/include/asm/fpu/xstate.h |    2 -
 arch/x86/kernel/fpu/regset.c      |   12 ++++-------
 arch/x86/kernel/fpu/xstate.c      |   40 ++++++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -128,7 +128,7 @@ void *get_xsave_addr(struct xregs_state
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 struct membuf;
-void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave);
+void copy_uabi_xstate_to_membuf(struct membuf to, struct task_struct *target);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -109,22 +109,20 @@ int xfpregs_set(struct task_struct *targ
 }
 
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
-		struct membuf to)
+		   struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
-
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	fpu__prepare_read(fpu);
+	fpu__prepare_read(&target->thread.fpu);
 
-	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave);
+	copy_uabi_xstate_to_membuf(to, target);
 	return 0;
 }
 
 int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
-		  unsigned int pos, unsigned int count,
-		  const void *kbuf, const void __user *ubuf)
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct xregs_state *tmpbuf = NULL;
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -968,12 +968,13 @@ static void copy_part(struct membuf *to,
  * It supports partial copy but pos always starts from zero. This is called
  * from xstateregs_get() and there we check the CPU has XSAVE.
  */
-void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave)
+void copy_uabi_xstate_to_membuf(struct membuf to, struct task_struct *target)
 {
-	struct xstate_header header;
 	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	unsigned size = to.left;
-	unsigned last = 0;
+	struct xregs_state *xsave = &target->thread.fpu.state.xsave;
+	struct xstate_header header;
+	unsigned int size = to.left;
+	unsigned int last = 0;
 	int i;
 
 	/*
@@ -983,6 +984,13 @@ void copy_uabi_xstate_to_membuf(struct m
 	header.xfeatures = xsave->header.xfeatures;
 	header.xfeatures &= xfeatures_mask_uabi();
 
+	/*
+	 * PKRU is not XSTATE managed. If enabled set the xfeature bit as
+	 * user space expects it to be part of the XSTATE buffer.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
+		header.xfeatures |= XFEATURE_MASK_PKRU;
+
 	if (header.xfeatures & XFEATURE_MASK_FP)
 		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);
 	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
@@ -1006,16 +1014,24 @@ void copy_uabi_xstate_to_membuf(struct m
 		  sizeof(header), &header);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		/*
-		 * Copy only in-use xstates:
-		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, i);
+		struct pkru_state pkru = {0};
+		void *src;
 
-			copy_part(&to, &last, xstate_offsets[i],
-				  xstate_sizes[i], src);
-		}
+		/* Copy only in-use xstates: */
+		if (!((header.xfeatures >> i) & 1))
+			continue;
 
+		if (i == XFEATURE_PKRU) {
+			/*
+			 * PKRU is not kept in the thread's XSAVE buffer.
+			 * Fill this part from the per-thread storage.
+			 */
+			pkru.pkru = target->thread.pkru;
+			src = &pkru;
+		} else {
+			src = __raw_xsave_addr(xsave, i);
+		}
+		copy_part(&to, &last, xstate_offsets[i], xstate_sizes[i], src);
 	}
 	fill_gap(&to, &last, size);
 }

