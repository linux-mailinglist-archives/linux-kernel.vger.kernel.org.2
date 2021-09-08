Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607E0403AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhIHNcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348576AbhIHNav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F7C061796
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:29:43 -0700 (PDT)
Message-ID: <20210908132526.084109938@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hyvbnbIdba3aIUMikIZq5XBHm5TKNH+S4SCGtu4MYY4=;
        b=rFxC3S5gbRp/H2bomRXVEANafwUFHVJ7upN0L20UZ2PqVAVUlH7CmEjfjVc+fZrFoc6mj8
        XQdd/63M5xOm/GwxBO1/V9jCCS10TsZhicw0OqeApOAeXAN5VxSTLpNAu4ufR9mp1MiVpv
        FilOcjgvGkM4VzBmX2X2UT7uwQxjObxxcGFcbW6mai7Bt4bL/+E6tlyO9+wYfgyWVGZ82v
        W2bHM/vHRCeqAU69xcmEzW/Na33a7hFSq2Mi4A+NVF2tir56UWynjv+si6PQPMyAE5nS/z
        QBuIAUzymwRuoDWrukIvpHj7Bmk7GqTTH95fh/so6+BQ5yR9XXSfmL3AXc1B8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hyvbnbIdba3aIUMikIZq5XBHm5TKNH+S4SCGtu4MYY4=;
        b=5JWFH5GRh5L6dCTS+U+lx3eNAjpXYCMXL1h8O1mhrBIXsJALQowhGi/s2qxChLo/0AFXtW
        ZZDRXYsO0WzXhECg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 20/20] x86/fpu/signal: Change return code of
 restore_fpregs_from_user() to boolean
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:41 +0200 (CEST)
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

