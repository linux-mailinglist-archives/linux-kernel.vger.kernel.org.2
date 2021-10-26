Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71243B460
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhJZOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbhJZOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:39:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C2C061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t7so14330078pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hg5X/fXuO5IzWpbw25ZvrVT5KoY60jnAFeBGvtwJeGk=;
        b=N3nDCx4tD873STgFEHBs43J9UvmV39d16dJ4bVKRJXH0RRJm9kFPZLyCQNEsTLLb75
         f0RBjB5fg47e+dWjJxT7odsAORyzNdmk+d/JFvzXYuMWeQV/yGoU04ycVkR5yrnvOXNY
         CqWfbnhJGbKNDapAudNYS+vlMQ2gPKhK2diawcDA1FJi5DAe1vQ1zdvSxWj6MWvzjpq2
         SDBR/IsOe+etxFYJMR2vGkO3JLISEojyTAarHrVk3YyS9wHWPBRd7etVJEEtAlTAGaKf
         +4dM/Y8vW+tGf5QWLnOgS3w3t81a3ccpAEyMgJRPTB9zfswu7pdnplm7JR3eYrcpLjZI
         lUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hg5X/fXuO5IzWpbw25ZvrVT5KoY60jnAFeBGvtwJeGk=;
        b=f3qOOTYbYbO1WX9xqzVufhTaMbdfe5vXbJ/9c+XWEPhFO/5jARtxJUuRLth7+isDpP
         62bJoCqGdgNgOndk0ScaKX5eaPUa6RBFLnv2YRL2AQkpXFAafvgOJQQXuOl5JB9VvmVm
         nLHVMsC4sWIPkYDF70AoecWhH8DCm1VLcLBOvqDtHvniqRJ+L0Ssq+fSOG0mGggYQgYd
         ZgeQQUOldf9V63/jdc493RNFnkPgfrMww9rBiZgqIi/iFBcnPdLW2qf9SEJgsL11fEqk
         6cdERwtuLTN0QxQEY65JRWF3wZ0+8sqznR5wf0sk7WUiUm216HSkMnBbRnZQiCJyF+k5
         6dMg==
X-Gm-Message-State: AOAM532n3WXjzflNNXV+DJV3qweswlP16jHKatk3ZPcN4HBfbpWW027T
        A4H6ohkqQu1l4HXkHfMFFCULTAFVSK0=
X-Google-Smtp-Source: ABdhPJy5YI7xE2oVzuyjKTNCO4ouG2Q0eufsPTNmK9g4UIWTNam2QNijFxozPVD3lRiSXMJ4ddSNPQ==
X-Received: by 2002:aa7:83cc:0:b0:455:c394:caba with SMTP id j12-20020aa783cc000000b00455c394cabamr26564073pfn.28.1635259002605;
        Tue, 26 Oct 2021 07:36:42 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id q13sm26428749pfj.26.2021.10.26.07.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:42 -0700 (PDT)
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Chester Lin <clin@suse.com>
Subject: [PATCH V4 42/50] x86/nmi: Use C entry code
Date:   Tue, 26 Oct 2021 22:34:28 +0800
Message-Id: <20211026143436.19071-17-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY to emit C entry function and use the function
directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 17 ++---------------
 arch/x86/include/asm/idtentry.h |  5 ++++-
 arch/x86/kernel/Makefile        |  1 +
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7c994bcde1b0..0a1a55c8207e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1309,21 +1309,8 @@ end_repeat_nmi:
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
index b9a6750dbba2..57636844b0fd 100644
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

