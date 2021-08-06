Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9D3E28B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbhHFKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245158AbhHFKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:35:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225BC061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:35:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so7725337pjy.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLydtriWBoLkRvXjTcQUsM9USlU5q/LpeE4a/vpFUgQ=;
        b=XHrrGzQTpFPUpvFEjErspGRyHvO6YaVSkODrfGprbOjPD7uuikbLQXemukpoObdPKO
         T9tn0pT3e3BPdd6Cb+4ONLl4nx7C/kYP9ilDI+drPDuzN3kjUn6WUHaAuLkCm1G2EzXF
         KJ2zOxk8Ioom2z1jPDBmnT+ZZnMYG8SDdFsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLydtriWBoLkRvXjTcQUsM9USlU5q/LpeE4a/vpFUgQ=;
        b=VSKmnWItHUPQJpoLfhhIQ9jhJ02WqsOE1fQp17geuyZygyc0ZUoIlYNsWeC+sh5ApW
         IhYm/PXvXHs1gtJ5F415+5NixvyvaVhcsAX03FDrG8i2gX1Vpto77Y2bJLLoaSYSZRYF
         hODSOHOzx6LJmzmXfR5kOVPr2xHLG4TN9czFHyBd0nNuQ66XdNkTAZ0XRhdvL6vGK0WV
         TGcrqo7vnTo33FOIw+MU3g1bqw7eJMgZVxpcSxtIk1OtErxvqSrPf9HQ2TsJuwI7/PHk
         w21wuETzA4GsXn7FYRLImxuLbYJVBTHpKUsBmCC12DcYEjlERljxdjeQc+rjikCxr2xG
         YlqA==
X-Gm-Message-State: AOAM531E/VW28OTJew8sn9NBghTyZm4h7J6VhoNEHdcOZfrMdzSaXTJP
        PMWd56CJNir4Q9OLKaH2xBh2pA==
X-Google-Smtp-Source: ABdhPJw0G4A/MYovW5PdtVJTCsaBJWP5FkD1nLhR0VjBJdTTsmSju3bvOiLHfLFoGzYG9eM+xzuEgw==
X-Received: by 2002:a17:902:930c:b029:12c:d5c8:61c4 with SMTP id bc12-20020a170902930cb029012cd5c861c4mr8151178plb.73.1628246103395;
        Fri, 06 Aug 2021 03:35:03 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
        by smtp.gmail.com with UTF8SMTPSA id u15sm10236248pfn.91.2021.08.06.03.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:35:03 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 2/9] dma-iommu: expose a few helper functions to module
Date:   Fri,  6 Aug 2021 19:34:16 +0900
Message-Id: <20210806103423.3341285-3-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Expose a few helper functions from dma-iommu to the rest of the module.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
 include/linux/dma-iommu.h |  8 ++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1491b5450246..055ccda5eba1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -412,7 +412,7 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
-static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
+dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -452,7 +452,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	return (dma_addr_t)iova << shift;
 }
 
-static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
+void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		dma_addr_t iova, size_t size, struct page *freelist)
 {
 	struct iova_domain *iovad = &cookie->iovad;
@@ -488,7 +488,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!cookie->fq_domain)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
+	__iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -506,12 +506,12 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	size = iova_align(iovad, size + iova_off);
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+		__iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -617,7 +617,8 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		return NULL;
 
 	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova = __iommu_dma_alloc_iova(domain, size,
+				      dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
@@ -643,7 +644,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 out_free_sg:
 	sg_free_table(sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	__iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -923,7 +924,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+	iova = __iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_restore_sg;
 
@@ -937,7 +938,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
+	__iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
@@ -1226,7 +1227,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_free_page;
 
@@ -1240,7 +1241,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	__iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 758ca4694257..50f676678318 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -42,6 +42,14 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 
 extern bool iommu_dma_forcedac;
 
+struct iommu_dma_cookie;
+
+dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
+				  size_t size, dma_addr_t dma_limit,
+				  struct device *dev);
+void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
+		dma_addr_t iova, size_t size, struct page *freelist);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.32.0.605.g8dce9f2422-goog

