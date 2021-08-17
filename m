Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE383EE6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhHQGlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhHQGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:41:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762ADC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so4062269qkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iarTYm4jWtEjo5T7li2UYUIkmBhr8NtFxAqzv/NmHwc=;
        b=I1PZ7N133LIUVkai6bo47SQq43mh4AkzzXJJ+NI5uJdefGqDuf0gPqMHwbgggChSn/
         fwogjCtAHHndzHF6SFYc6v2bFVJZNyrr143GJ5E4lsrNns7pNT8eh6K2DNFgdSwVVRRq
         7EnsrPbiGSaAvXHwfce/Ft/kF2tI+/Ac5QPlYKIGhQN5oHUdYZzuXAmBOgMisVdSwveE
         hPwyHkR5mCraBkfOYjm/CRN5IC+9yFDCvlIjHU0XGsJH9ZVVCVgb9phZGzYCLQiIGFu2
         hAdQ5d6vq7jFG4Y5de+Liw4k6kCs0eLkfL2Go9Wu03LVhItoZsYkLAteXKWbFwQ1Wjm8
         EQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iarTYm4jWtEjo5T7li2UYUIkmBhr8NtFxAqzv/NmHwc=;
        b=phz/d9r/1JIpMr/pqHYZx0t8rgIJarAYH/OMhB6R0D1nqYOA/QJhmrwZQ2FXIkbjIA
         /tNG8SIWy7fpvGAgDVcRAzLZG7/8eGY5VVuoslszWJYHtTaE9byQo86pmDDu3QOZ/5dU
         IV4jmEkVI3gca0iVwVDskpic4IFYWeLMzJtQVc8bbuO91CDIeqUvTPgKbiDuzkK+OoU9
         CU0pCvjBk3/4QXZ3D0rCz8c1HwkMS2pb3o9qmtrpj8a0tBEIUH0pJ/hjxNKeLt5c276n
         lJny/P4zzg8DUibjmmcFrhN2Ia5upv3OTsFBHXBkdd28aa4Y9c5YWHQE3mk6KLMUxbLY
         fYyQ==
X-Gm-Message-State: AOAM531gG/xXjnNo4exFOuWNvKXYgGNdVjEW6kSrGW5cbzh2IvXimxK4
        qih1OL2j95MD76iDW7SRz8M=
X-Google-Smtp-Source: ABdhPJwARCjfWMJT5q7bpwwA/Ump8KEcW9aEVkbp0TkGt+CrSep5CEw84rwk1901sOSR5Z1EyPSnpg==
X-Received: by 2002:a05:620a:31a7:: with SMTP id bi39mr2304815qkb.2.1629182430629;
        Mon, 16 Aug 2021 23:40:30 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:30 -0700 (PDT)
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
Subject: [PATCH v6 06/11] powerpc/pseries/iommu: Add ddw_property_create() and refactor enable_ddw()
Date:   Tue, 17 Aug 2021 03:39:24 -0300
Message-Id: <20210817063929.38701-7-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817063929.38701-1-leobras.c@gmail.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code used to create a ddw property that was previously scattered in
enable_ddw() is now gathered in ddw_property_create(), which deals with
allocation and filling the property, letting it ready for
of_property_add(), which now occurs in sequence.

This created an opportunity to reorganize the second part of enable_ddw():

Without this patch enable_ddw() does, in order:
kzalloc() property & members, create_ddw(), fill ddwprop inside property,
ddw_list_new_entry(), do tce_setrange_multi_pSeriesLP_walk in all memory,
of_add_property(), and list_add().

With this patch enable_ddw() does, in order:
create_ddw(), ddw_property_create(), of_add_property(),
ddw_list_new_entry(), do tce_setrange_multi_pSeriesLP_walk in all memory,
and list_add().

This change requires of_remove_property() in case anything fails after
of_add_property(), but we get to do tce_setrange_multi_pSeriesLP_walk
in all memory, which looks the most expensive operation, only if
everything else succeeds.

Also, the error path got remove_ddw() replaced by a new helper
__remove_dma_window(), which only removes the new DDW with an rtas-call.
For this, a new helper clean_dma_window() was needed to clean anything
that could left if walk_system_ram_range() fails.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 129 ++++++++++++++++---------
 1 file changed, 84 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index b34b473bbdc1..00392582fe10 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -795,17 +795,10 @@ static int __init disable_ddw_setup(char *str)
 
 early_param("disable_ddw", disable_ddw_setup);
 
-static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
-			      struct property *win)
+static void clean_dma_window(struct device_node *np, struct dynamic_dma_window_prop *dwp)
 {
-	struct dynamic_dma_window_prop *dwp;
-	u64 liobn;
 	int ret;
 
-	dwp = win->value;
-	liobn = (u64)be32_to_cpu(dwp->liobn);
-
-	/* clear the whole window, note the arg is in kernel pages */
 	ret = tce_clearrange_multi_pSeriesLP(0,
 		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
 	if (ret)
@@ -814,18 +807,39 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
 	else
 		pr_debug("%pOF successfully cleared tces in window.\n",
 			 np);
+}
+
+/*
+ * Call only if DMA window is clean.
+ */
+static void __remove_dma_window(struct device_node *np, u32 *ddw_avail, u64 liobn)
+{
+	int ret;
 
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
 
+static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
+			      struct property *win)
+{
+	struct dynamic_dma_window_prop *dwp;
+	u64 liobn;
+
+	dwp = win->value;
+	liobn = (u64)be32_to_cpu(dwp->liobn);
+
+	clean_dma_window(np, dwp);
+	__remove_dma_window(np, ddw_avail, liobn);
+}
+
 static void remove_ddw(struct device_node *np, bool remove_prop)
 {
 	struct property *win;
@@ -1153,6 +1167,35 @@ static int iommu_get_page_shift(u32 query_page_size)
 	return 0;
 }
 
+static struct property *ddw_property_create(const char *propname, u32 liobn, u64 dma_addr,
+					    u32 page_shift, u32 window_shift)
+{
+	struct dynamic_dma_window_prop *ddwprop;
+	struct property *win64;
+
+	win64 = kzalloc(sizeof(*win64), GFP_KERNEL);
+	if (!win64)
+		return NULL;
+
+	win64->name = kstrdup(propname, GFP_KERNEL);
+	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
+	win64->value = ddwprop;
+	win64->length = sizeof(*ddwprop);
+	if (!win64->name || !win64->value) {
+		kfree(win64->name);
+		kfree(win64->value);
+		kfree(win64);
+		return NULL;
+	}
+
+	ddwprop->liobn = cpu_to_be32(liobn);
+	ddwprop->dma_base = cpu_to_be64(dma_addr);
+	ddwprop->tce_shift = cpu_to_be32(page_shift);
+	ddwprop->window_shift = cpu_to_be32(window_shift);
+
+	return win64;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1171,12 +1214,12 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
+	u64 win_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64;
 	bool ddw_enabled = false;
-	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
 	bool default_win_removed = false;
 	bool pmem_present;
@@ -1293,72 +1336,68 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			1ULL << page_shift);
 		goto out_failed;
 	}
-	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
-	if (!win64) {
-		dev_info(&dev->dev,
-			"couldn't allocate property for 64bit dma window\n");
-		goto out_failed;
-	}
-	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
-	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
-	win64->length = sizeof(*ddwprop);
-	if (!win64->name || !win64->value) {
-		dev_info(&dev->dev,
-			"couldn't allocate property name and value\n");
-		goto out_free_prop;
-	}
 
 	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
 	if (ret != 0)
-		goto out_free_prop;
-
-	ddwprop->liobn = cpu_to_be32(create.liobn);
-	ddwprop->dma_base = cpu_to_be64(((u64)create.addr_hi << 32) |
-			create.addr_lo);
-	ddwprop->tce_shift = cpu_to_be32(page_shift);
-	ddwprop->window_shift = cpu_to_be32(len);
+		goto out_failed;
 
 	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
 		  create.liobn, dn);
 
-	window = ddw_list_new_entry(pdn, ddwprop);
+	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
+	win64 = ddw_property_create(DIRECT64_PROPNAME, create.liobn, win_addr,
+				    page_shift, len);
+	if (!win64) {
+		dev_info(&dev->dev,
+			 "couldn't allocate property, property name, or value\n");
+		goto out_remove_win;
+	}
+
+	ret = of_add_property(pdn, win64);
+	if (ret) {
+		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
+			pdn, ret);
+		goto out_free_prop;
+	}
+
+	window = ddw_list_new_entry(pdn, win64->value);
 	if (!window)
-		goto out_clear_window;
+		goto out_del_prop;
 
 	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
 			win64->value, tce_setrange_multi_pSeriesLP_walk);
 	if (ret) {
 		dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
 			 dn, ret);
-		goto out_free_window;
-	}
 
-	ret = of_add_property(pdn, win64);
-	if (ret) {
-		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
-			 pdn, ret);
-		goto out_free_window;
+		/* Make sure to clean DDW if any TCE was set*/
+		clean_dma_window(pdn, win64->value);
+		goto out_del_list;
 	}
 
 	spin_lock(&direct_window_list_lock);
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.archdata.dma_offset = win_addr;
 	ddw_enabled = true;
 	goto out_unlock;
 
-out_free_window:
+out_del_list:
 	kfree(window);
 
-out_clear_window:
-	remove_ddw(pdn, true);
+out_del_prop:
+	of_remove_property(pdn, win64);
 
 out_free_prop:
 	kfree(win64->name);
 	kfree(win64->value);
 	kfree(win64);
 
+out_remove_win:
+	/* DDW is clean, so it's ok to call this directly. */
+	__remove_dma_window(pdn, ddw_avail, create.liobn);
+
 out_failed:
 	if (default_win_removed)
 		reset_dma_window(dev, pdn);
-- 
2.32.0

