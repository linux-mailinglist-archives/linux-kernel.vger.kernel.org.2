Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C403086A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhA2HlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:41:18 -0500
Received: from foss.arm.com ([217.140.110.172]:44806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhA2Hkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:40:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7775C1509;
        Thu, 28 Jan 2021 23:39:59 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.92.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 561453F719;
        Thu, 28 Jan 2021 23:39:54 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/2] arm64/mm: Reorganize pfn_valid()
Date:   Fri, 29 Jan 2021 13:09:46 +0530
Message-Id: <1611905986-20155-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611905986-20155-1-git-send-email-anshuman.khandual@arm.com>
References: <1611905986-20155-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances of pfn_to_section_nr() and __pfn_to_section()
when CONFIG_SPARSEMEM is enabled. This can be just optimized if the memory
section is fetched earlier. Hence bifurcate pfn_valid() into two different
definitions depending on whether CONFIG_SPARSEMEM is enabled. Also replace
the open coded pfn <--> addr conversion with __[pfn|phys]_to_[phys|pfn]().
This does not cause any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/init.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1141075e4d53..09adca90c57a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -217,18 +217,25 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
+#ifdef CONFIG_SPARSEMEM
 int pfn_valid(unsigned long pfn)
 {
-	phys_addr_t addr = pfn << PAGE_SHIFT;
+	struct mem_section *ms = __pfn_to_section(pfn);
+	phys_addr_t addr = __pfn_to_phys(pfn);
 
-	if ((addr >> PAGE_SHIFT) != pfn)
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (__phys_to_pfn(addr) != pfn)
 		return 0;
 
-#ifdef CONFIG_SPARSEMEM
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 
-	if (!valid_section(__pfn_to_section(pfn)))
+	if (!valid_section(ms))
 		return 0;
 
 	/*
@@ -240,11 +247,28 @@ int pfn_valid(unsigned long pfn)
 	 * memory sections covering all of hotplug memory including
 	 * both normal and ZONE_DEVICE based.
 	 */
-	if (!early_section(__pfn_to_section(pfn)))
-		return pfn_section_valid(__pfn_to_section(pfn), pfn);
-#endif
+	if (!early_section(ms))
+		return pfn_section_valid(ms, pfn);
+
 	return memblock_is_map_memory(addr);
 }
+#else
+int pfn_valid(unsigned long pfn)
+{
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+
+	return memblock_is_map_memory(addr);
+}
+#endif
 EXPORT_SYMBOL(pfn_valid);
 
 static phys_addr_t memory_limit = PHYS_ADDR_MAX;
-- 
2.20.1

