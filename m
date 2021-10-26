Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FCD43B46F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhJZOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbhJZOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:41:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D4C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:38:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so1865750pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olANUIywlItruKHUBTqm2ifABR6f8SPD3JP9WQXuSlE=;
        b=ZLjh5sUtmmxIiRJ9AUoIYhI80hgWhvnZwQg1TIp1hva9D8CKPj3JbAdZhyV618z9ez
         1HRQtlXilU5S6llg7yoLBispjufkGbzb44b8lGFNODeFJtYyOaXW5DtksiEi9TP2hqOM
         d0s956GitwZDsIhvNFGkrfR2Juf2tEHrBgxEx4Til1kTWsY32yEu9YzIGloYfuxSZBir
         b93PCQKc13DAHn7LeDWbSCvvCdKT5TONnzTueTq5B0wulinx4Cy8Rj67aVFItQFWzsVM
         BKxughkaOyY/3B9f6e6ZkMN6ONKmJn1dgmFfT+/1qSunqEQGccckQRzrwsat+GQXLo/Q
         1tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olANUIywlItruKHUBTqm2ifABR6f8SPD3JP9WQXuSlE=;
        b=x8fAfCfURMC7dRT0WFG9gS97SkBRM6zaQDB0tif5xi/ccuDaY/XTqT0SKkAaR3DFHE
         OiJCBVSF2jIkn+E+h7cyKWht04lUVP+1gex2GoZ4TWeNqXssrXI7xn5fsexW8vvFaqWO
         98UcxYV7wzJ/9yN5wRZA6ahAzu43ZWOM/7kF34/INlnHdKzqomavK5ovsREaCIdVMiJr
         cWQ6VC18QnPS/Ky5kIUELegGbyGvj+k7qmwY2xUhTDV6jv5H1p1AdqyrhPitGtQXqXWd
         WmT9+7YmCU16pBQw/MzkQ2zyj6Eim5p+zjqR2WTmcu8hxZKbcPr2SzP8xgsNjrMjeoGw
         1rzQ==
X-Gm-Message-State: AOAM533DmZY2S7Yz9km7vVUDISPC0enyiFfyUVDFPkl2TWLZthvllIHi
        4So/g71UfGjhfJcDRltM0bO14SFwzBc=
X-Google-Smtp-Source: ABdhPJwfLGLx8BOUijNI2lVQVqctsvAJKUBPSuQfGz7R3kgYXyqgSAh/t+1LbKFAj6O2Sz+lX/+zjA==
X-Received: by 2002:a17:902:e750:b0:140:5a4d:207a with SMTP id p16-20020a170902e75000b001405a4d207amr10550732plf.69.1635259133355;
        Tue, 26 Oct 2021 07:38:53 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id q16sm26542314pfu.36.2021.10.26.07.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:38:53 -0700 (PDT)
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
Subject: [PATCH V4 46/50] x86/sev: Use C entry code
Date:   Tue, 26 Oct 2021 22:38:44 +0800
Message-Id: <20211026143851.19481-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 58f33e86c6c8..48b4c320f5e7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -528,28 +528,8 @@ SYM_CODE_START(\asmsym)
 
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

