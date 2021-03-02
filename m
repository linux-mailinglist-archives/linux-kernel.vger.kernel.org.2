Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D102E32A431
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380019AbhCBK0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349559AbhCBKFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:05:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB73A64F16;
        Tue,  2 Mar 2021 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614679466;
        bh=15SwaZ/8rrN2waOzJF7Zw5ICoWR5Pn4pn67kuMqXsIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABO9P5KTXvSfK5lusGZVnliPLUTf+U4T02/6GEhpj8IrDuhujOJj//0s5atDVq4O5
         YvBINr+hlj/FlCpxmp7r/Nzj1+3ZcMTO79qig9YSYlzOjsEKDnlKpMKip5UetleRmS
         xPQviVpaGF7/M8cE6/+jFzTkdgj+juT4q1kMtaCZTiXmunYIr1YDIq/pjNZd7EdIL4
         JIauPdohVhQpwb9Ups3l3pFYQ7QGgA/LYSdSSOtKq1lFAjGKBk6ySZOOF+teXFbzzZ
         p62E7atkEWw7KrruqdVsRiC8Mi+xlgTalHxA+VfejBmBF9ZCFdERgCHgz7Pj0HfdDQ
         484WQU36FbsRw==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 1/2] x86/setup: consolidate early memory reservations
Date:   Tue,  2 Mar 2021 12:04:05 +0200
Message-Id: <20210302100406.22059-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210302100406.22059-1-rppt@kernel.org>
References: <20210302100406.22059-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The early reservations of memory areas used by the firmware, bootloader,
kernel text and data are spread over setup_arch(). Moreover, some of them
happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
trim_low_memory_range() are called after reserve_real_mode() that allocates
memory.

There was no corruption of these memory regions because memblock always
allocates memory either from the end of memory (in top-down mode) or above
the kernel image (in bottom-up mode). However, the bottom up mode is going
to be updated to span the entire memory [1] to avoid limitations caused by
KASLR.

Consolidate early memory reservations in a dedicated function to improve
robustness against future changes. Having the early reservations in one
place also makes it clearer what memory must be reserved before we allow
memblock allocations.

[1] https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/setup.c | 92 ++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d883176ef2ce..3e3c6036b023 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -645,18 +645,6 @@ static void __init trim_snb_memory(void)
 	}
 }
 
-/*
- * Here we put platform-specific memory range workarounds, i.e.
- * memory known to be corrupt or otherwise in need to be reserved on
- * specific platforms.
- *
- * If this gets used more widely it could use a real dispatch mechanism.
- */
-static void __init trim_platform_memory_ranges(void)
-{
-	trim_snb_memory();
-}
-
 static void __init trim_bios_range(void)
 {
 	/*
@@ -729,7 +717,38 @@ static void __init trim_low_memory_range(void)
 {
 	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 }
-	
+
+static void __init early_reserve_memory(void)
+{
+	/*
+	 * Reserve the memory occupied by the kernel between _text and
+	 * __end_of_kernel_reserve symbols. Any kernel sections after the
+	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
+	 * separate memblock_reserve() or they will be discarded.
+	 */
+	memblock_reserve(__pa_symbol(_text),
+			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
+
+	/*
+	 * Make sure page 0 is always reserved because on systems with
+	 * L1TF its contents can be leaked to user processes.
+	 */
+	memblock_reserve(0, PAGE_SIZE);
+
+	early_reserve_initrd();
+
+	if (efi_enabled(EFI_BOOT))
+		efi_memblock_x86_reserve_range();
+
+	memblock_x86_reserve_range_setup_data();
+
+	reserve_ibft_region();
+	reserve_bios_regions();
+
+	trim_snb_memory();
+	trim_low_memory_range();
+}
+
 /*
  * Dump out kernel offset information on panic.
  */
@@ -764,29 +783,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 
 void __init setup_arch(char **cmdline_p)
 {
-	/*
-	 * Reserve the memory occupied by the kernel between _text and
-	 * __end_of_kernel_reserve symbols. Any kernel sections after the
-	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
-	 * separate memblock_reserve() or they will be discarded.
-	 */
-	memblock_reserve(__pa_symbol(_text),
-			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
-
-	/*
-	 * Make sure page 0 is always reserved because on systems with
-	 * L1TF its contents can be leaked to user processes.
-	 */
-	memblock_reserve(0, PAGE_SIZE);
-
-	early_reserve_initrd();
-
-	/*
-	 * At this point everything still needed from the boot loader
-	 * or BIOS or kernel text should be early reserved or marked not
-	 * RAM in e820. All other memory is free game.
-	 */
-
 #ifdef CONFIG_X86_32
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
 
@@ -910,8 +906,18 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
-	if (efi_enabled(EFI_BOOT))
-		efi_memblock_x86_reserve_range();
+	/*
+	 * Do some memory reservations *before* memory is added to
+	 * memblock, so memblock allocations won't overwrite it.
+	 * Do it after early param, so we could get (unlikely) panic from
+	 * serial.
+	 *
+	 * After this point everything still needed from the boot loader or
+	 * firmware or kernel text should be early reserved or marked not
+	 * RAM in e820. All other memory is free game.
+	 */
+	early_reserve_memory();
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
@@ -938,9 +944,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
-	/* after early param, so could get panic from serial */
-	memblock_x86_reserve_range_setup_data();
-
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
 		disable_apic = 1;
@@ -1032,8 +1035,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	find_smp_config();
 
-	reserve_ibft_region();
-
 	early_alloc_pgt_buf();
 
 	/*
@@ -1054,8 +1055,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	sev_setup_arch();
 
-	reserve_bios_regions();
-
 	efi_fake_memmap();
 	efi_find_mirror();
 	efi_esrt_init();
@@ -1081,9 +1080,6 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_real_mode();
 
-	trim_platform_memory_ranges();
-	trim_low_memory_range();
-
 	init_mem_mapping();
 
 	idt_setup_early_pf();
-- 
2.28.0

