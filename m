Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3426243B46D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhJZOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhJZOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:41:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F71C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:38:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n11so10480900plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WItD6o8b1vZH8I2hWH50f5s8mnMvsJZI2GLZECZuBRg=;
        b=NtiN1gmH/4NM8Bk+5oiVK7BfqAHplsFlqqbh9mFLkgTJhSjCwxwn0f8H8SUtDeex/O
         P6QfvMksi0hk1fPG7SKrnDxkfqr8K8C2RxMGlwHb+Pbu+y69QD9rTjv91VNMcBltvd+/
         mSkQXIgVDvWJb0fLhg3DCPtFf6LBlLEfqwu739ptdEow4+7jQNv2RGW1R0J0ImY22PX+
         w7wm4llVXU0o4962R67ilHEWPVvdTGD8KUXSjsdC0gkL5bIyC/Oa+Ee4udyfYuO5HgVL
         hEivgLkng5VA30i4FnXoeBvRMW4ThdYt2w++rN1ta2rwfAq8yxv4fP2RHhTxhZpUs99w
         ES/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WItD6o8b1vZH8I2hWH50f5s8mnMvsJZI2GLZECZuBRg=;
        b=sw0MnJxmiWH/mWsPOxP3HWIbopGJ3LdsFpSWHdQDCP1/0CYALCZOd1h6eJxIWeyjGL
         nV7S3E8ytQ488+K3Kgn3vJfxvr1OxHU68as1xufR+ctLjJPPRJI1eKuEdBwI/SCerfDv
         6yEOL7llpSErK/kLaaKQgCvJhT1iAjLdECRoRsTm3hr0DlTnkawAoKVCUICZkeYqi7mC
         tiuGebE5lnVNXsnjrc7MoyvCuLkMCs14S9Zlh0muvbgQrtfXQ6i3Tb50YuIPidR9Y8/V
         CVYjjzT3E1drDq5q+ZgI5h3WQzG83D4BI/7Dui161Ca+s57zH6h/Muy+PGs0p5ZiZ8ga
         n65g==
X-Gm-Message-State: AOAM5316j5mXMOIMDphHxQUgnVi6t036oNKU3yIc1OMSuUzSNzUFBu9F
        rfRtPjMcs4zp9JclOftwG+Q+qtJyNRE=
X-Google-Smtp-Source: ABdhPJzENt2fVA62KRJTqabdbPRyorL7yW5J4C9Tr7CXDDn8NvmVnE0xtQ9MGRR+M0q8zGzci/ePlg==
X-Received: by 2002:a17:90b:224a:: with SMTP id hk10mr10372850pjb.139.1635259125225;
        Tue, 26 Oct 2021 07:38:45 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id c15sm13707651pfv.66.2021.10.26.07.38.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:38:44 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V4 45/50] x86/sev: Add and use ist_vc_switch_off_ist()
Date:   Tue, 26 Oct 2021 22:38:43 +0800
Message-Id: <20211026143851.19481-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

ist_vc_switch_off_ist() is the same as vc_switch_off_ist(), but it is
called without CR3 or gsbase fixed.  It has to call ist_paranoid_entry()
by its own.

It is prepared for using C code for the other part of identry_vc and
remove ASM paranoid_entry() and paranoid_exit().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S    | 20 ++++++++++----------
 arch/x86/include/asm/traps.h |  3 ++-
 arch/x86/kernel/traps.c      | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 57559d810785..58f33e86c6c8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -516,26 +516,26 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
 	/*
 	 * Switch off the IST stack to make it free for nested exceptions. The
-	 * vc_switch_off_ist() function will switch back to the interrupted
+	 * ist_vc_switch_off_ist() function will switch back to the interrupted
 	 * stack if it is safe to do so. If not it switches to the VC fall-back
 	 * stack.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
-	call	vc_switch_off_ist
+	call	ist_vc_switch_off_ist
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	UNWIND_HINT_REGS
 
+	/*
+	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
+	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
+	 */
+	call	paranoid_entry
+
+	UNWIND_HINT_REGS
+
 	/* Update pt_regs */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 686461ac9803..1aefc081d763 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -16,7 +16,8 @@ asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
 asmlinkage __visible notrace struct pt_regs *error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
+asmlinkage __visible __entry_text
+struct pt_regs *ist_vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
 #ifdef CONFIG_X86_F00F_BUG
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f82f2584389a..1c35ebb26b05 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -717,7 +717,7 @@ asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
+static noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
 {
 	unsigned long sp, *stack;
 	struct stack_info info;
@@ -757,6 +757,18 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 
 	return regs_ret;
 }
+
+asmlinkage __visible __entry_text
+struct pt_regs *ist_vc_switch_off_ist(struct pt_regs *regs)
+{
+	unsigned long cr3, gsbase;
+
+	ist_paranoid_entry(&cr3, &gsbase);
+	regs = vc_switch_off_ist(regs);
+	ist_paranoid_exit(cr3, gsbase);
+
+	return regs;
+}
 #endif
 
 asmlinkage __visible noinstr
-- 
2.19.1.6.gb485710b

