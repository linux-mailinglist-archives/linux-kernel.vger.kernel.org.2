Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F011402FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346941AbhIGU0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbhIGU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B42C0613C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:25:12 -0700 (PDT)
Message-ID: <20210907200849.336397756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fBCsbpH9Cg9hzkyxGoEzUABjt5cYk0sCaKpx5p95NY0=;
        b=dm607QlJOIBEKL4if41bdtwN5p+g0XzxBwziGpXFTa6rdEt+bTKq60IHSxO0MMDylde0kE
        bJ1gFgcWkZEmm/H35h+TSwBzmFwcrAyT3CnSMAwMVff0qDLjeqYzUeP9hClIeO6oDZlpkj
        zZ7xvAy80EfB6seNPsU1Xn1U+NZL4wlhNutVhE6mlescJRWRNyGHdC/L8txFU5st0lu8G6
        eAJ7ZVmY7AoW+bpZggEOJaLvPN7QrDO7xVerENh9wlbt8KUSgeKftU9mYo2vGmCF/gMDml
        BLFOs/WkSq/A1t2ngYuld3xxzQKdM2EvopL0XCF2LfGMI+V1OpYtYLo1AmUSZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fBCsbpH9Cg9hzkyxGoEzUABjt5cYk0sCaKpx5p95NY0=;
        b=KnZXcNzy8rzPDjKn9GUEBntT69xuZdk5OtoVmzfJVsig4NSc3xJCKmpxXU1g4ibLmvjfjQ
        UEOHJWlalaIQZnBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 19/20] x86/fpu/signal: Change return code of
 check_xstate_in_sigframe() to boolean
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:25:10 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__fpu_sig_restore() only needs success/fail information and no detailed
error code.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -23,8 +23,8 @@ static struct _fpx_sw_bytes fx_sw_reserv
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline int check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
-					   struct _fpx_sw_bytes *fx_sw)
+static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+					    struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size = sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
@@ -32,7 +32,7 @@ static inline int check_xstate_in_sigfra
 	unsigned int magic2;
 
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
-		return -EFAULT;
+		return false;
 
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
@@ -48,10 +48,10 @@ static inline int check_xstate_in_sigfra
 	 * in the memory layout.
 	 */
 	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
-		return -EFAULT;
+		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
-		return 0;
+		return true;
 setfx:
 	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
 
@@ -59,7 +59,7 @@ static inline int check_xstate_in_sigfra
 	fx_sw->magic1 = 0;
 	fx_sw->xstate_size = sizeof(struct fxregs_state);
 	fx_sw->xfeatures = XFEATURE_MASK_FPSSE;
-	return 0;
+	return true;
 }
 
 /*
@@ -325,7 +325,7 @@ static bool __fpu_restore_sig(void __use
 	if (use_xsave()) {
 		struct _fpx_sw_bytes fx_sw_user;
 
-		if (check_xstate_in_sigframe(buf_fx, &fx_sw_user))
+		if (!check_xstate_in_sigframe(buf_fx, &fx_sw_user))
 			return false;
 
 		fx_only = !fx_sw_user.magic1;

