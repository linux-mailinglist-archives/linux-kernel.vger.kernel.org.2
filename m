Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB93A388835
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhESHdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:33:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240198AbhESHdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:33:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5046ED1;
        Wed, 19 May 2021 00:32:29 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3ED303F73D;
        Wed, 19 May 2021 00:32:26 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on USE_SPLIT_PTE_PTLOCKS
Date:   Wed, 19 May 2021 13:03:06 +0530
Message-Id: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split ptlocks need not be defined and allocated unless they are being used.
ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
just makes it explicit and clear. While here drop the spinlock_t element
from the struct page when USE_SPLIT_PTE_PTLOCKS is not enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.13-rc2.

Changes in V2:

- Dropped spinlock_t element from struct page

Changes in V1:

https://lore.kernel.org/linux-mm/1620618390-9999-1-git-send-email-anshuman.khandual@arm.com/

 include/linux/mm_types.h      | 2 ++
 include/linux/mm_types_task.h | 5 +++++
 mm/memory.c                   | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c10a45..a0fd851c0a0c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -152,10 +152,12 @@ struct page {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
 			};
+#if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
 #else
 			spinlock_t ptl;
+#endif
 #endif
 		};
 		struct {	/* ZONE_DEVICE pages */
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..1b222f8039d1 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -22,7 +22,12 @@
 #define USE_SPLIT_PTE_PTLOCKS	(NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
 #define USE_SPLIT_PMD_PTLOCKS	(USE_SPLIT_PTE_PTLOCKS && \
 		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
+
+#if USE_SPLIT_PTE_PTLOCKS
 #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
+#else
+#define ALLOC_SPLIT_PTLOCKS	0
+#endif
 
 /*
  * The per task VMA cache array:
diff --git a/mm/memory.c b/mm/memory.c
index 730daa00952b..9c3b63f11aee 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5250,7 +5250,7 @@ long copy_huge_page_from_user(struct page *dst_page,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
-#if USE_SPLIT_PTE_PTLOCKS && ALLOC_SPLIT_PTLOCKS
+#if ALLOC_SPLIT_PTLOCKS
 
 static struct kmem_cache *page_ptl_cachep;
 
-- 
2.20.1

