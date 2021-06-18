Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F022B3ACED7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhFRP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:28:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56806 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhFRPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:32 -0400
Message-Id: <20210618143451.562513044@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=VZiuaoMbQ+lzqJwpZe0a5HWgeLQ11vhAT7QIjiwbrM8=;
        b=iHDd11WTYa4CYXD+7v84OP4hEE4XqiVvG71+VP8pP1jzIRt5/hqC3MkzHVYYjM7CqZ4yrW
        +gv+mfQaZCGVJTzfkih3gseEGYJugXg09jgMVa4MeX1MytFuX6my+FKY9uL6VVGG+zOQtt
        wdHCBQPSjYk/TON2rjFVVG5ffcDD/ptHC6r7JJpz+vsWDgkjHoYI+vO7xCBSQwcNaOIWyY
        L/V0MCpdFm2V7PHURvSbNXkswc7WBsCdYotjUeUFzz3IoLGJdS0mqyJCDEnb2hnomUGGQX
        54o4FGYYTjj2iI5CCMj0IQNw2SJedNCYFqxILeNXisOekQfuwL6HlXxj/5m1JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=VZiuaoMbQ+lzqJwpZe0a5HWgeLQ11vhAT7QIjiwbrM8=;
        b=genUUa3Fsj49yDuh9kkSvgk+6va3VGbezrBDrhfbp3bdobBJtU8tAOeR2Rah06avNtxFqr
        L3X220xl3muCEzAA==
Date:   Fri, 18 Jun 2021 16:19:26 +0200
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
Subject: [patch V3 63/66] x86/fpu/signal: Split out the direct restore code
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for smarter failure handling of the direct restore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |  110 +++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 54 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -249,10 +249,7 @@ sanitize_restored_user_xstate(union fpre
 	}
 }
 
-/*
- * Restore the FPU state directly from the userspace signal frame.
- */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+static int restore_hwregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
 	if (use_xsave()) {
 		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
@@ -273,6 +270,56 @@ static int restore_fpregs_from_user(void
 	}
 }
 
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	int ret ;
+
+	fpregs_lock();
+	pagefault_disable();
+	ret = restore_hwregs_from_user(buf, xrestore, fx_only);
+	pagefault_enable();
+
+	if (unlikely(ret)) {
+		/*
+		 * The above did an FPU restore operation, restricted to
+		 * the user portion of the registers, and failed, but the
+		 * microcode might have modified the FPU registers
+		 * nevertheless.
+		 *
+		 * If the FPU registers do not belong to current, then
+		 * invalidate the FPU register state otherwise the task
+		 * might preempt current and return to user space with
+		 * corrupted FPU registers.
+		 *
+		 * In case current owns the FPU registers then no further
+		 * action is required. The fixup in the slow path will
+		 * handle it correctly.
+		 */
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			__cpu_invalidate_fpregs_state();
+		fpregs_unlock();
+		return ret;
+	}
+
+	/*
+	 * Restore supervisor states: previous context switch etc has done
+	 * XSAVES and saved the supervisor states in the kernel buffer from
+	 * which they can be restored now.
+	 *
+	 * We cannot do a single XRSTORS here - which would be nice -
+	 * because the rest of the FPU registers are being restored from a
+	 * user buffer directly. The single XRSTORS happens below, when the
+	 * user buffer has been copied to the kernel one.
+	 */
+	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
+		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
+
+	fpregs_mark_activate();
+	fpregs_unlock();
+	return 0;
+}
+
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			     bool ia32_fxstate)
 {
@@ -297,61 +344,16 @@ static int __fpu_restore_sig(void __user
 		user_xfeatures = fx_sw_user.xfeatures;
 	}
 
-	if (!ia32_fxstate) {
+	if (likely(!ia32_fxstate)) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
-		 * memory. For that to succeed, the user access cannot cause
-		 * page faults. If it does, fall back to the slow path below,
-		 * going through the kernel buffer with the enabled pagefault
-		 * handler.
+		 * memory. For that to succeed, the user access cannot cause page
+		 * faults. If it does, fall back to the slow path below, going
+		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		fpregs_lock();
-		pagefault_disable();
 		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
-		pagefault_enable();
-		if (!ret) {
-
-			/*
-			 * Restore supervisor states: previous context switch
-			 * etc has done XSAVES and saved the supervisor states
-			 * in the kernel buffer from which they can be restored
-			 * now.
-			 *
-			 * We cannot do a single XRSTORS here - which would
-			 * be nice - because the rest of the FPU registers are
-			 * being restored from a user buffer directly. The
-			 * single XRSTORS happens below, when the user buffer
-			 * has been copied to the kernel one.
-			 */
-			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
-			    xfeatures_mask_supervisor()) {
-				os_xrstor(&fpu->state.xsave,
-					  xfeatures_mask_supervisor());
-			}
-			fpregs_mark_activate();
-			fpregs_unlock();
+		if (likely(!ret))
 			return 0;
-		}
-
-		/*
-		 * The above did an FPU restore operation, restricted to
-		 * the user portion of the registers, and failed, but the
-		 * microcode might have modified the FPU registers
-		 * nevertheless.
-		 *
-		 * If the FPU registers do not belong to current, then
-		 * invalidate the FPU register state otherwise the task might
-		 * preempt current and return to user space with corrupted
-		 * FPU registers.
-		 *
-		 * In case current owns the FPU registers then no further
-		 * action is required. The fixup below will handle it
-		 * correctly.
-		 */
-		if (test_thread_flag(TIF_NEED_FPU_LOAD))
-			__cpu_invalidate_fpregs_state();
-
-		fpregs_unlock();
 	} else {
 		/*
 		 * For 32-bit frames with fxstate, copy the fxstate so it can

