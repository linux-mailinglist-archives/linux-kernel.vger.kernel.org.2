Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966F3AA280
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFPRgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhFPRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B296C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id n12so2548168pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahZGAXy9acwSVxDWNfEUSzxnYPHjGydJ4Ki8/ujo2d4=;
        b=UvCRFVv25P6A+UteTKxXOx9FJ9ojOITIh33NeOUUxyFtK8dWRAxiGS+jDP8RzlC6X5
         OmE93MjVhY/RJD6o/euM0bbZXiYqmPvhpKNNSEX+AoOsVPGDrnUacQPuXjWXngoZWOG2
         2Y2IYGnOY1AZoDJBw3VRmKwvvsM/yHMhmGHgOJNQtVPxhJYDlF4WP5+ZjxQ7kru+lqq+
         qUSh0w04/KuzbY1CINvfTkGDRDQaOLx6zNt3kQPMFOOgsyVLQr8Ai2MjOhlp3BeIE9qs
         Upkjn85xzfOdfXUbCnkStUbwwGd3i54TW6ZKJdu3gDGx5OmZ5W6bjrZtV54/prM7lUn0
         VaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahZGAXy9acwSVxDWNfEUSzxnYPHjGydJ4Ki8/ujo2d4=;
        b=FdaotomRb7KLFYBA8axr6etTPoyavn2E9wBfP9vvu0JCOi6IAUVZQoSOK4GQYfuCx7
         JoETkMqLnsPUOGdzoipHC96/AMGXYZ+9eiBmlglNZ/cY6CldZEJUERaxWTg/HMu3c135
         qksqVJe0vptZO0OvEufN8Znz3AqNrB9I/h9UUF+khh4vTLHfHYINuIHYjVsVFoFA7/OM
         5QFYr6WX6cYjbv6cUUIOAs9zM3Pyyz+l0tcRbmh9mVTOkeJ/m/kSG4Ply9qFPWeWFGcA
         Mamjf4IXSlzUl0cPzqeDcTP9MlqeFYETvVh2q6n/mP9lJUY0xfYJNdkj33ITbmqIaP8q
         TbHg==
X-Gm-Message-State: AOAM530csEW5TCI9eRgZ7kTjY/ed703Me0KaPRosCV3vHeIqj6PjTsiZ
        joR4CK5TfTKDQM03qiO7eF8=
X-Google-Smtp-Source: ABdhPJzB4NymddfIJDShOskkNBDG9hmXCzqxoQcCTIDXD4dK1j/pUVOnrFOJw0cFN30oMYIR4WQdIw==
X-Received: by 2002:a62:77d0:0:b029:2e9:a7ca:9c50 with SMTP id s199-20020a6277d00000b02902e9a7ca9c50mr985834pfc.5.1623864871795;
        Wed, 16 Jun 2021 10:34:31 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:31 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] iommu/amd: Sync once for scatter-gather operations
Date:   Wed, 16 Jun 2021 03:04:59 -0700
Message-Id: <20210616100500.174507-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

On virtual machines, software must flush the IOTLB after each page table
entry update.

The iommu_map_sg() code iterates through the given scatter-gather list
and invokes iommu_map() for each element in the scatter-gather list,
which calls into the vendor IOMMU driver through iommu_ops callback. As
the result, a single sg mapping may lead to multiple IOTLB flushes.

Fix this by adding amd_iotlb_sync_map() callback and flushing at this
point after all sg mappings we set.

This commit is followed and inspired by commit 933fcd01e97e2
("iommu/vt-d: Add iotlb_sync_map callback").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 63048aabaf5d..ce8e970aac9a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2027,6 +2027,16 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
+static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				     unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+
+	if (ops->map)
+		domain_flush_np_cache(domain, iova, size);
+}
+
 static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 phys_addr_t paddr, size_t page_size, int iommu_prot,
 			 gfp_t gfp)
@@ -2045,10 +2055,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	if (ops->map) {
+	if (ops->map)
 		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
-		domain_flush_np_cache(domain, iova, page_size);
-	}
 
 	return ret;
 }
@@ -2228,6 +2236,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.attach_dev = amd_iommu_attach_device,
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
+	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.probe_device = amd_iommu_probe_device,
-- 
2.25.1

