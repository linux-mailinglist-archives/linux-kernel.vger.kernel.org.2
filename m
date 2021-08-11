Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D6E3E8823
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhHKCow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhHKCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BDC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so7350452pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uK/FnVBscvb9gt2KwYk+sXYzXlkd3kRD4fZoCy8gV8Q=;
        b=aJGVB54LoTfBWgGyOTv3dYkkKKgSH4tjlVJIn/OLX7BXnPUh3Wfg1tGz0JfF/UYtcI
         sHLbpkAdYUQYAw0eikau+liKR+YJ5Vel6RFU2LzOQ88O9hUj9704YfliHs3MfbA/ZK4E
         Sn3vH4vVBuaR8UafmSt7qADKfIYfXS42s1prU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK/FnVBscvb9gt2KwYk+sXYzXlkd3kRD4fZoCy8gV8Q=;
        b=ULP1xOg/y4GOnOBzD0AOG0bHQnj8SouzC03F0QKK00bl6y7edpldWsCu6JoGoL7ojP
         UJePa/9Fm3ZEs6gdyIgYvLoAw0ludbDp+ssfz4H53exsF4PVFVOXJvm/H9+TJ2rULcw0
         rWbtc5bhsKCrDLvFdIFyd3nEZmScGYihS7ySY50QQbUKedzpKSgRJKmriMKWz1i+XoXC
         QJQhD3c/lE9DR6SWXyi6AI3gtqVu1zP7asUBwjK0Zxfgn+To0eHILa2V9iLkJjLIkFy0
         Ij/7UOQLyiHveDRvZe8oerwXhsCnpX6JZ3+kYKDRs8MCjcL938ahaE394LCeCrUfA8Ul
         iuNg==
X-Gm-Message-State: AOAM530Bbejrmu0YkNKzIlBnNTPBWwLJ8/30cqJzLvExcbFJURcBhYIb
        OJiAm8MFSNFPMzi9Zfw/8t8Ntw==
X-Google-Smtp-Source: ABdhPJzbsUY7hLr+SsX/ZABjK8m2acBbgxoapc9e0rEkZpzz39aRPvDlpqvnBDgk2iJsisu2YxepeQ==
X-Received: by 2002:a63:1e4b:: with SMTP id p11mr335123pgm.295.1628649864834;
        Tue, 10 Aug 2021 19:44:24 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
        by smtp.gmail.com with UTF8SMTPSA id 21sm25298942pfh.103.2021.08.10.19.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 19:44:24 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 5/5] dma-iommu: account for min_align_mask
Date:   Wed, 11 Aug 2021 11:42:47 +0900
Message-Id: <20210811024247.1144246-6-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

For devices which set min_align_mask, swiotlb preserves the offset of
the original physical address within that mask. Since __iommu_dma_map
accounts for non-aligned addresses, passing a non-aligned swiotlb
address with the swiotlb aligned size results in the offset being
accounted for twice in the size passed to iommu_map_atomic. The extra
page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
tht at function unmaps with the correct size. This causes mapping failures
if the iova gets reused, due to collisions in the iommu page tables.

To fix this, pass the original size to __iommu_dma_map, since that
function already handles alignment.

Additionally, when swiotlb returns non-aligned addresses, there is
padding at the start of the bounce buffer that needs to be cleared.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 89b689bf801f..ffa7e8ef5db4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -549,9 +549,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = org_size;
-	void *padding_start;
-	size_t padding_size;
+	void *tlb_start;
+	size_t aligned_size, iova_off, mapping_end_off;
 	dma_addr_t iova;
 
 	/*
@@ -566,24 +565,26 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		iova_off = iova_offset(iovad, phys);
+		tlb_start = phys_to_virt(phys - iova_off);
 
+		/* Cleanup the padding area. */
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    (dir == DMA_TO_DEVICE ||
 		     dir == DMA_BIDIRECTIONAL)) {
-			padding_start += org_size;
-			padding_size -= org_size;
+			mapping_end_off = iova_off + org_size;
+			memset(tlb_start, 0, iova_off);
+			memset(tlb_start + mapping_end_off, 0,
+			       aligned_size - mapping_end_off);
+		} else {
+			memset(tlb_start, 0, aligned_size);
 		}
-
-		memset(padding_start, 0, padding_size);
 	}
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, org_size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, org_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
 	return iova;
-- 
2.32.0.605.g8dce9f2422-goog

