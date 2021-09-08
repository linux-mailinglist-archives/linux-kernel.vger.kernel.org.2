Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D79403AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351829AbhIHNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351676AbhIHNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF47EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:29:32 -0700 (PDT)
Message-ID: <20210908132525.679356300@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5jeOxW36H43fKDkv84NoCQksuL/87wmqW6kiz8q5LY0=;
        b=aWCbvSnVW2+kbRs4n2ojuT5h2QDdbPEphwBghhmnX3Wh+xxYksOHpDk7UaqD7msbFvdFHn
        ZlpAS/n3J6ytPj206pyaw8e/ag9VOsju2svD43vv6N0qhkoiNLbcVMcskv5ow2NwVDzi9k
        wwmBLXEwlzzieqlrfI/iYfZyLr53lj5rL2it4zgeD0Ldv0VRgsJFUT9LehhrfKFPXwCtNY
        Ypp5Msr65Q/3pjrM0pZCghQDcvagW7lYQRQaitZNiPHqtSgXkJXjGGinJiMdVQDnGet0Zx
        YRTiRY9bdCNcSriZiG6f3XVL+OEE2NLHG6PqvE/a95+HcrX3F+VCkSrFpG4yRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5jeOxW36H43fKDkv84NoCQksuL/87wmqW6kiz8q5LY0=;
        b=vQFGfsSP0BtyFH8yue4R8TtwlYYvFxAvI6yunadKMWI/cAMgoBVRBfbMLpdYvQKxoZ2yMU
        WHlPorDoNYaQxGAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 13/20] x86/fpu/signal: Move xstate clearing out of
 copy_fpregs_to_sigframe()
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:30 +0200 (CEST)
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
V3: Remove the bogus X86_TRAP_PF check
---
 arch/x86/kernel/fpu/signal.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

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
@@ -218,9 +212,9 @@ int copy_fpstate_to_sigframe(void __user
 	fpregs_unlock();
 
 	if (ret) {
-		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+		if (!__clear_user(buf_fx, fpu_user_xstate_size))
 			goto retry;
-		return -EFAULT;
+		return -1;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */

