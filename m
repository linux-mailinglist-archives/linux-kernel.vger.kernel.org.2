Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BE44C07D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhKJMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhKJMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67177C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:41 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q126so2029092pgq.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3HmZe6Lmp0WFWen4iv0zIrpxY4KSrCQcXz86AqiQ/8=;
        b=hX0zeETtHN4w+3ySaqob1a2PMaAiy+WLG91bJgVBt3+QGp2EyX96qUuxWlzBbEr9yM
         6yqqX7UOMmd+hegsEPZBTF9Hp1Lh7YBYV96+uMvjdFjiebTiZ0nGLys6QhRlixpAplW3
         0C5ySOHmdgS5GI2LPW1tqCX1qVFi1LJj/4QuizDO4byvKzSHh/sUuozMyOvNMKLBubeF
         zYJTOeiPslMRacyYS6vVEg3xwp659t2PSRasvquFFUfG4mAZgdmDEqaeQg3xWWdf6NaL
         GD6hnutMmWJezrMLZ0h6OrcTSEB4WTZOxpJgEUcbfZmhuT2gRGIf4bt3rddmZWDuryn7
         7ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3HmZe6Lmp0WFWen4iv0zIrpxY4KSrCQcXz86AqiQ/8=;
        b=EzCQRWxs6mz2upTmGpWoqvI30VPMBNEjmy/nVqqoVzmlv/MKx8eiq4Tu4K+tDQkdt7
         3+BndFrRtkjGdZFOkr9N9jysvxjrp67fZlAWCIoEMoHabVbnM0437TnxRHbU6UMeKk3h
         TzbtxeP8qnLLKiBaF1dPHccgtuFMpAoIEYxa3rKM8NHSWUTYdKJApkSyH83SJxHkLJHM
         XUjEKIYrbScCiG2utZu6gl7iUIjvwbe5r8fFKtMmJGlDlUhFRPXpcbAceo/CFMdADnXI
         Ol4aK+Dxo/sbEGwVpIKJ3O8gDERxRw5s24rC/FollBwVW2e8A6XAaXJV1nEgbeDQa4Lo
         RkSQ==
X-Gm-Message-State: AOAM5317X7/Onad4s1ECvyPDOMpwRsg/mx9Lm2d68g2zrwMoDeojLp6L
        3LfqIUjv7PIXxuhL/5IOrWAOKDR9wLQ=
X-Google-Smtp-Source: ABdhPJzZNoqYerZ7l3DtBW3Ihf8MQtIIhM+HxalPZyYIWeHse4bpCFYhWssopbIGmwuLy8AZD/dO4Q==
X-Received: by 2002:aa7:88d6:0:b0:49f:dd4b:ddbc with SMTP id k22-20020aa788d6000000b0049fdd4bddbcmr16004865pff.31.1636545580707;
        Wed, 10 Nov 2021 03:59:40 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id s69sm17788122pgc.43.2021.11.10.03.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:40 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 21/50] x86/entry: Move cld to the start of idtentry
Date:   Wed, 10 Nov 2021 19:57:07 +0800
Message-Id: <20211110115736.3776-22-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 25c534b78eb7..74c82fb01d36 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -356,6 +356,7 @@ SYM_CODE_END(ret_from_fork)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -423,6 +424,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -478,6 +480,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -539,6 +542,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -854,7 +858,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -978,7 +981,6 @@ SYM_CODE_END(paranoid_exit)
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

