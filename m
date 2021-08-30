Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895EB3FBA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbhH3Q2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbhH3Q2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:32 -0400
Message-ID: <20210830162545.880982064@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3FUlW7gTDQNHNIUKT4Gu5kc3k7ZAzSULIDvbFs5OhHw=;
        b=SNx5MC4rzzWGh3a1dbUPJfu6VUR/RSs7RwBveMFjfMcil1Xdw6jczW1oWYxYcxiZmKqpsW
        xwccwobYiqT2ImKLBuyvvqLIgyfUr/pe4sJAnSVdseiw2ut5TL46rU5q8SzQoGKSEFl0ah
        TUHn7/1siDINjxx4kgonKPVf3i9RfyfcS36I4TJPW2J39rhkYW0K8N4oG3NSxXJLluSTNb
        WOFJI8EwaUNmRl8RzAY90NGV7gDZpHqDv8PCE2lvqpHLupgk013e61Uzg3VzkNfulgcH8s
        y+FsdQuDaHI7n89nEWoVHJsa/0zpzayBrl4cxOGcRrINAEH8JAnR04zLD8TJuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3FUlW7gTDQNHNIUKT4Gu5kc3k7ZAzSULIDvbFs5OhHw=;
        b=pbmcrj8lZcR7XI082j9pX6yAOBk9gUAnR4oXb7Rm7PLnAj7tAapo7YIvo5+vX0qO5/+Kpm
        v5NaHRLht2Ypg4CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 10/10] x86/fpu/signal: Change return code of
 restore_fpregs_from_user() to boolean
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:36 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__fpu_sig_restore() only needs information about success or fail and no
real error code.

This cleans up the confusing conversion from the negated trap number which
is returned by the *RSTOR() exception fixups to an error code.

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
 		if (ret != -X86_TRAP_PF)
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

