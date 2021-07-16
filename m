Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA99A3CB44E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbhGPIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbhGPIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:31:18 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7DDC061768
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:21 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id c15so4210830qvw.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlH3gc7KgzhKYim4M9r3yCL2JDpbDLw2PQ/04jyz0f4=;
        b=lJnpL9bE4BTOOFL/YNR66VWuXTzMQsvQ5I1o3DmBwSKRWZKaq68XL/5LRyyBBeYg25
         OTQwG17JS9WJFpB899mj03QQ4X1ivnZeadH+RkkzKxciEU/+qw1eX19n4dvtOtjtOIdt
         6IjX2r6+8+lQRfpAfQ8lAg+qxRNzLPiZbDavNqX7x+30SGVoSxACxoEXXrlIitQhN2i2
         3F3gZinuT5Ladb4ukFUU/Pbn1fO9Ki9nbK21hBi0nLGNoO0kKM10USoUq7KJCe2wOhau
         xq5ZaewkCbSku6R3ypadHlCAfe+pc4IRMWSkiRwQ6YrvFWu6GetLkPpVwJ+3nngyWCuo
         1AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlH3gc7KgzhKYim4M9r3yCL2JDpbDLw2PQ/04jyz0f4=;
        b=HnHfOQHl2+mI/si/0WmAlF0LGEGWs7tONLqHgy8yUcZiwoVb3T1B4mviNgdSEwRYNX
         47MP3qwY1HE5aduQX5lK54tlBfLUiTlPVItNQ8wPmH6uz9TI/B/6yMYgRutbgWqMOio5
         CXnugstzNmkigBIhs0FIRa7J5aOD8+HEAafZBOnc9hdPSo98Ey3BEImmBwI+kuFjxf5L
         owjoHy0Hs8RIUjBVDR1MKD5cZGE3olp4l6adtOFtvhhFjibCdw0oqqBSM00RztiC7cS8
         zZFOTlEtIlx/NI0T0dfy1G0beMFNqEAzQ3W0Mp3wiK8Tzch7BOaaY7E38iYvBKjFcZi7
         oyzw==
X-Gm-Message-State: AOAM5326mBqGbJchko7vXGRdUmxY/EpYXrVRbYGwVPFlXPEWK8tWrd5y
        NTcsT5dSgwqq64kE+m29n8Q=
X-Google-Smtp-Source: ABdhPJyfHqAxvLaAOgQAP7m9sofs7HVYgJMXQ/lH9xyzP6/Fiy+CpX/NjL7nDhmg5EYgiqK6kUQVQw==
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr9036907qvu.17.1626424101161;
        Fri, 16 Jul 2021 01:28:21 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:20 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/11] powerpc/pseries/iommu: Make use of DDW for indirect mapping
Date:   Fri, 16 Jul 2021 05:27:55 -0300
Message-Id: <20210716082755.428187-11-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far it's assumed possible to map the guest RAM 1:1 to the bus, which
works with a small number of devices. SRIOV changes it as the user can
configure hundreds VFs and since phyp preallocates TCEs and does not
allow IOMMU pages bigger than 64K, it has to limit the number of TCEs
per a PE to limit waste of physical pages.

As of today, if the assumed direct mapping is not possible, DDW creation
is skipped and the default DMA window "ibm,dma-window" is used instead.

By using DDW, indirect mapping  can get more TCEs than available for the
default DMA window, and also get access to using much larger pagesizes
(16MB as implemented in qemu vs 4k from default DMA window), causing a
significant increase on the maximum amount of memory that can be IOMMU
mapped at the same time.

Indirect mapping will only be used if direct mapping is not a
possibility.

For indirect mapping, it's necessary to re-create the iommu_table with
the new DMA window parameters, so iommu_alloc() can use it.

Removing the default DMA window for using DDW with indirect mapping
is only allowed if there is no current IOMMU memory allocated in
the iommu_table. enable_ddw() is aborted otherwise.

Even though there won't be both direct and indirect mappings at the
same time, we can't reuse the DIRECT64_PROPNAME property name, or else
an older kexec()ed kernel can assume direct mapping, and skip
iommu_alloc(), causing undesirable behavior.
So a new property name DMA64_PROPNAME "linux,dma64-ddr-window-info"
was created to represent a DDW that does not allow direct mapping.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 87 +++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 22d251e15b61..a67e71c49aeb 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -375,6 +375,7 @@ static DEFINE_SPINLOCK(direct_window_list_lock);
 /* protects initializing window twice for same device */
 static DEFINE_MUTEX(direct_window_init_mutex);
 #define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 
 static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 					unsigned long num_pfn, const void *arg)
@@ -925,6 +926,7 @@ static int find_existing_ddw_windows(void)
 		return 0;
 
 	find_existing_ddw_windows_named(DIRECT64_PROPNAME);
+	find_existing_ddw_windows_named(DMA64_PROPNAME);
 
 	return 0;
 }
@@ -1211,14 +1213,17 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct ddw_create_response create;
 	int page_shift;
 	u64 win_addr;
+	const char *win_name;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64;
 	bool ddw_enabled = false;
 	struct failed_ddw_pdn *fpdn;
-	bool default_win_removed = false;
+	bool default_win_removed = false, direct_mapping = false;
 	bool pmem_present;
+	struct pci_dn *pci = PCI_DN(pdn);
+	struct iommu_table *tbl = pci->table_group->tables[0];
 
 	dn = of_find_node_by_type(NULL, "ibm,pmemory");
 	pmem_present = dn != NULL;
@@ -1227,6 +1232,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	mutex_lock(&direct_window_init_mutex);
 
 	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
+		direct_mapping = (len >= max_ram_len);
 		ddw_enabled = true;
 		goto out_unlock;
 	}
@@ -1307,8 +1313,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			  query.page_size);
 		goto out_failed;
 	}
-	/* verify the window * number of ptes will map the partition */
-	/* check largest block * page size > max memory hotplug addr */
+
 	/*
 	 * The "ibm,pmemory" can appear anywhere in the address space.
 	 * Assuming it is still backed by page structs, try MAX_PHYSMEM_BITS
@@ -1324,13 +1329,25 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			dev_info(&dev->dev, "Skipping ibm,pmemory");
 	}
 
+	/* check if the available block * number of ptes will map everything */
 	if (query.largest_available_block < (1ULL << (len - page_shift))) {
 		dev_dbg(&dev->dev,
 			"can't map partition max 0x%llx with %llu %llu-sized pages\n",
 			1ULL << len,
 			query.largest_available_block,
 			1ULL << page_shift);
-		goto out_failed;
+
+		/* DDW + IOMMU on single window may fail if there is any allocation */
+		if (default_win_removed && iommu_table_in_use(tbl)) {
+			dev_dbg(&dev->dev, "current IOMMU table in use, can't be replaced.\n");
+			goto out_failed;
+		}
+
+		len = order_base_2(query.largest_available_block << page_shift);
+		win_name = DMA64_PROPNAME;
+	} else {
+		direct_mapping = true;
+		win_name = DIRECT64_PROPNAME;
 	}
 
 	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
@@ -1341,8 +1358,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		  create.liobn, dn);
 
 	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
-	win64 = ddw_property_create(DIRECT64_PROPNAME, create.liobn, win_addr,
-				    page_shift, len);
+	win64 = ddw_property_create(win_name, create.liobn, win_addr, page_shift, len);
 	if (!win64) {
 		dev_info(&dev->dev,
 			 "couldn't allocate property, property name, or value\n");
@@ -1360,12 +1376,51 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (!window)
 		goto out_del_prop;
 
-	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
-			win64->value, tce_setrange_multi_pSeriesLP_walk);
-	if (ret) {
-		dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
-			 dn, ret);
-		goto out_del_list;
+	if (direct_mapping) {
+		/* DDW maps the whole partition, so enable direct DMA mapping */
+		ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
+					    win64->value, tce_setrange_multi_pSeriesLP_walk);
+		if (ret) {
+			dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
+				 dn, ret);
+			goto out_del_list;
+		}
+	} else {
+		struct iommu_table *newtbl;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(pci->phb->mem_resources); i++) {
+			const unsigned long mask = IORESOURCE_MEM_64 | IORESOURCE_MEM;
+
+			/* Look for MMIO32 */
+			if ((pci->phb->mem_resources[i].flags & mask) == IORESOURCE_MEM)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(pci->phb->mem_resources))
+			goto out_del_list;
+
+		/* New table for using DDW instead of the default DMA window */
+		newtbl = iommu_pseries_alloc_table(pci->phb->node);
+		if (!newtbl) {
+			dev_dbg(&dev->dev, "couldn't create new IOMMU table\n");
+			goto out_del_list;
+		}
+
+		iommu_table_setparms_common(newtbl, pci->phb->bus->number, create.liobn, win_addr,
+					    1UL << len, page_shift, NULL, &iommu_table_lpar_multi_ops);
+		iommu_init_table(newtbl, pci->phb->node, pci->phb->mem_resources[i].start,
+				 pci->phb->mem_resources[i].end);
+
+		pci->table_group->tables[1] = newtbl;
+
+		/* Keep default DMA window stuct if removed */
+		if (default_win_removed) {
+			tbl->it_size = 0;
+			kfree(tbl->it_map);
+		}
+
+		set_iommu_table_base(&dev->dev, newtbl);
 	}
 
 	spin_lock(&direct_window_list_lock);
@@ -1408,10 +1463,10 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * as RAM, then we failed to create a window to cover persistent
 	 * memory and need to set the DMA limit.
 	 */
-	if (pmem_present && ddw_enabled && (len == max_ram_len))
+	if (pmem_present && ddw_enabled && direct_mapping && len == max_ram_len)
 		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + (1ULL << len);
 
-	return ddw_enabled;
+    return ddw_enabled && direct_mapping;
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
@@ -1553,7 +1608,9 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		 * we have to remove the property when releasing
 		 * the device node.
 		 */
-		remove_ddw(np, false, DIRECT64_PROPNAME);
+		if (remove_ddw(np, false, DIRECT64_PROPNAME))
+			remove_ddw(np, false, DMA64_PROPNAME);
+
 		if (pci && pci->table_group)
 			iommu_pseries_free_group(pci->table_group,
 					np->full_name);
-- 
2.32.0

