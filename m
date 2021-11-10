Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973044C07B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKJMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhKJMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5BC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b13so2846807plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHCZGxKN3KBd+O5Qi5dSjkEt/UOdmetDDo4XYyeRAyE=;
        b=oTmlxHs301RiGUq40HNvjcPCMfokdFkV1ZkxuIz0KKkFzhbHikk6SEflwB4DzhCmra
         57eckNUYeEOtrrMDB0TsAJ400vPEacLDbvcW0LlfAuJaqXs6x8+LVEjS3qiyu7SQTtgc
         LVKuvdxjPoDxfBY7jedawdvf9odwwbebv2zapBsWr+KwRIX0lCVPUhAUeLdfzpCYfOTN
         01XNtN9I6M67LbGb61f/tJq2T9UVvtgmxz8Av9AIY8yQNHXQBrTJ+/J9qPUsZko3xjU3
         bbaOzsKN/nvOT9UPA5GvixAu8JJxfS2a3ex9Pbogl69jG5eiMPtGk0KsdsUYE392N7Ab
         17YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHCZGxKN3KBd+O5Qi5dSjkEt/UOdmetDDo4XYyeRAyE=;
        b=dEphLI8Jz/VP8jPad9QeRTdvaUulC3AUXoAL30R77+z6+PLLDHiOK5XhZhDc9t0GoL
         /RqniK/O58JohI9L22xW6aobZ2t0BWw/dvOfAbKe5R0GzhJ4rt2U9PqMw53P1iSsnSlA
         1bq4GDhMRxmIfrCibFqGsw0y5v/WA3w7OUvwwHiTfW7pE7aN8kkCrrSJ/Wn+5o6FjaNN
         +yK9uTAChWL+Ypg4ZcTbtJL+tYJlNqcWXyOjE5+QA/d5FP30khCDH6gQf8yXTV9ii/sS
         uXx7gRoDYTezF3geBUcSc1TXHssQ9Om8/2NKYr4jrinxcgtIGHq8Kp74rkciO6JLTNa9
         +Niw==
X-Gm-Message-State: AOAM532l9nkuNKxkwOgHbTyNl09jKZ09diBIMzRezAHYn4092E5gbZEn
        hFtJEAOWb6xe/C3NPO40mbStZplZqyw=
X-Google-Smtp-Source: ABdhPJzgAMuzfykWS9OYcDggvoEflmiOxE/enn1amyNfftBLC6h7bNOhkfLYnA7ceoFBFHaOr2PwaA==
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id 2-20020a170902c20200b001422441aa25mr15186198pll.68.1636545569209;
        Wed, 10 Nov 2021 03:59:29 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id q11sm16583249pfk.192.2021.11.10.03.59.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:28 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 19/50] x86/entry: Switch the stack after error_entry() returns
Date:   Wed, 10 Nov 2021 19:57:05 +0800
Message-Id: <20211110115736.3776-20-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index c6b617c19fe1..3667317f6825 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -988,14 +990,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
@@ -1028,6 +1026,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ret
 
 .Lbstep_iret:
@@ -1048,12 +1047,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

