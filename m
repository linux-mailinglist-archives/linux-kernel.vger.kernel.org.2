Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051AB4456A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhKDP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:59:48 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:57524 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKDP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636041429; x=1667577429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MTq5hZatD7hD9SHlPbhbXOdMKu5hYT3GVGdSgkvs6HY=;
  b=YL0lzIh0Lxr8A0vHBt+l8hMnm6xeztchG2Y+INMmkS1E2mHGWeo6OV4w
   N57Dpl/OvIeqfyiSvDWe7IptZ7d6bp2pdCuDYqqXx1IVLRpN/Oot1bJVi
   p3/3kwtAa7+KVXFewVpMaTLRmwbG0YsnQPKK5nlrxNGY/cJ5zIO/6v5YU
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Nov 2021 08:57:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 08:57:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 4 Nov 2021 08:57:08 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 4 Nov 2021 08:57:07 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
Date:   Thu, 4 Nov 2021 11:56:23 -0400
Message-ID: <20211104155623.11158-1-quic_qiancai@quicinc.com>
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
 arch/arm64/mm/mmu.c      |  3 ++-
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 10 +++++++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d77bf06d6a6d..4d3cfbaa92a7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -96,7 +96,8 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
 	phys_addr_t phys;
 	void *ptr;
 
-	phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
+					 MEMBLOCK_ALLOC_PGTABLE);
 	if (!phys)
 		panic("Failed to allocate page table page\n");
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 7df557b16c1e..de903055b01c 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -390,6 +390,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
 #define MEMBLOCK_ALLOC_KASAN		1
+#define MEMBLOCK_ALLOC_PGTABLE		2
 
 /* We are using top down, so it is safe to use 0 here */
 #define MEMBLOCK_LOW_LIMIT 0
diff --git a/mm/memblock.c b/mm/memblock.c
index 659bf0ffb086..13bc56a641c0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -287,7 +287,8 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 {
 	/* pump up @end */
 	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
-	    end == MEMBLOCK_ALLOC_KASAN)
+	    end == MEMBLOCK_ALLOC_KASAN ||
+	    end == MEMBLOCK_ALLOC_PGTABLE)
 		end = memblock.current_limit;
 
 	/* avoid allocating the first page */
@@ -1387,8 +1388,11 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	return 0;
 
 done:
-	/* Skip kmemleak for kasan_init() due to high volume. */
-	if (end != MEMBLOCK_ALLOC_KASAN)
+	/*
+	 * Skip kmemleak for kasan_init() and early_pgtable_alloc() due to high
+	 * volume.
+	 */
+	if (end != MEMBLOCK_ALLOC_KASAN && end != MEMBLOCK_ALLOC_PGTABLE)
 		/*
 		 * The min_count is set to 0 so that memblock allocated
 		 * blocks are never reported as leaks. This is because many
-- 
2.30.2

