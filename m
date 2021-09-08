Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D8403AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351624AbhIHNbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349481AbhIHNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:29 -0400
Message-ID: <20210908132525.269689153@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sMaDLxrOOHRQpRXrrgdTg8Jdc/QYMZRLIYFiAKksplg=;
        b=ead6ZXZOBihpXKHlOTr9GCgNoKckd+qtSfTwRMYY89psDCaIFtXDz4fklGZpSRWmzCFzPf
        gJGNsstN9OUBfbJjq8gVLhLBMyiEGU1aVikmFPceWHLGEbJX9eDQiBiqDOVGPcZKrsmdF4
        BTGuwTdp9QwnMiJ9sFYoP5fImDxgUIWyyncXxOb/iIookr9N5vD+P11dxtasvnZe3Lwb0N
        Re0FYgd3SqPJ/OphaPtUKR7ABEaeqAqL5CGlf5eg3qFAzSFYk5VCwRp1dP2haJ0q1SdE/5
        wsV937pbUkqj87cYQ0dwufa5ReaBlIUTIqKaIsqe6CwcQG21fkxsp30N1Yl1kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sMaDLxrOOHRQpRXrrgdTg8Jdc/QYMZRLIYFiAKksplg=;
        b=Yn/YTK/GFZfOPwY85H894VpvzWAeU1F9NIxwMnI/63gmFG9p6KTudsv4MNtmEc9k3h9Eak
        blwOZKFp5piJ+TCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 06/20] x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and
 EX_TYPE_FAULT_MCE_SAFE
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:19 +0200 (CEST)
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

