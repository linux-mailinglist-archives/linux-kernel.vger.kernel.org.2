Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227F83C1DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGIDiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhGIDiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:38:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:35:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso5296147pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5kV9L0aXz6/KqDgMplR8Y/fr7ljFFELau9duMzUfLA=;
        b=IA0M1HHZuseGxoR9Uj4xCoKqPvLqZDU+anTFFsWfwSrtj4XXk0jbgcCyY1pQHcXE/u
         k5pDvW4Qc3Los7C2W9ThBMoEcNlx6kcnkAGjdOWZB985KjPNJIJ1ghDVlk2zrRfGp7pE
         BlBWBcgeUL3tGsy9D9TUs9Md4cbSOcWp3k690=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5kV9L0aXz6/KqDgMplR8Y/fr7ljFFELau9duMzUfLA=;
        b=mi6/FU6UB1E+UC4AYRA4FhJk6klY3+6dTDxc0oTe8L6B9+q1L40QF/4dd1HN4A/hPk
         MBK3f2G9nY63L6yZR1Pjqh/X45zfMU0UNX/3bn5yNwNanSAKmHs/xwFewxeoNOO8kJQn
         8dLXzbwu+s01NJLLAG4eLlWN19UG85giuQEdUeZCQYthTHmezWXYvvG6eh4YLBc1EfYp
         bMl8Ka97ZeCamE8HYjmO8y8ZWkzx3Ne7KTN2ga2Tq5WXfDyhHBy3XtCyqDhzC2bSQqI4
         FO3RJhXnCMbazaFklr8BGlwnT8APjcnoIi39xuSiDutRB+OgvD6EYqWn0lCSyymg/cT1
         Q4XA==
X-Gm-Message-State: AOAM532EOb5fYW/pOsjtGKQxtCzhOyJwuX2c7qQMXr90KP7XQQGBKrgW
        I86w0tib7Aw4aNGkFVwwgFG5LQ==
X-Google-Smtp-Source: ABdhPJzoJMbld2YjSn+KX+lOb9exBrS6UBmDPVaB0Lpvg4pQeVwQn3zbHeES2piH75m/86nSjTxvhQ==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr8399701pjb.108.1625801720435;
        Thu, 08 Jul 2021 20:35:20 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
        by smtp.gmail.com with UTF8SMTPSA id a65sm4609468pfa.11.2021.07.08.20.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 20:35:20 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 1/4] dma-iommu: fix sync_sg with swiotlb
Date:   Fri,  9 Jul 2021 12:34:59 +0900
Message-Id: <20210709033502.3545820-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709033502.3545820-1-stevensd@google.com>
References: <20210709033502.3545820-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

The is_swiotlb_buffer function takes the physical address of the swiotlb
buffer, not the physical address of the original buffer. The sglist
contains the physical addresses of the original buffer, so for the
sync_sg functions to work properly when a bounce buffer might have been
used, we need to use iommu_iova_to_phys to look up the physical address.
This is what sync_single does, so call that function on each sglist
segment.

The previous code mostly worked because swiotlb does the transfer on map
and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
sglists or which call sync_sg would not have had anything copied to the
bounce buffer.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..eac65302439e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -811,14 +811,14 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
 						    sg->length, dir);
-	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -831,14 +831,14 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_device(dev, sg_phys(sg),
-						       sg->length, dir);
-
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_device(dev,
+							 sg_dma_address(sg),
+							 sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-- 
2.32.0.93.g670b81a890-goog

