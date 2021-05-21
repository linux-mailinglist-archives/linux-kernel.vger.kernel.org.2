Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFA138C959
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhEUOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:41:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:45989 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233979AbhEUOlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:41:19 -0400
IronPort-SDR: Kvcyg0E7IbD6CTm6TmN7VBzKj4PIrtYhjrWy54Mz8CaqsIHyOkO5ihdP412UNZgeBk5KiZR6cA
 Y68rpPER2M8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201207685"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201207685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 07:39:56 -0700
IronPort-SDR: Flp03eSk5CPvBmnbK+6X9MZz0bCp72Rvp5SeupXtlGKA016CR0qhndu+3U/pTsZL9KTNKS+On+
 1C6aWj5O86wQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613271939"
Received: from spattipa-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.113.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 07:39:55 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v2 1/1] x86/boot: Add a trampoline for APs booting in 64-bit mode
Date:   Fri, 21 May 2021 07:39:40 -0700
Message-Id: <20210521143941.2528475-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2977129b-c568-8ce5-9a85-31473096719f@linux.intel.com>
References: <2977129b-c568-8ce5-9a85-31473096719f@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add a trampoline for booting APs in 64-bit mode via a software handoff
with BIOS, and use the new trampoline for the ACPI MP wake protocol used
by TDX. You can find MADT MP wake protocol details in ACPI specification
r6.4, sec 5.2.12.19.

Extend the real mode IDT pointer by four bytes to support LIDT in 64-bit
mode.  For the GDT pointer, create a new entry as the existing storage
for the pointer occupies the zero entry in the GDT itself.

Reported-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix:
 * Passed rmh as argument to get_trampoline_start_ip().
 * Added a comment line for get_trampoline_start_ip().
 * Moved X86_CR0_NE change from pa_trampoline_compat() to patch
   "x86/boot: Avoid #VE during boot for TDX platforms".
 * Fixed comments for tr_idt as per Dan's comments.
 * Moved TRAMPOLINE_32BIT_CODE_SIZE change to "x86/boot: Avoid #VE
   during boot for TDX platforms" patch.

 arch/x86/include/asm/realmode.h          | 11 +++++++
 arch/x86/kernel/smpboot.c                |  2 +-
 arch/x86/realmode/rm/header.S            |  1 +
 arch/x86/realmode/rm/trampoline_64.S     | 38 ++++++++++++++++++++++++
 arch/x86/realmode/rm/trampoline_common.S | 12 +++++++-
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d083c873..0f707521b797 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -25,6 +25,7 @@ struct real_mode_header {
 	u32	sev_es_trampoline_start;
 #endif
 #ifdef CONFIG_X86_64
+	u32	trampoline_start64;
 	u32	trampoline_pgd;
 #endif
 	/* ACPI S3 wakeup */
@@ -88,6 +89,16 @@ static inline void set_real_mode_mem(phys_addr_t mem)
 	real_mode_header = (struct real_mode_header *) __va(mem);
 }
 
+/* Common helper function to get start IP address */
+static inline unsigned long get_trampoline_start_ip(struct real_mode_header *rmh)
+{
+#ifdef CONFIG_X86_64
+	if (is_tdx_guest())
+		return rmh->trampoline_start64;
+#endif
+	return rmh->trampoline_start;
+}
+
 void reserve_real_mode(void);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 16703c35a944..659e8d011fe6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1031,7 +1031,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		       int *cpu0_nmi_registered)
 {
 	/* start_ip had better be page-aligned! */
-	unsigned long start_ip = real_mode_header->trampoline_start;
+	unsigned long start_ip = get_trampoline_start_ip(real_mode_header);
 
 	unsigned long boot_error = 0;
 	unsigned long timeout;
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 8c1db5bf5d78..2eb62be6d256 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -24,6 +24,7 @@ SYM_DATA_START(real_mode_header)
 	.long	pa_sev_es_trampoline_start
 #endif
 #ifdef CONFIG_X86_64
+	.long	pa_trampoline_start64
 	.long	pa_trampoline_pgd;
 #endif
 	/* ACPI S3 wakeup */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 84c5d1b33d10..957bb21ce105 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -161,6 +161,19 @@ SYM_CODE_START(startup_32)
 	ljmpl	$__KERNEL_CS, $pa_startup_64
 SYM_CODE_END(startup_32)
 
+SYM_CODE_START(pa_trampoline_compat)
+	/*
+	 * In compatibility mode.  Prep ESP and DX for startup_32, then disable
+	 * paging and complete the switch to legacy 32-bit mode.
+	 */
+	movl	$rm_stack_end, %esp
+	movw	$__KERNEL_DS, %dx
+
+	movl	$X86_CR0_PE, %eax
+	movl	%eax, %cr0
+	ljmpl   $__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(pa_trampoline_compat)
+
 	.section ".text64","ax"
 	.code64
 	.balign 4
@@ -169,6 +182,20 @@ SYM_CODE_START(startup_64)
 	jmpq	*tr_start(%rip)
 SYM_CODE_END(startup_64)
 
+SYM_CODE_START(trampoline_start64)
+	/*
+	 * APs start here on a direct transfer from 64-bit BIOS with identity
+	 * mapped page tables.  Load the kernel's GDT in order to gear down to
+	 * 32-bit mode (to handle 4-level vs. 5-level paging), and to (re)load
+	 * segment registers.  Load the zero IDT so any fault triggers a
+	 * shutdown instead of jumping back into BIOS.
+	 */
+	lidt	tr_idt(%rip)
+	lgdt	tr_gdt64(%rip)
+
+	ljmpl	*tr_compat(%rip)
+SYM_CODE_END(trampoline_start64)
+
 	.section ".rodata","a"
 	# Duplicate the global descriptor table
 	# so the kernel can live anywhere
@@ -182,6 +209,17 @@ SYM_DATA_START(tr_gdt)
 	.quad	0x00cf93000000ffff	# __KERNEL_DS
 SYM_DATA_END_LABEL(tr_gdt, SYM_L_LOCAL, tr_gdt_end)
 
+SYM_DATA_START(tr_gdt64)
+	.short	tr_gdt_end - tr_gdt - 1	# gdt limit
+	.long	pa_tr_gdt
+	.long	0
+SYM_DATA_END(tr_gdt64)
+
+SYM_DATA_START(tr_compat)
+	.long	pa_trampoline_compat
+	.short	__KERNEL32_CS
+SYM_DATA_END(tr_compat)
+
 	.bss
 	.balign	PAGE_SIZE
 SYM_DATA(trampoline_pgd, .space PAGE_SIZE)
diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
index 5033e640f957..4331c32c47f8 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -1,4 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 	.section ".rodata","a"
 	.balign	16
-SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
+
+/*
+ * When a bootloader hands off to the kernel in 32-bit mode an
+ * IDT with a 2-byte limit and 4-byte base is needed. When a boot
+ * loader hands off to a kernel 64-bit mode the base address
+ * extends to 8-bytes. Reserve enough space for either scenario.
+ */
+SYM_DATA_START_LOCAL(tr_idt)
+	.short  0
+	.quad   0
+SYM_DATA_END(tr_idt)
-- 
2.25.1

