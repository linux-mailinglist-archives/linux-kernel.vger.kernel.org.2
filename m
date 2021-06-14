Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E13A6C37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhFNQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhFNQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87868C0613A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:46 -0700 (PDT)
Message-Id: <20210614155358.689143950@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Nm/xYOmkS0HIRczi/t604zsMaqpxWxp01QOhQlWzhT4=;
        b=w/8RkNo+YJPdVtIanHp/S6HEe18Mt0E+U0A71nwLrGvX8D4jgeLSM+GlnTeUN8XFvwtNGD
        1EXrBDPIWf12zAwuLtU4v+FAvtTq2h9HHSu+BwUulLf+jUKBWjeLvSWAU7dCnnMTTZs2fI
        51hbolrXPAnVSQSZISpwix/S6EcBvODcSVBUoUWRtCLeD4rw3HRdlCE9HR6W701M6Smk8P
        Os07nMnusJc+/h9svHkY2lDJyRyJVLD/AbUUYxuEa/iAQ29yuEo/ywyaFxZbv8ZwV8Dyg/
        TI5fqzixRCt9raXcBwHRdM1LTJLc8YCbplCMP5Gevwe+aTe/6VsnzTp839Mf0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Nm/xYOmkS0HIRczi/t604zsMaqpxWxp01QOhQlWzhT4=;
        b=W0rUtKLkmFEfIKtKd6ndZgTxMe/glFWU4slULMmGR8a239oF8imgfJtQx9tsBs52kNHjwE
        jgHKLTDiZ5Ak0JAA==
Date:   Mon, 14 Jun 2021 17:44:57 +0200
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
Subject: [patch V2 49/52] x86/fpu: Remove PKRU handling from switch_fpu_finish()
References: <20210614154408.673478623@linutronix.de>
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
@@ -517,39 +517,13 @@ static inline void switch_fpu_prepare(st
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

