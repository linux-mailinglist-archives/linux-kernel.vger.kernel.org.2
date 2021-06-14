Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D73A6C38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhFNQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhFNQkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24BC061283
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:48 -0700 (PDT)
Message-Id: <20210614155358.789807029@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YJm0fCbuO5/CQerfHzZ1C3g54hEwWQR/y+DcgVyDl/I=;
        b=P4k7pEW3yM0iequoeHzHYlqZGIHcyo5XAn4WF9386KEUGOmHAUsOkMr0vI/bcyRM5u8/ai
        PveK+KwS7vq1+G6/tU6bTJ5WKfNZ0CYNF8bs/H+BnR85guDFhVW8TTdcM9IeXzbmUJGAll
        uzp0RNBM70755LZ5MSf5njNPBI+EcC72YXU3Eroiiz3IZ9/DBHI2Hs6Ip/nX+zdJ4+ivLz
        t6MFuOcJ+YO5ZfTcst5w7CyWRW2GpBb+p41VcyxGhm/p7AjUTmnfN04NvV38MhHYn27wBs
        K+cgbzf2GLAOuo9C2LBDVLefBwmmjCkMUS+5zC/r8J0h6E1SU0z/WMOf0Uftjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YJm0fCbuO5/CQerfHzZ1C3g54hEwWQR/y+DcgVyDl/I=;
        b=VSvYQBeyQabNz9Ygnqq9RZg6kS67bOnpgqBB0PSW7d4PfpZm/K3jrCOV1JABexIOObi+KM
        0pdIti+f+eTLS7DQ==
Date:   Mon, 14 Jun 2021 17:44:58 +0200
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
Subject: [patch V2 50/52] x86/fpu: Dont store PKRU in xstate in fpu_reset_fpstate()
References: <20210614154408.673478623@linutronix.de>
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
@@ -403,23 +403,6 @@ static inline unsigned int init_fpstate_
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
@@ -437,9 +420,12 @@ static void fpu_reset_fpstate(void)
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

