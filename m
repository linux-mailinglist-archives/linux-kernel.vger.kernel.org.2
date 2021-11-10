Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEA44C0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhKJMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhKJMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC443C06122E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v23so1396747pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifwDkthqp+OLMtF0JAwYMTH2xInM5hxoT3LHe8wvoRs=;
        b=ABCQs+JcfOtrqNcaQqLfSl9RPG4+8E/7wpfK5xI9odKK+VK6NASU5HlHzs4b6vVilc
         NpW+TSZGGUtVpkr63WWscFC+Ij+BAZafsyKR+EDdZaXrMkZs5b9Dxb/uU81d2DLQYQ2t
         PZBwuBm5K3zCicyuFY/uGC6Jzn23jFQxoM2JryXCZQInzzBXaWMCPguAd5H9krB2A/b7
         kQyGzR/ucoWRoTSWiBHoPGxqV4nhqj/yXdOgpnbZFH6/vvt19DnyONR0hGC44O3gYDmA
         1C/dl+A87BNZOd99umsm4P9Asnr23sEJkg2YYRYnvUWflrsDdqLR7E/czAlvdQEhtf16
         lAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifwDkthqp+OLMtF0JAwYMTH2xInM5hxoT3LHe8wvoRs=;
        b=aqwTXhblzyxb3MgdP8cWF3OSu2ubng9S5ZpK1oI+KSAx7/IbBAs6oXN7QJX/XVJMow
         fmHHMVln5N5PXI0OyX1simZ1JHmyG+Rzvs6n7PSA/wFALovRnXZ0qG99UC7u21xek3Hm
         uhnW3zBtem4Uapeck4uGQPY9HLQL20RTC+m/zuN47lwTd09aCMWLaDFJUGJcI7cTGjh4
         3NsUwGdD5ishJ+FOSbIfSMk8EVerzn5FP289uzbapDtPsZznCko2S1qWoI6c95X4xK9J
         HXIX1h9m5T8F7oIU0I4M5dvOPzhuNgbRzxothlCMt6u+CjU9J3qD2j7VPEmFbbXw6odr
         OHDw==
X-Gm-Message-State: AOAM532EyYzLD2LCOcI6NYrSPfSF8avy+VkPzjzv+kumsTZ5YwG09Es0
        9HTKP3nATk5fwxjhKeKReJAmMAdcxfU=
X-Google-Smtp-Source: ABdhPJwd/e8YoLd4Uq+N5LCuei+bAyT67JqOZfqoZntf95BHAWAawLqUh7AjQ0jhO1uzMZj9RJgdYw==
X-Received: by 2002:a17:90a:d3d6:: with SMTP id d22mr16078936pjw.242.1636545738076;
        Wed, 10 Nov 2021 04:02:18 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id z8sm19009734pgi.45.2021.11.10.04.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:17 -0800 (PST)
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
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V5 45/50] x86/sev: Add and use ist_vc_switch_off_ist()
Date:   Wed, 10 Nov 2021 19:57:31 +0800
Message-Id: <20211110115736.3776-46-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 9def3d2cedb7..944cf85e67da 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -515,26 +515,26 @@ SYM_CODE_START(\asmsym)
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
index 4e9d306f313c..1a84587cb4c7 100644
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

