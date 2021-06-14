Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B601C3A6C13
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhFNQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhFNQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:17 -0400
Message-Id: <20210614155356.055164114@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3Aq6UAIp2+3vfweCp1SkCScNtvaaq7gatu0lK1wSu7M=;
        b=MR/34k7Xe5gCFhnw6U4AnXx55Yzfy+xUMYxrX9FE9J4lGGD7oChFU39Usg6Y/40ZaNwLsR
        ComVucXKVA6rnssoKtuEufouffZTbuc7QPKiG6zg0rbitYLbt39Dj1IjEPD+IqjmuBzFIM
        EZDR9D3AB0rtUhGkWpReVJP99EpXIniFiKKsLhhlamY+ztP5i5pNRrgtSgkVoCqVJcFQtd
        WOVO+4YX3GP6r0goULSR675liS2nmGSs5FnuhD/88T2Dk7AmjrDoQQ/iQJ7BsmiU7dw6fe
        JWP3fBLS6twZwZkyITU5JUhWM0IzWVZEJt+/583dm2LYPp8bA+vXSLzjwVOJFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3Aq6UAIp2+3vfweCp1SkCScNtvaaq7gatu0lK1wSu7M=;
        b=Zk240UdqoynNoTViA9HJCAVqyW39sJVMKgGp+2lxG6mx6mdaD1IzOL5EkgUb3oP0ZopUo5
        Rs6iX15BSNMZmBDw==
Date:   Mon, 14 Jun 2021 17:44:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 23/52] x86/fpu: Rename copy_user_to_xregs() and
 copy_xregs_to_user()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for xsave[s]/xrstor[s] operations are horribly named and
a permanent source of confusion.

Rename:
	copy_xregs_to_user() to xsave_to_user_sigframe()
	copy_user_to_xregs() to xrstor_from_user_sigframe()

so it's entirely clear what this is about. This is also a clear indicator
of the potentially different storage format because this is user ABI and
cannot use compacted format.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 arch/x86/kernel/fpu/signal.c        |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -324,7 +324,7 @@ static inline void xrstor_from_kernel(st
  * backward compatibility for old applications which don't understand
  * compacted format of xsave area.
  */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
 	u64 mask = xfeatures_mask_user();
 	u32 lmask = mask;
@@ -349,7 +349,7 @@ static inline int copy_xregs_to_user(str
 /*
  * Restore xstate from user space xsave area.
  */
-static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
+static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 mask)
 {
 	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
 	u32 lmask = mask;
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -129,7 +129,7 @@ static inline int copy_fpregs_to_sigfram
 	int err;
 
 	if (use_xsave())
-		err = copy_xregs_to_user(buf);
+		err = xsave_to_user_sigframe(buf);
 	else if (use_fxsr())
 		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
 	else
@@ -276,7 +276,7 @@ static int copy_user_to_fpregs_zeroing(v
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
-			r = copy_user_to_xregs(buf, xbv);
+			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
 				xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 			return r;

