Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3B3B1A10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhFWM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhFWM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:27:09 -0400
Message-Id: <20210623121457.493455414@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=crEvCaVGqlYfZ7j0eEaR1HCQ06XYmYIz2pnF18+GiC0=;
        b=eWQtso8omZkUIiOJuStjEq3EVr635MDv2/M83h5wLEV67BP9IHxVfRWge9vg9exbUhC4OF
        OSzzrUaG87XFf2uAxN1abW6Wd/0ldF6AVAK4Vtk/W2JkQgYXBCkt5ORRE8oxSyQWND7g59
        XJqo6/L5Lbza3TOjzUjYeuFis5TYv9A4tR0LSvsjwXTqQZyHsLoiNvePD/1XAIvbRTPB56
        M4euIZmgb0WKXMfK+InLqHXBmQu7BYBro1zTjFmhsEZGbyyW66SuNVO5z8PlTki16/Ev7E
        mQFgkj8AFTVrXGCnIsbXCzkBGnmO1TiG3N4YtzPAnucQ1WJR6bTLrAFyLRULUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=crEvCaVGqlYfZ7j0eEaR1HCQ06XYmYIz2pnF18+GiC0=;
        b=3nIKTSMRAlGfdVQ31XnLFNc+8UTrHmaEMjjebCViglkbnRFj7zzs0/c0gFU/4MN2RAYOeA
        yrj2Gt7yN/q3u9DQ==
Date:   Wed, 23 Jun 2021 14:02:29 +0200
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
Subject: [patch V4 62/65] x86/fpu/signal: Split out the direct restore code
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for smarter failure handling of the direct restore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Rename function, fix whitespace and comments (Boris)
---
 arch/x86/kernel/fpu/signal.c |  112 ++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 54 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -250,10 +250,8 @@ sanitize_restored_user_xstate(union fpre
 	}
 }
 
-/*
- * Restore the FPU state directly from the userspace signal frame.
- */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+static int __restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				      bool fx_only)
 {
 	if (use_xsave()) {
 		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
@@ -274,6 +272,57 @@ static int restore_fpregs_from_user(void
 	}
 }
 
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	int ret;
+
+	fpregs_lock();
+	pagefault_disable();
+	ret = __restore_fpregs_from_user(buf, xrestore, fx_only);
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
+	 * It would be optimal to handle this with a single XRSTORS, but
+	 * this does not work because the rest of the FPU registers have
+	 * been restored from a user buffer directly. The single XRSTORS
+	 * happens below, when the user buffer has been copied to the
+	 * kernel one.
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
@@ -298,61 +347,16 @@ static int __fpu_restore_sig(void __user
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

