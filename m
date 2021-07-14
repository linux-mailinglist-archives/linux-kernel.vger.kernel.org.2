Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFAC3C848A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbhGNMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239284AbhGNMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:40:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11C8F613B7;
        Wed, 14 Jul 2021 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626266267;
        bh=HDxU9C4XWcZvXj9PvP7Rf+xajNX1bDrKnIsSd+7fGbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXX49VE8d7FWEc2fS7HJKBW6kNmhoyDmD4rHk8igoXeJCwBBrozG3EdVpO8lebiFM
         6QPXQ62hwcKB+b7k6Px3KTXPFa+O/UdIfL0QCX2wk6Mq6FaB7BYirB6pSyj2vTc/OG
         S7MIPd+PfTRwGYlmW4LPvnQpvI0ZOsAd2oXz1+xn5D536+UsqTbT1GiQUAs8fW6Exf
         dKu8ZhQkBBLr45l25xI4uhA0ZMkvw3u1HCA1a42LT+MCKh60EjOMfMHuLflyFgsuMf
         00T9stDHhgXyvJ8isLvbXiHUPy7++oW6IIeEIF1Hdv0zrAQiQVzxD+H43vbBSTKTUE
         HVLtiMCYiZZgA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/4] mm/page_alloc: always initialize memory map for the holes
Date:   Wed, 14 Jul 2021 15:37:36 +0300
Message-Id: <20210714123739.16493-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210714123739.16493-1-rppt@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Currently memory map for the holes is initialized only when SPARSEMEM
memory model is used. Yet, even with FLATMEM there could be holes in the
physical memory layout that have memory map entries.

For instance, the memory reserved using e820 API on i386 or
"reserved-memory" nodes in device tree would not appear in memblock.memory
and hence the struct pages for such holes will be skipped during memory map
initialization.

These struct pages will be zeroed because the memory map for FLATMEM
systems is allocated with memblock_alloc_node() that clears the allocated
memory. While zeroed struct pages do not cause immediate problems, the
correct behaviour is to initialize every page using __init_single_page().
Besides, enabling page poison for FLATMEM case will trigger
PF_POISONED_CHECK() unless the memory map is properly initialized.

Make sure init_unavailable_range() is called for both SPARSEMEM and FLATMEM
so that struct pages representing memory holes would appear as PG_Reserved
with any memory layout.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b97e17806be..878d7af4403d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6624,7 +6624,6 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	}
 }
 
-#if !defined(CONFIG_FLATMEM)
 /*
  * Only struct pages that correspond to ranges defined by memblock.memory
  * are zeroed and initialized by going through __init_single_page() during
@@ -6669,13 +6668,6 @@ static void __init init_unavailable_range(unsigned long spfn,
 		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
 			node, zone_names[zone], pgcnt);
 }
-#else
-static inline void init_unavailable_range(unsigned long spfn,
-					  unsigned long epfn,
-					  int zone, int node)
-{
-}
-#endif
 
 static void __init memmap_init_zone_range(struct zone *zone,
 					  unsigned long start_pfn,
-- 
2.28.0

