Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15145EB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377008AbhKZKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377263AbhKZK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:29:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF13C0619E9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b13so6405928plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whbUNMBuySdAeUOgRq5cwv4zCaetsrPBlMsxfQ22EyQ=;
        b=IfoHSnsthQ6dI/41NiXArwt/kmR3deVLA/yGOSFetzQD1NvWTVjYNjizDQLln+5tlG
         T1R4+pmCgY3QjVwln93HAghIwm78cWqnVsQ37uxjcghXI9Li6YAPOz2eZNYj7xg6HbNI
         yWSeG9y4UUxc8ZFpXW1tQIFwR26iBExBRVM8BSDEphqLHNXdzaxIOaKsiIdpz6BJmoJv
         Lb/bcFIBYpiMO32dNpSbuBV97gdBFcSrSRxGbXFszSTIbsE9PI9ljyQY1EJVo0LUljn6
         UpehBKQuZyBlLT3SnKcaVuTp+95GrAltrr2C/H36orsl0Q+W1HvkWGu5W045J1Uo+xqR
         VqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whbUNMBuySdAeUOgRq5cwv4zCaetsrPBlMsxfQ22EyQ=;
        b=B24PR6j23JbZlm/IDxOsiSAD7RkAlgdFR83yJ9bk+N/7vs2xqfcWOH17f6fvETegFO
         XA1LXJY6n+9RgWRFu62XQbM2zopVRmqGX0uta0yx1gGL7Fkf4+Fcj54fYiv0fU01gP83
         m+wbHL64LR3dWk78CN6jpZLvMXTrp9deTkJEDRYMNH99CFqB+PK48sCTK8RVDuhOJlbR
         G/2fj0RCaAojNXPqDCebd1/7YMe04vqBJxGrK3ghmlxWfuVD6K6hQTNs5weVMkoBeLg/
         18JHby9HqqJ/sjQRn+iTuIKoKyOKp5p1nVwnNJHaFkaJhst1BXzDz5Q/mpfG8YWOKkuA
         HmfQ==
X-Gm-Message-State: AOAM532w/nOcO/8XiYIbDkmqRDLLWX+gXuFD/zLatyuPCucS+lCIC4yX
        /kpb/6MjOPyMxJJo7KD+BrjNl9auCCU=
X-Google-Smtp-Source: ABdhPJy66/xN8oSad4VH+dXWTzmgots1WzHKDuPY7Z5t0llGMPxQOVgGbnYyqGp8eMWIludMEIkJ3w==
X-Received: by 2002:a17:902:b94b:b0:143:d3bc:9d83 with SMTP id h11-20020a170902b94b00b00143d3bc9d83mr37098630pls.6.1637921814153;
        Fri, 26 Nov 2021 02:16:54 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id v10sm6555115pfg.162.2021.11.26.02.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:53 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 46/49] x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
Date:   Fri, 26 Nov 2021 18:12:06 +0800
Message-Id: <20211126101209.8613-47-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

IST exceptions are changed to use C entry code which uses the C function
ist_paranoid_entry() and ist_paranoid_exit().  The ASM function
paranoid_entry() and paranoid_exit() are useless.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 126 --------------------------------------
 1 file changed, 126 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 614e6cbb871b..a583089e88c1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -848,132 +848,6 @@ SYM_CODE_START(xen_failsafe_callback)
 SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
-/*
- * Save all registers in pt_regs. Return GSBASE related information
- * in EBX depending on the availability of the FSGSBASE instructions:
- *
- * FSGSBASE	R/EBX
- *     N        0 -> SWAPGS on exit
- *              1 -> no SWAPGS on exit
- *
- *     Y        GSBASE value at entry, must be restored in paranoid_exit
- */
-SYM_CODE_START_LOCAL(paranoid_entry)
-	UNWIND_HINT_FUNC
-
-	/*
-	 * Always stash CR3 in %r14.  This value will be restored,
-	 * verbatim, at exit.  Needed if paranoid_entry interrupted
-	 * another entry that already switched to the user CR3 value
-	 * but has not yet returned to userspace.
-	 *
-	 * This is also why CS (stashed in the "iret frame" by the
-	 * hardware at entry) can not be used: this may be a return
-	 * to kernel code, but with a user CR3 value.
-	 *
-	 * Switching CR3 does not depend on kernel GSBASE so it can
-	 * be done before switching to the kernel GSBASE. This is
-	 * required for FSGSBASE because the kernel GSBASE has to
-	 * be retrieved from a kernel internal table.
-	 */
-	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
-
-	/*
-	 * Handling GSBASE depends on the availability of FSGSBASE.
-	 *
-	 * Without FSGSBASE the kernel enforces that negative GSBASE
-	 * values indicate kernel GSBASE. With FSGSBASE no assumptions
-	 * can be made about the GSBASE value when entering from user
-	 * space.
-	 */
-	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
-
-	/*
-	 * Read the current GSBASE and store it in %rbx unconditionally,
-	 * retrieve and set the current CPUs kernel GSBASE. The stored value
-	 * has to be restored in paranoid_exit unconditionally.
-	 *
-	 * The unconditional write to GS base below ensures that no subsequent
-	 * loads based on a mispredicted GS base can happen, therefore no LFENCE
-	 * is needed here.
-	 */
-	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
-	ret
-
-.Lparanoid_entry_checkgs:
-	/* EBX = 1 -> kernel GSBASE active, no restore required */
-	movl	$1, %ebx
-	/*
-	 * The kernel-enforced convention is a negative GSBASE indicates
-	 * a kernel value. No SWAPGS needed on entry and exit.
-	 */
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	.Lparanoid_kernel_gsbase
-
-	/* EBX = 0 -> SWAPGS required on exit */
-	xorl	%ebx, %ebx
-	swapgs
-.Lparanoid_kernel_gsbase:
-
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
-	ret
-SYM_CODE_END(paranoid_entry)
-
-/*
- * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from IST interrupts that came from kernel space.
- *
- * We may be returning to very strange contexts (e.g. very early
- * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, there's no good reason to try
- * to handle preemption here.
- *
- * R/EBX contains the GSBASE related information depending on the
- * availability of the FSGSBASE instructions:
- *
- * FSGSBASE	R/EBX
- *     N        0 -> SWAPGS on exit
- *              1 -> no SWAPGS on exit
- *
- *     Y        User space GSBASE, must be restored unconditionally
- */
-SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS offset=8
-	/*
-	 * The order of operations is important. RESTORE_CR3 requires
-	 * kernel GSBASE.
-	 *
-	 * NB to anyone to try to optimize this code: this code does
-	 * not execute at all for exceptions from user mode. Those
-	 * exceptions go through error_exit instead.
-	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
-
-	/* Handle the three GSBASE cases */
-	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
-
-	/* With FSGSBASE enabled, unconditionally restore GSBASE */
-	wrgsbase	%rbx
-	ret
-
-.Lparanoid_exit_checkgs:
-	/* On non-FSGSBASE systems, conditionally do SWAPGS */
-	testl		%ebx, %ebx
-	jnz		.Lparanoid_exit_done
-
-	/* We are returning to a context with user GSBASE */
-	swapgs
-.Lparanoid_exit_done:
-	ret
-SYM_CODE_END(paranoid_exit)
-
 SYM_CODE_START_LOCAL(error_return)
 	UNWIND_HINT_REGS
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
-- 
2.19.1.6.gb485710b

