Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7340F650
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbhIQKzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:55:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50650 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241743AbhIQKza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:55:30 -0400
Received: from zn.tnic (p200300ec2f127e008eb9261aa740485d.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:7e00:8eb9:261a:a740:485d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D81191EC0535;
        Fri, 17 Sep 2021 12:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631876047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy1W7WeWioZYr3c6nz4E+1brIo1mbkqKAToKPajIUxU=;
        b=P3pkXZKvFrlkgpD7ToN6miZXkwJtk1QIyUwfWuPERVE+dJrxgcj4xqkqiBxuTsc34/qlo/
        K3ZrFa/EdIjbnnDAWOvrPnWFxt5lPZc2l0ePAPWo7jDGcuii9jhqEcFv8j1aeKZFfWQGoQ
        65gJfqzXlJV22qYCpKdRxon6YPL9JSw=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] x86/mce: Get rid of the mce_severity function pointer
Date:   Fri, 17 Sep 2021 12:53:52 +0200
Message-Id: <20210917105355.2368-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210917105355.2368-1-bp@alien8.de>
References: <20210917105355.2368-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Turn it into a normal function which calls an AMD- or Intel-specific
variant depending on the CPU it runs on.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h         |  2 --
 arch/x86/kernel/cpu/mce/core.c     |  1 -
 arch/x86/kernel/cpu/mce/internal.h |  3 +--
 arch/x86/kernel/cpu/mce/severity.c | 11 +++++------
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index da9321548f6f..258ef6d9955c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -205,14 +205,12 @@ struct cper_ia_proc_ctx;
 int mcheck_init(void);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
-void mcheck_vendor_init_severity(void);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
-static inline void mcheck_vendor_init_severity(void) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8cb7816d03b4..fa38d51d9a23 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2207,7 +2207,6 @@ int __init mcheck_init(void)
 	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
-	mcheck_vendor_init_severity();
 
 	INIT_WORK(&mce_work, mce_gen_pool_process);
 	init_irq_work(&mce_irq_work, mce_irq_work_cb);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 88dcc79cfb07..09cb5ab9a81d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -38,8 +38,7 @@ int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
-extern int (*mce_severity)(struct mce *a, struct pt_regs *regs,
-			   int tolerant, char **msg, bool is_excp);
+int mce_severity(struct mce *a, struct pt_regs *regs, int tolerant, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 17e631443116..695570fadb5e 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -407,15 +407,14 @@ static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 	}
 }
 
-/* Default to mce_severity_intel */
-int (*mce_severity)(struct mce *m, struct pt_regs *regs, int tolerant, char **msg, bool is_excp) =
-		    mce_severity_intel;
-
-void __init mcheck_vendor_init_severity(void)
+int mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
+		 bool is_excp)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		mce_severity = mce_severity_amd;
+		return mce_severity_amd(m, regs, tolerant, msg, is_excp);
+	else
+		return mce_severity_intel(m, regs, tolerant, msg, is_excp);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.29.2

