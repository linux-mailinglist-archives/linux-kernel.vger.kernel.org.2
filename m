Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7EC3A6C35
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhFNQml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhFNQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:46 -0400
Message-Id: <20210614155358.495410783@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5Dw7qcBDRmMpugc8tyWKbYt9kmXObsJamMv/YcZGPQU=;
        b=rydJ6zByenz+/9jmusDgkLyDzeOjkW7QPoMABo+hsJEiiXCbnk3Tn0yGXUzRfVHxzVFtJ0
        FXBNHKZulXTc2IhMXRTdNflwuixtyM1ahJzNHyHq5izJuDx6o1SEj/fnW+DUHwgY5+x84n
        MrNuGbgdLIo4tnwWVSvmxXmdX64CC6pBvtSFZo8niKV7yjkfrS5SNxmUy6j+AYgk9uPkIh
        dVk42lRHL3VvuCcjLVpu6lnUuP1dFblfI5ZPRiKe3W1bsgnqu8Jza5QXB7xy+/vHUTE82H
        ROBCAygn1GIigXFOih/K1+z62yX4a9JxWC3tIdb54Xzi+CEJAbE+fT0YB7NSzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5Dw7qcBDRmMpugc8tyWKbYt9kmXObsJamMv/YcZGPQU=;
        b=NeQiddtZUu3u66lZv7Dmn2Dy+tz+H2DPu+1GgGWaAUSfqiDiJubIe3KYgCq952uBimFQhH
        ziIa0DNsDytQHoDA==
Date:   Mon, 14 Jun 2021 17:44:55 +0200
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
Subject: [patch V2 47/52] x86/fpu: Hook up PKRU into ptrace()
References: <20210614154408.673478623@linutronix.de>
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
 arch/x86/include/asm/fpu/xstate.h |    2 +-
 arch/x86/kernel/fpu/regset.c      |    6 ++----
 arch/x86/kernel/fpu/xstate.c      |   25 ++++++++++++++++++-------
 3 files changed, 21 insertions(+), 12 deletions(-)

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
@@ -93,14 +93,12 @@ int xfpregs_set(struct task_struct *targ
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
+			pkru.pkru = target->thread.pkru;
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

