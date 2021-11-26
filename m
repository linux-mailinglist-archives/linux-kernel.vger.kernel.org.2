Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0345EB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377040AbhKZK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhKZKZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:23 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C53C0613B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:52 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z6so8478482pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8sSW0BteOPYD+HpYHPkb+QlFYOFvs+MADGM7L6C9w4=;
        b=lQCwAMdzpa2uNSpuCkBg0EaxkR7rl+xnc2HMHoQZ0JnLxIf620I8a0undGLLoF3/wh
         OLCGphcjMVbA7XTHYzvNlJBNDsF5Ls0iB6MSvn1zns3Pel5G3fNdBVIwug3yuAtc7OQW
         Nu5irRTn7YW00Zf3Eeug91pBBmXl6gDLXr0+Us8SG74ksiVltSgp8nyfN7Cv7z5MYPZf
         UGjrFgQU3Am+4axavVfhwhnsWTaBI3RcHv8HOSAOrNo3MPqfwQ21dYJOULXEaeJE/gkH
         rnqpIpvS/Ivv6c4SztEqsF6qtudK26BeEE9DL4tfWwmQd1RQgUkL5+nYif/Mhyv1VAfS
         bnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8sSW0BteOPYD+HpYHPkb+QlFYOFvs+MADGM7L6C9w4=;
        b=NuujYLML8Xy94awi6EdIMlCVUpbU5aNKcpJpEHjT46WaU1cB0xGdsAmyESKq9RzEOI
         +JvysXKKzbM/SHB6KVIeXvOSttNpE3a1+ujGEboH+SDPy214GithNsbxrHLth35eZf/g
         OkmZfCwvMFOkN7meW9klv7VVrpbnhTC/1rsEzrDJpwXRHvH3+3U7MuUS0Ngkf0MguOqW
         qCw52NSdcmC71d2FmQFdrdy9nJaaOsBjyNL4FE8AE+GUMefeGDwMvzQ3P6ZZbu/WqDdW
         bY36k6YovY7W6t/NBcwvjgbw794XF+FLRUo+h9gWKqb0ojzeTWL6gzoOo+Bx633GxeWq
         iL3A==
X-Gm-Message-State: AOAM531i7HFfxsyQad4h49HMwbf73iBlG7P+NUuEQBBtj0m6uDSxSYTg
        k8WmbdlRe+XCdQcQ8tPQe5jSnRMovBI=
X-Google-Smtp-Source: ABdhPJyHJSmHqag8cZF/glSYAIu/6njOmMZzg+dYcVep0YXTf3rves7Kj+TPfQ1+lgIiSK7hqSbIRg==
X-Received: by 2002:a05:6a00:1741:b0:4a6:3de7:a816 with SMTP id j1-20020a056a00174100b004a63de7a816mr20427019pfc.29.1637921632319;
        Fri, 26 Nov 2021 02:13:52 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id k26sm5924270pfe.78.2021.11.26.02.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:52 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 18/49] x86/entry: Switch the stack after error_entry() returns
Date:   Fri, 26 Nov 2021 18:11:38 +0800
Message-Id: <20211126101209.8613-19-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
index 0d81f9b77367..e5d69604322d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -985,14 +987,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
@@ -1025,6 +1023,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ret
 
 .Lbstep_iret:
@@ -1045,12 +1044,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

