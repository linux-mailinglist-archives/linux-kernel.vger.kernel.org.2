Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C23C75AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhGMR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8DC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d12so20310616pfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRGkXhFVPDCN6lHFCDskTpMUgejvDkPOTh0TQ1SmxgY=;
        b=hC302NZA8ul/V+t8Z3Trs8zOIl6iLzgSxjoO/edKlYvKkEl9f6Zystolb9Ywauciek
         +hzneNkisIFFl0+3d3iFwjableLGJndP2tcfcw8peWty+OYoKswjVPDyHH7+Ff5louIW
         64DOKyUhkgXYyexcov1Bf8cqKm4XWCU1kmjfE9B04D1cZFKQtSMWZmowz4elIun+zOn9
         Z2jPV1eHkoYoeKtNVzak+7qfmqiqlR982/R7bqnDwJccowMQmiXbByt0ztpuv1SvI2Xs
         PYi9hU9Dm4ps0dwzgdzQhdwRqccpvqyctgVOKK3ix3tIq7UdOH57OqaAy1+OBM1CcmHX
         i+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRGkXhFVPDCN6lHFCDskTpMUgejvDkPOTh0TQ1SmxgY=;
        b=M/hEeLXd73XISecZBK382AlukmhYFM87Gwi2JW0TdwDSwpvOONX+n418npZf4dZrDW
         v7t6VjZtT7ydNC0QgRbBYXpoqm7TOp0+aDKf3AHMlxxl5SSoPKWkzpjoSuUTDx/B8YWT
         GAYbMFOPRmLsEqn6pWCUPG3HXSZl/iZ9M/s2eaRGX3J21dd/Lx98mVTTPUBMmXozc0Ex
         BRE+teiI/Q+G9nGpM+GYmpojrGaX53JS7JdcZP8C6+ufOAUoblcDOgEqn3Ejkc1hKmHS
         L8i0cXbbkqRM2LUjpQjka8r5l6hCcHq1DBNUWaorUpfVLwXM0DOAgAdl2khr5Dn7KfFc
         chQw==
X-Gm-Message-State: AOAM5336LnN9c81tOOb2b4ugrDGcGoTDdr1/Ez8MR2U4BubLcf1+QxDH
        TygkATNPCGKzr6jWxoB7Aue5fLQmMNLCyy8m
X-Google-Smtp-Source: ABdhPJwl24HFWvtohvEl9N5FlO2WDW6tugBIkQCzWSqu3enuljJcDf+az36g29V2YUSO4m4dObwCMQ==
X-Received: by 2002:a65:4047:: with SMTP id h7mr5292979pgp.198.1626197089588;
        Tue, 13 Jul 2021 10:24:49 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:49 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] iommu/amd: Selective flush on unmap
Date:   Tue, 13 Jul 2021 02:41:45 -0700
Message-Id: <20210713094151.652597-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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
index 811a49a95d04..bfae3928b98f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2054,12 +2054,17 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
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
@@ -2162,7 +2167,13 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
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

