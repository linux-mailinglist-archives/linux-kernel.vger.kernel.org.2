Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDC36B8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhDZSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:05:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:22346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234463AbhDZSDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:43 -0400
IronPort-SDR: 8+uPU/od0bHnsarZavlERPnBnxWxibrYJczaHumqBn0ls7f8TkOrckNPVTaYUxZpVmnJ1hFaZv
 zbyhsR1se7QQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263267"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263267"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:53 -0700
IronPort-SDR: vhDunfoY6bu/tfa5tbVcaCQOgAD/fOqvUi9lIU2GF1cQYyGKLlwLpk16j5XtMeDnTyWArYmtzR
 bTdWgZ+kgHjQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353420"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:52 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 21/32] x86/boot: Add a trampoline for APs booting in 64-bit mode
Date:   Mon, 26 Apr 2021 11:01:48 -0700
Message-Id: <13f8d4117f7b871f20f53403167913803bef87c2.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add a trampoline for booting APs in 64-bit mode via a software handoff
with BIOS, and use the new trampoline for the ACPI MP wake protocol used
by TDX.

Extend the real mode IDT pointer by four bytes to support LIDT in 64-bit
mode.  For the GDT pointer, create a new entry as the existing storage
for the pointer occupies the zero entry in the GDT itself.

Reported-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/realmode.h          |  1 +
 arch/x86/kernel/smpboot.c                |  5 +++
 arch/x86/realmode/rm/header.S            |  1 +
 arch/x86/realmode/rm/trampoline_64.S     | 49 +++++++++++++++++++++++-
 arch/x86/realmode/rm/trampoline_common.S |  5 ++-
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d083c873..5066c8b35e7c 100644
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 16703c35a944..27d8491d753a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1036,6 +1036,11 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	unsigned long boot_error = 0;
 	unsigned long timeout;
 
+#ifdef CONFIG_X86_64
+	if (is_tdx_guest())
+		start_ip = real_mode_header->trampoline_start64;
+#endif
+
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
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
index 84c5d1b33d10..12b734b1da8b 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -143,13 +143,20 @@ SYM_CODE_START(startup_32)
 	movl	%eax, %cr3
 
 	# Set up EFER
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	cmp	pa_tr_efer, %eax
+	jne	.Lwrite_efer
+	cmp	pa_tr_efer + 4, %edx
+	je	.Ldone_efer
+.Lwrite_efer:
 	movl	pa_tr_efer, %eax
 	movl	pa_tr_efer + 4, %edx
-	movl	$MSR_EFER, %ecx
 	wrmsr
 
+.Ldone_efer:
 	# Enable paging and in turn activate Long Mode
-	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
+	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	/*
@@ -161,6 +168,19 @@ SYM_CODE_START(startup_32)
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
+	movl	$(X86_CR0_NE | X86_CR0_PE), %eax
+	movl	%eax, %cr0
+	ljmpl   $__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(pa_trampoline_compat)
+
 	.section ".text64","ax"
 	.code64
 	.balign 4
@@ -169,6 +189,20 @@ SYM_CODE_START(startup_64)
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
@@ -182,6 +216,17 @@ SYM_DATA_START(tr_gdt)
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
index 5033e640f957..506d5897112a 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 	.section ".rodata","a"
 	.balign	16
-SYM_DATA_LOCAL(tr_idt, .fill 1, 6, 0)
+SYM_DATA_START_LOCAL(tr_idt)
+	.short	0
+	.quad	0
+SYM_DATA_END(tr_idt)
-- 
2.25.1

