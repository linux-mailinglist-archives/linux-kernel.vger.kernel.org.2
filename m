Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7EB42D116
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJNDjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhJNDjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:39:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q5so4236182pgr.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lhQrUUxc7kLVqNyEu//dKP6He8ZHxMSI107NCUgfsQ=;
        b=SsgmqhkUJi04hgXjdPcYHciXEE93XrwOJe9TwywQ2WKFYZRh70w9oNwKz9uaE2owCq
         sfOjjoaIVslzk2DK3oxdKNNzVQmPkwIWIkhsUqBlgn9iCdZIupyw2aXlXFETyzBa2+hi
         /bJq3Aj4zc+nNhpKTwWOV/M6kmoHqfxE+TjcqOyAp08bJpYXjjZQo9l41fmHMTu7Ei2y
         0VEG+/M5wvek2FIwt0ve0MBe/I7K8kMu8BWjFgfvu8YQBu/XSJ36We1lWs3TkpIybbyk
         AnGUWEN0yfU14WnyBiQrka5RadfvIxqA8qsR8toa0+VK5UbOdMqWU8xvqg0y9oobHcGq
         yxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lhQrUUxc7kLVqNyEu//dKP6He8ZHxMSI107NCUgfsQ=;
        b=KB+1W2Ib7xCnLofxzKilysK1L1noPn/qLlWfmctk/njr9mOes7k+oCiVRbxLIoMnH5
         2iLopNA5qq8FXm1m6Bt45xNxgWLsyVNdpe5k5IGU9ZgxipjJ3WsfbrFfGOSAqJgP8jSH
         UAS++AtUjXCYPjRu3sauhQVFDYmnXxGOYI02c6aC0N3uEHDjQSBA4c9rYNcMf8n/AYfE
         qBSo51/d26golnkGY6kJCz8knvixjYs2N1af5GDPif8QDW+CCI8WUZwYhAgcaOX+cfir
         oTrdLrYRnNRjOokYl1xvTeIkUx6U3CVvDqmPgyCjpB/07A46yljuOHAu/qH2w2+2wG3i
         NYNA==
X-Gm-Message-State: AOAM531DqFASRCvGq2m1PPANI9Ba25eAgtZO4FGyj7kv69rg9j87xwbY
        YyVovhdYO7A5gjaShD+xMjjS/2lFC7w=
X-Google-Smtp-Source: ABdhPJwG5wwoujtwfmTFzxPfVfMmQx2WqtWn6GvHEKIuMnpj6UQ6C6tONRmFbtUTc0Kk4L6WdjSLmg==
X-Received: by 2002:a62:7656:0:b0:44c:591b:5a42 with SMTP id r83-20020a627656000000b0044c591b5a42mr3203432pfc.57.1634182616152;
        Wed, 13 Oct 2021 20:36:56 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id i1sm840477pgc.94.2021.10.13.20.36.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:55 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 29/49] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Thu, 14 Oct 2021 11:33:52 +0800
Message-Id: <20211014033414.16321-24-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

