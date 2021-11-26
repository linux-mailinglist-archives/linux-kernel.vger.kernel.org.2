Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5F45EB86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376799AbhKZKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbhKZK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:28:36 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912EC06137A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x131so8463401pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uR4m6ifObxFLSv5+D5ccFLNsJTzVIwm+L+AspgH/sbc=;
        b=qXF+IVQG0dJL20dypSXsR7QCpiBBUUokf55xups/pCWC57wVk96LvlWYtF7HO7/33x
         0nD4RWmsdQKB7MhOFv0/5MQWwtLwfH1egAFss0Vhm6DUEZBSYEhcIozKZezOGcfvmU2k
         oItWpZIpgLPLLBJU25qcT1VATc/HRjsSZHQXotHNhoHTLQBGktfULgXlttgTRAwOC/UK
         OBsCQ777Iy9lKxyzZDDQLMM21dPZsBVufhbFaJlOQdHC5AG4J3gPDYo/0sY32HUyt5Nu
         aUYIhNsZgofh1K79bXAlbpVvb44V20rNahEMjZtF8Exm6C80cYP9fFP9RIG/q0hCmsPU
         05bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uR4m6ifObxFLSv5+D5ccFLNsJTzVIwm+L+AspgH/sbc=;
        b=HN5RBBkTpEUGGThXBRLLHpQKRiQG4cC7CGIFxYbIcrCzrA++cQhfDMVdC3DG/52JRi
         W5+kLkkzkq/xIrxSODtNz6HSzjx0EoM2XA1q7/rV6FbFaKGSL77xJr3DaKyQxCxLs5S7
         gKsp4Zex4d5KcEXtiTODN/HaOQiQygkiFkCbmgxgmr8H4+2/Jc4a8dygi1KKgUMdbGnN
         paMTfQeapv6SwxjQKv1QL5uZf/cC6Oz40fT7EAIVbaaCdF400h6+R0OCz0vrEVh/2DUC
         J7teuGb2wr56AawG59Mo/b0St8O96l6kAa3LxpaIrzPbUeoWM1Ll3ZD1WJs3roejGiMT
         ueZw==
X-Gm-Message-State: AOAM532mLekfMXMq9B2R1bCO1hcesOcox5hNxC/gF1gOmEcQUkBC+azA
        8/TwzZGDz/rLRGUPWnIN9xm5eZ2htMA=
X-Google-Smtp-Source: ABdhPJzhVJHtxlOgjrvlNxgXLaEVYHgPHS2gbT4d9cPSFAS5bXRfpqQIYg8bOxrUZn/FIPsIUwwaHQ==
X-Received: by 2002:a05:6a00:234a:b0:49f:c0f7:f474 with SMTP id j10-20020a056a00234a00b0049fc0f7f474mr20107522pfj.64.1637921777599;
        Fri, 26 Nov 2021 02:16:17 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id ot18sm6082432pjb.14.2021.11.26.02.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:17 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH V6 41/49] x86/nmi: Use C entry code
Date:   Fri, 26 Nov 2021 18:12:01 +0800
Message-Id: <20211126101209.8613-42-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ENTRY to emit C entry function and use the function
directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 17 ++---------------
 arch/x86/include/asm/idtentry.h |  5 ++++-
 arch/x86/kernel/Makefile        |  1 +
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ac05cbf894f5..cc552e23d691 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1306,21 +1306,8 @@ end_repeat_nmi:
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/*
-	 * Use paranoid_entry to handle SWAPGS and CR3.
-	 */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi
-	movq	$-1, %rsi
-	call	exc_nmi
-
-	/*
-	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
-	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
-	 */
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_exc_nmi
 
 	POP_REGS
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 737fbbe19d84..b65cb61aafdc 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -372,6 +372,8 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 #define DEFINE_IDTENTRY_NOIST(func)					\
 	DEFINE_IDTENTRY_RAW(noist_##func)
 
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
+
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
@@ -421,6 +423,8 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 
 #else	/* CONFIG_X86_64 */
 
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+
 /**
  * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
  * @vector:	Vector number (ignored for C)
@@ -452,7 +456,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
 
 #else /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8ac45801ba8b..28815c2e6cb2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -51,6 +51,7 @@ KCOV_INSTRUMENT		:= n
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 CFLAGS_traps.o		+= -fno-stack-protector
+CFLAGS_nmi.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

