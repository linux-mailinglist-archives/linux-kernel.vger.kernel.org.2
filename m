Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA33B1A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFWM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhFWM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:27:00 -0400
Message-Id: <20210623121456.802850233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6zitZTKyTwfMlECryRHi87+p+CaBlR0QliDtKwerXVQ=;
        b=IkbcQpnZrh+D9rvMClyeRiY6BWZaJcSj4n+IXOb8DvUStFBnSyeSluuCuOIKM5vwlusvEk
        0JkXn1LQZCLfmaECjguCFmGzEYhh2YYxu3TpTjDxCHDsxzEHQnWLTzCk75rECisYKdHxVv
        Go4jR2a1ogIW+LWjEdme37+qBLjIRv9tN1gESj4N/pKdcZYlqsSoE5zfJwCcRMeimoFj0V
        ly3F6P/lFJG1xFWIWcPrq113XlGOLrnJcdCmTEXZtv87gmssj/wNdzbXN6hHxbFP4rAzfq
        41BcfRDtOMX79XT06Pcyoo3iKV85oCkSjP/9nE7JL2xxgWmFKwkLmEW3t9/VyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6zitZTKyTwfMlECryRHi87+p+CaBlR0QliDtKwerXVQ=;
        b=wFy4/Qlg5ruOnz9gekk2z4MwIBeG8oh0iCPmCBo5hnJK2Nxt0gEtqOZMTBUGs5lSq8txo+
        iK7ZM7aVoJbJcUAQ==
Date:   Wed, 23 Jun 2021 14:02:22 +0200
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
Subject: [patch V4 55/65] x86/fpu: Dont store PKRU in xstate in fpu_reset_fpstate()
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/core.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -337,23 +337,6 @@ static inline unsigned int init_fpstate_
 	return sizeof(init_fpstate.xsave);
 }
 
-/* Temporary workaround. Will be removed once PKRU and XSTATE are untangled. */
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

