Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0D3F922B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbhH0B7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 21:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhH0B7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 21:59:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC01C061757;
        Thu, 26 Aug 2021 18:58:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so913953pjc.3;
        Thu, 26 Aug 2021 18:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MzdnpbkSqT/z5NfCkS7hW2RrJMy2W70L1qu2/Vz3A8=;
        b=QHPdYOFKJNatxSknc+wTLlY4UgUj6+Izwh/FyVyKkMNCnYL+ORYxbq1AEBvIN42zUr
         unSEC3Ro1/1ibXOpFpHpP2FolV8i/nsB/aODoF6lL2cT+dYJNRR0ld5os6VJEAnB1FTB
         oC46Xty1+71K9p+4Qs2pXCbiG2eqBYL/R2VJbfOwmThUCmiBhDnv+cuuBkE/OwxO9VkD
         hlZJOA1DQLaEzc9OR9D3jX9snZ2w2n1sdDkwD7B0n1xNEoKxu+hd5xgIlIcsgPQnifAM
         C0eXVyMTP/zaIn1qaRh4hsXePSjX2qkGPxrXuJlVneehQqdDzeMobIExOAzg8p0xQrwf
         TT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MzdnpbkSqT/z5NfCkS7hW2RrJMy2W70L1qu2/Vz3A8=;
        b=cRG9sjvd1iLJthFKWNOWURoRO2SWh0ngz9OnnYArxgLvc88Yg4fQhPAweZNbFmP+ti
         WBzHgT8osjYYDPVBAutuSZLDNvIS4AwV1qslwbBBMZssymyd8AfbVLzCeVvFhw8b+4ZX
         gLxINgTfZs2wmI9TTVsL0WyHyILg2HLMGGGPbOm92Jibv3G4nxUkNhXUYuwpcIAV7A/x
         O1kPs868YJa8bgub5Vjib2DPY6Le1tscq6xEHCRbkPKwAjC2ZcEtpiNz4/o8ldUhQIYo
         k3vcdv2QQx/JYe3QxMst+l6mVlXwc3O2OGhbRI7cks6bF/ORXz68F+Rfa57fOb+p1VTw
         ybuQ==
X-Gm-Message-State: AOAM531gyIx6sBEWUnxLvgsYNiFt9BCuhRipXMr2Mh6N106B5pZKU6UQ
        7FqUcfiivmG2VIWDztOKb7w=
X-Google-Smtp-Source: ABdhPJzJRTvVCRtlpXQmw7RFlja0wdH5+t1UxrgcVOTEmp5/4xE/oBYRiOFCeOz6/fr7QB/A3PL3RA==
X-Received: by 2002:a17:90b:116:: with SMTP id p22mr7840391pjz.67.1630029531447;
        Thu, 26 Aug 2021 18:58:51 -0700 (PDT)
Received: from localhost.localdomain (f.a4.5177.ip4.static.sl-reverse.com. [119.81.164.15])
        by smtp.gmail.com with ESMTPSA id u5sm4055733pjn.26.2021.08.26.18.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 18:58:51 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com
Cc:     corbet@lwn.net, akpm@linux-foundation.org, yaozhenguo@jd.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        yaozhenguo <yaozhenguo1@gmail.com>
Subject: [v2] hugetlbfs: Extend the definition of hugepages parameter to support node allocation
Date:   Fri, 27 Aug 2021 09:58:39 +0800
Message-Id: <20210827015839.90219-1-yaozhenguo1@gmail.com>
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
be an impossible task. So, extend hugepages kernel parameter to specify
node number of hugepages to allocate at boot.
For example add following parameter:

hugepagesz=1G hugepages=0:1,1:3

It will allocate 1 hugepags in node0 and 3 hugepages in node1.

Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
---
v2: 1. add checking for max node to avoid array out of bounds.
    2. fix wrong max_huge_pages after failed allocation.
    3. fix wrong behavior when parsing parameter: hugepages=0:1,2,3:4.
    4. return 0 when parsing invalid parameter in hugepages_setup
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 include/linux/hugetlb.h                       |   1 +
 mm/hugetlb.c                                  | 133 ++++++++++++++++--
 3 files changed, 126 insertions(+), 16 deletions(-)

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
index dfc940d52..9e9d94b2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
 static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
+static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -2842,10 +2843,65 @@ static void __init gather_bootmem_prealloc(void)
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
+			/* Put them into a private list first because mem_map is not up yet */
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
@@ -3580,6 +3636,9 @@ static int __init hugetlb_init(void)
 				default_hstate_max_huge_pages;
 		}
 	}
+	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
+		if (default_hugepages_in_node[i] > 0)
+			default_hstate.max_huge_pages_node[i] = default_hugepages_in_node[i];
 
 	hugetlb_cma_check();
 	hugetlb_init_hstates();
@@ -3649,6 +3708,11 @@ static int __init hugepages_setup(char *s)
 {
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
+	unsigned int node = NUMA_NO_NODE;
+	int ret;
+	int count;
+	unsigned long tmp;
+	char *p = s;
 
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
@@ -3656,25 +3720,68 @@ static int __init hugepages_setup(char *s)
 		return 0;
 	}
 
-	/*
-	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
-	 * yet, so this hugepages= parameter goes to the "default hstate".
-	 * Otherwise, it goes with the previously parsed hugepagesz or
-	 * default_hugepagesz.
-	 */
-	else if (!hugetlb_max_hstate)
-		mhp = &default_hstate_max_huge_pages;
-	else
-		mhp = &parsed_hstate->max_huge_pages;
+	while (*p) {
+		count = 0;
+		ret = sscanf(p, "%lu%n", &tmp, &count);
+		if (ret != 1) {
+			pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+			return 0;
+		}
+		/* Parameter is node format */
+		if (p[count] == ':') {
+			node = tmp;
+			p += count + 1;
+			if (node < 0 || node >= nodes_weight(node_states[N_MEMORY])) {
+				pr_warn("HugeTLB: Invalid hugepages parameter node:%d\n", node);
+				return 0;
+			}
+			if (!hugetlb_max_hstate)
+				mhp = (unsigned long *)
+					&(default_hugepages_in_node[node]);
+			else
+				mhp = (unsigned long *)
+					&(parsed_hstate->max_huge_pages_node[node]);
+			/* Parse hugepages */
+			ret = sscanf(p, "%lu%n", mhp, &count);
+			if (ret != 1) {
+				pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+				return 0;
+			}
+			if (!hugetlb_max_hstate)
+				default_hstate_max_huge_pages += *mhp;
+			else
+				parsed_hstate->max_huge_pages += *mhp;
+			/* Go to parse next node*/
+			if (p[count] == ',')
+				p += count + 1;
+			else
+				break;
+		} else if (p == s) {
+
+			/*
+			 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
+			 * yet, so this hugepages= parameter goes to the "default hstate".
+			 * Otherwise, it goes with the previously parsed hugepagesz or
+			 * default_hugepagesz.
+			 */
+			if (!hugetlb_max_hstate) {
+				default_hstate_max_huge_pages = tmp;
+				mhp = &default_hstate_max_huge_pages;
+			} else {
+				parsed_hstate->max_huge_pages = tmp;
+				mhp = &parsed_hstate->max_huge_pages;
+			}
+			break;
+		}
+		pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
+		return 0;
+	}
 
 	if (mhp == last_mhp) {
 		pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n", s);
 		return 0;
 	}
 
-	if (sscanf(s, "%lu", mhp) <= 0)
-		*mhp = 0;
-
 	/*
 	 * Global state is always initialized later in hugetlb_init.
 	 * But we need to allocate gigantic hstates here early to still
-- 
2.27.0

