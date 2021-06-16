Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9043AA276
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFPRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhFPRgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A67C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k6so2742037pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWMknRbD8X1K6AG9lburjdKW9p491bZf6T9lQOWSxxM=;
        b=WYmmuQrhubPiSJDW9wGOaMi600sb+jgw6jlrzgd9MuDRuGCR80bvURFllIw8BfQXVd
         4TFjA0fLpdScaKVxoEDyng4DGCWQbHnszW/V0kBgfohgSjKJm3f1tT0vIceGETESOO10
         /JipqRvLbzUuJytPGb+aKPld2kHiZV5mAV1gx96jX+eW/PNQCcTjV5sXlX2uLBdz3I9O
         nPlleW5R4avJw5GfeuF2ZgN8grnuRua/eWnJwAZehamQ/XJR2kDzuCvJ2MphojHlFZqJ
         QUThUTYiB6Z46cVzcvpsYirJLprl+ERslbjm5wGrYVjimjcTTB7NIKBBwKjbT1O/qHOG
         RFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWMknRbD8X1K6AG9lburjdKW9p491bZf6T9lQOWSxxM=;
        b=MsP8AN1e6OG4Ycc+Tf2djHW6yIFFTAnaEjgkkREDQX8uBpLYcLnSrF/2+7/oa46fVe
         6C7XKn5kOdFXVEEYuhn5Ujt/nCAKdl4rwuI9ARYxbNduTnqOjVfuHar2F0OLhc5fWfhK
         OMGGHVRCqaF+eaLEUYT8twe43Xkr/sLwkbLmbeAgLWhEn6YhfJaH0apzSGQH0NUcKb1D
         1i/d8+cwe7JsuOtx9r8vF0r2yAdsY1HCjuBc0C+vZ28PESY8OOvl1CjgZfH2/ri/NIu1
         DFmziHnigDA5ySWEOcg7sjOauzzXx6BKGdEDzeMBOPnwoVNn02EAA0cUi/r9ZsoID35g
         Ed3g==
X-Gm-Message-State: AOAM530QNTy5TubatOiKPbJEDYa50k9GJrmQTmeRRlzpPd5kOYt4peAD
        Eu2RI5MbJTfACqjUfMmiILE=
X-Google-Smtp-Source: ABdhPJz436Zw3YWQKZ/hPtmHRb319Ej3srR8Gc/K3d86FxQPw/wKMhw2zFKWx/8HRIJNrwlO9X6YPw==
X-Received: by 2002:aa7:9983:0:b029:2e9:e086:7917 with SMTP id k3-20020aa799830000b02902e9e0867917mr943222pfh.57.1623864864946;
        Wed, 16 Jun 2021 10:34:24 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:24 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] iommu/amd: Selective flush on unmap
Date:   Wed, 16 Jun 2021 03:04:54 -0700
Message-Id: <20210616100500.174507-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Recent patch attempted to enable selective page flushes on AMD IOMMU but
neglected to adapt amd_iommu_iotlb_sync() to use the selective flushes.

Adapt amd_iommu_iotlb_sync() to use selective flushes and change
amd_iommu_unmap() to collect the flushes. As a defensive measure, to
avoid potential issues as those that the Intel IOMMU driver encountered
recently, flush the page-walk caches by always setting the "pde"
parameter. This can be removed later.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3ac42bbdefc6..3e40f6610b6a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2059,12 +2059,17 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+	size_t r;
 
 	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-	return (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
+
+	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+
+	return r;
 }
 
 static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
@@ -2167,7 +2172,13 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	amd_iommu_flush_iotlb_all(domain);
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	__domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	amd_iommu_domain_flush_complete(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
 static int amd_iommu_def_domain_type(struct device *dev)
-- 
2.25.1

