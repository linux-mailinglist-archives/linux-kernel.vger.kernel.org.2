Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6005402F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbhIGT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbhIGT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:32 -0400
Message-ID: <20210907195004.216576712@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=txLTAvfCrpbPpD4W1xlvr75l/SIzjME+EBlmu+C3LU0=;
        b=Rm3IAK34YZkrU/GBKwu0XNB7LjqD9MZPxAWs/EKF4T2hY5XfNPwATLKjMW+yMiBul1tbg2
        go97pMcg65g8Es461sfGU7f2pKnsMLrvWW3iOmBGP8D5punXcFud+zV+g0j0YHrBjo6hy/
        gP3AhPJPftLxDQsbX5YkdviwzdTftdHiNvOH5qSodXOyN0mz58RazC3vfY62iEen0avgWP
        NXuqk3HVE/AflSBoDQp5yQI9k36kqqUWG6/On9nA4PIu+DhRiP4xu+eActE62MUUZq04jH
        N51dA5XS22NTvq6R139vywFw90NhCvRS3A1ysL3xtsz/fN+2dSYPaedgcfa1wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=txLTAvfCrpbPpD4W1xlvr75l/SIzjME+EBlmu+C3LU0=;
        b=Ym0f1Asx6hzuXs1Q1WpwfrqJ0B3U+zmhqIlDVnKmvyY9tAe6ft1nm1hQnYEgvKyqekf9tW
        +iOXs6MxgICN7+Bg==
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
Subject: [patch V2 08/20] x86/fpu: Use EX_TYPE_FAULT_MCE_SAFE for exception fixups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:24 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros used for restoring FPU state from a user space buffer can handle
all exceptions including #MC. They need to return the trap number in the
error case as the code which invokes them needs to distinguish the cause of
the failure. It aborts the operation for anything except #PF.

Use the new EX_TYPE_FAULT_MCE_SAFE exception table fixup type to document
the nature of the fixup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -102,7 +102,7 @@ extern void save_fpregs_to_fpstate(struc
 		     "3:  negl %%eax\n"					\
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -209,7 +209,7 @@ static inline void fxsave(struct fxregs_
 		     "3: negl %%eax\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")

