Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F044C0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhKJMEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbhKJMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE56C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:55 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p8so2035734pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwe147BgmRW5M8DCsZG/sjJusfIUl8gFyk7MG/7lkdw=;
        b=kzI6yE/bsQpBxrk/u8NMFDJKedkLphT4qDM9XWOQR/DEpARjQr7UUo8cqHkje7rnoT
         Fu5LglEmBnNnvDijYFchN/hmEZzY5F93rl1uXL0uzvBzDAj4YCN8quwNFcjTQU96YUlb
         XNU3PaM2Ir/Io0wspIRvwMwvkvaRzCW33l+/NpJ2QV9SBhByc8ymOpsxTzaME6EYpuiv
         A2tW0tNID6dwlifHqpwhchrP0AycCWekhyO6Px4DXoztHil0v1atIsM9toaHtAo/+DOf
         Xypf8CcmoSmCtfsdNYIwgtu5VMLbWOrj22NYoXh/l2REUxobnUNDsNVOJ9FdgR3+hhfA
         a45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwe147BgmRW5M8DCsZG/sjJusfIUl8gFyk7MG/7lkdw=;
        b=Ba9MY8VUl/15eVw7zOtpRl1Ea5aw36IxZCG0iZ0V6UE7JJwnjs3BN5sxCPd+CTMItO
         M8deq1ZuX7Bc0FIDYptnunPbMvqCq5CxqX9V7uzDG309srW9MqYAFNXvTeTyE6X6pmPa
         t8AAWYopFsaCr9dD6zJyUBCU3j/9xQMIlV7XwmoTmuiCD3mPcPQ4oTS/xR9+jHkZRSl7
         UXiPZLyzJ+nhjUQOQu2SdSuKWRcgykyK2ft00HHwRz7hzESMo6Tyb8NExfXDsB0Stzau
         IeIwTFr4yrud/wvchJlNyJCr4lFnPgPjgKKKv/jQ5QyKv6bBjhAq4JhgH8svYCkbfWJV
         5tfw==
X-Gm-Message-State: AOAM530IyvR0yyzRxtHj2rStEoW8QrQ4CgWp+xbmK0u7bYcWLzQOv+eD
        ChnayKmdSFo9orDTxukzjrD84fK0ttA=
X-Google-Smtp-Source: ABdhPJzq0Tu4Jz0YdYwZd1jcrNsAAvEad6yNImnzOiOGjA/nxf80snfTOFdtljINcXlcq2zW2A0Nhw==
X-Received: by 2002:a63:4b58:: with SMTP id k24mr11617088pgl.326.1636545715290;
        Wed, 10 Nov 2021 04:01:55 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id i76sm17592296pgd.69.2021.11.10.04.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:54 -0800 (PST)
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
Subject: [PATCH V5 42/50] x86/nmi: Use C entry code
Date:   Wed, 10 Nov 2021 19:57:28 +0800
Message-Id: <20211110115736.3776-43-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 61e89fd5ad8a..c4cc47519a11 100644
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

