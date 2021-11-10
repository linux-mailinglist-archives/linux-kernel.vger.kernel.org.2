Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4582D44C099
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhKJMDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhKJMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98BC06120F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id o4so2420295pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9NEeDtCVo+FiatRNBp9c/z7itcHiF3dSTibOob4YLE=;
        b=CfEv4GvioEcU+HMc1pv06hCbu+3F6q2jd08TV83uSBd5aMGFbsbGUOcL+8Zk9tNmv1
         8LdZZRZwObh2uzBYolmFYgagmA53FKm8UA9f+eL55sF1fwIoxBLIMm2KsWs1uHERJm3Z
         ppfxu+ZWFArUPFKtDCdXgKLeHKjpnOHLLAeN3JURZG04mGaT6cZ7aNvv6OMEXJL7gPiz
         fcY4W6rxTG+KUR9M7I7w13u+S7lmD3FLy1gn1kwRXlyHZgQ8PehsHStBrvJHKojy6SMC
         w5ZXBPhlSRJ87IkV0qZJQlCmBJOQ3mLNaqoAo1HcztVDXejxniQAIKjlDwRsPpPuucKa
         ZESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9NEeDtCVo+FiatRNBp9c/z7itcHiF3dSTibOob4YLE=;
        b=0ibelN7vSLOpKG6enpZ78nuyO2ZDXIpegZDOsslNKJGGIMrnJ8JuK7V6ZxKRkPtXaL
         YEU4pPt6E2ohOxZVkA3S4PFLgJ8YAIVRJVHJKcJwawKzH/l8K9Cen3wNwT3hjPfE3+71
         mDHsH8iSwSkrFT3yFHrrLrHMAztp7StQZqf66TExD7y9JQByeDrZgA2ZMPqLAfHrHFve
         Jwt9zOieAMB3rrDKCxYqVmk2Gyx2lTnkeShuTnvhpMXtamIjRpiDtzfHpRq9GbDPF6Kd
         IAaOq6mkSrsyX/0FXyMaAmSipa5jsFOuK9j3nDsQo7cGQsl0EHIMyFRvcUaYThy1sQYQ
         yyjA==
X-Gm-Message-State: AOAM531+SwUPANiSHwkk4d6/QUq+KLoTeaJLlUHbiOaiOKy/Mu3vClq7
        aMGaDF0VJdFDD+4jDxniU4Drac45e2k=
X-Google-Smtp-Source: ABdhPJyDd5zLkdFhXxkhRE41O8I0239Omk37A5TqilmApQnq8qaSB2sizeZ6qNJwjNTr/eIkhjd3/Q==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr15694419pfc.62.1636545631018;
        Wed, 10 Nov 2021 04:00:31 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id b21sm18686368pff.179.2021.11.10.04.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:30 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 29/50] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Wed, 10 Nov 2021 19:57:15 +0800
Message-Id: <20211110115736.3776-30-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The code between "call exc_nmi" and nmi_restore is as the same as
paranoid_exit(), so we can just use paranoid_exit() instead of the open
duplicated code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e6e655a1764a..3a434b179963 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -960,8 +960,7 @@ SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
+ * only on return from IST interrupts that came from kernel space.
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
@@ -1309,11 +1308,7 @@ end_repeat_nmi:
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
 	/*
-	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-	 * as we should not be calling schedule in NMI context.
-	 * Even with normal interrupts enabled. An NMI should not be
-	 * setting NEED_RESCHED or anything that normal interrupts and
-	 * exceptions might do.
+	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -1322,31 +1317,12 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	exc_nmi
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
-
 	/*
-	 * The above invocation of paranoid_entry stored the GSBASE
-	 * related information in R/EBX depending on the availability
-	 * of FSGSBASE.
-	 *
-	 * If FSGSBASE is enabled, restore the saved GSBASE value
-	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
+	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
 	 */
-	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
-
-	wrgsbase	%rbx
-	jmp	nmi_restore
-
-nmi_no_fsgsbase:
-	/* EBX == 0 -> invoke SWAPGS */
-	testl	%ebx, %ebx
-	jnz	nmi_restore
-
-nmi_swapgs:
-	swapgs
+	call	paranoid_exit
 
-nmi_restore:
 	POP_REGS
 
 	/*
-- 
2.19.1.6.gb485710b

