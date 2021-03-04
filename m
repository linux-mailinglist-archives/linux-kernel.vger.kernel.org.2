Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C312B32CDDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhCDHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:44:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12687 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhCDHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:43:31 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DrjTN2j5jzlSX7;
        Thu,  4 Mar 2021 15:40:40 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 15:42:43 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <hannes@cmpxchg.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <npiggin@gmail.com>,
        <ziy@nvidia.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <dingtianhong@huawei.com>,
        <chenweilong@huawei.com>, <rui.xiang@huawei.com>
Subject: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to split_page_memcg
Date:   Thu, 4 Mar 2021 07:40:52 +0000
Message-ID: <20210304074053.65527-2-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210304074053.65527-1-zhouguanghui1@huawei.com>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mem_cgroup_split_huge_fixup to split_page_memcg and explicitly
pass in page number argument.

In this way, the interface name is more common and can be used by
potential users. In addition, the complete info(memcg and flag) of
the memcg needs to be set to the tail pages.

Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
---
 include/linux/memcontrol.h |  6 ++----
 mm/huge_memory.c           |  2 +-
 mm/memcontrol.c            | 15 ++++++---------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..0c04d39a7967 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1061,9 +1061,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-void mem_cgroup_split_huge_fixup(struct page *head);
-#endif
+void split_page_memcg(struct page *head, unsigned int nr);
 
 #else /* CONFIG_MEMCG */
 
@@ -1400,7 +1398,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	return 0;
 }
 
-static inline void mem_cgroup_split_huge_fixup(struct page *head)
+static inline void split_page_memcg(struct page *head, unsigned int nr)
 {
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 395c75111d33..e7f29308ebc8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2471,7 +2471,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	int i;
 
 	/* complete memcg works before add pages to LRU */
-	mem_cgroup_split_huge_fixup(head);
+	split_page_memcg(head, nr);
 
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry = { .val = page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 845eec01ef9d..e064ac0d850a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3287,24 +3287,21 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 
 #endif /* CONFIG_MEMCG_KMEM */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
- * Because page_memcg(head) is not set on compound tails, set it now.
+ * Because page_memcg(head) is not set on tails, set it now.
  */
-void mem_cgroup_split_huge_fixup(struct page *head)
+void split_page_memcg(struct page *head, unsigned int nr)
 {
 	struct mem_cgroup *memcg = page_memcg(head);
 	int i;
 
-	if (mem_cgroup_disabled())
+	if (mem_cgroup_disabled() || !memcg)
 		return;
 
-	for (i = 1; i < HPAGE_PMD_NR; i++) {
-		css_get(&memcg->css);
-		head[i].memcg_data = (unsigned long)memcg;
-	}
+	for (i = 1; i < nr; i++)
+		head[i].memcg_data = head->memcg_data;
+	css_get_many(&memcg->css, nr - 1);
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_MEMCG_SWAP
 /**
-- 
2.25.0

