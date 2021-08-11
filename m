Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDC3E881B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhHKCog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhHKCod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043BDC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so720063plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STvZImlSg453zxS/WPOwXGrHy946aGM7gL5fircHQaY=;
        b=g0dnUO8gTU16GFKNQ5dbkY/g0YXcD9c2FT5bQMhIz1w4vbHr7Y0Fvh/GVEzJBkarx6
         mW68D65LMEPgcaq4NOh2lyk925jd+XdTARj08VOh/+BrdWwI1t1r8Q+XV/LCjqanXGny
         gLCYFbM4WEdFAkw2fhgKHA0dNM4rPz6OJEtc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STvZImlSg453zxS/WPOwXGrHy946aGM7gL5fircHQaY=;
        b=YNxmX9T04OHRE/vp7p/8uJo6oGGOC9Rs/08jipx0c9NScffbgehb05KFbBKGhmhhGZ
         RJkNYtqzxHEZ2G6pmHTuEdhwpEt8PTWXsHXqawimfsZE4n6hNwzqWnHNHx8kQXhclD83
         KcsVs87ZOQlzrT4gj84ENZd8FH6aulJA/l/9sO0Up4d6PHZ7vLXemARsyX0Bu5nNcR6p
         L5kDFZVn4uyCEup4RuAeDVqZPokVst/hkBTjW3Y1V5vdfb+NIPz+GdNP6i5Ew7G2VnYF
         iHecojRu9y8yJfBBR7nfOdt8XVxLUvy0h2utImVFWt+UuosOAqksHt1GKj/rm5zSGUG9
         +vMw==
X-Gm-Message-State: AOAM532j6/I69MF36l+9A+I/xG9aGh9u83RICQCT50UhRJ3d3b4kux3W
        V//iAVQBqPfTmZHckBE4FAYe+g==
X-Google-Smtp-Source: ABdhPJz+MiNNCQ88y5aE8tMHgImssnVqQZfCSaUyrQcTLh26+HYsTzqJXH3Vb4kkceHTlSB3xOeGfQ==
X-Received: by 2002:a17:902:7d88:b029:12d:3f9a:d34 with SMTP id a8-20020a1709027d88b029012d3f9a0d34mr5384873plm.13.1628649850589;
        Tue, 10 Aug 2021 19:44:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
        by smtp.gmail.com with UTF8SMTPSA id v1sm30068736pgj.40.2021.08.10.19.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 19:44:10 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 1/5] dma-iommu: fix sync_sg with swiotlb
Date:   Wed, 11 Aug 2021 11:42:43 +0900
Message-Id: <20210811024247.1144246-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
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
 drivers/iommu/dma-iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..54e103b989d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -813,14 +813,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
-						    sg->length, dir);
-	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -833,14 +832,14 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
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
2.32.0.605.g8dce9f2422-goog

