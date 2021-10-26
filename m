Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483143B470
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhJZOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbhJZOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:41:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE365C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:38:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r28so10005460pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuAFN0gj41dZzrfnCwRwUBU9rYJbG+oo1VF6StphUOE=;
        b=BPPeur7w/u/xlF77Qcid7CzyLgpgmnPiu+o8lUQqOGR+xrjZgE3Tg+Ab227hEEb36T
         J122UNjhNSVhU3yXpbaHi2JJJOWoHTJney5td6JMWEOPcNF59yUtX6cHQtiv8IXrTGv2
         xc0pixlLJwTnXpHY+jW0spMoz2npW4f/I2IvZDJXFk0FRm3kAaMjYvlplQRaaqtMsBYP
         d9FSrDNQUQRIUHxezxD35/kOfX+MaAthK21eLUqTGiyTumd77zCS8rgAqZtua1xRjpG3
         3Mrq8mf97pssGYRTdBNzqrXMRQWtR7DWsSRJCe98d0f1Hl4/ZUsU/g9gumnx42RNz491
         t9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuAFN0gj41dZzrfnCwRwUBU9rYJbG+oo1VF6StphUOE=;
        b=l2LztulAHUyL9yCPNDtgv46p340SYouekDUelCMC0h2/OkN/YifEdYljzkCxLyS0+N
         jj2Oo7jic0LHT1/naTKCJoTIjZGVhaSTUXwoyCGeahgeKqoY7uD3xfDWcamdEzHrEiKZ
         iPNHPj6ZxyvunrCo60fKfw4u06NWW03r1MlsfBDZN4wgrfugvBN80VFsesYAkOpS2izb
         22RV+ZM+6UFVIuKSZhSbdPyLgoKxg+cU74WKlcEXI60Ghtf+AvDqlKlfthAmII66tJ5O
         DmuKZAr1dpYM26D7FnIyG5Ga9lo9Z1W2i6sa/yr2a3HO7BHIeB1ECpt7Wb0VexyvufrO
         iNKQ==
X-Gm-Message-State: AOAM5301+JTiXvCpJpufeZNWIZ+HHHsYCfFodoxYmzo1YJgQMhD1C3pv
        fGzkVHpoGPnvdCG+bIzaOOCZz/NUmxg=
X-Google-Smtp-Source: ABdhPJx4ODUM0GS55J/uYiK0Es9S+qJPAoeKUv6DZNb3H7/ts/Cmqc5daKXNDbkPk70jCD4oUvauMw==
X-Received: by 2002:a63:7e04:: with SMTP id z4mr19259097pgc.221.1635259138857;
        Tue, 26 Oct 2021 07:38:58 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id j16sm3466980pfj.16.2021.10.26.07.38.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:38:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 47/50] x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
Date:   Tue, 26 Oct 2021 22:38:45 +0800
Message-Id: <20211026143851.19481-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry_64.S | 129 --------------------------------------
 1 file changed, 129 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 48b4c320f5e7..19f3e642707b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -847,135 +847,6 @@ SYM_CODE_START(xen_failsafe_callback)
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
-	jns	.Lparanoid_entry_swapgs
-	FENCE_SWAPGS_KERNEL_ENTRY
-	ret
-
-.Lparanoid_entry_swapgs:
-	swapgs
-
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
-
-	/* EBX = 0 -> SWAPGS required on exit */
-	xorl	%ebx, %ebx
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

