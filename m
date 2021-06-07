Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE72B39EBBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhFHB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhFHB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:57:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C92C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 18:55:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p13so4939084pfw.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWMknRbD8X1K6AG9lburjdKW9p491bZf6T9lQOWSxxM=;
        b=UfAkBGhzytTvY7tWO2nFI9gbpg7gzUZFQmZlmkhoLHVzezMdznstTDtKM8jB4JgeNL
         gWZEJMhiozQYik5Z26mB7KxyS5p5LTpD/ZiP/Uxyiu5gtnqDBo1pBUrXn45YPt0+ZVcG
         aCE3+b9R4o+HrmBCTknwtG9XAX+87es7bRRsFvIKABtU0AXVZK6Ye5Ms4ovvcPMIbsMD
         I0NrtcQI8XM4OyfgSjRLkon9m5+I2FU6a/xo/Im5VjjxAS9/OrbYri0V0jkeZY4SrTDw
         kTC8NgXhZ3J4W94L0S5tIwwc4nfyvzbfU24hiTGMEW4wY9pmnbzNMEA8T/lcW4KXMlzw
         kOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWMknRbD8X1K6AG9lburjdKW9p491bZf6T9lQOWSxxM=;
        b=bRbmwDf5c2DnQTKnDljCodCoRVgMZoJVv9lhZE5CWDtj5ub1/BDLQS+t3X0UTOiI43
         031qORWC+ByT0PIVK6bBsq6mcCww4/UleQtcvCfsr8ZcZ10zgf9yADcFGc8KgxKpYjZW
         3RWHnVGJP/f7wNu30SjrvqJ9Lut7m7EtjL1gFqtDUkR4IUOPWGx62/WEQuLZ2zToa+L5
         3aOT7Sjetkk0YPIW26OHeSsJP+pMMe+fzopBNZY8vEdbF2jQ0GcmfFY7HVTZdRSnZyQ0
         MdEKNpZdrJIxG2attGB7IP6LGadiuJiryCBj5Z/AkPF52ijXj/z+oZrafElNM5Iokp/L
         2rqg==
X-Gm-Message-State: AOAM533pg6vsKnHHBtwr6aZNe3Ooix0oOeaG5MXrrTceMU6BocBK9Mbm
        HlFgMlncnyGKAoZm1T4Mfjg=
X-Google-Smtp-Source: ABdhPJwGEQVYFg2a77oHAedrv7L7WnwzgJdO94nMtzoSPhpt1EFs6Z4XMU6b3oNq6dW9pWRYQBShgA==
X-Received: by 2002:a62:6491:0:b029:28e:8c90:6b16 with SMTP id y139-20020a6264910000b029028e8c906b16mr19157988pfb.24.1623117322049;
        Mon, 07 Jun 2021 18:55:22 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:21 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] iommu/amd: Selective flush on unmap
Date:   Mon,  7 Jun 2021 11:25:36 -0700
Message-Id: <20210607182541.119756-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
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

