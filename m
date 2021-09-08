Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180B7403AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351924AbhIHNb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbhIHNat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:49 -0400
Message-ID: <20210908132526.024024598@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fBCsbpH9Cg9hzkyxGoEzUABjt5cYk0sCaKpx5p95NY0=;
        b=vwUlicYVt0u50ncHNbL/jVT6cSTWcXTE7L72ion9U8EybLIPk6CRA0+wj4ikMgkGmEfKJ0
        ZnNFnHQlhlkc/xABx4fon1uFbZaa/fNMQKcNlaSyuamfm18ALubQF8SiNd4EV0RHqgQY5c
        764v2gjJOfn/YsWN4cemk3B5An912MWtstw4pmRudKrvRUYBeNnB0cayVyJQUoMtvqLLKZ
        0ZJ91sxAEa3B+PptZXtSJpJDhrCh+6v3pReo9D6yuIQ1KXVXPBMs5F1zpAJuj+tQgf2H7y
        yDywnPEenqjYA5JvFkvaAt9iSQnZPVsfDDi4Rz4cuL7GxmjpyT6BTA8GBvPCrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fBCsbpH9Cg9hzkyxGoEzUABjt5cYk0sCaKpx5p95NY0=;
        b=e/M34SKZK3PKNHCchsRWn3LYX20Jo1aDkA2i+jcx5ldApIdOBC635gNMHoMOQYQUzl8QlW
        r7o9LOH1cMDEpKAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 19/20] x86/fpu/signal: Change return code of
 check_xstate_in_sigframe() to boolean
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:40 +0200 (CEST)
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

