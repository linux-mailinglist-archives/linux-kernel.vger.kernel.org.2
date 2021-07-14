Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C413C848C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhGNMko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239284AbhGNMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B2AE613B0;
        Wed, 14 Jul 2021 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626266271;
        bh=d2immekSgHA4d0HzzgQ0U4J8/emUzkNR9p4b5EVUXL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdNb1905cVXkyWPv+c6YlXvxZxMs2zNeW6VJwG5o1+XeehmArs7qSfeYmGehpnhVO
         83PizuHhvC0jjqJzCyrrzIRayAOhyz8x7eINjhLT5XhAn+L7RXbtkfTFLv5oqzYKdJ
         Rz48GwUgRfZyUQOb0NWU0Tic49LXstBbJ6mMK5ELN1sx/JzmwKXuFLl0N8jVc6OyYt
         ceHwJcxqBr/Exhg2uBeLf0dMEi7M0IfSNjMpRdtx6EGH1gnP8NNIg0up8zyIrVTyOv
         T4VooaMbx16Uvq4EfK8oLiwPGZyl6/Xjhulmm6AdFCldbMFqWkg+u59Mnov8YFFccJ
         B/YMexS3gTj0g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/4] mm: introduce memmap_alloc() to unify memory map allocation
Date:   Wed, 14 Jul 2021 15:37:38 +0300
Message-Id: <20210714123739.16493-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210714123739.16493-1-rppt@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are several places that allocate memory for the memory map:
alloc_node_mem_map() for FLATMEM, sparse_buffer_init() and
__populate_section_memmap() for SPARSEMEM.

The memory allocated in the FLATMEM case is zeroed and it is never
poisoned, regardless of CONFIG_PAGE_POISON setting.

The memory allocated in the SPARSEMEM cases is not zeroed and it is
implicitly poisoned inside memblock if CONFIG_PAGE_POISON is set.

Introduce memmap_alloc() wrapper for memblock allocators that will be used
for both FLATMEM and SPARSEMEM cases and will makei memory map zeroing and
poisoning consistent for different memory models.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/internal.h   |  4 ++++
 mm/page_alloc.c | 24 ++++++++++++++++++++++--
 mm/sparse.c     |  6 ++----
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 31ff935b2547..57e28261a3b1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,6 +211,10 @@ extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 
+extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
+			  phys_addr_t min_addr,
+			  int nid, bool exact_nid);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 878d7af4403d..b82e55006894 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6730,6 +6730,26 @@ static void __init memmap_init(void)
 		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
 }
 
+void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
+			  phys_addr_t min_addr, int nid, bool exact_nid)
+{
+	void *ptr;
+
+	if (exact_nid)
+		ptr = memblock_alloc_exact_nid_raw(size, align, min_addr,
+						   MEMBLOCK_ALLOC_ACCESSIBLE,
+						   nid);
+	else
+		ptr = memblock_alloc_try_nid_raw(size, align, min_addr,
+						 MEMBLOCK_ALLOC_ACCESSIBLE,
+						 nid);
+
+	if (ptr && size > 0)
+		page_init_poison(ptr, size);
+
+	return ptr;
+}
+
 static int zone_batchsize(struct zone *zone)
 {
 #ifdef CONFIG_MMU
@@ -7501,8 +7521,8 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 		end = pgdat_end_pfn(pgdat);
 		end = ALIGN(end, MAX_ORDER_NR_PAGES);
 		size =  (end - start) * sizeof(struct page);
-		map = memblock_alloc_node(size, SMP_CACHE_BYTES,
-					  pgdat->node_id);
+		map = memmap_alloc(size, SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
+				   pgdat->node_id, false);
 		if (!map)
 			panic("Failed to allocate %ld bytes for node %d memory map\n",
 			      size, pgdat->node_id);
diff --git a/mm/sparse.c b/mm/sparse.c
index 6326cdf36c4f..a5fad244ac5f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -462,8 +462,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 	if (map)
 		return map;
 
-	map = memblock_alloc_try_nid_raw(size, size, addr,
-					  MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	map = memmap_alloc(size, size, addr, nid, false);
 	if (!map)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
 		      __func__, size, PAGE_SIZE, nid, &addr);
@@ -490,8 +489,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 * and we want it to be properly aligned to the section size - this is
 	 * especially the case for VMEMMAP which maps memmap to PMDs
 	 */
-	sparsemap_buf = memblock_alloc_exact_nid_raw(size, section_map_size(),
-					addr, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
 }
 
-- 
2.28.0

