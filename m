Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA732A0B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576437AbhCBE3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:29:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13018 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhCBBhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:37:46 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqKSS1k6szjVBC;
        Tue,  2 Mar 2021 09:35:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Mar 2021
 09:36:37 +0800
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <npiggin@suse.de>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>,
        <dingtianhong@huawei.com>, <chenweilong@huawei.com>,
        <rui.xiang@huawei.com>
Subject: [PATCH] mm/memcg: set memcg when split pages
Date:   Tue, 2 Mar 2021 01:34:51 +0000
Message-ID: <20210302013451.118701-1-zhouguanghui1@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When split page, the memory cgroup info recorded in first page is
not copied to tail pages. In this case, when the tail pages are
freed, the uncharge operation is not performed. As a result, the
usage of this memcg keeps increasing, and the OOM may occur.

So, the copying of first page's memory cgroup info to tail pages
is needed when split page.

Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/page_alloc.c            |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..c7e2b4421dc1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -867,6 +867,12 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
+static inline void copy_page_memcg(struct page *dst, struct page *src)
+{
+	if (src->memcg_data)
+		dst->memcg_data = src->memcg_data;
+}
+
 struct mem_cgroup *lock_page_memcg(struct page *page);
 void __unlock_page_memcg(struct mem_cgroup *memcg);
 void unlock_page_memcg(struct page *page);
@@ -1291,6 +1297,10 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
+static inline void copy_page_memcg(struct page *dst, struct page *src)
+{
+}
+
 static inline struct mem_cgroup *lock_page_memcg(struct page *page)
 {
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..ee0a63dc1c9b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3307,8 +3307,10 @@ void split_page(struct page *page, unsigned int order)
 	VM_BUG_ON_PAGE(PageCompound(page), page);
 	VM_BUG_ON_PAGE(!page_count(page), page);
 
-	for (i = 1; i < (1 << order); i++)
+	for (i = 1; i < (1 << order); i++) {
 		set_page_refcounted(page + i);
+		copy_page_memcg(page + i, page);
+	}
 	split_page_owner(page, 1 << order);
 }
 EXPORT_SYMBOL_GPL(split_page);
-- 
2.25.0

