Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23345EB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377055AbhKZKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377258AbhKZK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:29:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E2C0619E7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:49 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y8so6396566plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIFAzpHUj47magQlx5AbzST5T6sb/PLuRXVgeZxvSZw=;
        b=AhxTHqyBPFH9yrg8+iUPO5QU1XYo5QNjA6Hwrw1rJghZXFfIm9UDuKmE1YysL5VrEC
         lJmmevmgSJNNgnyLkwm/aXolZTSsYb/Vh1A0ztxVh70Z80tfrW+FLQlcMSckyup9RwAg
         /TLnCqy6sRUuGOb3xRkl0bv7/+ftXXoPkJIUR6pU41cW546S/HGrW0kE0RKf0tKRwfbI
         5bu5Pa+F+9Sib1U4lxViDlily/JLfR7ip+aBwR+TvAJ8W3B0FH2II2AYUO1bW7JveiP+
         7QV8iF5fho8IMZH+0ddRBwOE/o8BUAZUU89jzaGmcjghPXkujYBFN8+lDT9akDr9PFsq
         a1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIFAzpHUj47magQlx5AbzST5T6sb/PLuRXVgeZxvSZw=;
        b=nYspxB1Bqtt4LNV0slm4Ttf8w3IPEf8vYnzCYZa8LfkxzmpKSGTtbQoXy+ye4Pqha4
         RohWTiuSytECQCz9vEvaz4tAKak/nD/F3u2oaSkot91x1/aP9BAfW0OxfgUXRaUAvzVo
         FtjEaalsKmeBcsBz4G8k3jpdHQF26yHtz3crh6KiKt3zxRP2YmfbR/mZ6KnGFF3wNdAJ
         E/vT2aCk1QRSZV5Kjwixc7PR1SzSicpwiuifhXsZ3A3bjX5ILuygC2Wm7T9mKnR59Ik6
         iN2d1lRpEd5hprZnDoGCQP5CCIdcSYzzxqYWMGEju/J4jfBx+nPe63yQ0JYaPuRqS5fn
         YL2Q==
X-Gm-Message-State: AOAM53180pCHiRTHMrjhQCDNO16jKsZ94MvFAQGmOYSVvKiVTaVOr3a2
        LYdlfX1WTlHdVsi6iTp4Y2xR7kcKq3U=
X-Google-Smtp-Source: ABdhPJxPE1eeQxAnfZdMjzFR29xBUB0nzopUCRoA5+xJzrjJYEzETsiWtKPY19lrTxai3J2UYDUO3w==
X-Received: by 2002:a17:90a:7e0d:: with SMTP id i13mr14333389pjl.171.1637921808526;
        Fri, 26 Nov 2021 02:16:48 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id k1sm6804459pfu.31.2021.11.26.02.16.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:48 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Liam Merwick <liam.merwick@oracle.com>,
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
Subject: [PATCH V6 45/49] x86/sev: Use C entry code
Date:   Fri, 26 Nov 2021 18:12:05 +0800
Message-Id: <20211126101209.8613-46-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Cc: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 22 +---------------------
 arch/x86/include/asm/idtentry.h |  1 +
 arch/x86/kernel/Makefile        |  1 +
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b18df736b981..614e6cbb871b 100644
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
index 144f3a6d875a..7cfdb898982e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -426,6 +426,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_VC_KERNEL(func)				\
+	DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE(kernel_##func)	\
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

