Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A178A3A6C16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhFNQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhFNQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:20 -0400
Message-Id: <20210614155356.343591326@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=k7VV3l92V/rIwwci1AxNetWz45bQmo+lWEnqmELScvg=;
        b=PIGhrYHlkISQBBqh1pNy0c7zj/F2XbXb+IBTQcv/3N8WI1hx0fDjs7lIWU+055nOx+7CXE
        TDDfkg9isVaCWPzMnODqLLpEDtE1rPiV9zfZdpsIJ+tP2bGDW/ilYZOzz8cplqoEWFRn9V
        0wpPsZ6p2z9s++mCZc6Tdpd7tM4zCLR+VCPxMLVj0BLW+nZzXq7acVeykqYg/SV3TXqf2d
        9UkVzCJ9JiDoKoFzxDn6GTbLW9GPWIluajxuZ6uqP566Ybqd9/KapCwskWwbfzgQvMrtFX
        Qzx/pFKe66FZ4YphsrMOK/rUYM0XjoRC/tIEn4nuygMEzFbBTZ15G1QMdmT5bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=k7VV3l92V/rIwwci1AxNetWz45bQmo+lWEnqmELScvg=;
        b=5kYvyiROgGlNKqdmdRPMVg+ai3xlu5O+hL2MsSp2CVrE7WXZGSDOdNU5cliQnj0T7rIpyL
        r/b9hoV7bJca7wAw==
Date:   Mon, 14 Jun 2021 17:44:34 +0200
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
Subject: [patch V2 26/52] x86/fpu: Rename xstate copy functions which are
 related to UABI
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename them to reflect that these functions deal with user space format
XSAVE buffers.

      copy_xstate_to_kernel() -> copy_uabi_xstate_to_membuf()
      copy_kernel_to_xstate() -> copy_uabi_from_kernel_to_xstate()
      copy_user_to_xstate()   -> copy_sigframe_from_user_to_xstate()

Again a clear statement that these functions deal with user space ABI.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/xstate.h |    4 ++--
 arch/x86/kernel/fpu/regset.c      |    2 +-
 arch/x86/kernel/fpu/signal.c      |    2 +-
 arch/x86/kernel/fpu/xstate.c      |    5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -102,8 +102,8 @@ extern void __init update_regset_xstate_
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -132,7 +132,7 @@ int xstateregs_set(struct task_struct *t
 	}
 
 	fpu__prepare_write(fpu);
-	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -431,7 +431,7 @@ static int __fpu__restore_sig(void __use
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			goto out;
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1080,7 +1080,7 @@ void copy_uabi_xstate_to_membuf(struct m
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
  */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 {
 	unsigned int offset, size;
 	int i;
@@ -1140,7 +1140,8 @@ int copy_kernel_to_xstate(struct xregs_s
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+				      const void __user *ubuf)
 {
 	unsigned int offset, size;
 	int i;

