Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1485241F178
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354464AbhJAPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:50:22 -0400
Received: from 8bytes.org ([81.169.241.247]:42958 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhJAPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:50:12 -0400
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de [79.242.181.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id E3807494;
        Fri,  1 Oct 2021 17:48:26 +0200 (CEST)
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
Subject: [PATCH v3 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Date:   Fri,  1 Oct 2021 17:48:15 +0200
Message-Id: <20211001154817.29225-3-joro@8bytes.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211001154817.29225-1-joro@8bytes.org>
References: <20211001154817.29225-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The AP bringup code uses the trampoline_pgd page-table, which
establishes global mappings in the user range of the address space.
Flush the global TLB entries after the indentity mappings are removed
so no stale entries remain in the TLB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head64.c  | 15 +++++++++++++++
 arch/x86/kernel/head_64.S | 19 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903c3735..cae21afe0922 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -457,6 +457,19 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_unmap_bootdata(real_mode_data);
 }
 
+/*
+ * The __flush_tlb_all() function uses all kinds of state which is not
+ * initialized that early and can not be used here. So the helper below is used
+ * to flush global TLB entries.
+ */
+static void __init early_flush_tlb_global(void)
+{
+	unsigned long cr4 = native_read_cr4();
+
+	native_write_cr4(cr4 ^ X86_CR4_PGE);
+	native_write_cr4(cr4);
+}
+
 asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 {
 	/*
@@ -478,6 +491,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* Kill off the identity-map trampoline */
 	reset_early_page_tables();
 
+	early_flush_tlb_global();
+
 	clear_bss();
 
 	clear_page(init_top_pgt);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8b3ebd2bb85..bd4b6ebafdc3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -166,9 +166,26 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	call	sev_verify_cbit
 	popq	%rsi
 
-	/* Switch to new page-table */
+	/*
+	 * Switch to new page-table
+	 *
+	 * For the boot CPU this switches to early_top_pgt which still has the
+	 * indentity mappings present. The secondary CPUs will switch to the
+	 * init_top_pgt here, away from the trampoline_pgd and unmapping the
+	 * indentity mapped ranges.
+	 *
+	 * Do a global TLB flush after the CR3 switch to make sure the TLB
+	 * entries from the identity mapping are flushed.
+	 */
 	movq	%rax, %cr3
 
+	/* Flush global TLB entries - only needed for secondary CPUs */
+	movq	%cr4, %rcx
+	movq	%rcx, %rax
+	xorq	$X86_CR4_PGE, %rcx
+	movq	%rcx, %cr4
+	movq	%rax, %cr4
+
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
-- 
2.33.0

