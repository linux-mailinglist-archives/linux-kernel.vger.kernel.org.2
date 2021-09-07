Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF8402FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbhIGU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346589AbhIGU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9997EC0613D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:24:54 -0700 (PDT)
Message-ID: <20210907200848.699805190@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=txLTAvfCrpbPpD4W1xlvr75l/SIzjME+EBlmu+C3LU0=;
        b=zwekxeGSW7v1mmgmDyUC/urjUXfThQvDv+AHKZRP5lYQAW1X+rS24XlVvrZbiH19gTJdnx
        q2ckq97iRdqmQc0yrnJmD9es6BrMSSRq6Qp8YOerIrfW5WZM3Q5KGScUxwj5CglQ1UfcYc
        vPfFbDNRI4HFQMN3WowENSofdSq7j/cWziMk09rPykpUReKnkbyfpqS82P17kHI4bXZkQI
        7xlfWB2ry2b1V7PzrkB6BvtGQ5NlpckqC8v2zp75HM6AUtocVc6HAkIBoEck7tLJScJlLY
        ui0VV5tQ0WjBrnPG2j8nghJ72uVXsjmKXWfDNXZkq1oCfwRdMxqd+Jw4Cv+k4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=txLTAvfCrpbPpD4W1xlvr75l/SIzjME+EBlmu+C3LU0=;
        b=fZSk0qZox3j20XXEzZ4lT0jA05ZYGBvZ5SFk3BNbqfv6bX7IxSeqaxOzoHLkfbK2Hy0yDQ
        EIRNUeNfTCAKssBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 08/20] x86/fpu: Use EX_TYPE_FAULT_MCE_SAFE for exception fixups
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:52 +0200 (CEST)
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

