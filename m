Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA542E658
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhJOCGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:06:02 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53778 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232271AbhJOCF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:05:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Us1M8r0_1634263432;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Us1M8r0_1634263432)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 10:03:52 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, guro@fb.com, corbet@lwn.net,
        yaozhenguo1@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3] hugetlb: Support node specified when using cma for gigantic hugepages
Date:   Fri, 15 Oct 2021 10:03:41 +0800
Message-Id: <bb790775ca60bb8f4b26956bb3f6988f74e075c7.1634261144.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the size of CMA area for gigantic hugepages runtime allocation is
balanced for all online nodes, but we also want to specify the size of
CMA per-node, or only one node in some cases, which are similar with
patch [1].

For example, on some multi-nodes systems, each node's memory can be
different, allocating the same size of CMA for each node is not suitable
for the low-memory nodes. Meanwhile some workloads like DPDK mentioned by
Zhenguo in patch [1] only need hugepages in one node.

On the other hand, we have some machines with multiple types of memory,
like DRAM and PMEM (persistent memory). On this system, we may want to
specify all the hugepages only on DRAM node, or specify the proportion
of DRAM node and PMEM node, to tuning the performance of the workloads.

Thus this patch adds node format for 'hugetlb_cma' parameter to support
specifying the size of CMA per-node. An example is as follows:

hugetlb_cma=0:5G,2:5G

which means allocating 5G size of CMA area on node 0 and node 2
respectively. And the users should use the node specific sysfs file to
allocate the gigantic hugepages if specified the CMA size on that node.

[1]
https://lkml.kernel.org/r/20211005054729.86457-1-yaozhenguo1@gmail.com

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v2:
 - Update the commit log.
 - Remove hugetlb_cma_nodes_allowed nodemask and related code.
 - Rebase on the current linux-next branch.

Changes from v1:
 - Update the commit log.
 - Avoid changing the behavior for 'balanced' gigantic huge page pool
   allocations.
 - Catch the invalid node specified in hugetlb_cma_reserve().
 - Validate the size of CMA for each node in hugetlb_cma_reserve().
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +-
 mm/hugetlb.c                                    | 86 ++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ad94a2a..395d17e 100644
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
index 058158f..ee0db48 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -50,6 +50,7 @@
 
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
+static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
 static bool hugetlb_cma_page(struct page *page, unsigned int order)
 {
 	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
@@ -6766,7 +6767,38 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 
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
 
@@ -6775,6 +6807,7 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
+	bool node_specific_cma_alloc = false;
 	int nid;
 
 	cma_reserve_called = true;
@@ -6782,6 +6815,31 @@ void __init hugetlb_cma_reserve(int order)
 	if (!hugetlb_cma_size)
 		return;
 
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		if (hugetlb_cma_size_in_node[nid] == 0)
+			continue;
+
+		if (!node_state(nid, N_ONLINE)) {
+			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
+			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
+			hugetlb_cma_size_in_node[nid] = 0;
+			continue;
+		}
+
+		if (hugetlb_cma_size_in_node[nid] < (PAGE_SIZE << order)) {
+			pr_warn("hugetlb_cma: cma area of node %d should be at least %lu MiB\n",
+				nid, (PAGE_SIZE << order) / SZ_1M);
+			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
+			hugetlb_cma_size_in_node[nid] = 0;
+		} else {
+			node_specific_cma_alloc = true;
+		}
+	}
+
+	/* Validate the CMA size again in case some invalid nodes specified. */
+	if (!hugetlb_cma_size)
+		return;
+
 	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
 		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
 			(PAGE_SIZE << order) / SZ_1M);
@@ -6789,20 +6847,30 @@ void __init hugetlb_cma_reserve(int order)
 		return;
 	}
 
-	/*
-	 * If 3 GB area is requested on a machine with 4 numa nodes,
-	 * let's allocate 1 GB on first three nodes and ignore the last one.
-	 */
-	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
-	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
-		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
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
+			if (hugetlb_cma_size_in_node[nid] == 0)
+				continue;
+
+			size = hugetlb_cma_size_in_node[nid];
+		} else {
+			size = min(per_node, hugetlb_cma_size - reserved);
+		}
+
 		size = round_up(size, PAGE_SIZE << order);
 
 		snprintf(name, sizeof(name), "hugetlb%d", nid);
-- 
1.8.3.1

