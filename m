Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7861D3EE6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhHQGlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbhHQGlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:41:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7F5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t66so22006329qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9/YOSIeOhlXiGxbxVrq1o6Zfy48s4rPip3QIY+v580=;
        b=XFBBCK/t38AoCUCfB2Fvd+yDqoL0mfR6DNvF3qmwIRqceCkaX6I6qKaCq+2O46pT8B
         lzy9VgXB+Y/ni1t11dtuXM4D67cXtaidONwcbdF7SvN6BJGrNjPn4PXiqXfxBP+nPF22
         BoWYPeR0byDsdT/X66hVFLmcGChWT5+QuXPE86JH/LZa4YHBoAoPj8Gg1n6CPUPCGPzV
         tQWR/CyukegM6hHrxPq0y/yzqAm9/UoCFwmpUAE09ucaoiFJu9/2K84pCczl1CgF80xj
         vIbKGn9cdu2/LATxTEARJuYB96n4a/gcfScDRj20S0N7qjG6AppCi7l1uUfm3/Pn7Azs
         BElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9/YOSIeOhlXiGxbxVrq1o6Zfy48s4rPip3QIY+v580=;
        b=GSUq8XSWIY99hdSoC5NglKxcqpEXWuIyk4eaWHbcK+EF6kuVp77N1kI1k04smfE988
         Shq3UObxNqdr0yJmN2IkPmu+JZNk46bWQa4ScaLznoHlKySjwbR23jN2RIHs16mg1ZhB
         d/Iy69nE6RchCPM8u5jsM8uHGkTfxX2nvpHmtw5kTbslT/+dlMvir5tKDNQa4OMmEL9y
         9WYwY/T5Q+pjd/A/hq/ZyGAQDYcPKjgBuY28vgGtrM5hCWoOy0iwhctYqTf9Rr5T/Szl
         PR7lUK9FuT3pN0Rwrae0zJMHP10J/PuP5JfudEmbXvJsrbV4WetbY0dq6KFatEl1qdEL
         zhCw==
X-Gm-Message-State: AOAM533qjiol9aVkMWBTK9JQv/dqbJFeE4FrCSxcFhmYueqrayCC95vr
        V6G+ZvT7PKqIcqB5Tb43fA8=
X-Google-Smtp-Source: ABdhPJySFMLjCSdcxvLGY2norwSqebUNvjb/PvtfXchz9ir+8bkPRBr1FWf1wey1O8ywnKkK9ih7sg==
X-Received: by 2002:a05:620a:12e4:: with SMTP id f4mr2172225qkl.373.1629182433558;
        Mon, 16 Aug 2021 23:40:33 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:33 -0700 (PDT)
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
Subject: [PATCH v6 07/11] powerpc/pseries/iommu: Reorganize iommu_table_setparms*() with new helper
Date:   Tue, 17 Aug 2021 03:39:25 -0300
Message-Id: <20210817063929.38701-8-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817063929.38701-1-leobras.c@gmail.com>
References: <20210817063929.38701-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper _iommu_table_setparms(), and use it in
iommu_table_setparms() and iommu_table_setparms_lpar() to avoid duplicated
code.

Also, setting tbl->it_ops was happening outsite iommu_table_setparms*(),
so move it to the new helper. Since we need the iommu_table_ops to be
declared before used, declare iommu_table_lpar_multi_ops and
iommu_table_pseries_ops to before their respective iommu_table_setparms*().

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 72 ++++++++++++++------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 00392582fe10..a47f59a8f107 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -501,6 +501,24 @@ static int tce_setrange_multi_pSeriesLP_walk(unsigned long start_pfn,
 	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
 }
 
+static void iommu_table_setparms_common(struct iommu_table *tbl, unsigned long busno,
+					unsigned long liobn, unsigned long win_addr,
+					unsigned long window_size, unsigned long page_shift,
+					void *base, struct iommu_table_ops *table_ops)
+{
+	tbl->it_busno = busno;
+	tbl->it_index = liobn;
+	tbl->it_offset = win_addr >> page_shift;
+	tbl->it_size = window_size >> page_shift;
+	tbl->it_page_shift = page_shift;
+	tbl->it_base = (unsigned long)base;
+	tbl->it_blocksize = 16;
+	tbl->it_type = TCE_PCI;
+	tbl->it_ops = table_ops;
+}
+
+struct iommu_table_ops iommu_table_pseries_ops;
+
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
 				 struct iommu_table *tbl)
@@ -509,8 +527,13 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	const unsigned long *basep;
 	const u32 *sizep;
 
-	node = phb->dn;
+	/* Test if we are going over 2GB of DMA space */
+	if (phb->dma_window_base_cur + phb->dma_window_size > SZ_2G) {
+		udbg_printf("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
+		panic("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
+	}
 
+	node = phb->dn;
 	basep = of_get_property(node, "linux,tce-base", NULL);
 	sizep = of_get_property(node, "linux,tce-size", NULL);
 	if (basep == NULL || sizep == NULL) {
@@ -519,33 +542,18 @@ static void iommu_table_setparms(struct pci_controller *phb,
 		return;
 	}
 
-	tbl->it_base = (unsigned long)__va(*basep);
+	iommu_table_setparms_common(tbl, phb->bus->number, 0, phb->dma_window_base_cur,
+				    phb->dma_window_size, IOMMU_PAGE_SHIFT_4K,
+				    __va(*basep), &iommu_table_pseries_ops);
 
 	if (!is_kdump_kernel())
 		memset((void *)tbl->it_base, 0, *sizep);
 
-	tbl->it_busno = phb->bus->number;
-	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
-
-	/* Units of tce entries */
-	tbl->it_offset = phb->dma_window_base_cur >> tbl->it_page_shift;
-
-	/* Test if we are going over 2GB of DMA space */
-	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
-		udbg_printf("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
-		panic("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
-	}
-
 	phb->dma_window_base_cur += phb->dma_window_size;
-
-	/* Set the tce table size - measured in entries */
-	tbl->it_size = phb->dma_window_size >> tbl->it_page_shift;
-
-	tbl->it_index = 0;
-	tbl->it_blocksize = 16;
-	tbl->it_type = TCE_PCI;
 }
 
+struct iommu_table_ops iommu_table_lpar_multi_ops;
+
 /*
  * iommu_table_setparms_lpar
  *
@@ -557,17 +565,13 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct iommu_table_group *table_group,
 				      const __be32 *dma_window)
 {
-	unsigned long offset, size;
+	unsigned long offset, size, liobn;
 
-	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
+	of_parse_dma_window(dn, dma_window, &liobn, &offset, &size);
+
+	iommu_table_setparms_common(tbl, phb->bus->number, liobn, offset, size, IOMMU_PAGE_SHIFT_4K, NULL,
+				    &iommu_table_lpar_multi_ops);
 
-	tbl->it_busno = phb->bus->number;
-	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
-	tbl->it_base   = 0;
-	tbl->it_blocksize  = 16;
-	tbl->it_type = TCE_PCI;
-	tbl->it_offset = offset >> tbl->it_page_shift;
-	tbl->it_size = size >> tbl->it_page_shift;
 
 	table_group->tce32_start = offset;
 	table_group->tce32_size = size;
@@ -647,7 +651,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	tbl = pci->table_group->tables[0];
 
 	iommu_table_setparms(pci->phb, dn, tbl);
-	tbl->it_ops = &iommu_table_pseries_ops;
+
 	if (!iommu_init_table(tbl, pci->phb->node, 0, 0))
 		panic("Failed to initialize iommu table");
 
@@ -730,7 +734,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		tbl = ppci->table_group->tables[0];
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
 				ppci->table_group, dma_window);
-		tbl->it_ops = &iommu_table_lpar_multi_ops;
+
 		if (!iommu_init_table(tbl, ppci->phb->node, 0, 0))
 			panic("Failed to initialize iommu table");
 		iommu_register_group(ppci->table_group,
@@ -760,7 +764,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
 		tbl = PCI_DN(dn)->table_group->tables[0];
 		iommu_table_setparms(phb, dn, tbl);
-		tbl->it_ops = &iommu_table_pseries_ops;
+
 		if (!iommu_init_table(tbl, phb->node, 0, 0))
 			panic("Failed to initialize iommu table");
 
@@ -1461,7 +1465,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		tbl = pci->table_group->tables[0];
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
 				pci->table_group, dma_window);
-		tbl->it_ops = &iommu_table_lpar_multi_ops;
+
 		iommu_init_table(tbl, pci->phb->node, 0, 0);
 		iommu_register_group(pci->table_group,
 				pci_domain_nr(pci->phb->bus), 0);
-- 
2.32.0

