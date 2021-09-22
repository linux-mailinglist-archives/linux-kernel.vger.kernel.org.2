Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F0414E64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhIVQwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhIVQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:52:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C934C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:51:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93C9C1EC0559;
        Wed, 22 Sep 2021 18:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632329466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbVWDO+HACX0ieUQ+CoXTFx0hGSrtmQpS+WRkPNwpN4=;
        b=FylKIbssw+GBMrmpzKQyoaHeE3Pcz9mehJ4Yt9/PeqC1tpmxIWjUjmllqGb5sfhIbNbU/w
        nLJ68LznjP9Z2aLTA6yS1QrMDNeES1dEcsc7fwpNVj164LL6hd1bGMRgURanDp17fZI/s4
        FN1u6sf0RlYSKrJvHFvk04fjWffYwa8=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/5] x86/mce: Get rid of the ->quirk_no_way_out() indirect call
Date:   Wed, 22 Sep 2021 18:51:00 +0200
Message-Id: <20210922165101.18951-5-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922165101.18951-1-bp@alien8.de>
References: <20210922165101.18951-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Use a flag setting to call the only quirk function for that.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c     | 64 +++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h |  5 ++-
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8e766b2685d6..50a3e455cded 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -121,8 +121,6 @@ mce_banks_t mce_banks_ce_disabled;
 static struct work_struct mce_work;
 static struct irq_work mce_irq_work;
 
-static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
-
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
  * MCE errors in a human-readable form.
@@ -814,6 +812,34 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 }
 EXPORT_SYMBOL_GPL(machine_check_poll);
 
+/*
+ * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
+ * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
+ * Vol 3B Table 15-20). But this confuses both the code that determines
+ * whether the machine check occurred in kernel or user mode, and also
+ * the severity assessment code. Pretend that EIPV was set, and take the
+ * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
+ */
+static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
+{
+	if (bank != 0)
+		return;
+	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
+		return;
+	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
+		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
+			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
+			  MCACOD)) !=
+			 (MCI_STATUS_UC|MCI_STATUS_EN|
+			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
+			  MCI_STATUS_AR|MCACOD_INSTR))
+		return;
+
+	m->mcgstatus |= MCG_STATUS_EIPV;
+	m->ip = regs->ip;
+	m->cs = regs->cs;
+}
+
 /*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
@@ -830,8 +856,8 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			continue;
 
 		__set_bit(i, validp);
-		if (quirk_no_way_out)
-			quirk_no_way_out(i, m, regs);
+		if (mce_flags.snb_ifu_quirk)
+			quirk_sandybridge_ifu(i, m, regs);
 
 		m->bank = i;
 		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
@@ -1714,34 +1740,6 @@ static void __mcheck_cpu_check_banks(void)
 	}
 }
 
-/*
- * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
- * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
- * Vol 3B Table 15-20). But this confuses both the code that determines
- * whether the machine check occurred in kernel or user mode, and also
- * the severity assessment code. Pretend that EIPV was set, and take the
- * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
- */
-static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
-{
-	if (bank != 0)
-		return;
-	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
-		return;
-	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
-		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
-			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
-			  MCACOD)) !=
-			 (MCI_STATUS_UC|MCI_STATUS_EN|
-			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
-			  MCI_STATUS_AR|MCACOD_INSTR))
-		return;
-
-	m->mcgstatus |= MCG_STATUS_EIPV;
-	m->ip = regs->ip;
-	m->cs = regs->cs;
-}
-
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
@@ -1815,7 +1813,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 			cfg->bootlog = 0;
 
 		if (c->x86 == 6 && c->x86_model == 45)
-			quirk_no_way_out = quirk_sandybridge_ifu;
+			mce_flags.snb_ifu_quirk = 1;
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 1ad7b4bf5423..21865545cd3b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -167,7 +167,10 @@ struct mce_vendor_flags {
 	/* Centaur Winchip C6-style MCA */
 	winchip			: 1,
 
-	__reserved_0		: 58;
+	/* SandyBridge IFU quirk */
+	snb_ifu_quirk		: 1,
+
+	__reserved_0		: 57;
 };
 
 extern struct mce_vendor_flags mce_flags;
-- 
2.29.2

