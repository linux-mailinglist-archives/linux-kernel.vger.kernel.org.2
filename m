Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7E367AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhDVHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhDVHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:09:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC78C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id 18so19681075qtz.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fki2MDlr3+q/tA363Zpv6iDH7bhv7YszMbA19cxnvz0=;
        b=VNqg6lhoCBRWgb11ufnzkEd4TgmKB9yMNeMI4hesMJY/krhj7lYZMXKNL4DqZwTUFV
         jS+NN8Fz/tMn6qWnK0XA2OmC6Zbo4M/uHxtlebgxdOYtsuqM+Qno6fQZEdPOniSTyvgM
         UfTc33m6aIuhL9oObqY9uqXr83mUxEU0cMeQWCuVQGNhW9nutqq1xXARbLJcA6R0in6Y
         mw2qZxZZJHrZE7erRNPLfSr3SwkLBzsn3uGTbJngs64eKGe8t2ZWnnCgKCog2immcl1z
         5w2q/e1beQHw3ZiH77Dwy8G1ua5fOhCkoZ34SEWdkB3q93ERs6MxWio0c2rTZCyZLCGR
         WICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fki2MDlr3+q/tA363Zpv6iDH7bhv7YszMbA19cxnvz0=;
        b=Ix5hvq51CC2AGPjvPkrdreOM8WMhju6VQv7sMjpvKpblHZwvZaLwUTd/LR4XsX5HQ9
         mRczhVWTecDtzJwFn/nhjR8bii7nqwaM/VhIIo9cjjWsAoO9u8b3+3FBFx6/8I1DguKd
         oODmwui8NoO0Jynj6lm4GgIGz1ujyOaVAzsRUZZF5VvVQbcH1uuRWaD9gmZ4YxSt3IQU
         w/UZS390kUIroAyBw2bgMyVNNs0r+mzpqvFXaczMFXC4X6aueLNN7xu3q2pfT5w7/Vez
         x5NObmyUeNbFWAAXsDTFichvMGGh2DXf6dp/K6UFTimiULgV6JHR6zfmsEyEF88JPaVp
         /ufg==
X-Gm-Message-State: AOAM53213dMJkYiathQVk0/7xPUpIiV+YSFweJC7KdABjQ+4aTo4uBNb
        AXeu0wRm9G0cGS75RWRZqOA=
X-Google-Smtp-Source: ABdhPJwZXmAmqCBVdwlwDbgwlvzzNxVRHCRWln1yR8V6MzYpJuouoTSNoHkXn7viYn+5WQwfxFLjDg==
X-Received: by 2002:ac8:7151:: with SMTP id h17mr1660399qtp.205.1619075311623;
        Thu, 22 Apr 2021 00:08:31 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:08:31 -0700 (PDT)
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
Subject: [PATCH v3 07/11] powerpc/pseries/iommu: Reorganize iommu_table_setparms*() with new helper
Date:   Thu, 22 Apr 2021 04:07:19 -0300
Message-Id: <20210422070721.463912-8-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
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
declared before used, move iommu_table_lpar_multi_ops and
iommu_table_pseries_ops to before their respective iommu_table_setparms*().

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 100 ++++++++++++-------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 48c029386d94..0147ccaf0be4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -53,6 +53,11 @@ enum {
 	DDW_EXT_QUERY_OUT_SIZE = 2
 };
 
+#ifdef CONFIG_IOMMU_API
+static int tce_exchange_pseries(struct iommu_table *tbl, long index, unsigned long *tce,
+				enum dma_data_direction *direction, bool realmode);
+#endif
+
 static struct iommu_table *iommu_pseries_alloc_table(int node)
 {
 	struct iommu_table *tbl;
@@ -501,6 +506,28 @@ static int tce_setrange_multi_pSeriesLP_walk(unsigned long start_pfn,
 	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
 }
 
+static inline void _iommu_table_setparms(struct iommu_table *tbl, unsigned long busno,
+					 unsigned long liobn, unsigned long win_addr,
+					 unsigned long window_size, unsigned long page_shift,
+					 unsigned long base, struct iommu_table_ops *table_ops)
+{
+	tbl->it_busno = busno;
+	tbl->it_index = liobn;
+	tbl->it_offset = win_addr >> page_shift;
+	tbl->it_size = window_size >> page_shift;
+	tbl->it_page_shift = page_shift;
+	tbl->it_base = base;
+	tbl->it_blocksize = 16;
+	tbl->it_type = TCE_PCI;
+	tbl->it_ops = table_ops;
+}
+
+struct iommu_table_ops iommu_table_pseries_ops = {
+	.set = tce_build_pSeries,
+	.clear = tce_free_pSeries,
+	.get = tce_get_pseries
+};
+
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
 				 struct iommu_table *tbl)
@@ -509,8 +536,13 @@ static void iommu_table_setparms(struct pci_controller *phb,
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
@@ -519,33 +551,25 @@ static void iommu_table_setparms(struct pci_controller *phb,
 		return;
 	}
 
-	tbl->it_base = (unsigned long)__va(*basep);
+	_iommu_table_setparms(tbl, phb->bus->number, 0, phb->dma_window_base_cur,
+			      phb->dma_window_size, IOMMU_PAGE_SHIFT_4K,
+			      (unsigned long)__va(*basep), &iommu_table_pseries_ops);
 
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
 
+struct iommu_table_ops iommu_table_lpar_multi_ops = {
+	.set = tce_buildmulti_pSeriesLP,
+#ifdef CONFIG_IOMMU_API
+	.xchg_no_kill = tce_exchange_pseries,
+#endif
+	.clear = tce_freemulti_pSeriesLP,
+	.get = tce_get_pSeriesLP
+};
+
 /*
  * iommu_table_setparms_lpar
  *
@@ -557,28 +581,17 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct iommu_table_group *table_group,
 				      const __be32 *dma_window)
 {
-	unsigned long offset, size;
+	unsigned long offset, size, liobn;
 
-	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
+	of_parse_dma_window(dn, dma_window, &liobn, &offset, &size);
 
-	tbl->it_busno = phb->bus->number;
-	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
-	tbl->it_base   = 0;
-	tbl->it_blocksize  = 16;
-	tbl->it_type = TCE_PCI;
-	tbl->it_offset = offset >> tbl->it_page_shift;
-	tbl->it_size = size >> tbl->it_page_shift;
+	_iommu_table_setparms(tbl, phb->bus->number, liobn, offset, size, IOMMU_PAGE_SHIFT_4K, 0,
+			      &iommu_table_lpar_multi_ops);
 
 	table_group->tce32_start = offset;
 	table_group->tce32_size = size;
 }
 
-struct iommu_table_ops iommu_table_pseries_ops = {
-	.set = tce_build_pSeries,
-	.clear = tce_free_pSeries,
-	.get = tce_get_pseries
-};
-
 static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 {
 	struct device_node *dn;
@@ -647,7 +660,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	tbl = pci->table_group->tables[0];
 
 	iommu_table_setparms(pci->phb, dn, tbl);
-	tbl->it_ops = &iommu_table_pseries_ops;
 	iommu_init_table(tbl, pci->phb->node, 0, 0);
 
 	/* Divide the rest (1.75GB) among the children */
@@ -664,7 +676,7 @@ static int tce_exchange_pseries(struct iommu_table *tbl, long index, unsigned
 				bool realmode)
 {
 	long rc;
-	unsigned long ioba = (unsigned long) index << tbl->it_page_shift;
+	unsigned long ioba = (unsigned long)index << tbl->it_page_shift;
 	unsigned long flags, oldtce = 0;
 	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
 	unsigned long newtce = *tce | proto_tce;
@@ -686,15 +698,6 @@ static int tce_exchange_pseries(struct iommu_table *tbl, long index, unsigned
 }
 #endif
 
-struct iommu_table_ops iommu_table_lpar_multi_ops = {
-	.set = tce_buildmulti_pSeriesLP,
-#ifdef CONFIG_IOMMU_API
-	.xchg_no_kill = tce_exchange_pseries,
-#endif
-	.clear = tce_freemulti_pSeriesLP,
-	.get = tce_get_pSeriesLP
-};
-
 static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 {
 	struct iommu_table *tbl;
@@ -729,7 +732,6 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		tbl = ppci->table_group->tables[0];
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
 				ppci->table_group, dma_window);
-		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		iommu_init_table(tbl, ppci->phb->node, 0, 0);
 		iommu_register_group(ppci->table_group,
 				pci_domain_nr(bus), 0);
@@ -758,7 +760,6 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
 		tbl = PCI_DN(dn)->table_group->tables[0];
 		iommu_table_setparms(phb, dn, tbl);
-		tbl->it_ops = &iommu_table_pseries_ops;
 		iommu_init_table(tbl, phb->node, 0, 0);
 		set_iommu_table_base(&dev->dev, tbl);
 		return;
@@ -1436,7 +1437,6 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		tbl = pci->table_group->tables[0];
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
 				pci->table_group, dma_window);
-		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		iommu_init_table(tbl, pci->phb->node, 0, 0);
 		iommu_register_group(pci->table_group,
 				pci_domain_nr(pci->phb->bus), 0);
-- 
2.30.2

