Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAFE42D10B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhJNDiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhJNDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v20so3200649plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuEWxmriGjeR93wdoRYx5BXrqZi0N9S7r5MEKadT8C0=;
        b=NIYPK3g8SHqEArdwoxkRs4QRk3qi5LORtJcrYNv4TiKPf3huxermq1b7QSbWfE7CZo
         fv4GykX3ARoq5/fMGEaH11Dz/fJAXDZGq3GCdIFepo0CRwfuXb5eTTTFyaLatwmnjSnA
         9rCitLwXIngzzT8xpZv4mUD4uXd81isglK6ZsyLOXMxsxd76j4et4gt3hh3oao5x70H6
         4ht11+dBR+RT6ckDAFjoHzh5lM6O3TvQDyPd6lYsJ8tpQA998fmz46elUQ8yU2i755l9
         9p+8FYLC+oLsUSIue4/8j+oYPqTS+Cu7f/FdkDIetQHJ1Yul7xY7KUUn0VDnrl6xVey7
         37rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuEWxmriGjeR93wdoRYx5BXrqZi0N9S7r5MEKadT8C0=;
        b=nRNbtaeXf4OdqKQjpqlb7/DdBbWIovMePIBYKqNELgyhJwmZS1uc/r6/Kz01iqmrWF
         brk4uKLSKp+Pqh3TVa8SgdgI00MbwW/hymkyIdVGI/xR4lcHxQiJzKiPv2LsnPv9b2uQ
         Dp9iFusWyOBx1qiPT5UMBXMhqiDOJk8kYulzIegDQimmKU4yukxZUFVf0B1szU9ETxqp
         d0wg+2CxZKMYmeSUQyGAToXqKyCqpX9yjb6qGIueC+GOFCHi1Ji15tD6HkqM1uByfKkV
         XqFUBEft0get+23FyPin+W51Wv4m8elP4xi2VQXbADiT55dhYIA9xtcWI7FZTpNqzPFt
         RT/w==
X-Gm-Message-State: AOAM531CTRUBDgYRBt+HxQ2MfEg5e2hSmq2Hb4Cn0vtoPKx5wot+4yjW
        EBWJtQxwR0a3EpAwoTO12bmOwTDBGMs=
X-Google-Smtp-Source: ABdhPJxEiQZhiCsdbX967u4QGGUsfPOo76KFUFGf1iMD62rshwb5mjLxiyOWz+imAG9I5GY0PAnUTQ==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr3653931pjb.120.1634182552994;
        Wed, 13 Oct 2021 20:35:52 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id z11sm7440689pjl.45.2021.10.13.20.35.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:52 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 19/49] x86/entry: Switch the stack after error_entry() returns
Date:   Thu, 14 Oct 2021 11:33:42 +0800
Message-Id: <20211014033414.16321-14-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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
index 7f2338c3b676..1af28027a138 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -324,6 +324,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -987,14 +989,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
 
 	/*
@@ -1027,6 +1025,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ret
 
 .Lbstep_iret:
@@ -1047,12 +1046,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

