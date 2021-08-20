Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE3E3F251B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhHTDGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhHTDGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:06:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895EC061575;
        Thu, 19 Aug 2021 20:05:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y190so7381296pfg.7;
        Thu, 19 Aug 2021 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKa5fNGiQdpiDE73Y/wXWALNQvnhbKcn95gVeAZ0DeM=;
        b=Q0IxkP23p97cLE/qQYxan3kPansBEd5wlkmnsgdJZzPsn+A9+1OAlK6PkU/n+5ww2p
         5kpv4qXTluk3rQdGc4sQvQjiIlrRBxdJvj8aYGVHfoP1uVxIqnlWOE9LhJFKk/qqpAvq
         M3MXtlz3Y9RPM3bvwzno+LDeHm0Auup8DCHpRlpiUnqpBAMtbFbUIhSmkisqWpmhlk1/
         eEXrUBn9PnE3D4Rt31pVW9jBr87y2m5r9zBFp80BUVuwUwontidSCs1uNkYkbWJvsQC3
         /AjbhyOIyBFpqdWw4+mfe5/Hr26Sd+WjUQRJeeAQw8boNmKkrotuIgOY5RmCzhzHIcRX
         j17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKa5fNGiQdpiDE73Y/wXWALNQvnhbKcn95gVeAZ0DeM=;
        b=VWsj55IQ99KphbarGu14uPW7pbu5zyGpAiMvG+yw09VIJ21EpLKrA1J5Sx99FY0YgA
         oA92ryO0A9FOac7o2seZTS12CJWHzsU7WJ0foDSvV62x/ow17WNUKyjrxZfwLQx9ZMCg
         4lW6KRgfA2AbLTSY8kf5XmwE0ebSqbpo23Li57z586rQt25kiZ+lsvUZyWMFg1Pb+Wqu
         dGETuxUujdUNfpZFKJWoE/i5zyVTJOiKZs/j/VB9vuGHlzjEXH4qvdDZkGmf/O26F6py
         y7sasafxKYtJKc/7eKvi4Qj1Dh3o0YEko1UkDCkCLf5VWWr1Ig5fm+HMQ8TQVaaSB+dY
         Oigw==
X-Gm-Message-State: AOAM531vpxmO6uD88ESeQaFPn9ZFQlFXFw1oAXw9WjMRC4OLa/lDuRhO
        OuHIeoUvlzoCAM+xFLt56ZvOI+9bmDPKzUDWzv8=
X-Google-Smtp-Source: ABdhPJzDuiS+dMnR0RKVQpDr/5SRcHMRyxfMY+1gTr3Z0wrASBq+OVzESAQe0qWvZY6mYLGmzwRwJg==
X-Received: by 2002:aa7:8685:0:b0:3e1:76d8:922e with SMTP id d5-20020aa78685000000b003e176d8922emr17348400pfo.45.1629428755284;
        Thu, 19 Aug 2021 20:05:55 -0700 (PDT)
Received: from localhost.localdomain ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id d198sm5002861pfd.101.2021.08.19.20.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 20:05:55 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com, corbet@lwn.net, akpm@linux-foundation.org
Cc:     yaozhenguo@jd.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        yaozhenguo <yaozhenguo1@gmail.com>
Subject: [PATCH] hugetlbfs: add hugepages_node kernel parameter
Date:   Fri, 20 Aug 2021 11:05:36 +0800
Message-Id: <20210820030536.25737-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can specify the number of hugepages to allocate at boot. But the
hugepages is balanced in all nodes at present. In some scenarios,
we only need hugepags in one node. For example: DPDK needs hugepages
which is in the same node as NIC. if DPDK needs four hugepags of 1G
size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
in kernel cmdline. But, only four hugepages is used. The others should
be free after boot.If the system memory is low(for example: 64G), it will
be an impossible task. So, add hugepages_node kernel parameter to specify
node number of hugepages to allocate at boot.
For example add following parameter:

hugepagesz=1G hugepages_node=1 hugepages=4

It will allocate 4 hugepags in node1 at boot.

Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 include/linux/hugetlb.h                       |   1 +
 mm/hugetlb.c                                  | 109 +++++++++++++++++-
 3 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f..1f85f2b3d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1583,6 +1583,12 @@
 			hugepages using the CMA allocator. If enabled, the
 			boot-time allocation of gigantic hugepages is skipped.
 
+	hugepages_node=	[HW] Node number of hugepages to allocate at boot.
+			This is used in conjunction with  hugepages (below),
+			The pair hugepages_node=X hugepages=Y can be specified
+			for number of hugepages in numa node X.
+			Format: <integer>
+
 	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
 			If this follows hugepagesz (below), it specifies
 			the number of pages of hugepagesz to be allocated.
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
index dfc940d52..1f50f866c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -66,6 +66,8 @@ static struct hstate * __initdata parsed_hstate;
 static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
+static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
+static int parsed_huge_pages_node __initdata = NUMA_NO_NODE;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -2842,10 +2844,68 @@ static void __init gather_bootmem_prealloc(void)
 	}
 }
 
-static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
+static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid, bool *gns)
+{
+	unsigned long i;
+
+	for (i = 0; i < h->max_huge_pages_node[nid]; i++) {
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
+			/* Put them into a private list first because mem_map is not up yet */
+			INIT_LIST_HEAD(&m->list);
+			list_add(&m->list, &huge_boot_pages);
+			m->hstate = h;
+			*gns = true;
+		} else {
+			struct page *page;
+
+			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+
+			page = alloc_fresh_huge_page(h, gfp_mask, nid,
+					&node_states[N_MEMORY], NULL);
+			if (page)
+				put_page(page); /* free it into the hugepage allocator */
+
+		}
+	}
+	if (hstate_is_gigantic(h)) {
+		h->max_huge_pages_node[nid] = 0;
+	}
+}
+
+static void __init hugetlb_hstate_alloc_pages(struct hstate *h, int nid)
 {
 	unsigned long i;
 	nodemask_t *node_alloc_noretry;
+	bool hugetlb_node_set = false;
+	bool gigantic_node_set = false;
+
+	/* do node alloc */
+	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
+		if (h->max_huge_pages_node[i] > 0)
+			hugetlb_hstate_alloc_pages_onenode(h, i, &gigantic_node_set);
+		/* use gigantic_node_set to make a distinction
+		 * between node set and whole set in gigantic hstate
+		 */
+		if (gigantic_node_set || h->nr_huge_pages_node[i] > 0)
+			hugetlb_node_set = true;
+	}
+
+	/* nid != NUMA_NO_NODE  prevent more pages are alloced in gigantic hstate
+	 * for exampe:
+	 *     hugepagesz=1G hugepages_node=0 hugepages=4 hugepages_node=1 hugepages=0
+	 */
+	if (hugetlb_node_set || nid != NUMA_NO_NODE)
+		return;
 
 	if (!hstate_is_gigantic(h)) {
 		/*
@@ -2901,7 +2961,7 @@ static void __init hugetlb_init_hstates(void)
 
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
-			hugetlb_hstate_alloc_pages(h);
+			hugetlb_hstate_alloc_pages(h, NUMA_NO_NODE);
 	}
 	VM_BUG_ON(minimum_order == UINT_MAX);
 }
@@ -3580,6 +3640,9 @@ static int __init hugetlb_init(void)
 				default_hstate_max_huge_pages;
 		}
 	}
+	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
+		if (default_hugepages_in_node[i] > 0)
+			default_hstate.max_huge_pages_node[i] = default_hugepages_in_node[i];
 
 	hugetlb_cma_check();
 	hugetlb_init_hstates();
@@ -3663,9 +3726,16 @@ static int __init hugepages_setup(char *s)
 	 * default_hugepagesz.
 	 */
 	else if (!hugetlb_max_hstate)
-		mhp = &default_hstate_max_huge_pages;
+		if (parsed_huge_pages_node == NUMA_NO_NODE)
+			mhp = &default_hstate_max_huge_pages;
+		else
+			mhp = (unsigned long *)&(default_hugepages_in_node[parsed_huge_pages_node]);
 	else
-		mhp = &parsed_hstate->max_huge_pages;
+		if (parsed_huge_pages_node == NUMA_NO_NODE)
+			mhp = &parsed_hstate->max_huge_pages;
+		else
+			mhp = (unsigned long *)
+				&(parsed_hstate->max_huge_pages_node[parsed_huge_pages_node]);
 
 	if (mhp == last_mhp) {
 		pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n", s);
@@ -3675,20 +3745,47 @@ static int __init hugepages_setup(char *s)
 	if (sscanf(s, "%lu", mhp) <= 0)
 		*mhp = 0;
 
+	if (parsed_huge_pages_node != NUMA_NO_NODE) {
+		if (!hugetlb_max_hstate)
+			default_hstate_max_huge_pages += *mhp;
+		else
+			parsed_hstate->max_huge_pages += *mhp;
+	}
 	/*
 	 * Global state is always initialized later in hugetlb_init.
 	 * But we need to allocate gigantic hstates here early to still
 	 * use the bootmem allocator.
 	 */
 	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
-		hugetlb_hstate_alloc_pages(parsed_hstate);
+		hugetlb_hstate_alloc_pages(parsed_hstate, parsed_huge_pages_node);
 
+	parsed_huge_pages_node = NUMA_NO_NODE;
 	last_mhp = mhp;
 
 	return 1;
 }
 __setup("hugepages=", hugepages_setup);
 
+static int __init hugetlb_node_setup(char *s)
+{
+	int ret;
+
+	if (!parsed_valid_hugepagesz) {
+		pr_warn("hugepages_node=%s preceded by an unsupported hugepagesz, ignoring\n", s);
+		parsed_valid_hugepagesz = true;
+		return 1;
+	}
+
+	ret = kstrtoint(s, 0, &parsed_huge_pages_node);
+	if (ret < 0 || parsed_huge_pages_node < 0) {
+		pr_warn("hugepages_node = %d is invalid\n", parsed_huge_pages_node);
+		parsed_huge_pages_node = NUMA_NO_NODE;
+	}
+
+	return 1;
+}
+__setup("hugepages_node=", hugetlb_node_setup);
+
 /*
  * hugepagesz command line processing
  * A specific huge page size can only be specified once with hugepagesz.
@@ -3776,7 +3873,7 @@ static int __init default_hugepagesz_setup(char *s)
 	if (default_hstate_max_huge_pages) {
 		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
 		if (hstate_is_gigantic(&default_hstate))
-			hugetlb_hstate_alloc_pages(&default_hstate);
+			hugetlb_hstate_alloc_pages(&default_hstate, NUMA_NO_NODE);
 		default_hstate_max_huge_pages = 0;
 	}
 
-- 
2.27.0

