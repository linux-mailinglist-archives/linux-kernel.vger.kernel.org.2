Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD30B377AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEJDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:47:00 -0400
Received: from foss.arm.com ([217.140.110.172]:47058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhEJDq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:46:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68B9ED1;
        Sun,  9 May 2021 20:45:52 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.77.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D67333F718;
        Sun,  9 May 2021 20:45:50 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on USE_SPLIT_PTE_PTLOCKS
Date:   Mon, 10 May 2021 09:16:30 +0530
Message-Id: <1620618390-9999-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split ptlocks need not be defined and allocated unless they are being used.
ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
just makes it explicit and clear.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm_types_task.h | 5 +++++
 mm/memory.c                   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

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

