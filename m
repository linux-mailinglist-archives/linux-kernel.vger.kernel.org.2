Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD68441C77B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbhI2O5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344809AbhI2O5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:57:11 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E104EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:55:30 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de [79.242.181.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id F034B1043;
        Wed, 29 Sep 2021 16:55:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] x86/mm: Flush global TLB when switching to trampoline page-table
Date:   Wed, 29 Sep 2021 16:55:00 +0200
Message-Id: <20210929145501.4612-4-joro@8bytes.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929145501.4612-1-joro@8bytes.org>
References: <20210929145501.4612-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move the switching code into a function so that it can be re-used and
add a global TLB flush. This makes sure that usage of memory which is
not mapped in the trampoline page-table is reliably caught.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/kernel/reboot.c        | 12 ++----------
 arch/x86/realmode/init.c        | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d083c873..331474b150f1 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -89,6 +89,7 @@ static inline void set_real_mode_mem(phys_addr_t mem)
 }
 
 void reserve_real_mode(void);
+void load_trampoline_pgtable(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0a40df66a40d..fa700b46588e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -113,17 +113,9 @@ void __noreturn machine_real_restart(unsigned int type)
 	spin_unlock(&rtc_lock);
 
 	/*
-	 * Switch back to the initial page table.
+	 * Switch to the trampoline page table.
 	 */
-#ifdef CONFIG_X86_32
-	load_cr3(initial_page_table);
-#else
-	write_cr3(real_mode_header->trampoline_pgd);
-
-	/* Exiting long mode will fail if CR4.PCIDE is set. */
-	if (boot_cpu_has(X86_FEATURE_PCID))
-		cr4_clear_bits(X86_CR4_PCIDE);
-#endif
+	load_trampoline_pgtable();
 
 	/* Jump to the identity-mapped low memory code */
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 31b5856010cb..0cfe1046cec9 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -17,6 +17,25 @@ u32 *trampoline_cr4_features;
 /* Hold the pgd entry used on booting additional CPUs */
 pgd_t trampoline_pgd_entry;
 
+void load_trampoline_pgtable(void)
+{
+#ifdef CONFIG_X86_32
+	load_cr3(initial_page_table);
+#else
+	/* Exiting long mode will fail if CR4.PCIDE is set. */
+	if (boot_cpu_has(X86_FEATURE_PCID))
+		cr4_clear_bits(X86_CR4_PCIDE);
+
+	write_cr3(real_mode_header->trampoline_pgd);
+#endif
+
+	/*
+	 * Flush global TLB entries to catch any bugs where code running on the
+	 * trampoline_pgd uses memory not mapped into the trampoline page-table.
+	 */
+	__flush_tlb_all();
+}
+
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem;
-- 
2.33.0

