Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7613F3B1A03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFWM1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhFWM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673F5C061767
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:13 -0700 (PDT)
Message-Id: <20210623121454.318485015@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dPDWUjVKimeg6NXmDbDgUvf3ZlJrT/wKGenyoPyiM08=;
        b=oRPEosuULkUF5CPiE022tHwg12SBJX36l/jdP6QtpIUPwsHo1oCC3o7rGwSI0G3/4DH4eT
        Q/SGOD7PGDRdPp4AUk9TcYw7s8uK4KkeP+40OSkIibJVAqth+EHhd2fBv0+KrJGDt2qnIQ
        K79we3aOyeWmaqtNGmFhihEbaxMsxUJaR8T3I2BC4eTP+kOPpYij0duBxhzU8kpf65gUif
        kBip5nXoWqG8py0koJhsDg4hKm45QkrZs00zWg0qAjn0OtjmltkJQRQYDqRDCs7UIwKO6t
        HTjFXmiamAf3UbuRfIMfbaeBVFHdOeujwzf4Ku+C6A4kE1Ds+E5SxzU7748TDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dPDWUjVKimeg6NXmDbDgUvf3ZlJrT/wKGenyoPyiM08=;
        b=dUxx5Rka2FovE/GfRNanau5/WOBUqNgOvYZcSq+pVqTGfbHKnEqEST/2CCPQbwwiO+xO78
        kYsZVN4B+Eq6YXDg==
Date:   Wed, 23 Jun 2021 14:01:57 +0200
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
Subject: [patch V4 30/65] x86/fpu: Rename xstate copy functions which are
 related to UABI
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
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

