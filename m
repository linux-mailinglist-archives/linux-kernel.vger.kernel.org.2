Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78959446572
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhKEPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:09:30 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:28464 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhKEPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636124810; x=1667660810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N/XGvxinYfHMqC8ASpNZ0TKaYbQ/o6kLCUX0kgvUPGU=;
  b=DltiNJz2ho9J9yhDyNajsbHrNurA53hQlBblxSwe9r8rh8rTW0bNvnWt
   x+/Z1s7QPKUDYhpbsmVSw/0uLSUfb8Y60it/jJ/FJ6i7AA1gedZSA26qc
   +EZWc/y7gCHQveg64yzow+maophQkOOhxEG6SRvOd6hzIQ5Q+anlMJlFB
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 05 Nov 2021 08:06:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 08:06:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 08:06:49 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 08:06:47 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Russell King <linux@armlinux.org.uk>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH v2] arm64: Track no early_pgtable_alloc() for kmemleak
Date:   Fri, 5 Nov 2021 11:05:09 -0400
Message-ID: <20211105150509.7826-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switched page size from 64KB to 4KB on several arm64 servers here,
kmemleak starts to run out of early memory pool due to a huge number of
those early_pgtable_alloc() calls:

  kmemleak_alloc_phys()
  memblock_alloc_range_nid()
  memblock_phys_alloc_range()
  early_pgtable_alloc()
  init_pmd()
  alloc_init_pud()
  __create_pgd_mapping()
  __map_memblock()
  paging_init()
  setup_arch()
  start_kernel()

Increased the default value of DEBUG_KMEMLEAK_MEM_POOL_SIZE by 4 times
won't be enough for a server with 200GB+ memory. There isn't much
interesting to check memory leaks for those early page tables and those
early memory mappings should not reference to other memory. Hence, no
kmemleak false positives, and we can safely skip tracking those early
allocations from kmemleak like we did in the commit fed84c785270
("mm/memblock.c: skip kmemleak for kasan_init()") without needing to
introduce complications to automatically scale the value depends on the
runtime memory size etc. After the patch, the default value of
DEBUG_KMEMLEAK_MEM_POOL_SIZE becomes sufficient again.

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
v2:
Rename MEMBLOCK_ALLOC_KASAN to MEMBLOCK_ALLOC_NOLEAKTRACE to deal with
those situations in general.

 arch/arm/mm/kasan_init.c   | 2 +-
 arch/arm64/mm/kasan_init.c | 5 +++--
 arch/arm64/mm/mmu.c        | 3 ++-
 include/linux/memblock.h   | 2 +-
 mm/memblock.c              | 9 ++++++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 4b1619584b23..5ad0d6c56d56 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -32,7 +32,7 @@ pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
 static __init void *kasan_alloc_block(size_t size)
 {
 	return memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
-				      MEMBLOCK_ALLOC_KASAN, NUMA_NO_NODE);
+				      MEMBLOCK_ALLOC_NOLEAKTRACE, NUMA_NO_NODE);
 }
 
 static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 6f5a6fe8edd7..c12cd700598f 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -36,7 +36,7 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
 {
 	void *p = memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
 					      __pa(MAX_DMA_ADDRESS),
-					      MEMBLOCK_ALLOC_KASAN, node);
+					      MEMBLOCK_ALLOC_NOLEAKTRACE, node);
 	if (!p)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE, node,
@@ -49,7 +49,8 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
 {
 	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
-						MEMBLOCK_ALLOC_KASAN, node);
+						MEMBLOCK_ALLOC_NOLEAKTRACE,
+						node);
 	if (!p)
 		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE, node,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d77bf06d6a6d..acfae9b41cc8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -96,7 +96,8 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
 	phys_addr_t phys;
 	void *ptr;
 
-	phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
+					 MEMBLOCK_ALLOC_NOLEAKTRACE);
 	if (!phys)
 		panic("Failed to allocate page table page\n");
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 7df557b16c1e..8adcf1fa8096 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -389,7 +389,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 /* Flags for memblock allocation APIs */
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
-#define MEMBLOCK_ALLOC_KASAN		1
+#define MEMBLOCK_ALLOC_NOLEAKTRACE	1
 
 /* We are using top down, so it is safe to use 0 here */
 #define MEMBLOCK_LOW_LIMIT 0
diff --git a/mm/memblock.c b/mm/memblock.c
index 659bf0ffb086..1018e50566f3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -287,7 +287,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 {
 	/* pump up @end */
 	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
-	    end == MEMBLOCK_ALLOC_KASAN)
+	    end == MEMBLOCK_ALLOC_NOLEAKTRACE)
 		end = memblock.current_limit;
 
 	/* avoid allocating the first page */
@@ -1387,8 +1387,11 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	return 0;
 
 done:
-	/* Skip kmemleak for kasan_init() due to high volume. */
-	if (end != MEMBLOCK_ALLOC_KASAN)
+	/*
+	 * Skip kmemleak for those places like kasan_init() and
+	 * early_pgtable_alloc() due to high volume.
+	 */
+	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
 		/*
 		 * The min_count is set to 0 so that memblock allocated
 		 * blocks are never reported as leaks. This is because many
-- 
2.30.2

