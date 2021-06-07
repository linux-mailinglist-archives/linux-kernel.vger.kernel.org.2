Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39A539DE75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFGOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:18:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4381 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:18:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzFgp63qCz6v28;
        Mon,  7 Jun 2021 22:12:38 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 22:16:28 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 22:16:28 +0800
From:   wangbin <wangbin224@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <n-horiguchi@ah.jp.nec.com>, <mike.kravetz@oracle.com>,
        <akpm@linux-foundation.org>, <wuxu.wu@huawei.com>
Subject: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory failure on hugetlbfs
Date:   Mon, 7 Jun 2021 22:16:23 +0800
Message-ID: <20210607141623.1971-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.206]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Wang <wangbin224@huawei.com>

In the current hugetlbfs memory failure handler, reserved huge page
counts are used to record the number of huge pages with hwposion.
There are two problems:

1. We call hugetlb_fix_reserve_counts() to change reserved counts
in hugetlbfs_error_remove_page(). But this function is only called if
hugetlb_unreserve_pages() fails, and hugetlb_unreserve_pages() fails
only if kmalloc in region_del() fails, which is almost impossible.
As a result, the reserved count is not corrected as expected when a
memory failure occurs.

2. Reserved counts is designed to display the number of hugepages
reserved at mmap() time. This means that even if we fix the first
issue, reserved counts will be confusing because we can't tell if
it's hwposion or reserved hugepage.

This patch adds hardware corrput huge pages counts to record memory
failure on hugetlbfs instead of reserved counts.

Signed-off-by: Bin Wang <wangbin224@huawei.com>
---
 fs/hugetlbfs/inode.c    |  3 +--
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 55efd3dd04f6..3c094f533981 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -985,8 +985,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	pgoff_t index = page->index;
 
 	remove_huge_page(page);
-	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
-		hugetlb_fix_reserve_counts(inode);
+	hugetlb_fix_hwcrp_counts(page);
 
 	return 0;
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b92f25ccef58..130f244f3bef 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -153,6 +153,7 @@ void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
+void hugetlb_fix_hwcrp_counts(struct page *page);
 extern struct mutex *hugetlb_fault_mutex_table;
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
@@ -576,12 +577,14 @@ struct hstate {
 	unsigned long free_huge_pages;
 	unsigned long resv_huge_pages;
 	unsigned long surplus_huge_pages;
+	unsigned long hwcrp_huge_pages;
 	unsigned long nr_overcommit_huge_pages;
 	struct list_head hugepage_activelist;
 	struct list_head hugepage_freelists[MAX_NUMNODES];
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+	unsigned int hwcrp_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95918f410c0f..dae91f118c18 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -761,6 +761,15 @@ void hugetlb_fix_reserve_counts(struct inode *inode)
 		pr_warn("hugetlb: Huge Page Reserved count may go negative.\n");
 }
 
+void hugetlb_fix_hwcrp_counts(struct page *page)
+{
+	struct hstate *h = &default_hstate;
+	int nid = page_to_nid(page);
+
+	h->hwcrp_huge_pages++;
+	h->hwcrp_huge_pages_node[nid]++;
+}
+
 /*
  * Count and return the number of huge pages in the reserve map
  * that intersect with the range [f, t).
@@ -3089,12 +3098,30 @@ static ssize_t surplus_hugepages_show(struct kobject *kobj,
 }
 HSTATE_ATTR_RO(surplus_hugepages);
 
+static ssize_t hwcrp_hugepages_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	struct hstate *h;
+	unsigned long hwcrp_huge_pages;
+	int nid;
+
+	h = kobj_to_hstate(kobj, &nid);
+	if (nid == NUMA_NO_NODE)
+		hwcrp_huge_pages = h->hwcrp_huge_pages;
+	else
+		hwcrp_huge_pages = h->hwcrp_huge_pages_node[nid];
+
+	return sprintf(buf, "%lu\n", hwcrp_huge_pages);
+}
+HSTATE_ATTR_RO(hwcrp_hugepages);
+
 static struct attribute *hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&nr_overcommit_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&resv_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&hwcrp_hugepages_attr.attr,
 #ifdef CONFIG_NUMA
 	&nr_hugepages_mempolicy_attr.attr,
 #endif
@@ -3164,6 +3191,7 @@ static struct attribute *per_node_hstate_attrs[] = {
 	&nr_hugepages_attr.attr,
 	&free_hugepages_attr.attr,
 	&surplus_hugepages_attr.attr,
+	&hwcrp_hugepages_attr.attr,
 	NULL,
 };
 
@@ -3657,11 +3685,13 @@ void hugetlb_report_meminfo(struct seq_file *m)
 				   "HugePages_Free:    %5lu\n"
 				   "HugePages_Rsvd:    %5lu\n"
 				   "HugePages_Surp:    %5lu\n"
+				   "HugePages_Hwcrp:   %5lu\n"
 				   "Hugepagesize:   %8lu kB\n",
 				   count,
 				   h->free_huge_pages,
 				   h->resv_huge_pages,
 				   h->surplus_huge_pages,
+				   h->hwcrp_huge_pages,
 				   huge_page_size(h) / SZ_1K);
 	}
 
-- 
2.23.0

