Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8620F40F654
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbhIQKzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242148AbhIQKzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:55:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ECBC061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:54:10 -0700 (PDT)
Received: from zn.tnic (p200300ec2f127e008eb9261aa740485d.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:7e00:8eb9:261a:a740:485d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0C8D1EC059F;
        Fri, 17 Sep 2021 12:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631876048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+gRu7QC+AZgJLPJjj84Ci6AuZBQrhaBK4x0J+JzDAc=;
        b=rW02GNPY0hfZVku1e5/A8BS4ev9YB9iFweQhgqw2//GBX5n8YZq32WM7UCldnwbHOI9Lwa
        MyhQ3gk6kUp5uJwFsQ02ZZB7VX5utNg7uA+6CMS2ZK9CDsrLxKkQ38T5wIWMa8hhdyUwZv
        sOI8/kKkAce44/oOMMuCsyKefiFy6Q8=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] x86/mce: Get rid of msr_ops
Date:   Fri, 17 Sep 2021 12:53:54 +0200
Message-Id: <20210917105355.2368-4-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210917105355.2368-1-bp@alien8.de>
References: <20210917105355.2368-1-bp@alien8.de>
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
 arch/x86/kernel/cpu/mce/core.c     | 95 +++++++++++-------------------
 arch/x86/kernel/cpu/mce/internal.h | 12 ++--
 3 files changed, 44 insertions(+), 73 deletions(-)

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
index 59f327cae84f..ee4f534424b8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -176,53 +176,31 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
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
+	switch (reg) {
+	case MCA_CTL:
+		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_CTL(bank)
+				      : MSR_IA32_MCx_CTL(bank);
 
-static inline u32 smca_ctl_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_CTL(bank);
-}
+	case MCA_STATUS:
+		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_STATUS(bank)
+				      : MSR_IA32_MCx_STATUS(bank);
 
-static inline u32 smca_status_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_STATUS(bank);
-}
+	case MCA_ADDR:
+		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_ADDR(bank)
+				      : MSR_IA32_MCx_ADDR(bank);
 
-static inline u32 smca_addr_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_ADDR(bank);
-}
+	case MCA_MISC:
+		return mce_flags.smca ? MSR_AMD64_SMCA_MCx_MISC(bank)
+				      : MSR_IA32_MCx_MISC(bank);
+	default: break;
+	}
 
-static inline u32 smca_misc_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_MISC(bank);
+	WARN_ON_ONCE(1);
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
@@ -362,11 +340,11 @@ static int msr_to_offset(u32 msr)
 
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
@@ -685,10 +663,10 @@ static struct notifier_block mce_default_nb = {
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
@@ -758,7 +736,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		m.bank = i;
 
 		barrier();
-		m.status = mce_rdmsrl(msr_ops.status(i));
+		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
@@ -826,7 +804,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrl(msr_ops.status(i), 0);
+		mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 
 	/*
@@ -851,7 +829,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		m->status = mce_rdmsrl(msr_ops.status(i));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1144,7 +1122,7 @@ static void mce_clear_state(unsigned long *toclear)
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (test_bit(i, toclear))
-			mce_wrmsrl(msr_ops.status(i), 0);
+			mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1203,7 +1181,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 		m->addr = 0;
 		m->bank = i;
 
-		m->status = mce_rdmsrl(msr_ops.status(i));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1682,8 +1660,8 @@ static void __mcheck_cpu_init_clear_banks(void)
 
 		if (!b->init)
 			continue;
-		wrmsrl(msr_ops.ctl(i), b->ctl);
-		wrmsrl(msr_ops.status(i), 0);
+		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1709,7 +1687,7 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
-		rdmsrl(msr_ops.ctl(i), msrval);
+		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
 }
@@ -1868,13 +1846,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
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
 
@@ -2228,7 +2199,7 @@ static void mce_disable_error_reporting(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(msr_ops.ctl(i), 0);
+			wrmsrl(mca_msr_reg(i, MCA_CTL), 0);
 	}
 	return;
 }
@@ -2580,7 +2551,7 @@ static void mce_reenable_cpu(void)
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

