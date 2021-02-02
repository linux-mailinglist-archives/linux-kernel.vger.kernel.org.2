Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0430B638
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhBBEMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:12:41 -0500
Received: from foss.arm.com ([217.140.110.172]:43236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhBBEM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:12:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C3F1509;
        Mon,  1 Feb 2021 20:11:43 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 117133F66E;
        Mon,  1 Feb 2021 20:11:37 -0800 (PST)
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
Subject: [PATCH V2 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Date:   Tue,  2 Feb 2021 09:41:53 +0530
Message-Id: <1612239114-28428-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_valid() validates a pfn but basically it checks for a valid struct page
backing for that pfn. It should always return positive for memory ranges
backed with struct page mapping. But currently pfn_valid() fails for all
ZONE_DEVICE based memory types even though they have struct page mapping.

pfn_valid() asserts that there is a memblock entry for a given pfn without
MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
that they do not have memblock entries. Hence memblock_is_map_memory() will
invariably fail via memblock_search() for a ZONE_DEVICE based address. This
eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
into the system via memremap_pages() called from a driver, their respective
memory sections will not have SECTION_IS_EARLY set.

Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
for firmware reserved memory regions. memblock_is_map_memory() can just be
skipped as its always going to be positive and that will be an optimization
for the normal hotplug memory. Like ZONE_DEVICE based memory, all normal
hotplugged memory too will not have SECTION_IS_EARLY set for their sections

Skipping memblock_is_map_memory() for all non early memory sections would
fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
performance for normal hotplug memory as well.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Acked-by: David Hildenbrand <david@redhat.com>
Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 709d98fea90c..1141075e4d53 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -230,6 +230,18 @@ int pfn_valid(unsigned long pfn)
 
 	if (!valid_section(__pfn_to_section(pfn)))
 		return 0;
+
+	/*
+	 * ZONE_DEVICE memory does not have the memblock entries.
+	 * memblock_is_map_memory() check for ZONE_DEVICE based
+	 * addresses will always fail. Even the normal hotplugged
+	 * memory will never have MEMBLOCK_NOMAP flag set in their
+	 * memblock entries. Skip memblock search for all non early
+	 * memory sections covering all of hotplug memory including
+	 * both normal and ZONE_DEVICE based.
+	 */
+	if (!early_section(__pfn_to_section(pfn)))
+		return pfn_section_valid(__pfn_to_section(pfn), pfn);
 #endif
 	return memblock_is_map_memory(addr);
 }
-- 
2.20.1

