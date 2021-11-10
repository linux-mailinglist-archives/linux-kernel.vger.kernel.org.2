Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED3844C0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhKJMFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhKJMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BF3C06118D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so2841281plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7nFoQDL01vIwCYPnI2Hx3uLfrj/s1t/62LuuENgwn8=;
        b=XHb6vC0YGg/sudJXza/Ltog6h1dK8ansIWjTIYXjtnvktJF6IE4SvXXvMVR0BB34F7
         ggA91srHYMo5Yk86YYZgx/b6XwL5VMS5ovlLTRsGqVP1Af/2SuJqR8QlbGKroRUiQSb9
         i99emal59jEabHSd8GINHSMPC0Ubup7GSDxhMs2JKQaXmFDrabj5CZowYZq+Qky90RM4
         /4PEViy/Gvg0ooSzi9btBx3Xkcfw92FO4s09wKCYO9sJg6z+2IYNbwFeMVxuntHd6kEu
         nRScxJoUMDdpxq6oqbQ47aBSOu6jx4maD0VLZmX/EVnzP4EUxGgWZdY04Gr7cpYbmIu0
         iE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7nFoQDL01vIwCYPnI2Hx3uLfrj/s1t/62LuuENgwn8=;
        b=BbVkCQoD6aG/iEpzRvQATO0sBdD8vuged3rzsBnHdTaZh+83/ZMrK4f5bKnIW9Myf/
         6KDo0IrUBH6MmQjcc8yWsC4T4Se0HFmH8Y0JNZfugv/0gOFhnkyspr56J7bvqv60MYKD
         1djBpvQRGXPvHdM4jsvRmTUt4ZbssFy7HjpUNXUnJnc/msT4xEli8vzXSvl0ycgz12lk
         qNKuDMIGJtU1gauY+kF+WPq0Od1pKMinw4ce4yF+jctO+zFcGv4fSnt4UUE5dErKDmVt
         JrL8TKgOBFbikvvXjps6/FMFf4jajDE+nrtfqLtZ7Q0HJwIgw2zKT5vH0dwM6p1wHYTQ
         wQPw==
X-Gm-Message-State: AOAM5322ifi5nk6d1/qFHSkdm9+M81xs/noPCgHb4m792CiRqLDsedVK
        x4EhcfZEtOdRLjDLYquIiS1O/Ecq1Fc=
X-Google-Smtp-Source: ABdhPJzPGyiKY2ytibhaKjZJKxW9kO4mpmkAHIm3Dw2iz3Xq+kwnDNcqFwB7DBw89kQutQWrIGtrZA==
X-Received: by 2002:a17:902:c7d5:b0:143:72b7:2ca5 with SMTP id r21-20020a170902c7d500b0014372b72ca5mr11273312pla.20.1636545751618;
        Wed, 10 Nov 2021 04:02:31 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id t11sm17796190pgi.73.2021.11.10.04.02.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:31 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 47/50] x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
Date:   Wed, 10 Nov 2021 19:57:33 +0800
Message-Id: <20211110115736.3776-48-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry_64.S | 128 --------------------------------------
 1 file changed, 128 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index dfef02696319..cce2673c5bb0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -849,134 +849,6 @@ SYM_CODE_START(xen_failsafe_callback)
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
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
-
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
-	ret
-
-.Lparanoid_entry_swapgs:
-	swapgs
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

