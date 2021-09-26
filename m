Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857644189DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhIZPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhIZPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE2C061773
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t4so10046331plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XoTNrMM2bEXs+/2fpe+iUfvDPWFRs8Hd7+/ZH9LFzN8=;
        b=B6t90YQNy+oue416r/63f7wAH7BoWDbdjH9igklgR9nMB5K5WiI6JROVzM5P6jJ5wf
         5Ld7X7PnucAeCgyi5xkSfnr2cDkW6bm7sTFNrawLA3eQjDaIZS/dQNPZ2pzQs3ylNgen
         LHnxPihDH4WGzO5zAQkcpa0JWpmgQL+OUA4QNZszsFd7ZFO2Fgt3SCd3/bkT2ZDqxlZH
         fWqUawpbIvncY6UOS/kh4Q42tpYarJdPnJU63yyc72tOaDSk5fuCDpigzNX7EBiI8ugm
         lcXt9P9SWBQQbcYUGPaF9uYt4GN0XCECdL/7JLKHgCtn20QW5qSNYZcgBjrwHFp9daMC
         g89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XoTNrMM2bEXs+/2fpe+iUfvDPWFRs8Hd7+/ZH9LFzN8=;
        b=sF5TAdxQgi+4L2NKFIDBptMc67I27cculLya+pDYCHE2di8amqEJjFs/lq7nMlAzfM
         nKcYgOUnaMYWiJFo8gEAB4f23tjKPbC2pz314nwu1i90QPYi4XY5A1MsGWcodayEsNLt
         obK0y3qWWl7fi5q1i64R/63QescVij1BZH00/bS2jIkut2v/WFtFtDOSp8U5TQiFldxx
         mRm4izn0HVJ6QzDvIpPZ47izLfm38jMoP1By3c27+qXBp7yOnWY7k9DFxcM8urNW64FI
         vBxKE/OKTa4FQXhMkYou2bTBCB6z8uKih+M6KyzEbwWJIudlrnQxeKYG3d3mop4XY0vB
         magA==
X-Gm-Message-State: AOAM532UokLyGruFd4Jdi6AQ8wXNKLi8Un6QYccWpGw6Y817HpmmkSzk
        KqnGwJ/RLFghny1jWNp6tYX1kcwLzfXTIw==
X-Google-Smtp-Source: ABdhPJx2b5hvGlwC9gT2HeKwk2HM3IFcBMYjCT6ZpP4Zht/gC5MQb6nQ/iKCORvWOGnZ/Sf2eR8amA==
X-Received: by 2002:a17:902:7ec9:b0:13d:8e79:8e37 with SMTP id p9-20020a1709027ec900b0013d8e798e37mr17890771plb.48.1632669180838;
        Sun, 26 Sep 2021 08:13:00 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id p4sm15586669pgc.15.2021.09.26.08.12.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:13:00 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 38/41] x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
Date:   Sun, 26 Sep 2021 23:08:35 +0800
Message-Id: <20210926150838.197719-39-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry_64.S | 124 --------------------------------------
 1 file changed, 124 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 63cafeeaf27d..260be3c9da7d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -815,130 +815,6 @@ SYM_CODE_START(xen_failsafe_callback)
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
-	cld
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
-	FENCE_SWAPGS_USER_ENTRY
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

