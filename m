Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD03402F41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbhIGT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346303AbhIGT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90EEC06179A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:34 -0700 (PDT)
Message-ID: <20210907195004.491774936@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ud9Rd1/fZ50YrK/Tfm/gE+UHE7gbflVrR9DwkiPTzFE=;
        b=1vp+q4AeKzhE+UuMKWueoEQHHYKrGsu9qRiPJleUQu+R2RHD7MU1wHisyCbX6a9QNQ8JZx
        gtnZ4ydtfc9xX11rYH1u9xJoO1WmnDebJcvq2MKhO6jU8nSrnaW4RTpZebs4KTTNMsDQ+S
        yPyBZWloga2Q+vVvFRa0rU9bhIIqcgPENYXPzrx9QSiFgi6O8a4jttLPWVBmbUOTtdKSaL
        mo0kUi5XX3y4jlLjU8aKUAB1MKhXH2yvrxXSjz1d0WAX6jxWSUotcNJciqW5DRwJBuR/oj
        s9XTGMPXnCoJibYYboFMEtx2Ch3kzxUGfl6MZxvvoyC1amG2UwZJPec+uECkaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ud9Rd1/fZ50YrK/Tfm/gE+UHE7gbflVrR9DwkiPTzFE=;
        b=+1vR4VjFgq///4eq4A341nFuxF8DdsxsLfxYaa2lq4c6EfNIulBe9LvDkX7h07Qb4v3CNa
        uBhoESxT9M78rEAA==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 13/20] x86/fpu/signal: Move xstate clearing out of
 copy_fpregs_to_sigframe()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:32 +0200 (CEST)
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
+		    ret == X86_TRAP_PF)
 			goto retry;
-		return -EFAULT;
+		return -1;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */

