Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B260D44557A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKDOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhKDOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:26 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69F6C1EC057F;
        Thu,  4 Nov 2021 15:40:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KcwngwuYv4Sxyk8V6f0lXa2kRN+beCC+ZYhnU810No=;
        b=KShN288ugjHQl0ACQIkYblw5dbq8+h8EH6VyxJIYimG1Ety7OdR1B2kqhXCcglsHsRoVKb
        HjNyiEPzfu6Gtj7S/BYUVftIhLTMHXdWJv9FMDlLBFbGOeptdfEQvrGTN3kP2odzMET9dy
        gTANPuOcIIOnqxlJDWlvs3/nFST5/Ew=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 03/12] x86/mce: Use mce_rdmsrl() in severity checking code
Date:   Thu,  4 Nov 2021 15:40:26 +0100
Message-Id: <20211104144035.20107-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

MCA has its own special MSR accessors. Use them.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c     | 2 +-
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 arch/x86/kernel/cpu/mce/severity.c | 8 +++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dcd7ac7444c..c660008ccd4a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -365,7 +365,7 @@ void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 }
 
 /* MSR access wrappers used for error injection */
-static noinstr u64 mce_rdmsrl(u32 msr)
+noinstr u64 mce_rdmsrl(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index acd61c41846c..52c633950b38 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -207,4 +207,6 @@ static inline void pentium_machine_check(struct pt_regs *regs) {}
 static inline void winchip_machine_check(struct pt_regs *regs) {}
 #endif
 
+noinstr u64 mce_rdmsrl(u32 msr);
+
 #endif /* __X86_MCE_INTERNAL_H__ */
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index bb019a594a2c..00e97ebbd94a 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -288,8 +288,7 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 
 static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 {
-	u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-	u32 low, high;
+	u64 mcx_cfg;
 
 	/*
 	 * We need to look at the following bits:
@@ -300,11 +299,10 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 	if (!mce_flags.succor)
 		return MCE_PANIC_SEVERITY;
 
-	if (rdmsr_safe(addr, &low, &high))
-		return MCE_PANIC_SEVERITY;
+	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
 
 	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
-	if ((low & MCI_CONFIG_MCAX) &&
+	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
 	    (m->status & MCI_STATUS_TCC) &&
 	    (err_ctx == IN_KERNEL))
 		return MCE_PANIC_SEVERITY;
-- 
2.29.2

