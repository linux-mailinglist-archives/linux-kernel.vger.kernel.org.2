Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63A344C0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhKJMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhKJMFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88ABC06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so1397074pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNxZ4m5TWB5i0YPYTaaKUAb8Dfa2e/drbUTAmm/8JWE=;
        b=qAvrmDmwUDWDWw3rKMWZqZjH0b5dlu9u+uugak1iRbF/XJQ7FpohgqvL4RgWZFYGwb
         /kKBuuBEIc/xltKnQicAl99SYcr/yOC19KsZl/SYGwAWvrFF8J6mxQMWvLdj8I5eSQde
         DKWALOEMtBl7utTureksveMKbWZclxOXhJ96B1zJcnLth9ZOOmzAN27PmSExRe/h1I9z
         Wf7AlDBV5Xr9Se7nxMS59keOpa6vW7d5oRg/zpFb+NH1ADLeBQGQZOz4rUTME3IB8LPQ
         v4P5shAmks/+xrfeRFVybGiZPoOfqYWJ7kH7pbbd5ke/C4pOW6Ko7wlHz02MH6DZx/L8
         QREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNxZ4m5TWB5i0YPYTaaKUAb8Dfa2e/drbUTAmm/8JWE=;
        b=ETeAG+0B6hW77GKj1AgtPEA/ISdp7ZQMQmqMzT7+l4BZ+8DdxCLZeXd7XXEOvQJlkP
         zjZFKJP5tNZ92SL+gXmRt6h2OShc8OdgmZKG0Gpf0F4gr+BVDInTIhEsII/LvmMXWxRM
         Zl1QU+pimcSGdHNRtxP0qM25KvwV6T4Q4TYJWQCjOcV2M5/2xT/X+mfuJ03UxbGV684k
         fZOaIE19w2E/UgLjvE9KTZLIPB8JvQFn5+4hXaX/dtAON+LmqKdX1sFJZ2I5ks5ogLvN
         jp9O9fl38VLrFBsBQdr50dSOTAMyF3XUID7lsgLNEl1/3D7kOcVZmayUwiasvsdE04JR
         Fibg==
X-Gm-Message-State: AOAM5321yHjH2i83yjJnxM1NR2b9gKsSXWb3oazRK7lX9wB3OQS7wgM6
        50KqBejNGS2PiK+u/yjKOhtUkeNlVqI=
X-Google-Smtp-Source: ABdhPJz/6jcTBbzi6HXlNPECPKw+imq4eUyeAZo+x5enprerZQLro8OT8hmQm7xgQi56Uds54aJEEw==
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr16493047pjb.150.1636545746237;
        Wed, 10 Nov 2021 04:02:26 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id o16sm9697145pfu.72.2021.11.10.04.02.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:25 -0800 (PST)
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
Subject: [PATCH V5 46/50] x86/sev: Use C entry code
Date:   Wed, 10 Nov 2021 19:57:32 +0800
Message-Id: <20211110115736.3776-47-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 22 +---------------------
 arch/x86/include/asm/idtentry.h |  1 +
 arch/x86/kernel/Makefile        |  1 +
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 944cf85e67da..dfef02696319 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -527,28 +527,8 @@ SYM_CODE_START(\asmsym)
 
 	UNWIND_HINT_REGS
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
-	/* Update pt_regs */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
-
-	call	kernel_\cfunc
-
-	/*
-	 * No need to switch back to the IST stack. The current stack is either
-	 * identical to the stack in the IRET frame or the VC fall-back stack,
-	 * so it is definitely mapped even with PTI enabled.
-	 */
-	call	paranoid_exit
+	call	ist_kernel_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 931b689f464c..84ce63f03c7f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -426,6 +426,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_VC_KERNEL(func)				\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(kernel_##func)	\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
 
 /**
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 28815c2e6cb2..9535d03aaa61 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -52,6 +52,7 @@ CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 CFLAGS_traps.o		+= -fno-stack-protector
 CFLAGS_nmi.o		+= -fno-stack-protector
+CFLAGS_sev.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

