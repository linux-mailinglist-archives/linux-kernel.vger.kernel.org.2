Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38E63CB44F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhGPIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbhGPIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:31:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8FC061762
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:24 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i4so4200317qvq.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdAliCpy1s8eE3Cyhe9T+/KxHYRUlECJH7EBqgHl9iM=;
        b=kphNcgbg2BnzYpVNIyaH4ZNP79T5xG0FrmdbK1PopJ7RGk8psCVRmboU9ABDMcZBdP
         rGM/06srRMaeJQxHgQYdEstKLbLOZtsLqNQN3AzQD/zYyE3Bvkq145xo3lJs4JwGziPp
         RteZNK3qpA74hW7sYqt9YCEcs5k1S3ePto9tL4LynpGf1S3BcplRs4hjCXT9N8abQG2K
         oTb0cP8kZzoKw/6xG5cS5lr79+oA0pqpOPHXwdKFAsGXwLV3/XLXKgpoiPol5fRJPXf9
         B5ziCeSSgWmclELrAbAmulT5O1A8mikLrv57KN4JiFYHfCSD5g+2+R+5aIBBpYJgceiN
         vqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdAliCpy1s8eE3Cyhe9T+/KxHYRUlECJH7EBqgHl9iM=;
        b=MVkbjkjqCURIyD9QfS7/srdEvRhb926oVoGYzPkidCmJVmaTtbS6H5gMGK5bXv10r0
         POsYnxY2R3eY4YXK+loPACguy9w60028Cy2+XKa8o9s2/2ch8Qsr2cDgh//WICqne8C0
         KO1mfNIapGHv/mUdtVr33B6JrwE3K07zOmu/iF25dOnBWvDlREQzOFyJdbujenvtteKa
         xaFsUKTTEKfINLrraNLj6g/P9HHzA/4Aqa7Kq0g2umN9cJk/Tg9yM2i7Vb9zmvYa1laC
         Xf+FK/Cy7xbpc791rAfowNWnmzRj8cg474tE3Gxoj+OhV757t4Ti2IxtoXROhlnffFyW
         4Rrw==
X-Gm-Message-State: AOAM533v8pcmVgGoreKAXJc5vj1Mx103DVzUCgHd0JJZkMNF3r1uBpFk
        u2Po2Wrw1D+ZTHOdm21Tb41EEb5wYbE=
X-Google-Smtp-Source: ABdhPJw/3xoPg7m2ecyA7a+Anr934hIhljBPq34wtB2QIV0O+NQBJcs7PpRTiGn4IAqwsmHaNbwBeQ==
X-Received: by 2002:a0c:f213:: with SMTP id h19mr9047690qvk.49.1626424103731;
        Fri, 16 Jul 2021 01:28:23 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:28:23 -0700 (PDT)
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
Subject: [PATCH v5 11/11] powerpc/pseries/iommu: Rename "direct window" to "dma window"
Date:   Fri, 16 Jul 2021 05:27:56 -0300
Message-Id: <20210716082755.428187-12-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716082755.428187-1-leobras.c@gmail.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous change introduced the usage of DDW as a bigger indirect DMA
mapping when the DDW available size does not map the whole partition.

As most of the code that manipulates direct mappings was reused for
indirect mappings, it's necessary to rename all names and debug/info
messages to reflect that it can be used for both kinds of mapping.

This should cause no behavioural change, just adjust naming.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 91 +++++++++++++-------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a67e71c49aeb..52548dfb8b45 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -349,7 +349,7 @@ struct dynamic_dma_window_prop {
 	__be32	window_shift;	/* ilog2(tce_window_size) */
 };
 
-struct direct_window {
+struct dma_win {
 	struct device_node *device;
 	const struct dynamic_dma_window_prop *prop;
 	struct list_head list;
@@ -369,11 +369,11 @@ struct ddw_create_response {
 	u32 addr_lo;
 };
 
-static LIST_HEAD(direct_window_list);
+static LIST_HEAD(dma_win_list);
 /* prevents races between memory on/offline and window creation */
-static DEFINE_SPINLOCK(direct_window_list_lock);
+static DEFINE_SPINLOCK(dma_win_list_lock);
 /* protects initializing window twice for same device */
-static DEFINE_MUTEX(direct_window_init_mutex);
+static DEFINE_MUTEX(dma_win_init_mutex);
 #define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
 #define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 
@@ -713,7 +713,10 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	pr_debug("pci_dma_bus_setup_pSeriesLP: setting up bus %pOF\n",
 		 dn);
 
-	/* Find nearest ibm,dma-window, walking up the device tree */
+	/*
+	 * Find nearest ibm,dma-window (default DMA window), walking up the
+	 * device tree
+	 */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
 		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window != NULL)
@@ -822,11 +825,11 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
 
 	ret = rtas_call(ddw_avail[DDW_REMOVE_PE_DMA_WIN], 1, 1, NULL, liobn);
 	if (ret)
-		pr_warn("%pOF: failed to remove direct window: rtas returned "
+		pr_warn("%pOF: failed to remove DMA window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
 			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 	else
-		pr_debug("%pOF: successfully removed direct window: rtas returned "
+		pr_debug("%pOF: successfully removed DMA window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
 			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
 }
@@ -854,37 +857,37 @@ static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_
 
 	ret = of_remove_property(np, win);
 	if (ret)
-		pr_warn("%pOF: failed to remove direct window property: %d\n",
+		pr_warn("%pOF: failed to remove DMA window property: %d\n",
 			np, ret);
 	return 0;
 }
 
 static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
 {
-	struct direct_window *window;
-	const struct dynamic_dma_window_prop *direct64;
+	struct dma_win *window;
+	const struct dynamic_dma_window_prop *dma64;
 	bool found = false;
 
-	spin_lock(&direct_window_list_lock);
+	spin_lock(&dma_win_list_lock);
 	/* check if we already created a window and dupe that config if so */
-	list_for_each_entry(window, &direct_window_list, list) {
+	list_for_each_entry(window, &dma_win_list, list) {
 		if (window->device == pdn) {
-			direct64 = window->prop;
-			*dma_addr = be64_to_cpu(direct64->dma_base);
-			*window_shift = be32_to_cpu(direct64->window_shift);
+			dma64 = window->prop;
+			*dma_addr = be64_to_cpu(dma64->dma_base);
+			*window_shift = be32_to_cpu(dma64->window_shift);
 			found = true;
 			break;
 		}
 	}
-	spin_unlock(&direct_window_list_lock);
+	spin_unlock(&dma_win_list_lock);
 
 	return found;
 }
 
-static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
-						const struct dynamic_dma_window_prop *dma64)
+static struct dma_win *ddw_list_new_entry(struct device_node *pdn,
+					  const struct dynamic_dma_window_prop *dma64)
 {
-	struct direct_window *window;
+	struct dma_win *window;
 
 	window = kzalloc(sizeof(*window), GFP_KERNEL);
 	if (!window)
@@ -900,7 +903,7 @@ static void find_existing_ddw_windows_named(const char *name)
 {
 	int len;
 	struct device_node *pdn;
-	struct direct_window *window;
+	struct dma_win *window;
 	const struct dynamic_dma_window_prop *dma64;
 
 	for_each_node_with_property(pdn, name) {
@@ -914,9 +917,9 @@ static void find_existing_ddw_windows_named(const char *name)
 		if (!window)
 			break;
 
-		spin_lock(&direct_window_list_lock);
-		list_add(&window->list, &direct_window_list);
-		spin_unlock(&direct_window_list_lock);
+		spin_lock(&dma_win_list_lock);
+		list_add(&window->list, &dma_win_list);
+		spin_unlock(&dma_win_list_lock);
 	}
 }
 
@@ -1216,7 +1219,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	const char *win_name;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
-	struct direct_window *window;
+	struct dma_win *window;
 	struct property *win64;
 	bool ddw_enabled = false;
 	struct failed_ddw_pdn *fpdn;
@@ -1229,7 +1232,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	pmem_present = dn != NULL;
 	of_node_put(dn);
 
-	mutex_lock(&direct_window_init_mutex);
+	mutex_lock(&dma_win_init_mutex);
 
 	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
 		direct_mapping = (len >= max_ram_len);
@@ -1309,8 +1312,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	page_shift = iommu_get_page_shift(query.page_size);
 	if (!page_shift) {
-		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
-			  query.page_size);
+		dev_dbg(&dev->dev, "no supported page size in mask %x",
+			query.page_size);
 		goto out_failed;
 	}
 
@@ -1367,7 +1370,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	ret = of_add_property(pdn, win64);
 	if (ret) {
-		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
+		dev_err(&dev->dev, "unable to add DMA window property for %pOF: %d",
 			pdn, ret);
 		goto out_free_prop;
 	}
@@ -1381,7 +1384,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
-			dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
+			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
 				 dn, ret);
 			goto out_del_list;
 		}
@@ -1423,9 +1426,9 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		set_iommu_table_base(&dev->dev, newtbl);
 	}
 
-	spin_lock(&direct_window_list_lock);
-	list_add(&window->list, &direct_window_list);
-	spin_unlock(&direct_window_list_lock);
+	spin_lock(&dma_win_list_lock);
+	list_add(&window->list, &dma_win_list);
+	spin_unlock(&dma_win_list_lock);
 
 	dev->dev.archdata.dma_offset = win_addr;
 	ddw_enabled = true;
@@ -1456,7 +1459,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&fpdn->list, &failed_ddw_pdn_list);
 
 out_unlock:
-	mutex_unlock(&direct_window_init_mutex);
+	mutex_unlock(&dma_win_init_mutex);
 
 	/*
 	 * If we have persistent memory and the window size is only as big
@@ -1554,29 +1557,29 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 		void *data)
 {
-	struct direct_window *window;
+	struct dma_win *window;
 	struct memory_notify *arg = data;
 	int ret = 0;
 
 	switch (action) {
 	case MEM_GOING_ONLINE:
-		spin_lock(&direct_window_list_lock);
-		list_for_each_entry(window, &direct_window_list, list) {
+		spin_lock(&dma_win_list_lock);
+		list_for_each_entry(window, &dma_win_list, list) {
 			ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
 					arg->nr_pages, window->prop);
 			/* XXX log error */
 		}
-		spin_unlock(&direct_window_list_lock);
+		spin_unlock(&dma_win_list_lock);
 		break;
 	case MEM_CANCEL_ONLINE:
 	case MEM_OFFLINE:
-		spin_lock(&direct_window_list_lock);
-		list_for_each_entry(window, &direct_window_list, list) {
+		spin_lock(&dma_win_list_lock);
+		list_for_each_entry(window, &dma_win_list, list) {
 			ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
 					arg->nr_pages, window->prop);
 			/* XXX log error */
 		}
-		spin_unlock(&direct_window_list_lock);
+		spin_unlock(&dma_win_list_lock);
 		break;
 	default:
 		break;
@@ -1597,7 +1600,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 	struct of_reconfig_data *rd = data;
 	struct device_node *np = rd->dn;
 	struct pci_dn *pci = PCI_DN(np);
-	struct direct_window *window;
+	struct dma_win *window;
 
 	switch (action) {
 	case OF_RECONFIG_DETACH_NODE:
@@ -1615,15 +1618,15 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 			iommu_pseries_free_group(pci->table_group,
 					np->full_name);
 
-		spin_lock(&direct_window_list_lock);
-		list_for_each_entry(window, &direct_window_list, list) {
+		spin_lock(&dma_win_list_lock);
+		list_for_each_entry(window, &dma_win_list, list) {
 			if (window->device == np) {
 				list_del(&window->list);
 				kfree(window);
 				break;
 			}
 		}
-		spin_unlock(&direct_window_list_lock);
+		spin_unlock(&dma_win_list_lock);
 		break;
 	default:
 		err = NOTIFY_DONE;
-- 
2.32.0

