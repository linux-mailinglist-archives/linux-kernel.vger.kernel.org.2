Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CE43B44B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhJZOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhJZOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB97C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n12so5792286plc.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lhQrUUxc7kLVqNyEu//dKP6He8ZHxMSI107NCUgfsQ=;
        b=XXqyFh9TsXGyVqBT+cjiPNuZf1BOPdrErU27osHoEj3Ey8yZCk/h766YDo4xHli/V2
         lPhjd+dWILy6bnvpbwQMsKcTxYqpaTZSAFq1zVluvlo8TeP06C0Smfo0/Is+rdN7Tzeh
         gYS7kSHme/AZpRFY2+u2kuc568uWa/5Uh6p93Hw+fDbr382HlCyKWZnEBfdAgac+iiYu
         hcralk6HtPTK/5THbbjVQX9Igr0amtExuaPwIlblY3YQO/dvEyq+7jz/jnwL+mmlFNNr
         jRQKmBsVgQUkDBpaot0GgX1EPj5f6o+0r5qCSEVnv3MGrUm/3TIUI1stH4AGAzMs1vYF
         bKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lhQrUUxc7kLVqNyEu//dKP6He8ZHxMSI107NCUgfsQ=;
        b=3wJuVrWmQrADOZ++f/Qnac/s6AyWJoBwBFFPZiSApwLNuJBiEGCFQkyxnAk4nMCQKL
         wKbaFzYwkc/kxM3f3oCXc78HOzu7wpSzmyZKKV6fneMvVCjheQmk5JMTY3UPiOL19Toq
         izR25r/vD/NAxRBm/EnUoV6sGowPBGLCrpuOSLbASGhjhRQxWlY1NReMxw+S3W6ZZ901
         1pnPLVKq37cgQwY0NR61e9ZvxhfSRLEcsF9vR6TtUeHcKX7LCwTT/U2DpgB7v0YL6ELf
         UIAfWOBd5pSqKDlLflOaHVJulLIM0d2RZvdv/0dcTYGEwv0oKZEHdXtjeyay0PHCA9Mv
         h/3A==
X-Gm-Message-State: AOAM533uWUQdqyDu38sQOUWzoVbjPqRiaUNZuQVY4bnj5+JI08KRGq6l
        eKmS2kB+IiSu3XxGODPMC+ma2IAELOc=
X-Google-Smtp-Source: ABdhPJyqHXFlw+x8jlbKKgFISP7xYLn/WtQKzVW9/Uy/RcW0iBPLN9wJ9XSPvX9WAAKbSCGfW7k2Og==
X-Received: by 2002:a17:90b:ec9:: with SMTP id gz9mr3211937pjb.218.1635258917280;
        Tue, 26 Oct 2021 07:35:17 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id j16sm3457583pfj.16.2021.10.26.07.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:17 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 29/50] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Tue, 26 Oct 2021 22:34:15 +0800
Message-Id: <20211026143436.19071-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The code between "call exc_nmi" and nmi_restore is as the same as
paranoid_exit(), so we can just use paranoid_exit() instead of the open
duplicated code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8790bf41edd4..8d873b778681 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -959,8 +959,7 @@ SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
+ * only on return from IST interrupts that came from kernel space.
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
@@ -1309,11 +1308,7 @@ end_repeat_nmi:
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
 	/*
-	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-	 * as we should not be calling schedule in NMI context.
-	 * Even with normal interrupts enabled. An NMI should not be
-	 * setting NEED_RESCHED or anything that normal interrupts and
-	 * exceptions might do.
+	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -1322,31 +1317,12 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	exc_nmi
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
-
 	/*
-	 * The above invocation of paranoid_entry stored the GSBASE
-	 * related information in R/EBX depending on the availability
-	 * of FSGSBASE.
-	 *
-	 * If FSGSBASE is enabled, restore the saved GSBASE value
-	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
+	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
 	 */
-	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
-
-	wrgsbase	%rbx
-	jmp	nmi_restore
-
-nmi_no_fsgsbase:
-	/* EBX == 0 -> invoke SWAPGS */
-	testl	%ebx, %ebx
-	jnz	nmi_restore
-
-nmi_swapgs:
-	swapgs
+	call	paranoid_exit
 
-nmi_restore:
 	POP_REGS
 
 	/*
-- 
2.19.1.6.gb485710b

