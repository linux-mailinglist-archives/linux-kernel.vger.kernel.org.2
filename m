Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAA42D14E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJNEAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhJNEAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:00:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB7C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:58:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k26so4319338pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqLJE+F/ih5LDuvpsukHdnpoVjVbxOfB4N2TyGXArfU=;
        b=j4ktgasxgGa9LDCdcuPTlCzBCc51oI4q+OXLmPfkJ3jHKWQB9IvTSt6gBiINS1LOi7
         5lpwxAmPrfPWbmdB0CBKM7blDJQRF48qEqHOCC1oyD15iWqwwNZ95Bm2iWp4jyPKY91F
         ZWOzzzqdYmc2n4R8G/oflITSwtxYB5F+pcLseWXq1y1/7YsfxdPtmLcGnfSIRk6Ipiz/
         9thiTaaVSAHQlM4e1hDt6lnSv8d04GA/nJZv5fCJarLZukegqkH47QOb0mzDOmcwK1rE
         l79u9QM3YTqgBLDY8okCMDj9+4WLjP9T5wkaiEa1wpsKsxGpTdABohTiP2L9/EtF2Si8
         xhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqLJE+F/ih5LDuvpsukHdnpoVjVbxOfB4N2TyGXArfU=;
        b=jG4H2pGC1H6Hhh3lxHRxOGlUJIJDgkkcAy8GYAp78ta7Bhy5gUbkVsezr//yMDyNeL
         UkMIoWjmS55Y6rfteONytXj0/yZIUkprQhzLvpeZ/tgP4lH6HVZKgs7NCgFLrf+MyT6J
         FLc8dmySqvkgJZf0BzTQCXs8qCye04ptAcFiJlv0xKGkZJIS5Mn4i8/pB6sRXiEZ2oNN
         ChCVv5PBEei4YTsrOJTFUaltxHZ7xBlKv1fCaFECf1kx3ATCBsokerG9bFilnBnd0MfK
         4WYg09hAZHlKD8Qk8YCvoJ4/G1rwRr3DoGmNC4zSm0AfVuxFXm6eMSl1OQZxYaw6C1e1
         /2Lg==
X-Gm-Message-State: AOAM530Hf+TwH44yavFrDeAUhfYwFDA7RwT09d6Ok66vqZGCQuCRTSmj
        HB9E+wSVRPTYFG2aSZ1xO6mjPf99ywk=
X-Google-Smtp-Source: ABdhPJyJpkMStDrOSjynP/GJvwBTiT/qWCrFxUR5UBKC7xj8k3KMeeUPh+hmf0nSa2wlmo+TI6otYg==
X-Received: by 2002:a05:6a00:48:b0:44c:f5d3:8549 with SMTP id i8-20020a056a00004800b0044cf5d38549mr3304381pfk.5.1634183922653;
        Wed, 13 Oct 2021 20:58:42 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id x129sm904913pfc.140.2021.10.13.20.58.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:58:42 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V3 44/49] x86/sev: Add and use ist_vc_switch_off_ist()
Date:   Thu, 14 Oct 2021 11:58:30 +0800
Message-Id: <20211014035836.18401-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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
index 0afa16ea3702..03347db4c2c4 100644
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

