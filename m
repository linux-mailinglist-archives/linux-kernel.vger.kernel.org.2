Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7873FBA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhH3Q2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbhH3Q2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC5C0612E7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:36 -0700 (PDT)
Message-ID: <20210830162545.823787435@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fBCsbpH9Cg9hzkyxGoEzUABjt5cYk0sCaKpx5p95NY0=;
        b=fkwXd7XCC4qpJW5mC/Zluqdq99KS++HFjoPNXvYp79z0fgjkzlAxfP24QWEyXHqdieVJyM
        ESM2oMvLehB5XJZ2AO5ui9gv+eaSPbNougLH+vIuOgtEO0IklZBqa7kysp6dYukjwg62qv
        5uhqzmFNlYQbkEtJq1lPyTM8RN6fWcXrc/mdfNPk0w+miigl0V9WGJ1fxWUtPO6cqJi4PE
        rtqjOP8SmYif+PlPM+XMMOgZ6lkeL203Z8xd/+iYzcqOAO6ClLkQOJjSdZOWxNWUjBW5tt
        3ZUFLxA1wDOjyVN+ouNBFSGMnwH7Ens/8Dq9qriOgvGdrpqbZJOZYZMV/NKhzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fBCsbpH9Cg9hzkyxGoEzUABjt5cYk0sCaKpx5p95NY0=;
        b=K3taoN7eoCDQlU6if5SG2syxzTWYeSkDAPltXKF+ONyRhiF3B8vXCku2Jh1wA33emZkHk3
        mDkgma+8x/tA0sCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 09/10] x86/fpu/signal: Change return code of
 check_xstate_in_sigframe() to boolean
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:35 +0200 (CEST)
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

