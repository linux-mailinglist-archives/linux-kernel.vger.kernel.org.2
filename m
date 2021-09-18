Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832FE410614
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhIRLeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbhIRLeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:34:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCEEC061574;
        Sat, 18 Sep 2021 04:32:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso11852296pjh.5;
        Sat, 18 Sep 2021 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9D5rmbeIblNmXzdIi6awS6UUNKRPWH71RTw2nqD8F0=;
        b=dGhYNvzWvrTDyFU9Wm4W4mVeStvJ3kkGBHp+IpjRZCb2NEDkVbONjNlz8JySASNPQh
         VMIkOkHfebOfI4pghnsbuSpa1Y7V9U0uTHOKGI/3SUSWu4GeTm4PsWC/LWV7WWfr0HP5
         /4pIrt8R8BpQ3sT9+fmm97gVR/Qy5CpcubRtmxg++WXoi0O/I1xtAZdaydNrNfgCxwHS
         32hOIsgH4mwY4AsNUyAHFJ4oJ74Fg0CD3Rv53VlstKQN4nAp4nED2kcKFNnRn4jQJQuE
         RslisvHgx+CGi6ePCYS46iupDVOtrQD9nzz5ROMc/uQWsWKa8JBgKPzmBzdnhB5Sh51l
         BZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9D5rmbeIblNmXzdIi6awS6UUNKRPWH71RTw2nqD8F0=;
        b=OUrLUjdRSXEMYBnRerF0OWfsnviv1fvKMQqld0TcrZZA6AYAXYuqSlXNAA/mMsdYVB
         hoKlxOzqUWepuxlbPXcDfnvg5Ie5LkFFMkyo7UhjDsgDoLpT7zwzQDMIDMIP8jX8ary5
         m+Otxw7rPN7uVahE0WD33qzgl01JsVjFM/tzTg7gYi27YRiTSaqDhQzv+UUz9wtTemzu
         k6rWjiSSbju4zayNS4iSF5tXeMiFLmSFLpkXC70yQbxc6bMJ2DaW/FHC/MB7foNrcxae
         VtdczjsHsxtfuSY4oLc+fwEy+ksD0RmdwaobbKbhUcIrNvGjo8TKZlLpCaYqU3XZ6+5x
         mrCg==
X-Gm-Message-State: AOAM533tVnAXkKXnLyA4dai3HV4u9BwavWa5Ma5G6vRlMp4q7ZmuIbYw
        FRd3UzMb+g93DVjRMfG4LNPwtAcO5y9Hz0bu
X-Google-Smtp-Source: ABdhPJzMmL7EuCR8lIXnKVg4EYRoW0lXxDD4fCP2AroXOsFh4YI0IEl3EBj6AEOOwg8Sw6utXMJDzA==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id 12mr519541pjl.89.1631964757024;
        Sat, 18 Sep 2021 04:32:37 -0700 (PDT)
Received: from localhost.localdomain ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id x21sm5824pfa.186.2021.09.18.04.32.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 04:32:36 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, rppt@kernel.org, akpm@linux-foundation.org,
        yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, yaozhenguo <yaozhenguo1@gmail.com>
Subject: [PATCH v5] hugetlbfs: Extend the definition of hugepages parameter to support node allocation
Date:   Sat, 18 Sep 2021 19:32:01 +0800
Message-Id: <20210918113201.4133-1-yaozhenguo1@gmail.com>
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
v4->v5 changes:
	- remove BUG_ON in __alloc_bootmem_huge_page.
	- add nid parameter in __alloc_bootmem_huge_page to support
	  called in both specific node alloc and normal alloc.
	- do normal alloc if architecture can't support node specific alloc.
	- return -1 in powerpc version of alloc_bootmem_huge_page when
	  nid is not NUMA_NO_NODE. 
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
 arch/powerpc/mm/hugetlbpage.c                 |   8 +-
 include/linux/hugetlb.h                       |   5 +-
 mm/hugetlb.c                                  | 155 ++++++++++++++++--
 5 files changed, 166 insertions(+), 22 deletions(-)

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
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9a75ba078..4a9cea714 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -19,6 +19,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
+#include <linux/numa.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/setup.h>
@@ -232,14 +233,17 @@ static int __init pseries_alloc_bootmem_huge_page(struct hstate *hstate)
 #endif
 
 
-int __init alloc_bootmem_huge_page(struct hstate *h)
+int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 
 #ifdef CONFIG_PPC_BOOK3S_64
+	/* Don't support node specific alloc */
+	if (nid != NUMA_NO_NODE)
+		return -1;
 	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
 		return pseries_alloc_bootmem_huge_page(h);
 #endif
-	return __alloc_bootmem_huge_page(h);
+	return __alloc_bootmem_huge_page(h, nid);
 }
 
 #ifndef CONFIG_PPC_BOOK3S_64
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a387..a9bdbc870 100644
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
@@ -637,8 +638,8 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct page *page);
 
 /* arch callback */
-int __init __alloc_bootmem_huge_page(struct hstate *h);
-int __init alloc_bootmem_huge_page(struct hstate *h);
+int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
+int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
 
 void __init hugetlb_add_hstate(unsigned order);
 bool __init arch_hugetlb_valid_size(unsigned long size);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfc940d52..f7aaca6ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
 static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
+static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -2774,17 +2775,30 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	vma_end_reservation(h, vma, addr);
 	return ERR_PTR(-ENOSPC);
 }
-
-int alloc_bootmem_huge_page(struct hstate *h)
+/*
+ * Architecture version must provide there own node specific hugepage
+ * allocation code. If not, please return -1 when nid is not NUMA_NO_NODE.
+ */
+int alloc_bootmem_huge_page(struct hstate *h, int nid)
 	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
-int __alloc_bootmem_huge_page(struct hstate *h)
+int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
 	struct huge_bootmem_page *m;
 	int nr_nodes, node;
+	void *addr = NULL;
 
+	/* do node specific alloc */
+	if (nid != NUMA_NO_NODE && nid < nodes_weight(node_states[N_MEMORY])) {
+		addr = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
+				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+		if (addr) {
+			m = addr;
+			goto found;
+		} else {
+			return 0;
+		}
+	}
 	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
-		void *addr;
-
 		addr = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
 				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
@@ -2801,7 +2815,6 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 	return 0;
 
 found:
-	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
 	/* Put them into a private list first because mem_map is not up yet */
 	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
@@ -2841,11 +2854,83 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 }
+/*
+ * do node specific hugepage allocation
+ * return  0: allocation is failed
+ *	   1: allocation is successful
+ *	   -1: alloc_bootmem_huge_page can't support node specific allocation
+ */
+static int __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
+{
+	unsigned long i;
+	char buf[32];
+	int ret = 1;
+
+	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
+		if (hstate_is_gigantic(h)) {
+			ret = alloc_bootmem_huge_page(h, nid);
+			if (ret == 0 || ret == -1)
+				break;
+		} else {
+			struct page *page;
+			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+
+			page = alloc_fresh_huge_page(h, gfp_mask, nid,
+					&node_states[N_MEMORY], NULL);
+			if (!page) {
+				ret = 0;
+				break;
+			}
+			put_page(page); /* free it into the hugepage allocator */
+		}
+		cond_resched();
+	}
+	if (i == h->max_huge_pages_node[nid])
+		return ret;
+
+	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
+	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
+		h->max_huge_pages_node[nid], buf, nid, i);
+	/*
+	 * we need h->max_huge_pages to do normal alloc,
+	 * when alloc_bootm_huge_page can't support node specific allocation.
+	 */
+	if (ret != -1)
+		h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
+	h->max_huge_pages_node[nid] = i;
+	return ret;
+}
 
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
+			/*
+			 * if hugetlb_hstate_alloc_pages_onenode return -1
+			 * architecture version alloc_bootmem_huge_page
+			 * can't support node specific alloc for gigantic
+			 * hugepage, so goto normal alloc.
+			 */
+			if (hugetlb_hstate_alloc_pages_onenode(h, i) == -1)
+				pr_warn_once("HugeTLB: architecture can't support node specific alloc, skip!\n");
+			else
+				hugetlb_node_set = true;
+		}
+	}
+
+	if (hugetlb_node_set)
+		return;
 
 	if (!hstate_is_gigantic(h)) {
 		/*
@@ -2867,11 +2952,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (hugetlb_cma_size) {
-				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
-				goto free;
-			}
-			if (!alloc_bootmem_huge_page(h))
+			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
 		} else if (!alloc_pool_huge_page(h,
 					 &node_states[N_MEMORY],
@@ -2887,7 +2968,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			h->max_huge_pages, buf, i);
 		h->max_huge_pages = i;
 	}
-free:
 	kfree(node_alloc_noretry);
 }
 
@@ -3578,6 +3658,11 @@ static int __init hugetlb_init(void)
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
 
@@ -3649,6 +3734,10 @@ static int __init hugepages_setup(char *s)
 {
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
+	int node = NUMA_NO_NODE;
+	int count;
+	unsigned long tmp;
+	char *p = s;
 
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
@@ -3672,8 +3761,37 @@ static int __init hugepages_setup(char *s)
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
@@ -3686,6 +3804,10 @@ static int __init hugepages_setup(char *s)
 	last_mhp = mhp;
 
 	return 1;
+
+invalid:
+	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+	return 0;
 }
 __setup("hugepages=", hugepages_setup);
 
@@ -3747,6 +3869,7 @@ __setup("hugepagesz=", hugepagesz_setup);
 static int __init default_hugepagesz_setup(char *s)
 {
 	unsigned long size;
+	int i;
 
 	parsed_valid_hugepagesz = false;
 	if (parsed_default_hugepagesz) {
@@ -3775,6 +3898,10 @@ static int __init default_hugepagesz_setup(char *s)
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

