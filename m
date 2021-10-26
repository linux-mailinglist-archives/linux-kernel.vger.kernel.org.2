Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC143B42D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhJZOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhJZOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:32:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A9C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w16so1828703plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OuEWxmriGjeR93wdoRYx5BXrqZi0N9S7r5MEKadT8C0=;
        b=TVbtCkc1lGPGVYp1+zllxowWzOeSu6A7hgUbz2RRiP4gYH7XSu65aaqiMpdgA+qGHJ
         CVzZGlVJv0MPGCPxGF0ZdP+Ohmey5r2fOxbAX/oW6cBxDaMIjV4TR/EOu6BhjZfFXZGy
         DE+nFyYC6mO8WCIQz+cgRVnZXa8GQwBnn7mSw4aKu1lfi0J0QpeX6R15TmQqE7IOkdGl
         /YGrm0fTlz6LI0ayelwzo0Lbp2YQeOHJlm8lX7qGPEhrSN2Y6FWswCarNIGtZxa7WG3+
         SMhVY7LG1UA1urxTTOmchQ0rgZI/rcSXNqkPAHavVtAist1tPSglPXMfW2EullIIyHVI
         AYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OuEWxmriGjeR93wdoRYx5BXrqZi0N9S7r5MEKadT8C0=;
        b=lLgfcZGhkk5wWJm3g73GheBvKYxEp9nCFsh8vvQ6d7VRx9sEnp0rtZTvgd/1pVCPi7
         npxRk5m7vFUgIBfAybHNl6tKtwW+6hgCFQl23suDgp37Pyp4kGYJSbgdjCKSWZSryu0U
         mD2QNGyMHiinmHSDErAzh4wLWBGkxIVigG6EDZgC8JLuVSCQppuiWn+9IiUTlABmvvhf
         jGjkwZWg2kNgn+fVTzmWJ29T9IaDUx8+6LdmTwIPkplKqnk3U8DXJWWVqdW/1YcLCV19
         lS8AR8wWXqhGJ4Xk+B4PpTXxINJXzc0Pc7E4m1puSK4N/5vkzL6e1X7nkgVmpwIJhmqk
         /3nA==
X-Gm-Message-State: AOAM532A0fR7cURGXvIxjHgREJcZLETAwZsuW64l5bXgzN2JCzCBP8oE
        fHvjmiob84dUxedQ6U/01cDiHb0xoqA=
X-Google-Smtp-Source: ABdhPJynhNOw6mGJEWR/hLE+YMzQvhxHnnGRO8gjiK1oikaZBca/Qy4jd40s4k5cLz2MzixpL4zkeg==
X-Received: by 2002:a17:90a:a88c:: with SMTP id h12mr5935760pjq.147.1635258625222;
        Tue, 26 Oct 2021 07:30:25 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id u23sm26371274pfg.162.2021.10.26.07.30.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:30:24 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 19/50] x86/entry: Switch the stack after error_entry() returns
Date:   Tue, 26 Oct 2021 22:30:01 +0800
Message-Id: <20211026143032.18624-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

