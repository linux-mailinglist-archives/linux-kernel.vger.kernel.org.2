Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB954189BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhIZPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhIZPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96740C06176A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w19so13367507pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pU/rHJIbAjH0/Ru2mlnqoPCdE3prShAHRDg+WW/jhCs=;
        b=l2BS5emtxKn1mPwXVRZ+BTlqNIwczqCrBRwO7eXeadaGFF4/JIHJ/DZBUBfFrKWI18
         4tt27NbughPvXr7bWpxlRwgjPua7exnKmX03zYBtol+K9hWLb1zMwCq4GOfznhd3DzDk
         EzGusoJ17Vq308kgXesL0xTP0eF3bsk16mCFL9Z+tqsLhD0+qW0ZgurNimtLmkezTovJ
         rHbpmJ30mi1SObG9/bOVKQ0VIqgryRNFUPGM2/1pixbv68Ic5DWodCcRLtWo9yoZYJjx
         FLunRNBiXGsnHEQ11/hV5usQ/K3j7u+HOQxeNexMUOnvS9uxnvku+LGcsGSoKcJJGxZl
         mp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pU/rHJIbAjH0/Ru2mlnqoPCdE3prShAHRDg+WW/jhCs=;
        b=d0X7LaDxkDuCFYe/qWpJuxQwrWXIgYFPq/5SHRO3BiWc4a5hWLgxWNKl2aHlKvmioe
         24Mw4Mp/joBoH7yuJ6a5+GfDgjBMRpiTq7pRp4Zc1ic9vUdAxPs5ftyPuAGqLyrp0/T+
         5aAunKAsmX2JRuDL3LZgJzDEh2wfJWJ2ZbWsYzAXc8Mkb+YeaVaS7/ISUEN1lbrNDJDe
         /Yrr/RXPRpMHImojYnOZtTyx4jExZzz2NBc1XeAhX32pJyB7VFSj+rfx0bRnx/jyOCPw
         FWVkIvmJFuN6TofMwuDxyjlH3/fiEHIANwmqvTzkKz/4LPcAVL7PkG0PWrGNkjctylLs
         MbOQ==
X-Gm-Message-State: AOAM533Bn31cGPVAeQ6Vga2eXqyis9OyPalFPuR7FQ2oaCY1dvZTjssQ
        3G9Qfqo+/kQuNYEopacaFRSPx/JCMr7Yyg==
X-Google-Smtp-Source: ABdhPJyMZApaykyV7vmScJ2Wo7yWYepR6xzzK8Eh5PE/B4z9jhZl0OPV4aU1tCCSpoWd+2RAaQ/czg==
X-Received: by 2002:a63:1d10:: with SMTP id d16mr12527613pgd.13.1632669008014;
        Sun, 26 Sep 2021 08:10:08 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id m186sm12587363pfb.165.2021.09.26.08.10.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 13/41] x86/entry: Switch the stack after error_entry() returns
Date:   Sun, 26 Sep 2021 23:08:10 +0800
Message-Id: <20210926150838.197719-14-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

error_entry() calls sync_regs() to settle/copy the pt_regs and switches
the stack directly after sync_regs().  But because error_entry() is also
called from entry, the switching has to handle the return address together,
which causes the behavior tangly.

Switching to the stack after error_entry() makes the code simpler and
intuitive.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9921a823b2c6..dd453a8e7317 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -979,19 +981,16 @@ SYM_CODE_START_LOCAL(error_entry)
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
+	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
 	call	sync_regs
-	movq	%rax, %rsp			/* switch stack */
-	ENCODE_FRAME_POINTER
-	pushq	%r12
 	ret
 
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
 .Lerror_entry_done:
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ret
 
 	/*
@@ -1037,12 +1036,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * Pretend that the exception came from user mode: set up pt_regs
 	 * as if we faulted immediately after IRET.
 	 */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
+	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
-	mov	%rax, %rsp
-	ENCODE_FRAME_POINTER
-	pushq	%r12
+	mov	%rax, %rdi
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
 
-- 
2.19.1.6.gb485710b

