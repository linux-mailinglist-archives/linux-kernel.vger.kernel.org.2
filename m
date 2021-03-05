Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91FC32E161
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCEFYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:24:50 -0500
Received: from foss.arm.com ([217.140.110.172]:47988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCEFYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:24:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61A87113E;
        Thu,  4 Mar 2021 21:24:48 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E9043F73B;
        Thu,  4 Mar 2021 21:24:42 -0800 (PST)
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH V3 2/2] arm64/mm: Reorganize pfn_valid()
Date:   Fri,  5 Mar 2021 10:54:58 +0530
Message-Id: <1614921898-4099-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances of pfn_to_section_nr() and __pfn_to_section()
when CONFIG_SPARSEMEM is enabled. This can be optimized if memory section
is fetched earlier. This replaces the open coded PFN and ADDR conversion
with PFN_PHYS() and PHYS_PFN() helpers. While there, also add a comment.
This does not cause any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/init.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5920c527845a..3685e12aba9b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -219,16 +219,26 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 
 int pfn_valid(unsigned long pfn)
 {
-	phys_addr_t addr = pfn << PAGE_SHIFT;
+	phys_addr_t addr = PFN_PHYS(pfn);
 
-	if ((addr >> PAGE_SHIFT) != pfn)
+	/*
+	 * Ensure the upper PAGE_SHIFT bits are clear in the
+	 * pfn. Else it might lead to false positives when
+	 * some of the upper bits are set, but the lower bits
+	 * match a valid pfn.
+	 */
+	if (PHYS_PFN(addr) != pfn)
 		return 0;
 
 #ifdef CONFIG_SPARSEMEM
+{
+	struct mem_section *ms;
+
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 
-	if (!valid_section(__pfn_to_section(pfn)))
+	ms = __pfn_to_section(pfn);
+	if (!valid_section(ms))
 		return 0;
 
 	/*
@@ -240,8 +250,9 @@ int pfn_valid(unsigned long pfn)
 	 * memory sections covering all of hotplug memory including
 	 * both normal and ZONE_DEVICE based.
 	 */
-	if (!early_section(__pfn_to_section(pfn)))
-		return pfn_section_valid(__pfn_to_section(pfn), pfn);
+	if (!early_section(ms))
+		return pfn_section_valid(ms, pfn);
+}
 #endif
 	return memblock_is_map_memory(addr);
 }
-- 
2.20.1

