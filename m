Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD033679C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhDVGTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhDVGTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 275BD60E0C;
        Thu, 22 Apr 2021 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619072359;
        bh=uAcQCKfynNirKrVcKn7BUZtb4Q7z7Znh4i0ynZdq9kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzfnTm3Z1pasiEH1lFZ42vt8BpmmNbt8U4aNZDs48SNuYcBU/Xdl4S/HQPLYNPYjN
         ZdRUVwu+uSRJY+41MYKZluiy9qQuuIn7q9LE/GyHMIbISznQ2oWPWxC9Qz7N1eKu8N
         9jzEZvri+Lio8jIA6hZawhZU7qVjD6bUoxTribnLNM6fd/BIp3gMFODASulbMWHtOq
         re+OJ1tv+B49WL1NU+QPHkzjrdACu9GLk9d5KWrIMEQJzR4GJKXwvmCl3M9YHcf2yW
         zLiUPmbqfOx6PWakTZ2fDBSMKaiZ7ex8/8mUw6yo6le9C7ULIJZw4L3ci5ZLsI7ryO
         34jeQUkYTpUXQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/4] memblock: update initialization of reserved pages
Date:   Thu, 22 Apr 2021 09:19:00 +0300
Message-Id: <20210422061902.21614-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210422061902.21614-1-rppt@kernel.org>
References: <20210422061902.21614-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The struct pages representing a reserved memory region are initialized
using reserve_bootmem_range() function. This function is called for each
reserved region just before the memory is freed from memblock to the buddy
page allocator.

The struct pages for MEMBLOCK_NOMAP regions are kept with the default
values set by the memory map initialization which makes it necessary to
have a special treatment for such pages in pfn_valid() and
pfn_valid_within().

Split out initialization of the reserved pages to a function with a
meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
reserved regions and mark struct pages for the NOMAP regions as
PageReserved.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memblock.h |  4 +++-
 mm/memblock.c            | 28 ++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5984fff3f175..1b4c97c151ae 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -30,7 +30,9 @@ extern unsigned long long max_possible_pfn;
  * @MEMBLOCK_NONE: no special request
  * @MEMBLOCK_HOTPLUG: hotpluggable region
  * @MEMBLOCK_MIRROR: mirrored region
- * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
+ * @MEMBLOCK_NOMAP: don't add to kernel direct mapping and treat as
+ * reserved in the memory map; refer to memblock_mark_nomap() description
+ * for further details
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..3abf2c3fea7f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -906,6 +906,11 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
  * @base: the base phys addr of the region
  * @size: the size of the region
  *
+ * The memory regions marked with %MEMBLOCK_NOMAP will not be added to the
+ * direct mapping of the physical memory. These regions will still be
+ * covered by the memory map. The struct page representing NOMAP memory
+ * frames in the memory map will be PageReserved()
+ *
  * Return: 0 on success, -errno on failure.
  */
 int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
@@ -2002,6 +2007,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	return end_pfn - start_pfn;
 }
 
+static void __init memmap_init_reserved_pages(void)
+{
+	struct memblock_region *region;
+	phys_addr_t start, end;
+	u64 i;
+
+	/* initialize struct pages for the reserved regions */
+	for_each_reserved_mem_range(i, &start, &end)
+		reserve_bootmem_region(start, end);
+
+	/* and also treat struct pages for the NOMAP regions as PageReserved */
+	for_each_mem_region(region) {
+		if (memblock_is_nomap(region)) {
+			start = region->base;
+			end = start + region->size;
+			reserve_bootmem_region(start, end);
+		}
+	}
+}
+
 static unsigned long __init free_low_memory_core_early(void)
 {
 	unsigned long count = 0;
@@ -2010,8 +2035,7 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_range(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	memmap_init_reserved_pages();
 
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
-- 
2.28.0

