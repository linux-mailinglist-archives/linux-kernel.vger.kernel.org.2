Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA13C1DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhGIDiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhGIDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:38:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A97C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:35:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y4so6094993pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VUfXQzWtFRM7U68C/zyfMuk93kjPlYa9PR0xxD2xic=;
        b=B3jOGSNdch75Pk9zvvAHQWxHiYcXwurhghja4Glu3ELo0CQiPIkJpTVx4MhlAVQzHK
         PsqQZHnJ+jdpSGgw30X1l+4YvHL9SsT5H+Oi9sWXRR1gz2SJC13mAu38I8tejIWNArHB
         Ax+pBWP9zMHVtxVBgDkaoEw9myXHEF1xMrvv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VUfXQzWtFRM7U68C/zyfMuk93kjPlYa9PR0xxD2xic=;
        b=HlPXVwpkXMuLKtQXEnLgHTdzEp5chMxWktIWaK0gEs0SPvejBx1Rui6A+7CFi6iW7a
         aD9vdECDri8v8xPLCtfXDcmTWOUnTy1KqaZ4wZ6CmDcDg4/jVIRaElHm156FbZiBN3Om
         eE7paVqK6dFmiFVe7GbHK09CpUH6utLuPAOu9wpxh+3gHourNyt6uJ6PTNzu9BhAQHlE
         HIr8V4z0+entWzYW6fM6OvfvTk/tVCWcEN+hQ2Mj9FaiN6pm5b6dBsPPhAvEdoRh6gve
         LLnAxRDYIZxXtO7S82CZeYtQOBhCQUgM+jg8J4GBD7DFJ+ztQHMy59nqd8Ith/qGkjUX
         XEYA==
X-Gm-Message-State: AOAM533bXOVfFFNOOFXr0Dvk7Xv5Zhjb75wOJJY6ekO8zl/H8u0f0rJh
        ayOQLWEZc4H09w7e9KqhDCNaGg==
X-Google-Smtp-Source: ABdhPJw3/4Aeqw6xIS1A2FgwKChh7mQPgc7V2haArsEw5MbJC4ev9VjMc/Ol2MIfkJ86tzswkqEJyA==
X-Received: by 2002:a63:2009:: with SMTP id g9mr35199752pgg.105.1625801728043;
        Thu, 08 Jul 2021 20:35:28 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
        by smtp.gmail.com with UTF8SMTPSA id u37sm4194501pfg.140.2021.07.08.20.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 20:35:27 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 3/4] dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
Date:   Fri,  9 Jul 2021 12:35:01 +0900
Message-Id: <20210709033502.3545820-4-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709033502.3545820-1-stevensd@google.com>
References: <20210709033502.3545820-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

If SKIP_CPU_SYNC isn't already set, then iommu_dma_unmap_(page|sg) has
already called iommu_dma_sync_(single|sg)_for_cpu, so there is no need
to copy from the bounce buffer again.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e79e274d2dc5..0a9a9a343e64 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
2.32.0.93.g670b81a890-goog

