Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058B441F17C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355106AbhJAPuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:50:32 -0400
Received: from 8bytes.org ([81.169.241.247]:42980 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhJAPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:50:13 -0400
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de [79.242.181.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 4F7D349B;
        Fri,  1 Oct 2021 17:48:27 +0200 (CEST)
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
Subject: [PATCH v3 3/4] x86/mm: Flush global TLB when switching to trampoline page-table
Date:   Fri,  1 Oct 2021 17:48:16 +0200
Message-Id: <20211001154817.29225-4-joro@8bytes.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211001154817.29225-1-joro@8bytes.org>
References: <20211001154817.29225-1-joro@8bytes.org>
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
 arch/x86/realmode/init.c        | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+), 10 deletions(-)

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
index 31b5856010cb..b9802b18f504 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -17,6 +17,29 @@ u32 *trampoline_cr4_features;
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
+	 * The CR3 write above will not flush global TLB entries.
+	 * Stale, global entries from previous sets of page tables may
+	 * still be present.  Flush those stale entries.
+	 *
+	 * This ensures that memory accessed while running with
+	 * trampoline_pgd is *actually* mapped into trampoline_pgd.
+	 */
+	__flush_tlb_all();
+}
+
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem;
-- 
2.33.0

