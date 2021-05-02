Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60C1370AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhEBHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhEBHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:07 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B9C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j7so1533321pgi.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHTsdU2vfU5Wpq72nptCBLFongQuhd4/qiJ01bkzxDc=;
        b=aBDqkxDC0vcKuNSD5lKBp9yytX2lw8gij6ncyAJK8EZqXbfXJyxKa4HlR4UUGOZLEg
         daX7I3oXZBk8JOC8q9fKBvuCtSRmwz4VqIdreVswAf0fRBU6XUx2sM4K66Y0BI3Rfl2T
         I1YzWYWXzwBYvcdGsC7CWGc8c96zjEp1LuF7Ji8iEypvykWDA1aFLV9dCk0xTscTCQO4
         f5u+ak2SzecGcLQK7q8duOo2c40jtQmdjiVXJngbYXVTls36Alwhk9ubXh07/r8TBO9N
         0aIpxs1UgdSNTjZBZzTbwR6TxbG5j02gXn0m58Orxsfxi9fh8+Um+WlN7WiQvvfCTE+0
         NxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHTsdU2vfU5Wpq72nptCBLFongQuhd4/qiJ01bkzxDc=;
        b=WCSHfIQ4DP4YnEqJA/i2QuWwvoBEAMzQNSmeoA1L6GDjU258xmseWm/+nF+yix7M/V
         L5mo+dNULhKE8Pyo4dpdNwZndjUhUwNwx1m2hGWwLgbRDSjVAVQgCB/gdaNNnYjotAni
         1beu2pE40hCcES4dW80dnL1pe+p0IIZvGxP7xJLpJ4mdXRPqH5z8NWxd7z5Yj1isMlSo
         Lv/lStUBK9z0/ylwuSaJ4j/e0aa+Y2x0QbVyniYqrWXOziNRQmOkcVnW7RGKYuNU6fXH
         MM7RfFRdepyAXFFCOdqH5d3lMR3RxxbwmTW5L0KlI0kHF7NIJis4HFq/VHiwO8yHIAiH
         5cng==
X-Gm-Message-State: AOAM531rs3rfNhdXkyAn4rNKSbevamrqmdQ+eWg5fXfBTd49T6EAcDnX
        vTnM+9vt6fX64CjS6PB8Wys=
X-Google-Smtp-Source: ABdhPJyXpX1JGNTK5UlbEjpgZqyaBFGalwAGyRgOkA5CWK1tYgbtXN9KoSapMP+nUITKESJanl6B7g==
X-Received: by 2002:a63:1b10:: with SMTP id b16mr12476471pgb.308.1619939115817;
        Sun, 02 May 2021 00:05:15 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:15 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/amd: Selective flush on unmap
Date:   Sun,  2 May 2021 00:00:00 -0700
Message-Id: <20210502070001.1559127-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502070001.1559127-1-namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
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
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8a71ad477c34..1849b53f2149 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2057,12 +2057,17 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
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
@@ -2165,7 +2170,13 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
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

