Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9C3ACED2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhFRP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhFRPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:02 -0400
Message-Id: <20210618143450.752639563@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yXhxHhPu2UmPkfXLL2+ihpjOP9TXabQ1b95tUjsHnZ8=;
        b=NKR2XpYwy6BMwnSUOUsn3qs2Ga7C/W9i9UIapiqicSaQP+w1ple4axIc9zf6EDOhO0Wwxy
        CmOTWC3P0XU53ntr6ykKSmOx6DCKHR2kTw1z3/MLuDPJyW7fNih9p/Un4BGTNq7UIw4PqJ
        CzqvRQDOHnrnTEsAV++LsZANa1li2MA0MO80mllZ2Hdz/AAhBA3SU2mArKQEHBHTVTm/1G
        4tb/Vpzg55/mpLYocW48FgF1qLT68HOQu6qFn46LtfDvLCXDk0lcc8HHsScc7o2tAWcgBM
        syEbm5w6WTCkI9rOJ/WF3BxHvXIiX8nOCXfXxkhU5gQ0RLYImTd3qKch7j8etA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yXhxHhPu2UmPkfXLL2+ihpjOP9TXabQ1b95tUjsHnZ8=;
        b=CkcAINnf75w/YjdD39tpys2dllBHTc6VlzpOLpD8PFgKxL2n4EKfFfh9421HiKCGjktnp9
        5NK0PRH8tE4V5ZAA==
Date:   Fri, 18 Jun 2021 16:19:19 +0200
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
Subject: [patch V3 56/66] x86/fpu: Dont store PKRU in xstate in fpu_reset_fpstate()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PKRU for a task is stored in task->thread.pkru when the task is scheduled
out. For 'current' the authoritative source of PKRU is the hardware.

fpu_reset_fpstate() has two callers:

  1) fpu__clear_user_states() for !FPU systems. For those PKRU is irrelevant

  2) fpu_flush_thread() which is invoked from flush_thread(). flush_thread()
     resets the hardware to the kernel restrictive default value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/core.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -337,23 +337,6 @@ static inline unsigned int init_fpstate_
 	return sizeof(init_fpstate.xsave);
 }
 
-/* Temporary workaround. Will be removed once PKRU and XSTATE are distangled. */
-static inline void pkru_set_default_in_xstate(struct xregs_state *xsave)
-{
-	struct pkru_state *pk;
-
-	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
-	/*
-	 * Force XFEATURE_PKRU to be set in the header otherwise
-	 * get_xsave_addr() does not work and it also needs to be set to
-	 * make XRSTOR(S) load it.
-	 */
-	xsave->header.xfeatures |= XFEATURE_MASK_PKRU;
-	pk = get_xsave_addr(xsave, XFEATURE_PKRU);
-	pk->pkru = pkru_get_init_value();
-}
-
 /*
  * Reset current->fpu memory state to the init values.
  */
@@ -371,9 +354,12 @@ static void fpu_reset_fpstate(void)
 	 *
 	 * Do not use fpstate_init() here. Just copy init_fpstate which has
 	 * the correct content already except for PKRU.
+	 *
+	 * PKRU handling does not rely on the xstate when restoring for
+	 * user space as PKRU is eagerly written in switch_to() and
+	 * flush_thread().
 	 */
 	memcpy(&fpu->state, &init_fpstate, init_fpstate_copy_size());
-	pkru_set_default_in_xstate(&fpu->state.xsave);
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 }

