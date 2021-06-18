Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE263ACEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhFRPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhFRPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:07 -0400
Message-Id: <20210618143447.897676792@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P9TNA8BrRu5FvvIRm8vv4Q4IOmB6ti1etddLvPAwE48=;
        b=FxIwc2J2fblNmTTEsAF26d3VSvadzT2z2orCZ9alSAP3iDKbkfRjuiDYxyakzG4DVqKQl9
        KOYuS3HYMr5Ys5y0JC+U8TjGQmUNDh/sN3rt263JRQED3UnSZJeEPftZONmh6SspVbq9t+
        UBK+nkhhgrOjYpzh0i8H0vvTPN3VOlw+9tLj+2hBKLg/DgflFN2aWsMXlUSx/tJtBBTxb9
        WDMN4tCmGXcTKqXIneDqWKiQbbkl0WZZWTURcZymFd3W2kHpvpgWQUXTl0J12fzwHsSWdD
        CEUcJT5OmVAkEZ3W1uc+dMzqSkscYFqn/vddPnJVkbCaHK6M7c7PlDwKmNvchQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P9TNA8BrRu5FvvIRm8vv4Q4IOmB6ti1etddLvPAwE48=;
        b=JaCtRwLRvZFLPdTK60hLM9mAdA2bU4QcDglM4m40EalzxF7tUGsIBd18GzSQ56SngIXkwj
        Q9P31peFRumgVNBg==
Date:   Fri, 18 Jun 2021 16:18:54 +0200
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
Subject: [patch V3 31/66] x86/fpu: Rename xstate copy functions which are
 related to UABI
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename them to reflect that these functions deal with user space format
XSAVE buffers.

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
@@ -167,7 +167,7 @@ int xstateregs_set(struct task_struct *t
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -422,7 +422,7 @@ static int __fpu__restore_sig(void __use
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			goto out;
 
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1099,7 +1099,7 @@ static inline bool mxcsr_valid(struct xs
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
  */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 {
 	unsigned int offset, size;
 	int i;
@@ -1154,7 +1154,8 @@ int copy_kernel_to_xstate(struct xregs_s
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+				      const void __user *ubuf)
 {
 	unsigned int offset, size;
 	int i;

