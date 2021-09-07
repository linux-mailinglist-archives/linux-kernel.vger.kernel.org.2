Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C866B402FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbhIGU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345433AbhIGU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:25:13 -0700 (PDT)
Message-ID: <20210907200849.396117872@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hyvbnbIdba3aIUMikIZq5XBHm5TKNH+S4SCGtu4MYY4=;
        b=spS9kG5VjiPaTYo79U536qMP5jT4/qj34k5vGbdgFsqd7zdjtSO+vj0ceCgeNaV6wCNLmE
        W6jiKzS5c35PjTOn2EP1HWAjOEDOtax/5+NSAEJFwlVHq5FjFxn/5kEWdrKRoGvLd6oZwU
        cz96NePXbYw1RQ9//Ynf0UXQjk19hyaHhRDBx2xn3Xx8f+87urjvipVvHc0yJtdZ6HbJsY
        QAqjZqdrwJ7vgH22tzq3lG7VH6D6dysbzpFWE/U6VCmXG+QLjqYfBPae1UeJK6z0SInoFA
        isC6dVxLBamIVvHis1GnjwHconwdDgkGpFmODJ0VUp+d8m740irl6/7myMpyqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hyvbnbIdba3aIUMikIZq5XBHm5TKNH+S4SCGtu4MYY4=;
        b=SPQk3t2DRFOsGXVwiJTQ1W8DvRj9B5I+WXk9HWgkKmoeHfsLIxlndfm/RriG8//BCa8egA
        rIrPk8h2/0Z9cbDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 20/20] x86/fpu/signal: Change return code of
 restore_fpregs_from_user() to boolean
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:25:11 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__fpu_sig_restore() only needs information about success or fail and no
real error code.

This cleans up the confusing conversion of the trap number, which is
returned by the *RSTOR() exception fixups, to an error code.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -255,8 +255,8 @@ static int __restore_fpregs_from_user(vo
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static int restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				    bool fx_only, unsigned int size)
+static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
+				     bool fx_only, unsigned int size)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int ret;
@@ -285,12 +285,11 @@ static int restore_fpregs_from_user(void
 
 		/* Try to handle #PF, but anything else is fatal. */
 		if (ret != X86_TRAP_PF)
-			return -EINVAL;
+			return false;
 
-		ret = fault_in_pages_readable(buf, size);
-		if (!ret)
+		if (!fault_in_pages_readable(buf, size))
 			goto retry;
-		return ret;
+		return false;
 	}
 
 	/*
@@ -307,7 +306,7 @@ static int restore_fpregs_from_user(void
 
 	fpregs_mark_activate();
 	fpregs_unlock();
-	return 0;
+	return true;
 }
 
 static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
@@ -342,8 +341,8 @@ static bool __fpu_restore_sig(void __use
 		 * faults. If it does, fall back to the slow path below, going
 		 * through the kernel buffer with the enabled pagefault handler.
 		 */
-		return !restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						 state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
+						state_size);
 	}
 
 	/*

