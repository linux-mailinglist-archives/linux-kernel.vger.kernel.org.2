Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6285F3A46D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFKQq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhFKQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:15 -0400
Message-Id: <20210611163112.660994554@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0GvF6bL0/2pxmLsIk5auS7IdXZNJQkJhDNONiM2D2No=;
        b=dkWVO3hSX0E3qEnCcz40kBi0eT5cf9oJw9lQlrbPTJ3c957AdZv774BnC0i43PaSNbpuCJ
        3VpYVTAPDCHnfBDrkRRy8RXvcxGjCmnNA/wIS9LXJlZ38IAM4jy4EggkJv9FpyWFSEC8is
        T29uPHxQ4luT5+WDqOOxSI694nxFckqyG2SpN6yV+ky/uTn0L9kv5Dj2/AHUAkEbIFP+0Q
        9+a1B6vRiBwdNDCK/RFrWfQ3sjDq/ApcSD+Htwk/DPy+DNInYhdCDEVEb7E9EfmCKgxo2Z
        Dmhnu8f0JkNFor23llcU0aX4ZwPt5c6tuDUaUKfPED7VY+bblh6LzbmeUqAIjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0GvF6bL0/2pxmLsIk5auS7IdXZNJQkJhDNONiM2D2No=;
        b=G7idnV9v3clkDAoOe7ZfywugRtPZnW2x3bmmYlwJsr3SOfsz9wkj1sqP83d4ZDH0DRhF4A
        ZJBBq8BtyieBuICA==
Date:   Fri, 11 Jun 2021 18:15:39 +0200
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
Subject: [patch 16/41] x86/fpu: Rename xstate copy functions which are related to UABI
References: <20210611161523.508908024@linutronix.de>
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
V4: Better names at least more consistent
V2: New patch
---
 arch/x86/include/asm/fpu/xstate.h |    6 +++---
 arch/x86/kernel/fpu/regset.c      |    4 ++--
 arch/x86/kernel/fpu/signal.c      |    2 +-
 arch/x86/kernel/fpu/xstate.c      |    7 ++++---
 4 files changed, 10 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -104,9 +104,9 @@ void *get_xsave_addr(struct xregs_state
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 struct membuf;
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave);
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -118,7 +118,7 @@ int xstateregs_get(struct task_struct *t
 
 	fpu__prepare_read(fpu);
 
-	copy_xstate_to_kernel(to, &fpu->state.xsave);
+	copy_uabi_xstate_to_membuf(to, &fpu->state.xsave);
 	return 0;
 }
 
@@ -150,7 +150,7 @@ int xstateregs_set(struct task_struct *t
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
@@ -968,7 +968,7 @@ static void copy_part(struct membuf *to,
  * It supports partial copy but pos always starts from zero. This is called
  * from xstateregs_get() and there we check the CPU has XSAVE.
  */
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
+void copy_uabi_xstate_to_membuf(struct membuf to, struct xregs_state *xsave)
 {
 	struct xstate_header header;
 	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
@@ -1024,7 +1024,7 @@ void copy_xstate_to_kernel(struct membuf
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
  * and copy to the target thread. This is called from xstateregs_set().
  */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 {
 	unsigned int offset, size;
 	int i;
@@ -1079,7 +1079,8 @@ int copy_kernel_to_xstate(struct xregs_s
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+				      const void __user *ubuf)
 {
 	unsigned int offset, size;
 	int i;

