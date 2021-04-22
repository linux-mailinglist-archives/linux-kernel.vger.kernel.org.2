Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55213367AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhDVHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhDVHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:09:24 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A07C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id bs7so21032737qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1QVoqFegiTF5Zf+99wGk3Vf6RJJhIaV6QXhI2Vj91o=;
        b=cA3MQ8RBo3wgqcBJeW6bQRTSF58d+lJk4aaAwshfWmPqWQLfJsmvdtgvdWDPqZU+mY
         qBTtovi1O9Nw0iG0t+tVliDkYTd8hAndgSpvbZl2dccjKqoGCmbeWkEj8jUWhXI4uuh9
         pXOJngoY8LmrDUH9SSUdNkhpnna3YgLWZC8jkuX7V4VNrVIOQ4ifbqAK9sx/sMJoRIsZ
         cm1B1NpFueiih8ZIZHPIPWVurpj42GCLSJxvfo5QUEg43AGRE8k05YtBFLsr83otxwDo
         o6DHEPsl84k7/8wVYWtj/IwtzwPUQjhUsoVc84TMQou0xphlNmav8yIAByJJEO0JP5Az
         AYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1QVoqFegiTF5Zf+99wGk3Vf6RJJhIaV6QXhI2Vj91o=;
        b=QtlSYd3oCh/oplKnZG4XP4gmahTvZTxLDTjSTJDJA64NYsA6uS3MtMHNwBgKPxoxsQ
         ecUKaEZMeBeNkuinnHPJ4sDCfzvQVu2z+VwgeWIYId3wW4k/AVgM0siCY0O7a9SRubL0
         hFRg9RV/pmzwlhJfcWwesI7dIiZCHw6zjCLnceXJVCjxw/3Bj1LZKQhst9tDPYFFl1uK
         HtYfdExPMeFpLh8ROSVKDukXL9SDnUsgEXuLywsl85ZHDdsJAOPgm1BaLMRHGsyuJvDP
         SJsAA4wlB+EX2hblFqpC7EZBmF6qxbvvn/JCf3LWpMY00G9NwyfziBa0TSSY9K9GfyOk
         HzYg==
X-Gm-Message-State: AOAM533upIH2N/+ZzsKc3bVcuyS8z6rWTMIWukMbMH5aQkydwV6HPXh6
        mQDZKO+A3XACFkW0Crj10tI=
X-Google-Smtp-Source: ABdhPJxN15GnBdNnp7Ng0hOAMmlLkPJK0zabPqHbF9E81Xfvv2dYEmCf2/KudnDo64YvMMb5KSBc4w==
X-Received: by 2002:a0c:f1cc:: with SMTP id u12mr1843988qvl.20.1619075329352;
        Thu, 22 Apr 2021 00:08:49 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:49 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] powerpc/pseries/iommu: Rename "direct window" to "dma window"
Date:   Thu, 22 Apr 2021 04:07:23 -0300
Message-Id: <20210422070721.463912-12-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
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
 arch/powerpc/platforms/pseries/iommu.c | 93 +++++++++++++-------------
 1 file changed, 48 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 50909cbc73f6..f5d0a6f012da 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -355,7 +355,7 @@ struct dynamic_dma_window_prop {
 	__be32	window_shift;	/* ilog2(tce_window_size) */
 };
 
-struct direct_window {
+struct dma_win {
 	struct device_node *device;
 	const struct dynamic_dma_window_prop *prop;
 	struct list_head list;
@@ -375,11 +375,11 @@ struct ddw_create_response {
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
 
@@ -712,7 +712,10 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
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
@@ -816,11 +819,11 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
 
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
@@ -848,37 +851,37 @@ static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_
 
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
@@ -894,7 +897,7 @@ static void find_existing_ddw_windows_named(const char *name)
 {
 	int len;
 	struct device_node *pdn;
-	struct direct_window *window;
+	struct dma_win *window;
 	const struct dynamic_dma_window_prop *dma64;
 
 	for_each_node_with_property(pdn, name) {
@@ -908,9 +911,9 @@ static void find_existing_ddw_windows_named(const char *name)
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
 
@@ -1209,7 +1212,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	u64 win_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
-	struct direct_window *window;
+	struct dma_win *window;
 	const char *win_name;
 	struct property *win64 = NULL;
 	struct failed_ddw_pdn *fpdn;
@@ -1222,12 +1225,12 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	pmem_present = dn != NULL;
 	of_node_put(dn);
 
-	mutex_lock(&direct_window_init_mutex);
+	mutex_lock(&dma_win_init_mutex);
 
 	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
 		direct_mapping = (len >= max_ram_len);
 
-		mutex_unlock(&direct_window_init_mutex);
+		mutex_unlock(&dma_win_init_mutex);
 		return direct_mapping;
 	}
 
@@ -1303,8 +1306,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	page_shift = iommu_get_page_shift(query.page_size);
 	if (!page_shift) {
-		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
-			  query.page_size);
+		dev_dbg(&dev->dev, "no supported page size in mask %x",
+			query.page_size);
 		goto out_failed;
 	}
 	/* verify the window * number of ptes will map the partition */
@@ -1360,7 +1363,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	ret = of_add_property(pdn, win64);
 	if (ret) {
-		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
+		dev_err(&dev->dev, "unable to add DMA window property for %pOF: %d",
 			pdn, ret);
 		goto out_free_prop;
 	}
@@ -1374,7 +1377,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
-			dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
+			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
 				 dn, ret);
 			goto out_del_list;
 		}
@@ -1412,9 +1415,9 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		set_iommu_table_base(&dev->dev, newtbl);
 	}
 
-	spin_lock(&direct_window_list_lock);
-	list_add(&window->list, &direct_window_list);
-	spin_unlock(&direct_window_list_lock);
+	spin_lock(&dma_win_list_lock);
+	list_add(&window->list, &dma_win_list);
+	spin_unlock(&dma_win_list_lock);
 
 	dev->dev.archdata.dma_offset = win_addr;
 	goto out_unlock;
@@ -1445,7 +1448,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&fpdn->list, &failed_ddw_pdn_list);
 
 out_unlock:
-	mutex_unlock(&direct_window_init_mutex);
+	mutex_unlock(&dma_win_init_mutex);
 
 	/*
 	 * If we have persistent memory and the window size is only as big
@@ -1542,29 +1545,29 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
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
@@ -1585,7 +1588,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 	struct of_reconfig_data *rd = data;
 	struct device_node *np = rd->dn;
 	struct pci_dn *pci = PCI_DN(np);
-	struct direct_window *window;
+	struct dma_win *window;
 
 	switch (action) {
 	case OF_RECONFIG_DETACH_NODE:
@@ -1604,15 +1607,15 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
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
2.30.2

