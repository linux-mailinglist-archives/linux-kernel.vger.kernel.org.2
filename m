Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7069545EB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377112AbhKZK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhKZK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:26:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44155C0613B8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so9589223pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LK+v5xSJ0HQlFTdpYVH5UkAtfpD7/zQtB1qubQsaUZk=;
        b=Fs5im2peiITt0nAI73LKSK8kyTG1PmCy74iTvip18/CAGSist/S6e/pvoOs9HERtHY
         dFGQSMm8SUUmdd+2j8sCGTQ9lDnASFdR3VCRdSoDZmQ5F71BSC7crURj7MBsHTuyPJDV
         hCUP98EA3tX1JVZVvaYrmp7GUIocovwFNpyHOJpvM9a0+k9U4t3AJRnd7z1GFMF9AljE
         kYwHDSz8zuddoMnwvQYaCLB3mu6ND+qHpnHCZjmiBEG9+Tun2Tc3xRc83nX6G97ARqPl
         uYZhjHL4RvsmPKx/5q71jWhwUjigFwuTHR8euyzFy7ppGPiYSfj5K27UkR/5jAJXBzDE
         YHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LK+v5xSJ0HQlFTdpYVH5UkAtfpD7/zQtB1qubQsaUZk=;
        b=kZwcPqux8EL2eI3/h1eexBAfCVglIyIa45ZMnNS0zItXhBABFk3xRZxO9W5DaStN0G
         znM8McHcZiRRYqJ7RNPJl9clNNG+xoHKw3hjQ57XGt67cvO4ltTsTXUnK595XAwK1Aoh
         ypeuIqGL5U4BZscE5HV/aWUdKQHuipVib7uVOM5LFUNYDgTLjZwpv1ipNhZkzAhf/z+/
         lWbCZpiVwEHvgv2EA55Sbd4LZYKSkmcfpdw4lMJ5fKOSxLMr54ZhjobK1PmfTWCpzlZb
         cgUSA7gLn9rcEivNY3zPur84QsOwnLq/pvHwsjoCytB2YAe/aCsxCSaFpf2y/OiJ4344
         tm6A==
X-Gm-Message-State: AOAM530xWESc1q2w0HN4kic5Q2EhkElITVlW7h2LQHwkCnnzzMvgE4u7
        S30l5Lwefe/4LaWJaZCBbqche54J4oA=
X-Google-Smtp-Source: ABdhPJwMAHbAFK8zCR2Y1JFtXX7QAOctCqhuRNmZmaHcYf6uUFP3G+4Cj26AhvhkFvf2wqIaxhqfkA==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr14316652pjb.157.1637921643720;
        Fri, 26 Nov 2021 02:14:03 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id s19sm7044535pfu.104.2021.11.26.02.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:03 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 20/49] x86/entry: Move cld to the start of idtentry
Date:   Fri, 26 Nov 2021 18:11:40 +0800
Message-Id: <20211126101209.8613-21-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
index 4781ffbe39ba..09bd77e49249 100644
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
@@ -853,7 +857,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -975,7 +978,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1109,6 +1111,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1128,7 +1131,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

