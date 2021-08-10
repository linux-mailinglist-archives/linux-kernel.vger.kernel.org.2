Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFB3E2E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbhHFP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:57:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42215 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244981AbhHFP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:57:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 218335C00DF;
        Fri,  6 Aug 2021 11:56:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 11:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=TMk8dk6rwqNSh
        lfAzMP/cNOKCJcH9iBVJfOMC1qEbGk=; b=R5ZsY7NhlHkLPoMumiznu+TtLW6AT
        uxUF8jbDaHP71Apu00XQxGv4/9mSzNXc97ZJ/hWcaNvDFOLhx+1+A0UvRLd5mlbn
        K+Vs/v9LUz2QaJgLn/bMlyhAPFAHXazs6dhy4FTo3wMPDb+DE2OMqDdt3buJVLSD
        PVUv0w2+gzbwZw6ElvHseSMshkE+cPDKkTe9s+HnDbB8Wsxt8NCMNZ3b64pL1QCN
        t+C15uij0Gm/Yb68rq/KBgn1idl+1cu3jlRMsB7jtY3ndcyvZhyKma/FfNOVng8l
        OUEEPy23bM3vumpWUD9Up5Z1Pm8Zdi/6/DYeNzUkvzOAA0zd8hZp6DSvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=TMk8dk6rwqNShlfAzMP/cNOKCJcH9iBVJfOMC1qEbGk=; b=qSpq/iIt
        NUWKkN+fTsZSzDIXrvxUeAA32EkqjJI0MyuXmWA0b6a+c2UdiUNp6/iepICmvoND
        ZeocUwprJZBhSwULsj7yRrrZL3zPwqjcFv22HcdIJIidrDA1TP0CFSOGiKvItdOr
        auyp16IX3d6hMEw50HustxTnhfRTTzAv4Aj0GobruwdlPtPRKh8y+CmciZFrgDIx
        XK9FI4qb6sWIC9yVvH8zyug+Z2Scqh74B8ZqQ5W7JJsX6MKFJgEglbuWYnhZjKv2
        rjSyLmeSa2xl5bu60sJ+qc9aZlZ1h19gvjyuDXUqtTvNf2iTyRihDcygsmYwgQEX
        Y6lwsG5e/ICStw==
X-ME-Sender: <xms:xlsNYeIIf8T_nOiifeLSAI5qwaT0lJkXGxX2Y2obWtG_ZfY0McB2XQ>
    <xme:xlsNYWLwX0Ay1wSA9p1Qcss-fLHmyPmqWcgZ5IfpuRK0Qoq6X8Wqt1sLZgGBYK5ss
    PLY7AfJocjpP74cSmY>
X-ME-Received: <xmr:xlsNYeu9iSivy-eudXIINkqsXx6Ba81V5cBPX3Fa3OpZbfwCMv1OITWxu0j-wSyikO9pJDt36bCJ-LEAXjPA8i1xm645ObfYaZ7AefmGtDNLcut5XmC40Hbkhy74eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfefjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:x1sNYTZrziYAZJMOAj2HXluB7JvN8BptHo43np34d9gS9DCWuiloTA>
    <xmx:x1sNYVbuQeDUII1gefCWBF0SEyXoOFLF41SpJp3ufLCWz4Dv0dLqvQ>
    <xmx:x1sNYfBaYoQ_zWYBhaxEULwIYnQclyM-3CL4vjBXOJboEGCDXsvpbw>
    <xmx:x1sNYTP3n8RGR8T-BNqxnSKznqLDXSsRdMHhLv1LxL5spBC2gQxX8g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 11:56:53 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] iommu/dma-iommu: Support iovad->granule > PAGE_SIZE
Date:   Fri,  6 Aug 2021 17:55:22 +0200
Message-Id: <20210806155523.50429-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210806155523.50429-1-sven@svenpeter.dev>
References: <20210806155523.50429-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA IOMMU domains can support hardware where the IOMMU page size is
larger than the CPU page size.
Alignments need to be done with respect to both PAGE_SIZE and
iovad->granule. Additionally, the sg list optimization to use a single
IOVA allocation cannot be used in those cases since the physical
addresses will very likely not be aligned to the larger IOMMU page size.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 87 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6f0df629353f..e072d9030d9f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2000-2004 Russell King
  */
 
+#include <linux/align.h>
 #include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
@@ -51,6 +52,15 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+/* aligns size to CPU and IOMMU page size */
+static inline size_t iommu_page_align(struct device *dev, size_t size)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+
+	return iova_align(&cookie->iovad, PAGE_ALIGN(size));
+}
+
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
 bool iommu_dma_forcedac __read_mostly;
 
@@ -647,6 +657,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 /*
  * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
  * but an IOMMU which supports smaller pages might not map the whole thing.
+ * If the IOMMU page size is larger than the CPU page size, then the size
+ * will be aligned to that granularity and some memory will be left unused.
  */
 static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		size_t size, struct sg_table *sgt, gfp_t gfp, pgprot_t prot,
@@ -736,7 +748,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 
 out_unmap:
 	__iommu_dma_unmap(dev, *dma_handle, size);
-	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	__iommu_dma_free_pages(pages, iommu_page_align(dev, size) >> PAGE_SHIFT);
 	return NULL;
 }
 
@@ -766,7 +778,8 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 	struct dma_sgt_handle *sh = sgt_handle(sgt);
 
 	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
-	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	__iommu_dma_free_pages(sh->pages,
+		iommu_page_align(dev, size) >> PAGE_SHIFT);
 	sg_free_table(&sh->sgt);
 	kfree(sh);
 }
@@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (dev_is_untrusted(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
+	/*
+	 * If the IOMMU pagesize is larger than the CPU pagesize we will
+	 * very likely run into sgs with a physical address that is not aligned
+	 * to an IOMMU page boundary. Fall back to just mapping every entry
+	 * independently with __iommu_dma_map then.
+	 */
+	if (iovad->granule > PAGE_SIZE) {
+		for_each_sg(sg, s, nents, i) {
+			sg_dma_address(s) = __iommu_dma_map(dev, sg_phys(s),
+				s->length, prot, dma_get_mask(dev));
+			if (sg_dma_address(s) == DMA_MAPPING_ERROR)
+				break;
+			sg_dma_len(s) = s->length;
+		}
+
+		if (unlikely(i != nents)) {
+			nents = i;
+			for_each_sg(sg, s, nents, i)
+				__iommu_dma_unmap(dev, sg_dma_address(s), sg_dma_len(s));
+			return 0;
+		}
+
+		return nents;
+	}
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -1068,6 +1106,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	dma_addr_t start, end;
 	struct scatterlist *tmp;
 	int i;
@@ -1080,6 +1121,17 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		return;
 	}
 
+	/*
+	 * If the IOMMU pagesize is larger than the CPU pagesize we mapped
+	 * every entry indepedently with __iommu_dma_map then. Let's do the
+	 * opposite here.
+	 */
+	if (iovad->granule > PAGE_SIZE) {
+		for_each_sg(sg, tmp, nents, i)
+			__iommu_dma_unmap(dev, sg_dma_address(tmp), sg_dma_len(tmp));
+		return;
+	}
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
@@ -1110,7 +1162,7 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 
 static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 {
-	size_t alloc_size = PAGE_ALIGN(size);
+	size_t alloc_size = iommu_page_align(dev, size);
 	int count = alloc_size >> PAGE_SHIFT;
 	struct page *page = NULL, **pages = NULL;
 
@@ -1150,7 +1202,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 		struct page **pagep, gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
-	size_t alloc_size = PAGE_ALIGN(size);
+	size_t alloc_size = iommu_page_align(dev, size);
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	void *cpu_addr;
@@ -1201,8 +1253,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
-		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					       gfp, NULL);
+		page = dma_alloc_from_pool(dev, iommu_page_align(dev, size),
+					       &cpu_addr, gfp, NULL);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
@@ -1253,6 +1305,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
+	size_t aligned_size = iommu_page_align(dev, size);
 	struct page *page;
 	int ret;
 
@@ -1261,7 +1314,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 		if (pages) {
 			return sg_alloc_table_from_pages(sgt, pages,
-					PAGE_ALIGN(size) >> PAGE_SHIFT,
+					aligned_size >> PAGE_SHIFT,
 					0, size, GFP_KERNEL);
 		}
 
@@ -1272,7 +1325,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	if (!ret)
-		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+		sg_set_page(sgt->sgl, page, aligned_size, 0);
 	return ret;
 }
 
@@ -1283,11 +1336,25 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
 }
 
+static struct page *iommu_dma_alloc_aligned_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	size = iommu_page_align(dev, size);
+	return dma_common_alloc_pages(dev, size, dma_handle, dir, gfp);
+}
+
+static void iommu_dma_free_aligned_pages(struct device *dev, size_t size, struct page *page,
+		dma_addr_t dma_handle, enum dma_data_direction dir)
+{
+	size = iommu_page_align(dev, size);
+	return dma_common_free_pages(dev, size, page, dma_handle, dir);
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
-	.alloc_pages		= dma_common_alloc_pages,
-	.free_pages		= dma_common_free_pages,
+	.alloc_pages		= iommu_dma_alloc_aligned_pages,
+	.free_pages		= iommu_dma_free_aligned_pages,
 #ifdef CONFIG_DMA_REMAP
 	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
 	.free_noncontiguous	= iommu_dma_free_noncontiguous,
-- 
2.25.1

