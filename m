Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D83F4B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhHWNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhHWNCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:02:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305FC061575;
        Mon, 23 Aug 2021 06:02:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso12096683pjb.1;
        Mon, 23 Aug 2021 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzAazooiiJYmFS22cSG4nL3NYpAxYHxNwYwzLrIUQAY=;
        b=e+KR5PgkrcwTs6bn8OqC9Lvg8zFvcbfgXDhXFOtygO9/DN/8kjBbHGtLlNrKm8zmLN
         oCOPmBn9hmS4t8g2uDW1la/XJ0N0VnHauGAjR1ipW4aSyIk4SikZNLN2eATR/cFiH0hw
         bSQaUYCN9DouXUvk+O+zMF0NS4NDDq9yMogoEdbChNhVYvaIaiMujLxa+ZkhVwsGNr0p
         6g2tmtNFiJFQbYXolv0Dgnfa4Nz09eKZDeex/txykqVVMyYRn7L7Oaa0GUQCaABr/jlr
         oDUsHnbAoeNXOP6JG/+y849KP2Q15mAWBakhgp3dYpKHyOzdYEcftw7DsFz0Wm5zT8Le
         43Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzAazooiiJYmFS22cSG4nL3NYpAxYHxNwYwzLrIUQAY=;
        b=WnFaCY22F4NqtX8Umk1+ctGE5j2gc3RhwG5QGsohlTe0xyOY4vJvGHiU88L/D7eLQh
         uj9OpJRcdJKGIiPNJUNWO5vUqOvDf7yOP5cmXZGXi3eFaILEIr+Dwyc2eBY2wLaTR7fr
         9PGctQDwEbAy80dIGgC0LcHgNoRxTbCo/8yTVrbDoiEPp0OV/9eW/NmEjSiyN24z60dE
         CaNEfxa+nGgKBbCxXwFOBOAQjDoJXW5UjEmKmZYF2b4RGNfnpnfvedrm5e68P+HiSzZE
         EshF3bBxZBJQqdFeuIKKq9JQLpZE9IxISZGcDTe/KD4QTch/PWw5wXlwHAvMhQ035C8n
         uvyQ==
X-Gm-Message-State: AOAM531CjltoXgMbLCnREzPELC1uEPFsSFQGgSAEPsthFdcNZAqUW7Rx
        IrB1VZkJnleSG/Ic2HaD2RI=
X-Google-Smtp-Source: ABdhPJxyAhjyxa7X7HpxLpaN/GLp3/A/VE9grFMkAcbX/vfXa8QilJZXsL1zQOa4RvSECKVQzggh9w==
X-Received: by 2002:a17:90a:b015:: with SMTP id x21mr19551722pjq.26.1629723728579;
        Mon, 23 Aug 2021 06:02:08 -0700 (PDT)
Received: from localhost.localdomain (5e.8a.38a9.ip4.static.sl-reverse.com. [169.56.138.94])
        by smtp.gmail.com with ESMTPSA id t10sm19217079pji.30.2021.08.23.06.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 06:02:08 -0700 (PDT)
From:   yaozhenguo <yaozhenguo1@gmail.com>
To:     mike.kravetz@oracle.com, corbet@lwn.net, akpm@linux-foundation.org
Cc:     yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, yaozhenguo <yaozhenguo1@gmail.com>
Subject: [PATCH V1] hugetlbfs: Extend the definition of hugepages parameter to support node allocation
Date:   Mon, 23 Aug 2021 21:01:54 +0800
Message-Id: <20210823130154.75070-1-yaozhenguo1@gmail.com>
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
 .../admin-guide/kernel-parameters.txt         |   8 +-
 include/linux/hugetlb.h                       |   1 +
 mm/hugetlb.c                                  | 122 ++++++++++++++++--
 3 files changed, 115 insertions(+), 16 deletions(-)

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
index dfc940d52..b898cddcd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
 static unsigned long __initdata default_hstate_max_huge_pages;
 static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
+static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -2842,10 +2843,56 @@ static void __init gather_bootmem_prealloc(void)
 	}
 }
 
+static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
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
@@ -3580,6 +3627,9 @@ static int __init hugetlb_init(void)
 				default_hstate_max_huge_pages;
 		}
 	}
+	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
+		if (default_hugepages_in_node[i] > 0)
+			default_hstate.max_huge_pages_node[i] = default_hugepages_in_node[i];
 
 	hugetlb_cma_check();
 	hugetlb_init_hstates();
@@ -3649,6 +3699,11 @@ static int __init hugepages_setup(char *s)
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
@@ -3656,25 +3711,66 @@ static int __init hugepages_setup(char *s)
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
+			break;
+		}
+		/* Parameter is not node format */
+		if (p[count] != ':') {
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
+		/* Parameter is node format */
+		node = tmp;
+		p += count + 1;
+		if (node < 0) {
+			pr_warn("HugeTLB: Invalid hugepages parameter node:%d\n", node);
+			break;
+		}
+		if (!hugetlb_max_hstate)
+			mhp = (unsigned long *)
+				&(default_hugepages_in_node[node]);
+		else
+			mhp = (unsigned long *)
+				&(parsed_hstate->max_huge_pages_node[node]);
+		/* Parse hugepages */
+		ret = sscanf(p, "%lu%n", mhp, &count);
+		if (ret != 1) {
+			pr_warn("HugeTLB: Invalid parameter %s\n", p);
+			*mhp = 0;
+			break;
+		}
+		if (!hugetlb_max_hstate)
+			default_hstate_max_huge_pages += *mhp;
+		else
+			parsed_hstate->max_huge_pages += *mhp;
+		/* Go to parse next node*/
+		if (p[count] == ',')
+			p += count + 1;
+		else
+			break;
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

