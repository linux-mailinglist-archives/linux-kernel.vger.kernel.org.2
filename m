Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC59C402FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346552AbhIGU0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346556AbhIGUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A75C0613A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:24:51 -0700 (PDT)
Message-ID: <20210907200848.586382643@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sMaDLxrOOHRQpRXrrgdTg8Jdc/QYMZRLIYFiAKksplg=;
        b=HZjrju9PqQfiwcOOf3Cu4KbQC3czQZfKzw44xgDcnOGP5lybm8YKGJyP+oyeDXMAhmMMeF
        a1njtFKhzQNAmTH2XnFqlTR2N31u0rOPAZjcnc6g2P4Y74VzrU/drlZekc1dYeFuyZwe6e
        RTjNCKELHP9RrwG7dlPkp4kl81HS9VQgqR4aLaHDbdcZYdkTMGWQB0qBs+INB9VQ79KOer
        o+EH3RmvYLvuXrAYM+ZDg4uJ+/0aFvfx4WakOPRyo93w/gGhI707z8ChYRts+D5y6sOFqP
        pQv6qEV9A5Akfoeg2Y7idv01YCU3vQJvM9mxNJF8PeNSIyYH8RHjFGxXwinjtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sMaDLxrOOHRQpRXrrgdTg8Jdc/QYMZRLIYFiAKksplg=;
        b=teGPzIgRblggDTBJUjXBpo9uI4nQ1VdZYaOesfszRwkZJQ8ZDynH/N+i0+I5Txj2x7Eb3+
        VYkX+Ryban+bFHBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 06/20] x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and
 EX_TYPE_FAULT_MCE_SAFE
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:49 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide exception fixup types which can be used to identify fixups which
allow in kernel #MC recovery and make them invoke the existing handlers.

These will be used at places where #MC recovery is handled correctly by the
caller.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/extable_fixup_types.h |    3 +++
 arch/x86/kernel/cpu/mce/severity.c         |    2 ++
 arch/x86/mm/extable.c                      |    2 ++
 3 files changed, 7 insertions(+)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -16,4 +16,7 @@
 #define	EX_TYPE_WRMSR_IN_MCE		10
 #define	EX_TYPE_RDMSR_IN_MCE		11
 
+#define	EX_TYPE_DEFAULT_MCE_SAFE	12
+#define	EX_TYPE_FAULT_MCE_SAFE		13
+
 #endif
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -278,6 +278,8 @@ static int error_context(struct mce *m,
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
 	case EX_TYPE_FAULT:
+	case EX_TYPE_FAULT_MCE_SAFE:
+	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 	default:
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -131,8 +131,10 @@ int fixup_exception(struct pt_regs *regs
 
 	switch (e->type) {
 	case EX_TYPE_DEFAULT:
+	case EX_TYPE_DEFAULT_MCE_SAFE:
 		return ex_handler_default(e, regs);
 	case EX_TYPE_FAULT:
+	case EX_TYPE_FAULT_MCE_SAFE:
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
 		return ex_handler_uaccess(e, regs, trapnr);

