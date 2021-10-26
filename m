Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3443B42F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhJZOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbhJZOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:33:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A189DC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r5so5878090pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qdPX6leSrxZFRthtIVsp8vJTUvVJ0ZjU2fXlZEYPiA=;
        b=A/cF4NzyvrgY2ycbA7TF2ho6MuJBhMFil3dbGT4s6o7ZjH12uTCZcdcf/xj+9WNaUo
         i1yUljbkmpicY7xb9JsamvknWzfMefAa+VzuPBHYVHJr3L1FtY4X9WWX2o6FEZCoSqx+
         LacqyD07Tf2u4eBBSLlLF3bB6cPmeqEO3Q0obMemOKXzyX+DYcEuZx/1vJhEdcp0Ai8Y
         9LpjBqHWKvdvkLc5I2ld4YZy2WoduoRUJod3OkQl9G+WVRXo36YiIJTNKERn845Qr6YQ
         44ndpzLQ7fsyed02fVzIJTrwTZKN5wGGWGgZzH092bbdIVpG6aINc7l90bp4Kdw7YGQW
         iqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qdPX6leSrxZFRthtIVsp8vJTUvVJ0ZjU2fXlZEYPiA=;
        b=O7enL7A2KIXdBviu5hWqEsq0fFAUtX9s2v6++Q8sTcnbOd6oJMmImacNFcXPs0S1jb
         vwsiQudCc9WtwqyEEfRhNDqfsxZoAQXrqy0+sQI3FaVstI8lnjquoHMbUQubW1vidmPV
         qpDIIIwhSwdlD+C98RpGesags4w6HTTeZxWKwfcZos/5M8h0kS8u4+jzSuNRAVDTrKBe
         f+UkjKim8RcUYp9MFV258D371Fb4FJTnU4t7DNLON1nKO3oK2ztIf34Zy8eGCGdvH/6e
         gMpxStfP16O5FxCXVWRppPKpwi+Gszujv/lzvnme/3JwXBqQ3TS5VihV8/We64l92ESo
         rMGg==
X-Gm-Message-State: AOAM532Q5IFn5oIFYXGvgJUBlSN+70NoAI0x94OqZzsxP0d9JlI3PCpH
        SpbWkk2e7zXGyiWGWX4F/l81mRA5lJI=
X-Google-Smtp-Source: ABdhPJwmxdi3fVNDycx2KUUi3fFJwPCJ0xCM3d92DZ18Qq/polIC0ilaMCZPHC10x3IkXSd7YJoD/A==
X-Received: by 2002:a17:90a:f195:: with SMTP id bv21mr3642603pjb.203.1635258637283;
        Tue, 26 Oct 2021 07:30:37 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id h35sm7448946pgh.71.2021.10.26.07.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:30:37 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 21/50] x86/entry: Move cld to the start of idtentry
Date:   Tue, 26 Oct 2021 22:30:03 +0800
Message-Id: <20211026143032.18624-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1ec87d9e685d..52a08c4a0171 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -357,6 +357,7 @@ SYM_CODE_END(ret_from_fork)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -424,6 +425,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -479,6 +481,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -540,6 +543,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -852,7 +856,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -977,7 +980,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1112,6 +1114,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1131,7 +1134,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

