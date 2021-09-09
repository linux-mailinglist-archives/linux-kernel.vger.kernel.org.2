Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7582405962
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbhIIOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbhIIOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:44:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938C9C03547D;
        Thu,  9 Sep 2021 07:17:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f129so1924481pgc.1;
        Thu, 09 Sep 2021 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIfdnfFYe7CXfYMyKUIkrwUaExyxjd6v554ANyt2LoQ=;
        b=c3IljvfTRREUH/FbmtAi+v/46GJDMmJWi56ht3zjJxfKgNP9e5y+uQa6fGy5PK+w3o
         pHXiCXKTp78ORmivKtGmUBuXZmcYMoE7yzqR4CPYYTC+Wkgj0tTWiSL6On/Ja1aoQJ/q
         po1dZhk3itHaSew+Iv3mTjDQ35A2gNq5/uXnA+NPBmVrAMYp8pC716fhz6rjR7oMcoTv
         gyKvmc0lmLIP5HugWGWn6arpISFixqMOU1+J0Vk7ZVpsV/fyWK1PNGFL7tRpq+pKxDZY
         0ZOzDiD5d4jN7pIDQgt0Syq8+vBuRduUHpEPYf68dqNo9+EgK7+A5bK5YyEifFnEZRJ2
         PkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIfdnfFYe7CXfYMyKUIkrwUaExyxjd6v554ANyt2LoQ=;
        b=rMAF4wEDfapttHr9VcuDBcr++eERR3wvm8yvGjpsM/yox3lpfcxWofVzc+XvDDjviR
         +WG1QEaYlXJJ3b7TXWrIRWiJgbpT5f7qwlwZHUkdf4BogpDuQUS7h7EAaJfNySmBuHnY
         M6sz0CQmFa8tPKRxgw8X3i30Y42kn3eyUoQYyO+LGeDuJx1657+2Zdo3jM1SVQNqyYqT
         WK5GcKIopWG4s2iBbh00dtMWDtBysBDz6uo++9KnPnBnQSODrqsxQxSa9cA5WqZJxjmb
         iKx0VYqEVfNbJwwNlGpEttCNyAM6O8O5DVgdgD0GA3SBqtIgQbJP3r4ZN8O2pYGNTDCL
         VUPg==
X-Gm-Message-State: AOAM530O7plDbsGiuJXyGVkjUCdnMpOTfVIvoz99VIYmZbgGnqdVtjv4
        U/nb/fUX4JZ3Io7gvp76UwU=
X-Google-Smtp-Source: ABdhPJxvSy40b++F7HHqqFUe//1pPNUn2vjUjPsH0Sb3Z3Y5h6hlOLBaoHmaS7Zdce6PYlKVCvfegA==
X-Received: by 2002:a63:7112:: with SMTP id m18mr2900138pgc.93.1631197058066;
        Thu, 09 Sep 2021 07:17:38 -0700 (PDT)
Received: from localhost.localdomain (f.a4.5177.ip4.static.sl-reverse.com. [119.81.164.15])
        by smtp.gmail.com with ESMTPSA id e19sm2460957pfi.139.2021.09.09.07.17.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Sep 2021 07:17:37 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, yaozhenguo@jd.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        yaozhenguo <yaozhenguo1@gmail.com>
Subject: [PATCH v4] hugetlbfs: Extend the definition of hugepages parameter to support node allocation
Date:   Thu,  9 Sep 2021 22:16:55 +0800
Message-Id: <20210909141655.87821-1-yaozhenguo1@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can specify the number of hugepages to allocate at boot. But the
hugepages is balanced in all nodes at present. In some scenarios,
we only need hugepages in one node. For example: DPDK needs hugepages
which are in the same node as NIC. if DPDK needs four hugepages of 1G
size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
in kernel cmdline. But, only four hugepages are used. The others should
be free after boot. If the system memory is low(for example: 64G), it will
be an impossible task. So, Extending hugepages parameter to support
specifying hugepages at a specific node.
For example add following parameter:

hugepagesz=1G hugepages=0:1,1:3

It will allocate 1 hugepage in node0 and 3 hugepages in node1.

Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
---
v3 -> v4: changes
    - fix wrong behavior for parameter: hugepages=0:1,1:3 default_hugepagesz=1G
    - make the change of documentation more reasonable
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
 include/linux/hugetlb.h                       |   1 +
 mm/hugetlb.c                                  | 122 +++++++++++++++++-
 4 files changed, 132 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f..a2046b2c5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1588,9 +1588,11 @@
 			the number of pages of hugepagesz to be allocated.
 			If this is the first HugeTLB parameter on the command
 			line, it specifies the number of pages to allocate for
-			the default huge page size.  See also
-			Documentation/admin-guide/mm/hugetlbpage.rst.
-			Format: <integer>
+			the default huge page size. If using node format, the
+			number of pages to allocate per-node can be specified.
+			See also Documentation/admin-guide/mm/hugetlbpage.rst.
+			Format: <integer> or (node format)
+				<node>:<integer>[,<node>:<integer>]
 
 	hugepagesz=
 			[HW] The size of the HugeTLB pages.  This is used in
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8abaeb144..d70828c07 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -128,7 +128,9 @@ hugepages
 	implicitly specifies the number of huge pages of default size to
 	allocate.  If the number of huge pages of default size is implicitly
 	specified, it can not be overwritten by a hugepagesz,hugepages
-	parameter pair for the default size.
+	parameter pair for the default size.  This parameter also has a
+	node format.  The node format specifies the number of huge pages
+	to allocate on specific nodes.
 
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
+	It will allocate 1 2M hugepage on node0 and 2 2M hugepages on node1.
+	If the node number is invalid,  the parameter will be ignored.
+
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
index dfc940d52..c92ab09cf 100644
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
 
@@ -3578,6 +3639,11 @@ static int __init hugetlb_init(void)
 			}
 			default_hstate.max_huge_pages =
 				default_hstate_max_huge_pages;
+
+			for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
+				if (default_hugepages_in_node[i] > 0)
+					default_hstate.max_huge_pages_node[i] =
+						default_hugepages_in_node[i];
 		}
 	}
 
@@ -3649,6 +3715,10 @@ static int __init hugepages_setup(char *s)
 {
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
+	unsigned int node = NUMA_NO_NODE;
+	int count;
+	unsigned long tmp;
+	char *p = s;
 
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
@@ -3672,8 +3742,37 @@ static int __init hugepages_setup(char *s)
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
@@ -3686,6 +3785,10 @@ static int __init hugepages_setup(char *s)
 	last_mhp = mhp;
 
 	return 1;
+
+invalid:
+	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+	return 0;
 }
 __setup("hugepages=", hugepages_setup);
 
@@ -3747,6 +3850,7 @@ __setup("hugepagesz=", hugepagesz_setup);
 static int __init default_hugepagesz_setup(char *s)
 {
 	unsigned long size;
+	int i;
 
 	parsed_valid_hugepagesz = false;
 	if (parsed_default_hugepagesz) {
@@ -3775,6 +3879,10 @@ static int __init default_hugepagesz_setup(char *s)
 	 */
 	if (default_hstate_max_huge_pages) {
 		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
+		for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
+			if (default_hugepages_in_node[i] > 0)
+				default_hstate.max_huge_pages_node[i] =
+					default_hugepages_in_node[i];
 		if (hstate_is_gigantic(&default_hstate))
 			hugetlb_hstate_alloc_pages(&default_hstate);
 		default_hstate_max_huge_pages = 0;
-- 
2.27.0

