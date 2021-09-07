Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3056E402F48
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbhIGT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:58:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbhIGT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:52 -0400
Message-ID: <20210907195004.888293505@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hyvbnbIdba3aIUMikIZq5XBHm5TKNH+S4SCGtu4MYY4=;
        b=2+FYNx4S/Wxbe4IcMwMjkamVbffkwSRAwHHY+/gdFEnBGM5/izCTNAwwsepbwc/tGqcuNT
        dJDIojtDpEbiCe3Aeq3R5AnFC+8htWk/Xy9euhOIPp83RrU0bL9QaWDVJsRucSvjkZxKUp
        Rae/JEQa4vAFZQnLCQLqKm7H/2Fr5p02AeTYDT09/5Ejnaqf6io53I1WYbcOS0smi/Qsia
        sJiwCuKIEZk8gDVkekvbmntzclnvXgwqQExByJax4gzcOTXTuSuVTyQebhhMIfxmZPMTSF
        XqmP34LiVwaL3hQWzZq2O6RVfuIIC/AzGAEWKNfNMVxYtdpdpbnvqrDvXvGh/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hyvbnbIdba3aIUMikIZq5XBHm5TKNH+S4SCGtu4MYY4=;
        b=R9ecQqoTM+1ZrEla93ajKmf6aMPjry2/xqudhKxe5vkwUZPvH0J9kF58lRpKdVWtV4ia4I
        DVG96NVlenqmvLCA==
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
Subject: [patch V2 20/20] x86/fpu/signal: Change return code of
 restore_fpregs_from_user() to boolean
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:44 +0200 (CEST)
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

