Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C35307440
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhA1K6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhA1K6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:58:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA21164DDC;
        Thu, 28 Jan 2021 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611831457;
        bh=70iHhMxvmraB34yqcAAJU007XgcD9AGfPnYDMHhju08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4FAFSSXFkb0EsMN6SDLmMung7rmRn1ozygUmvcrjlH4MtnI410hMaNtzN43nguBv
         bLQPVHTZc+te4WxGWwvC/BAYjr6mFCVQZy1fMxSktiiXL+zwTNM4SVtGiTwY9qW+Nz
         VsX+BJOQuMLoL6UbG7idcTBev8Ms9MPLq8e2/ajHFyGn9y0Dcsadk4XDF9Yn7mdZ8i
         PZyqTGjMDLqPXkrHkhNCk8n6fhyTHB8/xTJeHgAg/RbvJHC4CoqMiMQFjYSPGEOTjh
         jtyUypoQ5K+AaRFNSN1KkY0QxuzBO1Hx9/aVgWQSEawu6Ff3jWREZmslsJoXWEV3+C
         AE4UidmbYl8MQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 1/2] x86/setup: consolidate early memory reservations
Date:   Thu, 28 Jan 2021 12:57:10 +0200
Message-Id: <20210128105711.10428-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210128105711.10428-1-rppt@kernel.org>
References: <20210128105711.10428-1-rppt@kernel.org>
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
index 3412c4595efd..3b582406363a 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -646,18 +646,6 @@ static void __init trim_snb_memory(void)
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
@@ -728,7 +716,38 @@ static void __init trim_low_memory_range(void)
 	 */
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
@@ -763,29 +782,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 
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
 
@@ -909,8 +905,18 @@ void __init setup_arch(char **cmdline_p)
 
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
@@ -937,9 +943,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_report_nx();
 
-	/* after early param, so could get panic from serial */
-	memblock_x86_reserve_range_setup_data();
-
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
 		disable_apic = 1;
@@ -1031,8 +1034,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	find_smp_config();
 
-	reserve_ibft_region();
-
 	early_alloc_pgt_buf();
 
 	/*
@@ -1053,8 +1054,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	sev_setup_arch();
 
-	reserve_bios_regions();
-
 	efi_fake_memmap();
 	efi_find_mirror();
 	efi_esrt_init();
@@ -1080,9 +1079,6 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_real_mode();
 
-	trim_platform_memory_ranges();
-	trim_low_memory_range();
-
 	init_mem_mapping();
 
 	idt_setup_early_pf();
-- 
2.28.0

