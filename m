Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E221F3FBA21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhH3Q2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbhH3Q2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB9C061760
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:27 -0700 (PDT)
Message-ID: <20210830162545.486406880@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BViExDUUk0819C3tKkPGXmNE65S3GQe4k5Uoukrl+kw=;
        b=yR4kiJbbTqnneEtHLlxaokL/r1l4t6YMijGwQc2Arjjg7n+HgRMu4yRnMifiL5FPOvsjZX
        aT4cYCGkpDu4tckseHuh/z7A7ajnnhFJiKFLbshW2Oe3vKiGyBxrheVBIDwEVwrJMABNjO
        cvSWKz1qh7wyJAHWhh2POzLDGtHyD0Jb2eUDbqxoaFVtuCYa7Zq/2hh6bLY3st7PhCXDjg
        6lCPKibGMvxUD4oAYKkNLjeffJE3GIHEKE/WJQinYZHCixGP5nunwbJTnT9ULq9mwfrmxW
        ROHDcUL5EIbCpJFKjgHRDchx2e7D+Wc3Mzor0MmzU5nYMEXHWFuLtXrvsRP5jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BViExDUUk0819C3tKkPGXmNE65S3GQe4k5Uoukrl+kw=;
        b=FwXbdGDnAdPphPeAy7cr2J9VTqx9FPyPqocNj9ScyhpwDG1AG/Sq3QjlI8Eqx8QQDV90Aa
        1jwlSxCAAus3R7Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 03/10] x86/fpu/signal: Move xstate clearing out of
 copy_fpregs_to_sigframe()
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:25 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the direct saving of the FPU registers to the user space sigframe
fails, copy_fpregs_to_sigframe() attempts to clear the user buffer.

The most likely reason for such a fail is a page fault. As
copy_fpregs_to_sigframe() is invoked with pagefaults disabled the chance
that __clear_user() succeeds is minuscule.

Move the clearing out into the caller which replaces the
fault_in_pages_writeable() in that error handling path.

The return value confusion will be cleaned up separately.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -136,18 +136,12 @@ static inline int save_xstate_epilog(voi
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 {
-	int err;
-
 	if (use_xsave())
-		err = xsave_to_user_sigframe(buf);
-	else if (use_fxsr())
-		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
+		return xsave_to_user_sigframe(buf);
+	if (use_fxsr())
+		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
-
-	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
-		err = -EFAULT;
-	return err;
+		return fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 }
 
 /*
@@ -218,9 +212,10 @@ int copy_fpstate_to_sigframe(void __user
 	fpregs_unlock();
 
 	if (ret) {
-		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+		if (!__clear_user(buf_fx, fpu_user_xstate_size) &&
+		    ret == -X86_TRAP_PF)
 			goto retry;
-		return -EFAULT;
+		return -1;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */

