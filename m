Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35623ACECF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhFRP1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhFRPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:02 -0400
Message-Id: <20210618143450.643422340@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FLU9xb+KaJEErkpNWe5fXK/9Dxoh5neHYL0w/s0D18s=;
        b=b1O8obLk0y78B1n1OnE7aiEz5Jluylysv6tvUBeR5v6G8TQhfm7//I1+TWWIm6uqWF2n/a
        OxtihFTuBhWuj4F3EyqGYH9iLcTl0KKe0WyQUChHauvdsZGwyTNGPGFXKX8Q97Mew8ZCZF
        LnpAsE0xr+ulrjPxRUJdWMgVqBTr3ytiYZUD3Ug8vfvx6V2bH6wpjrv83INt3AJEqmqjdg
        hNcMUGfpVvUyWdwqjdsnB/Y7eTwEiRcLWsxD4NkULUOGMGKnfk0+SeVwNxHTXRcZ07AAVa
        1Z0IrfH397e8QijOXVgv8kfc9MRBcrHHb2zWELX1JCpDurQ469SWVt3AOBbdCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FLU9xb+KaJEErkpNWe5fXK/9Dxoh5neHYL0w/s0D18s=;
        b=TZbaBXhaE6H//AXBBzgy02Wp4M3hGxQ8XjtOZ9Lc7ra+5S1UEBrzBeQof+DXbi4DRGkei4
        sRa5v8vXA5wclXAA==
Date:   Fri, 18 Jun 2021 16:19:18 +0200
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
Subject: [patch V3 55/66] x86/fpu: Remove PKRU handling from switch_fpu_finish()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PKRU is already updated and the xstate is not longer the proper source of
information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |   34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -549,39 +549,13 @@ static inline void switch_fpu_prepare(st
  */
 
 /*
- * Load PKRU from the FPU context if available. Delay loading of the
- * complete FPU state until the return to userland.
+ * Delay loading of the complete FPU state until the return to userland.
+ * PKRU is handled seperately.
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu)
 {
-	u32 pkru_val = init_pkru_value;
-	struct pkru_state *pk;
-
-	if (!static_cpu_has(X86_FEATURE_FPU))
-		return;
-
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-
-	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
-
-	/*
-	 * PKRU state is switched eagerly because it needs to be valid before we
-	 * return to userland e.g. for a copy_to_user() operation.
-	 */
-	if (!(current->flags & PF_KTHREAD)) {
-		/*
-		 * If the PKRU bit in xsave.header.xfeatures is not set,
-		 * then the PKRU component was in init state, which means
-		 * XRSTOR will set PKRU to 0. If the bit is not set then
-		 * get_xsave_addr() will return NULL because the PKRU value
-		 * in memory is not valid. This means pkru_val has to be
-		 * set to 0 and not to init_pkru_value.
-		 */
-		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		pkru_val = pk ? pk->pkru : 0;
-	}
-	__write_pkru(pkru_val);
+	if (static_cpu_has(X86_FEATURE_FPU))
+		set_thread_flag(TIF_NEED_FPU_LOAD);
 }
 
 #endif /* _ASM_X86_FPU_INTERNAL_H */

