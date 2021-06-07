Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32B839EBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhFHB6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:58:21 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:35809 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFHB6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:58:20 -0400
Received: by mail-pf1-f182.google.com with SMTP id h12so11666565pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYSa5dzZqlSBhiWVVfbL3z5005cJpSnxJob3wTcfuvM=;
        b=Jd5F59np7OwVQO4iLQZZLy20cUm82OhVfYN3mJMZIrXP6qc9avY20mjm1C0Or+RVgB
         D8jUAnDWyLgze5HS1B/75OyPE1K8d6EUmdEU4BOrxfUP8MxPGnp5PAZS7SaqHSYGUFAx
         kefMT1zw88Y8HzyexdjUaGhbkOZMZjX7Z7gckJqNzLyalxgUrf8URyI/dI5nknCH1mKu
         5jkM/9v7rkj6H45xZQqKt+YeQpa0m0Oe/YrOhkrFbruIyhUXgvMo7eoATEpd4XIb/ipD
         NCkQVqkdMrjOwgDG6BMhswrXq4trgof6QRXTa9BXWunfeCMfOEvidJVA7yIP7UtHzPZU
         FTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYSa5dzZqlSBhiWVVfbL3z5005cJpSnxJob3wTcfuvM=;
        b=AA8t+YESQhcMUjbsNjYapfgH/eBa429ZF91YfGCw95AxA7fNJZ/niHzCT39l1xjK5P
         6RVt12k1N7Cp/PnoOZHZ7ET+f2xrRcuqV1vdmjO9SqEQ1k9KQ1gnZOekk+r+zRl79Yin
         Ig0TyL4WXcDX3ZIxLA/HzDOPANLyA+clzRR//IbP45Kny1biQPrUa5tjLqp8U67fehvV
         aGSyENA5884r+pf/Vxyh0WJhDlYt+nkCel4aazEWJ/jZj//gAUmY5RraqbmJM7/Is+kG
         7DPU56lMWHCH4n1csYNUn9u2t3kGaMAKQHfxUdc8fPQ0hb4qYjxKRAPcp64jYYq4+sMk
         mJzw==
X-Gm-Message-State: AOAM530g51O4RfbxEdxCUWu7YlE8fPQpM5+o+Ny2G7a137liwSvVjjpx
        w2N3BA1qPxacLpcyd2kn5lw=
X-Google-Smtp-Source: ABdhPJyQ8lkTxIxUP+pI7+xd1dEjyqRcbeEohR06teOYio4TrTHXUm0jN2/AKARGkcYGzSnUGJH6Ew==
X-Received: by 2002:a05:6a00:1893:b029:2ec:a754:570e with SMTP id x19-20020a056a001893b02902eca754570emr13709535pfh.38.1623117328716;
        Mon, 07 Jun 2021 18:55:28 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:28 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] iommu/amd: Sync once for scatter-gather operations
Date:   Mon,  7 Jun 2021 11:25:41 -0700
Message-Id: <20210607182541.119756-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
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
index 128f2e889ced..dd23566f1db8 100644
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
@@ -2249,6 +2257,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.attach_dev = amd_iommu_attach_device,
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
+	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.probe_device = amd_iommu_probe_device,
-- 
2.25.1

