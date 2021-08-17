Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDF3EE6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbhHQGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhHQGlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:41:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E96C0613A4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d9so16296870qty.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2LhOT8wKXwFFKbj1q2vhWVrDkR6KFzmfHIVvRI42P8=;
        b=HCd7BbfbzjyuSQoAZBY0KXbca4qPV0s6Yn9+ktNA336FnJIGq3/rfhl6wo7WDrDMiX
         vLV9LJ2Ab7BNCx2BnEmj90YUuOJ7KhP+qGcIC0Qjh3q3x8joV1k5N2lx/84KjAOFDVYw
         llnhsznIlOY08zI3WvuSwiwWsT7nOpXV8+YXK7cQt7Io2qBkaVkwrNO9/qbN4+h4dfNg
         uvQWfqaXnPPV+YrfzeL9dDI9bvaYFudxQQJqz6BGST85a95uXUho/74BuBDknSWhwcV0
         HqcUe+uva4TdnVSgR/sjvYtI37oqNwXdrPt6ztsQBqWnkyayFCLpc4dbYr+Bl2U+WndR
         N6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2LhOT8wKXwFFKbj1q2vhWVrDkR6KFzmfHIVvRI42P8=;
        b=sdjOMK+ay2zMIosFoRJQZyKiTChxp5YI8cyDAF7XzbvnpXzkoJdEbOG5tIgw1X6AzM
         1bYA/mmquvSE9OAXOTVCAXQvhLGDCgT51AiFhpUH0kTC7+PvoOA2XNmfoy7VJLkpYvPt
         aB1y0CtJ2/3+mc44Vk33psuKWBh3E6C8Y5w96phJIxB76GN1FQXL2KEYM/H9gWx2iUC0
         YoMOn2Ma7gFyf9rJr17i78y7T2LmpXNYeP0Ii83vryVgyHzpRMEtqmrITaNBkTjcdTpw
         n4qn/sWHeSTwZ71zzVRtKY1bBeNdRvHnd5U6flwqDS1WKlP9bSdgrlNNtllH01DeDb9g
         jTuA==
X-Gm-Message-State: AOAM532+5ayy4m7NqBOUcim0dKGZqgDCJe9824ch5o0pjCSbtNEVWZK7
        n2/aZMLrJI/ZvyAopkWVtvM=
X-Google-Smtp-Source: ABdhPJzTPnmO3ONGgzNpn00puAX0SOcGYaRn4jh7/kafHfY84xLNphrzfIIMPtJyZHOWESRjWskZFg==
X-Received: by 2002:ac8:665a:: with SMTP id j26mr1639544qtp.173.1629182427741;
        Mon, 16 Aug 2021 23:40:27 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:27 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/11] powerpc/pseries/iommu: Allow DDW windows starting at 0x00
Date:   Tue, 17 Aug 2021 03:39:23 -0300
Message-Id: <20210817063929.38701-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817063929.38701-1-leobras.c@gmail.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable_ddw() currently returns the address of the DMA window, which is
considered invalid if has the value 0x00.

Also, it only considers valid an address returned from find_existing_ddw
if it's not 0x00.

Changing this behavior makes sense, given the users of enable_ddw() only
need to know if direct mapping is possible. It can also allow a DMA window
starting at 0x00 to be used.

This will be helpful for using a DDW with indirect mapping, as the window
address will be different than 0x00, but it will not map the whole
partition.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 712d1667144a..b34b473bbdc1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -853,25 +853,26 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 			np, ret);
 }
 
-static u64 find_existing_ddw(struct device_node *pdn, int *window_shift)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
 {
 	struct direct_window *window;
 	const struct dynamic_dma_window_prop *direct64;
-	u64 dma_addr = 0;
+	bool found = false;
 
 	spin_lock(&direct_window_list_lock);
 	/* check if we already created a window and dupe that config if so */
 	list_for_each_entry(window, &direct_window_list, list) {
 		if (window->device == pdn) {
 			direct64 = window->prop;
-			dma_addr = be64_to_cpu(direct64->dma_base);
+			*dma_addr = be64_to_cpu(direct64->dma_base);
 			*window_shift = be32_to_cpu(direct64->window_shift);
+			found = true;
 			break;
 		}
 	}
 	spin_unlock(&direct_window_list_lock);
 
-	return dma_addr;
+	return found;
 }
 
 static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
@@ -1161,20 +1162,20 @@ static int iommu_get_page_shift(u32 query_page_size)
  * pdn: the parent pe node with the ibm,dma_window property
  * Future: also check if we can remap the base window for our base page size
  *
- * returns the dma offset for use by the direct mapped DMA code.
+ * returns true if can map all pages (direct mapping), false otherwise..
  */
-static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
+static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 {
 	int len = 0, ret;
 	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
-	u64 dma_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64;
+	bool ddw_enabled = false;
 	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
 	bool default_win_removed = false;
@@ -1186,9 +1187,10 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	mutex_lock(&direct_window_init_mutex);
 
-	dma_addr = find_existing_ddw(pdn, &len);
-	if (dma_addr != 0)
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
+		ddw_enabled = true;
 		goto out_unlock;
+	}
 
 	/*
 	 * If we already went through this for a previous function of
@@ -1342,7 +1344,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
+	ddw_enabled = true;
 	goto out_unlock;
 
 out_free_window:
@@ -1374,10 +1377,10 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * as RAM, then we failed to create a window to cover persistent
 	 * memory and need to set the DMA limit.
 	 */
-	if (pmem_present && dma_addr && (len == max_ram_len))
-		dev->dev.bus_dma_limit = dma_addr + (1ULL << len);
+	if (pmem_present && ddw_enabled && (len == max_ram_len))
+		dev->dev.bus_dma_limit = dev->dev.archdata.dma_offset + (1ULL << len);
 
-	return dma_addr;
+	return ddw_enabled;
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
@@ -1456,11 +1459,8 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 			break;
 	}
 
-	if (pdn && PCI_DN(pdn)) {
-		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
-		if (pdev->dev.archdata.dma_offset)
-			return true;
-	}
+	if (pdn && PCI_DN(pdn))
+		return enable_ddw(pdev, pdn);
 
 	return false;
 }
-- 
2.32.0

