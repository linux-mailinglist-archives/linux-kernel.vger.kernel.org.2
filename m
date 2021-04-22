Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA51367AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhDVHJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhDVHJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:09:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8BC061343
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o21so5001891qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gm2u0MoJ5Bed4BuF1gw4oaCsTmYYKzVCi1JSFgC8mOg=;
        b=QTnT04s5W4pZA8n+oLovKIGr4IzSLP1P60yUHsSAhtXG+2h2ceTBa1HJtdm+Xxc1bZ
         8iP/WjbrxKlyHTMZd/K7f6T+lqQNIouDysjS6onHfc8zcFWKvWqE1b6xwAFgpGw4YhOI
         q9KzFBLVqELEOfyOctTMQ82mlV5BcyElM8K8RPa01phBMClYKAVbdVX+FOeB1NjZ2h0h
         w4nN24TxvcCnsxl9ZMqWmQIPRvHdkMTBns4nCGME2dhh19Y/gVWrrXrGg7gyOZ+sjaVr
         wVn9cwYyztAjDTSUXnUjsHlZ9BaFZf8M93evtwEX5WUuMqxUKYAZbU9z71Tjro9FweDO
         MiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gm2u0MoJ5Bed4BuF1gw4oaCsTmYYKzVCi1JSFgC8mOg=;
        b=fc1+dstKwkkUUj2ZdodZRdYk28zvtvZNFUldkF1b5O3c9W+ZWPmoBP9tMk62AWm6ab
         eOfMyHanhRZFuy6BKPnZF2SHHYhNBlpQZ7AYoYALbvjdKaa0/4X7Ae1N+5EAZdC24j9I
         C6Qaz3SGK5nw4Ca0XJFhOtAhEYfuRsGLNkKo8woXNl8nrLdHqac01qjIzzDTp4KolzsN
         Ad4N0f5x6JTfFAfVXtlpzNXNC58seUZJsg+aZwTADEG5HqGAoe32HYZ5zO3sUeTKqsuK
         paL+IP/w1jM0TC7v9N31PrnqzhcrjmbGT4nnzaMGO8dCCFEPzciY+1k6ivdhY7zDOCpW
         8yCw==
X-Gm-Message-State: AOAM5301wfxDj69fSglIYdo7MPCnJ4lTVmgYf6LfKL3D2oBQF51QhBOy
        c2aLUCCdVx/870rQz/39biA=
X-Google-Smtp-Source: ABdhPJz34J0iVWIoFJNyX22hJA/OheS/gKGl9unUVL1p21/cDi4jtAEhXOUBBf3JogOAbwhyRUZzaQ==
X-Received: by 2002:a05:622a:50a:: with SMTP id l10mr1735245qtx.131.1619075307429;
        Thu, 22 Apr 2021 00:08:27 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:27 -0700 (PDT)
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
Subject: [PATCH v3 06/11] powerpc/pseries/iommu: Add ddw_property_create() and refactor enable_ddw()
Date:   Thu, 22 Apr 2021 04:07:18 -0300
Message-Id: <20210422070721.463912-7-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
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

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 93 ++++++++++++++++----------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 955cf095416c..48c029386d94 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1122,6 +1122,35 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
 			 ret);
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
+		kfree(win64);
+		kfree(win64->name);
+		kfree(win64->value);
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
 /* Return largest page shift based on "IO Page Sizes" output of ibm,query-pe-dma-window. */
 static int iommu_get_page_shift(u32 query_page_size)
 {
@@ -1167,11 +1196,11 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
+	u64 win_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	struct direct_window *window;
 	struct property *win64 = NULL;
-	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
 	bool default_win_removed = false;
 	bool pmem_present;
@@ -1286,65 +1315,54 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
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
+		goto out_del_win;
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
-
-	ret = of_add_property(pdn, win64);
-	if (ret) {
-		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
-			 pdn, ret);
-		goto out_free_window;
+		goto out_del_list;
 	}
 
 	spin_lock(&direct_window_list_lock);
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
+	dev->dev.archdata.dma_offset = win_addr;
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
@@ -1352,6 +1370,9 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64);
 	win64 = NULL;
 
+out_del_win:
+	remove_ddw(pdn, true);
+
 out_failed:
 	if (default_win_removed)
 		reset_dma_window(dev, pdn);
-- 
2.30.2

