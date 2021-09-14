Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727B40A6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhINGvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:51:35 -0400
Received: from foss.arm.com ([217.140.110.172]:40046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhINGve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:51:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD871FB;
        Mon, 13 Sep 2021 23:50:17 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 363713F719;
        Mon, 13 Sep 2021 23:50:14 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm/hotplug: Warn when memory limit has been reduced
Date:   Tue, 14 Sep 2021 12:21:10 +0530
Message-Id: <1631602270-29215-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the max memory limit has been reduced with 'mem=' kernel command line
option, there might be UEFI memory map described memory beyond that limit
which could be hot removed. This might be problematic for subsequent kexec
kernel which could just access such removed memory.

Memory offline notifier exists because there is no other way to block the
removal of boot memory, only the offlining (which isn't actually a problem)
But with 'mem=', there is no chance to stop such boot memory being offlined
as it where never in use by the kernel. As 'mem=' is a debug only option on
arm64 platform, just warn for such a situation and move on.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.15-rc1

 arch/arm64/include/asm/memory.h |  1 +
 arch/arm64/mm/init.c            |  9 +++++++--
 arch/arm64/mm/mmu.c             | 12 ++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f1745a843414..361d4e01a864 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -353,6 +353,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
+bool has_mem_limit_reduced(void);
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 37a81754d9b6..cf21edfc8b0f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -211,6 +211,11 @@ EXPORT_SYMBOL(pfn_is_map_memory);
 
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
 
+bool has_mem_limit_reduced(void)
+{
+	return memory_limit != PHYS_ADDR_MAX;
+}
+
 /*
  * Limit the memory size that was specified via FDT.
  */
@@ -285,7 +290,7 @@ void __init arm64_memblock_init(void)
 	 * high up in memory, add back the kernel region that must be accessible
 	 * via the linear mapping.
 	 */
-	if (memory_limit != PHYS_ADDR_MAX) {
+	if (has_mem_limit_reduced()) {
 		memblock_mem_limit_remove_map(memory_limit);
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
@@ -461,7 +466,7 @@ void free_initmem(void)
 
 void dump_mem_limit(void)
 {
-	if (memory_limit != PHYS_ADDR_MAX) {
+	if (has_mem_limit_reduced()) {
 		pr_emerg("Memory Limit: %llu MB\n", memory_limit >> 20);
 	} else {
 		pr_emerg("Memory Limit: none\n");
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb347c3..7ac39ee876c3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1627,6 +1627,18 @@ static int __init prevent_bootmem_remove_init(void)
 	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
 		return ret;
 
+	if (has_mem_limit_reduced()) {
+		/*
+		 * Physical memory limit has been reduced via the 'mem=' kernel
+		 * command line option. Memory beyond reduced limit could now be
+		 * removed and reassigned (guest ?) transparently to the kernel.
+		 * This might cause subsequent kexec kernel to crash or at least
+		 * corrupt the memory when accessing UEFI memory map enumerated
+		 * boot memory which might have been repurposed.
+		 */
+		pr_warn("Memory limit reduced, kexec might be problematic\n");
+	}
+
 	validate_bootmem_online();
 	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
 	if (ret)
-- 
2.20.1

