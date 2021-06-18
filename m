Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66293ACED6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhFRP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:28:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhFRPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:28 -0400
Message-Id: <20210618143451.442467526@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=G8iaiN0Nz3z/S/4NxUHUVDR+5LdmMYCqLA5fWAwGTu0=;
        b=ZRn0qL+6esKN1u2T1Zp+oFgST3gVZaNsX3OZy1duZur9fon+WjJF1blrY50Nn39So6bigq
        iknJdAu6oR54DVDF2roY8NeuIbCh6kIaXzcRO2Y67z4cawQ2+ErJUUOiaB+OVYbuqfmGHj
        xDiZHrnE74ElrpZ8X0UO6bS/TfxU2JLyZkx8e7D5SH9bdVoptdKPOrFGmu0x1IkQGFB5ZX
        Xp0nXR8hWbDwe08SoUuRDGCnJez49Xr9nr5ZsoQ8UwJGTC+0cs6qQlNH5Fc3MvJZEhIqUE
        e38p15LXziRfvtIG+DdBIIPmSNE76ukALILVPugVeIdpcURGyG5sHRvUC8H9NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=G8iaiN0Nz3z/S/4NxUHUVDR+5LdmMYCqLA5fWAwGTu0=;
        b=XuSu6WaiA8TmdMwgLPwvRt8c3hR85mOe/NGsqQlElhMXavXnG553vPCqkmzDB62GBhgT19
        8WNhWR0yoiSMvDAA==
Date:   Fri, 18 Jun 2021 16:19:25 +0200
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
Subject: [patch V3 62/66] x86/fpu/signal: Sanitize copy_user_to_fpregs_zeroing()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that user_xfeatures is correctly set when xsave is enabled, remove the
duplicated initialization of components.

Rename the function while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -250,33 +250,27 @@ sanitize_restored_user_xstate(union fpre
 }
 
 /*
- * Restore the extended state if present. Otherwise, restore the FP/SSE state.
+ * Restore the FPU state directly from the userspace signal frame.
  */
-static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
-	u64 init_bv;
-	int r;
-
 	if (use_xsave()) {
-		if (fx_only) {
-			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
+		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
+		int ret;
 
-			r = fxrstor_from_user_sigframe(buf);
-			if (!r)
-				os_xrstor(&init_fpstate.xsave, init_bv);
-			return r;
-		} else {
-			init_bv = xfeatures_mask_uabi() & ~xbv;
-
-			r = xrstor_from_user_sigframe(buf, xbv);
-			if (!r && unlikely(init_bv))
-				os_xrstor(&init_fpstate.xsave, init_bv);
-			return r;
-		}
+		if (likely(!fx_only))
+			ret = xrstor_from_user_sigframe(buf, xrestore);
+		else
+			ret = fxrstor_from_user_sigframe(buf);
+
+		if (!ret && unlikely(init_bv))
+			os_xrstor(&init_fpstate.xsave, init_bv);
+		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
-	} else
+	} else {
 		return frstor_from_user_sigframe(buf);
+	}
 }
 
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
@@ -313,7 +307,7 @@ static int __fpu_restore_sig(void __user
 		 */
 		fpregs_lock();
 		pagefault_disable();
-		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
+		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
 

