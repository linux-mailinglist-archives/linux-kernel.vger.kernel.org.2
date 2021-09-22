Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E304414E62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhIVQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhIVQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:52:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B370C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:51:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B30B11EC054F;
        Wed, 22 Sep 2021 18:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632329465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyAI6xTRturKg9D0c/d78VTYCQwlYfO0ugGUZYiITJ8=;
        b=QS8aPZKLMN/NkGG638Xr+39qbqL3pXQ3vElxMwfwNEVGpv/U6FyVnX2Z4uhOem+XTv/SDl
        3fxNNsvAwsfgLT1WyjQL04ny8yDkcNSbt/zfZ6LErFNsweL4SKgFEoECaFJnOpWqVcl9eb
        TTK7QDcOcQnKE0ddvh/iDfVjN4kwIRA=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/5] x86/mce: Get rid of msr_ops
Date:   Wed, 22 Sep 2021 18:50:59 +0200
Message-Id: <20210922165101.18951-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922165101.18951-1-bp@alien8.de>
References: <20210922165101.18951-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid having indirect calls and use a normal function which returns the
proper MSR address based on ->smca setting.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c      | 10 ++--
 arch/x86/kernel/cpu/mce/core.c     | 95 ++++++++++--------------------
 arch/x86/kernel/cpu/mce/internal.h | 12 ++--
 3 files changed, 42 insertions(+), 75 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 08831acc1d03..27cacf504663 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -526,7 +526,7 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	/* Fall back to method we used for older processors: */
 	switch (block) {
 	case 0:
-		addr = msr_ops.misc(bank);
+		addr = mca_msr_reg(bank, MCA_MISC);
 		break;
 	case 1:
 		offset = ((low & MASK_BLKPTR_LO) >> 21);
@@ -978,8 +978,8 @@ static void log_error_deferred(unsigned int bank)
 {
 	bool defrd;
 
-	defrd = _log_error_bank(bank, msr_ops.status(bank),
-					msr_ops.addr(bank), 0);
+	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
+				mca_msr_reg(bank, MCA_ADDR), 0);
 
 	if (!mce_flags.smca)
 		return;
@@ -1009,7 +1009,7 @@ static void amd_deferred_error_interrupt(void)
 
 static void log_error_thresholding(unsigned int bank, u64 misc)
 {
-	_log_error_bank(bank, msr_ops.status(bank), msr_ops.addr(bank), misc);
+	_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS), mca_msr_reg(bank, MCA_ADDR), misc);
 }
 
 static void log_and_reset_block(struct threshold_block *block)
@@ -1397,7 +1397,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		}
 	}
 
-	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
+	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7aff9a503d1c..8e766b2685d6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -176,53 +176,27 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
-static inline u32 ctl_reg(int bank)
+u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	return MSR_IA32_MCx_CTL(bank);
-}
-
-static inline u32 status_reg(int bank)
-{
-	return MSR_IA32_MCx_STATUS(bank);
-}
-
-static inline u32 addr_reg(int bank)
-{
-	return MSR_IA32_MCx_ADDR(bank);
-}
-
-static inline u32 misc_reg(int bank)
-{
-	return MSR_IA32_MCx_MISC(bank);
-}
-
-static inline u32 smca_ctl_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_CTL(bank);
-}
-
-static inline u32 smca_status_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_STATUS(bank);
-}
+	if (mce_flags.smca) {
+		switch (reg) {
+		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
+		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
+		case MCA_MISC:	 return MSR_AMD64_SMCA_MCx_MISC(bank);
+		case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank);
+		}
+	}
 
-static inline u32 smca_addr_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_ADDR(bank);
-}
+	switch (reg) {
+	case MCA_CTL:	 return MSR_IA32_MCx_CTL(bank);
+	case MCA_ADDR:	 return MSR_IA32_MCx_ADDR(bank);
+	case MCA_MISC:	 return MSR_IA32_MCx_MISC(bank);
+	case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank);
+	}
 
-static inline u32 smca_misc_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_MISC(bank);
+	return 0;
 }
 
-struct mca_msr_regs msr_ops = {
-	.ctl	= ctl_reg,
-	.status	= status_reg,
-	.addr	= addr_reg,
-	.misc	= misc_reg
-};
-
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -362,11 +336,11 @@ static int msr_to_offset(u32 msr)
 
 	if (msr == mca_cfg.rip_msr)
 		return offsetof(struct mce, ip);
-	if (msr == msr_ops.status(bank))
+	if (msr == mca_msr_reg(bank, MCA_STATUS))
 		return offsetof(struct mce, status);
-	if (msr == msr_ops.addr(bank))
+	if (msr == mca_msr_reg(bank, MCA_ADDR))
 		return offsetof(struct mce, addr);
-	if (msr == msr_ops.misc(bank))
+	if (msr == mca_msr_reg(bank, MCA_MISC))
 		return offsetof(struct mce, misc);
 	if (msr == MSR_IA32_MCG_STATUS)
 		return offsetof(struct mce, mcgstatus);
@@ -685,10 +659,10 @@ static struct notifier_block mce_default_nb = {
 static void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
-		m->misc = mce_rdmsrl(msr_ops.misc(i));
+		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrl(msr_ops.addr(i));
+		m->addr = mce_rdmsrl(mca_msr_reg(i, MCA_ADDR));
 
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -758,7 +732,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		m.bank = i;
 
 		barrier();
-		m.status = mce_rdmsrl(msr_ops.status(i));
+		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
@@ -826,7 +800,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrl(msr_ops.status(i), 0);
+		mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 
 	/*
@@ -851,7 +825,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		m->status = mce_rdmsrl(msr_ops.status(i));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1144,7 +1118,7 @@ static void mce_clear_state(unsigned long *toclear)
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (test_bit(i, toclear))
-			mce_wrmsrl(msr_ops.status(i), 0);
+			mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1203,7 +1177,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 		m->addr = 0;
 		m->bank = i;
 
-		m->status = mce_rdmsrl(msr_ops.status(i));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1708,8 +1682,8 @@ static void __mcheck_cpu_init_clear_banks(void)
 
 		if (!b->init)
 			continue;
-		wrmsrl(msr_ops.ctl(i), b->ctl);
-		wrmsrl(msr_ops.status(i), 0);
+		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1735,7 +1709,7 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
-		rdmsrl(msr_ops.ctl(i), msrval);
+		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
 }
@@ -1894,13 +1868,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 		mce_flags.amd_threshold	 = 1;
-
-		if (mce_flags.smca) {
-			msr_ops.ctl	= smca_ctl_reg;
-			msr_ops.status	= smca_status_reg;
-			msr_ops.addr	= smca_addr_reg;
-			msr_ops.misc	= smca_misc_reg;
-		}
 	}
 }
 
@@ -2254,7 +2221,7 @@ static void mce_disable_error_reporting(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(msr_ops.ctl(i), 0);
+			wrmsrl(mca_msr_reg(i, MCA_CTL), 0);
 	}
 	return;
 }
@@ -2606,7 +2573,7 @@ static void mce_reenable_cpu(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(msr_ops.ctl(i), b->ctl);
+			wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d71d6c5c3ef0..1ad7b4bf5423 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -172,14 +172,14 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
-struct mca_msr_regs {
-	u32 (*ctl)	(int bank);
-	u32 (*status)	(int bank);
-	u32 (*addr)	(int bank);
-	u32 (*misc)	(int bank);
+enum mca_msr {
+	MCA_CTL,
+	MCA_STATUS,
+	MCA_ADDR,
+	MCA_MISC,
 };
 
-extern struct mca_msr_regs msr_ops;
+u32 mca_msr_reg(int bank, enum mca_msr reg);
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
-- 
2.29.2

