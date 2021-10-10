Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C5427F3D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 07:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhJJF02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 01:26:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54153 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230310AbhJJF01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 01:26:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UrDvT6w_1633843467;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UrDvT6w_1633843467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 10 Oct 2021 13:24:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] hugetlb: Support node specified when using cma for gigantic hugepages
Date:   Sun, 10 Oct 2021 13:24:08 +0800
Message-Id: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the size of CMA area for gigantic hugepages runtime allocation is
balanced for all online nodes, but we also want to specify the size of
CMA per-node, or only one node in some cases, which are similar with
commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
parameter to support node allocation")[1].

Thus this patch adds node format for 'hugetlb_cma' parameter to support
specifying the size of CMA per-node. An example is as follows:

hugetlb_cma=0:5G,2:5G

which means allocating 5G size of CMA area on node 0 and node 2
respectively.

[1]
https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +-
 mm/hugetlb.c                                    | 79 +++++++++++++++++++++----
 2 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3ad8e9d0..a147faa5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1587,8 +1587,10 @@
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
 	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
-			of gigantic hugepages.
-			Format: nn[KMGTPE]
+			of gigantic hugepages. Or using node format, the size
+			of a CMA area per node can be specified.
+			Format: nn[KMGTPE] or (node format)
+				<node>:nn[KMGTPE][,<node>:nn[KMGTPE]]
 
 			Reserve a CMA area of given size and allocate gigantic
 			hugepages using the CMA allocator. If enabled, the
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d2f4c2..8b4e409 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -50,6 +50,7 @@
 
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
+static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
 static bool hugetlb_cma_page(struct page *page, unsigned int order)
 {
 	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
@@ -62,6 +63,7 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
 }
 #endif
 static unsigned long hugetlb_cma_size __initdata;
+static nodemask_t hugetlb_cma_nodes_allowed = NODE_MASK_NONE;
 
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
@@ -3497,9 +3499,15 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 
 	if (nid == NUMA_NO_NODE) {
 		/*
+		 * If we've specified the size of CMA area per node,
+		 * should use it firstly.
+		 */
+		if (hstate_is_gigantic(h) && !nodes_empty(hugetlb_cma_nodes_allowed))
+			n_mask = &hugetlb_cma_nodes_allowed;
+		/*
 		 * global hstate attribute
 		 */
-		if (!(obey_mempolicy &&
+		else if (!(obey_mempolicy &&
 				init_nodemask_of_mempolicy(&nodes_allowed)))
 			n_mask = &node_states[N_MEMORY];
 		else
@@ -6745,7 +6753,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 
 static int __init cmdline_parse_hugetlb_cma(char *p)
 {
-	hugetlb_cma_size = memparse(p, &p);
+	int nid, count = 0;
+	unsigned long tmp;
+	char *s = p;
+
+	while (*s) {
+		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
+			break;
+
+		if (s[count] == ':') {
+			nid = tmp;
+			if (nid < 0 || nid >= MAX_NUMNODES)
+				break;
+
+			s += count + 1;
+			tmp = memparse(s, &s);
+			hugetlb_cma_size_in_node[nid] = tmp;
+			hugetlb_cma_size += tmp;
+
+			/*
+			 * Skip the separator if have one, otherwise
+			 * break the parsing.
+			 */
+			if (*s == ',')
+				s++;
+			else
+				break;
+		} else {
+			hugetlb_cma_size = memparse(p, &p);
+			break;
+		}
+	}
+
 	return 0;
 }
 
@@ -6754,6 +6793,7 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
+	bool node_specific_cma_alloc = false;
 	int nid;
 
 	cma_reserve_called = true;
@@ -6767,20 +6807,37 @@ void __init hugetlb_cma_reserve(int order)
 		return;
 	}
 
-	/*
-	 * If 3 GB area is requested on a machine with 4 numa nodes,
-	 * let's allocate 1 GB on first three nodes and ignore the last one.
-	 */
-	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
-	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
-		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
+	for_each_node_state(nid, N_ONLINE) {
+		if (hugetlb_cma_size_in_node[nid] > 0) {
+			node_specific_cma_alloc = true;
+			break;
+		}
+	}
+
+	if (!node_specific_cma_alloc) {
+		/*
+		 * If 3 GB area is requested on a machine with 4 numa nodes,
+		 * let's allocate 1 GB on first three nodes and ignore the last one.
+		 */
+		per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
+		pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
+			hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
+	}
 
 	reserved = 0;
 	for_each_node_state(nid, N_ONLINE) {
 		int res;
 		char name[CMA_MAX_NAME];
 
-		size = min(per_node, hugetlb_cma_size - reserved);
+		if (node_specific_cma_alloc) {
+			if (hugetlb_cma_size_in_node[nid] <= 0)
+				continue;
+
+			size = hugetlb_cma_size_in_node[nid];
+		} else {
+			size = min(per_node, hugetlb_cma_size - reserved);
+		}
+
 		size = round_up(size, PAGE_SIZE << order);
 
 		snprintf(name, sizeof(name), "hugetlb%d", nid);
@@ -6799,6 +6856,8 @@ void __init hugetlb_cma_reserve(int order)
 			continue;
 		}
 
+		if (node_specific_cma_alloc)
+			node_set(nid, hugetlb_cma_nodes_allowed);
 		reserved += size;
 		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
 			size / SZ_1M, nid);
-- 
1.8.3.1

