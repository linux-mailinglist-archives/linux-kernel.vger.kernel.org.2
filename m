Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E6402FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbhIGU0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345769AbhIGU0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:08 -0400
Message-ID: <20210907200848.991751342@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ud9Rd1/fZ50YrK/Tfm/gE+UHE7gbflVrR9DwkiPTzFE=;
        b=pWo00YPKJ7F5mXtUUNvZTZTws7haHF4eIexTWQNfLtRo45CGeSAIYAXD1Ir1ngcmAipPsd
        A4Y/o8GBHTKhadPLcOEF6mk/yQPL6Jj7ZHXP+31Z82/04cgh0/HuWaMcGdKWwgPJ/bxwRj
        J7WG/4INyMSmwstxD5YoVCef5d5Ey9oa+Smrgw4x6spoAVHx7vkFg8H0lk0KReofRSaqOH
        Ekk20vRbIZUq2nkTD4kv349/N/Tt15r82fEUzen5stL126B0MtFEBpfVDdTYJZckNo0Sib
        waQvMqtS22sSqshwm0qVSTWHiFamiuz3BqHOB67AduRUGNq3P3VPRYHauo4xOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ud9Rd1/fZ50YrK/Tfm/gE+UHE7gbflVrR9DwkiPTzFE=;
        b=JiHjc+eT5CO3ldqOvZuvj3cK87FGsvUa145OqnN36jJZwWUjlSHUweJkCAomX2yEpBcKnb
        QmNeEwitNfIRMHAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 13/20] x86/fpu/signal: Move xstate clearing out of
 copy_fpregs_to_sigframe()
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:25:00 +0200 (CEST)
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

