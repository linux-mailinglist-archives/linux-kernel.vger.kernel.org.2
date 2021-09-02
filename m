Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AF3FE99A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhIBHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhIBHAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:00:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C18C061575;
        Wed,  1 Sep 2021 23:59:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f129so958088pgc.1;
        Wed, 01 Sep 2021 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOYJtWsdS7SutHyjF6nRHzWxEA78dd75fpyYE9eFsvQ=;
        b=IbcsY7XfGF8GjV3D6bL6fU677WIQsi457bBH6UrahI8belr/3Oq5qINXp/dhphobFW
         CCSBaR6W5maNVwGt7RR6YIhhPmae4ylGQA3aJKTXTGt0O0hzQk7Bu3yXzGBZMvRpI5or
         Y4GD5UD8da8ezygjYTZuerlAAUGNaq9XuSWWMWoPB9dJzpEuulIWUqhF2TujW/TXMENF
         OoVzlDfvONNQeB5VJ8FQWPgZEfnEYxSvYZURzZpjyE1hc1WIMzJcm0TJagHhmozl4nLd
         103VDj0psKDo8kSQyYcJCBc+VDwuKGRbYUE3UWvQHD2r9mepP6vByoU62VP6nvjJki//
         1ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOYJtWsdS7SutHyjF6nRHzWxEA78dd75fpyYE9eFsvQ=;
        b=GDvtBClTnohoQYNxWyYKfP+ZwEd3XjhVjzfDUWfCoue13YolVhWb6ayo8X5mvgeqnr
         plZA14wH4JdQpL8ERQpCzg3gUk9Gb41IuYeH9SuGtlj+uuoOtQ6p5MGSR22VlDhKknB+
         OVUWSLyp9nky8qsbcRqIAxo4zpj5n6DXWUk7gTO/B0t5lGRTBsLzItMSRVqsL0IPjbDV
         5WncIyxmgxaN+yK8RRAAc2ccLdFMHzV0cLccAOKPBsqt5f4BvQiuqTJqerLbvxHXIUCw
         hndRnpGYV2JzsyoSY5sKN2ryH4r43u+fYG52Ns2fUTEjtZtxoROB/yQfG5ODU4X5Fvd3
         pJ0g==
X-Gm-Message-State: AOAM530gBeoGES0soJLcIYWlJ7xxJjtxWvmHG/OyhWBdDn12wkFhnlQU
        SXrPAUKYuAsoRE9cDoOzSIzf9fPUBDMwG8Lt06g=
X-Google-Smtp-Source: ABdhPJyVy2z9ru7c5q/UAmSvDHPo/80dbZA0wJj9KbuTYEe/YjVM+d6JUIlTGdZ6+YIP15nanD5EBw==
X-Received: by 2002:a65:4c47:: with SMTP id l7mr1759003pgr.211.1630565975214;
        Wed, 01 Sep 2021 23:59:35 -0700 (PDT)
Received: from localhost.localdomain ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id q21sm1259288pgk.71.2021.09.01.23.59.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 23:59:34 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, yaozhenguo@jd.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, yaozhenguo <yaozhenguo1@gmail.com>
Subject: [v3] hugetlbfs: Extend the definition of hugepages parameter to support node allocation
Date:   Thu,  2 Sep 2021 14:59:02 +0800
Message-Id: <20210902065902.81943-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can specify the number of hugepages to allocate at boot. But the
hugepages is balanced in all nodes at present. In some scenarios,
we only need hugepages in one node. For example: DPDK needs hugepages
which is in the same node as NIC. if DPDK needs four hugepages of 1G
size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
in kernel cmdline. But, only four hugepages are used. The others should
be free after boot.If the system memory is low(for example: 64G), it will
be an impossible task. So, extend hugepages kernel parameter to specify
node number of hugepages to allocate at boot.
For example add following parameter:

hugepagesz=1G hugepages=0:1,1:3

It will allocate 1 hugepages in node0 and 3 hugepages in node1.

Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
---
v3:	1. Skip gigantic hugepages allocation if hugetlb_cma is enabled.
	2. Fix wrong behavior for parameter: hugepagesz=2M hugepages=2 hugepages=5.
	3. Update hugetlbpage.rst.
	4. Fix side effects which v2 brings in.
	5. add cond_resched in hugetlb_hstate_alloc_pages_onenode.
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
 include/linux/hugetlb.h                       |   1 +
 mm/hugetlb.c                                  | 116 ++++++++++++++++--
 4 files changed, 126 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f..64a128924 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1588,9 +1588,11 @@
 			the number of pages of hugepagesz to be allocated.
 			If this is the first HugeTLB parameter on the command
 			line, it specifies the number of pages to allocate for
-			the default huge page size.  See also
-			Documentation/admin-guide/mm/hugetlbpage.rst.
-			Format: <integer>
+			the default huge page size. If using node format, It
+			specifies numbers of hugepage in a specific node.
+			See also Documentation/admin-guide/mm/hugetlbpage.rst.
+			Format: <integer> or (node format)
+				<node>:<numbers>[,<node>:<numbers>]
 
 	hugepagesz=
 			[HW] The size of the HugeTLB pages.  This is used in
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8abaeb144..bc5f674ff 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -128,7 +128,9 @@ hugepages
 	implicitly specifies the number of huge pages of default size to
 	allocate.  If the number of huge pages of default size is implicitly
 	specified, it can not be overwritten by a hugepagesz,hugepages
-	parameter pair for the default size.
+	parameter pair for the default size. This parameter also has node
+	format. It specifies numbers of hugepage in a specific node when
+	using node format.
 
 	For example, on an architecture with 2M default huge page size::
 
@@ -138,6 +140,14 @@ hugepages
 	indicating that the hugepages=512 parameter is ignored.  If a hugepages
 	parameter is preceded by an invalid hugepagesz parameter, it will
 	be ignored.
+
+	Node format example::
+
+		hugepagesz=2M hugepages=0:1,1:2
+
+	It will allocate 1 2M hugepages in node0 and 2 2M hugepages in node1.
+	If the node number exceeds the maximum node, the parameter will be
+	ignored.
 default_hugepagesz
 	Specify the default huge page size.  This parameter can
 	only be specified once on the command line.  default_hugepagesz can
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a387..5939ecd4f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -605,6 +605,7 @@ struct hstate {
 	unsigned long nr_overcommit_huge_pages;
 	struct list_head hugepage_activelist;
 	struct list_head hugepage_freelists[MAX_NUMNODES];
+	unsigned int max_huge_pages_node[MAX_NUMNODES];
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfc940d52..317f8fa21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
 static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
+static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void)
 	}
 }
 
+static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
+{
+	unsigned long i;
+	char buf[32];
+
+	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
+		if (hstate_is_gigantic(h)) {
+			struct huge_bootmem_page *m;
+			void *addr;
+
+			addr = memblock_alloc_try_nid_raw(
+					huge_page_size(h), huge_page_size(h),
+					0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+			if (!addr)
+				break;
+			m = addr;
+			BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
+			/*
+			 * Put them into a private list first because mem_map
+			 * is not up yet
+			 */
+			INIT_LIST_HEAD(&m->list);
+			list_add(&m->list, &huge_boot_pages);
+			m->hstate = h;
+		} else {
+			struct page *page;
+
+			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+
+			page = alloc_fresh_huge_page(h, gfp_mask, nid,
+					&node_states[N_MEMORY], NULL);
+			if (!page)
+				break;
+			put_page(page); /* free it into the hugepage allocator */
+		}
+		cond_resched();
+	}
+	if (i == h->max_huge_pages_node[nid])
+		return;
+
+	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
+	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
+		h->max_huge_pages_node[nid], buf, nid, i);
+	h->max_huge_pages_node[nid] = i;
+	h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
+}
+
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
 	nodemask_t *node_alloc_noretry;
+	bool hugetlb_node_set = false;
+
+	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
+	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
+		pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
+		return;
+	}
+
+	/* do node alloc */
+	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
+		if (h->max_huge_pages_node[i] > 0) {
+			hugetlb_hstate_alloc_pages_onenode(h, i);
+			hugetlb_node_set = true;
+		}
+	}
+
+	if (hugetlb_node_set)
+		return;
 
 	if (!hstate_is_gigantic(h)) {
 		/*
@@ -2867,10 +2933,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (hugetlb_cma_size) {
-				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
-				goto free;
-			}
 			if (!alloc_bootmem_huge_page(h))
 				break;
 		} else if (!alloc_pool_huge_page(h,
@@ -2887,7 +2949,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			h->max_huge_pages, buf, i);
 		h->max_huge_pages = i;
 	}
-free:
 	kfree(node_alloc_noretry);
 }
 
@@ -3580,6 +3641,10 @@ static int __init hugetlb_init(void)
 				default_hstate_max_huge_pages;
 		}
 	}
+	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
+		if (default_hugepages_in_node[i] > 0)
+			default_hstate.max_huge_pages_node[i] =
+					default_hugepages_in_node[i];
 
 	hugetlb_cma_check();
 	hugetlb_init_hstates();
@@ -3649,6 +3714,10 @@ static int __init hugepages_setup(char *s)
 {
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
+	unsigned int node = NUMA_NO_NODE;
+	int count;
+	unsigned long tmp;
+	char *p = s;
 
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
@@ -3672,8 +3741,37 @@ static int __init hugepages_setup(char *s)
 		return 0;
 	}
 
-	if (sscanf(s, "%lu", mhp) <= 0)
-		*mhp = 0;
+	while (*p) {
+		count = 0;
+		if (sscanf(p, "%lu%n", &tmp, &count) != 1)
+			goto invalid;
+		/* Parameter is node format */
+		if (p[count] == ':') {
+			node = tmp;
+			p += count + 1;
+			if (node < 0 ||
+				node >= nodes_weight(node_states[N_MEMORY]))
+				goto invalid;
+			/* Parse hugepages */
+			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
+				goto invalid;
+			if (!hugetlb_max_hstate)
+				default_hugepages_in_node[node] = tmp;
+			else
+				parsed_hstate->max_huge_pages_node[node] = tmp;
+			*mhp += tmp;
+			/* Go to parse next node*/
+			if (p[count] == ',')
+				p += count + 1;
+			else
+				break;
+		} else {
+			if (p != s)
+				goto invalid;
+			*mhp = tmp;
+			break;
+		}
+	}
 
 	/*
 	 * Global state is always initialized later in hugetlb_init.
@@ -3686,6 +3784,10 @@ static int __init hugepages_setup(char *s)
 	last_mhp = mhp;
 
 	return 1;
+
+invalid:
+	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+	return 0;
 }
 __setup("hugepages=", hugepages_setup);
 
-- 
2.27.0

