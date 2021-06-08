Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6019F39F98E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhFHOv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhFHOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:24 -0400
Message-Id: <20210608144346.045616965@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7O85/tFcthcFjZKj3FL4XnZphychvCI4giAeYfOTUQc=;
        b=VILxw9/U1btBgQ8MDD92kKuNX9Ph8/HKVi5HOnskZR1b9dlWv3zC+nenaJpbmYRHWtLHfL
        a7OodYgQcYjfZQbqv6x4LMk3ErnR8EOaBYErO/FlFKZWPL3H007pu9g7X3aE/uK63cw71N
        9zgS2Y+FCe1W24UkFj9/8Vl8546/8boolnCIa2jCNYb0vKfNVZnpAR97mRpKWvdLZ+/XlB
        fxNH4XjxI/Qs2ujMpjuDuo5nFQ3cKa1KoqT3j3HObHZ0DJrxlortwhagkSi1d+MYmhGkmX
        /7BxH1Lktk617wVGnPOffvMCl+97zJWfAkRSzO2CXWqGgPyDgkuW1bPKaMi7rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7O85/tFcthcFjZKj3FL4XnZphychvCI4giAeYfOTUQc=;
        b=dCzyUlNYB1YLaXOlACqKfnAiMD4WoYHsBmbDTAbW2Xe+eYjoSTZqBwA+CiyTa3pOdlN14t
        lFG9oosCMC/+pzDQ==
Date:   Tue, 08 Jun 2021 16:36:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@suse.de>
Subject: [patch V3 4/6] x86/pkru: Make PKRU=0 actually work
References: <20210608143617.565868844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user space brings PKRU into init state, then the kernel handling is
broken:

  T1 user space
     xsave(state)
     state.header.xfeatures &= ~XFEATURE_MASK_PKRU;
     xrstor(state)

  T1 -> kernel
     schedule()
       XSAVE(S) -> T1->xsave.header.xfeatures[PKRU] == 0
       T1->flags |= TIF_NEED_FPU_LOAD;

       wrpkru();

     schedule()
       ...
       pk = get_xsave_addr(&T1->fpu->state.xsave, XFEATURE_PKRU);
       if (pk)
	 wrpkru(pk->pkru);
       else
	 wrpkru(DEFAULT_PKRU);

Because the xfeatures bit is 0 and therefore the value in the xsave storage
is not valid, get_xsave_addr() returns NULL and switch_to() writes the
default PKRU. -> FAIL #1!

So that wreckages any copy_to/from_user() on the way back to user space
which hits memory which is protected by the default PKRU value.

Assumed that this does not fail (pure luck) then T1 goes back to user
space and because TIF_NEED_FPU_LOAD is set it ends up in

switch_fpu_return()
    __fpregs_load_activate()
      if (!fpregs_state_valid()) {
	 load_XSTATE_from_task();
      }

But if nothing touched the FPU between T1 scheduling out and in the
fpregs_state is valid so switch_fpu_return() does nothing and just clears
TIF_NEED_FPU_LOAD. Back to user space with DEFAULT_PKRU loaded. -> FAIL #2!

The fix is simple: if get_xsave_addr() returns NULL then set the PKRU value
to 0 instead of the restrictive default PKRU value.

Fixes: 0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/fpu/internal.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -579,9 +579,16 @@ static inline void switch_fpu_finish(str
 	 * return to userland e.g. for a copy_to_user() operation.
 	 */
 	if (!(current->flags & PF_KTHREAD)) {
+		/*
+		 * If the PKRU bit in xsave.header.xfeatures is not set,
+		 * then the PKRU compoment was in init state, which means
+		 * XRSTOR will set PKRU to 0. If the bit is not set then
+		 * get_xsave_addr() will return NULL because the PKRU value
+		 * in memory is not valid. This means pkru_val has to be
+		 * set to 0 and not to init_pkru_value.
+		 */
 		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		if (pk)
-			pkru_val = pk->pkru;
+		pkru_val = pk ? pk->pkru : 0;
 	}
 	__write_pkru(pkru_val);
 }

