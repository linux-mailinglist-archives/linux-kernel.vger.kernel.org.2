Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E5370AA5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhEBHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEBHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7070C06138C
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so3970021pjn.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNLrC3xn/EJ4tCCyd6W1ssXumNURL3TkwWzu/8GDQlU=;
        b=jIJhKOykgtuz5dFxlmHmjr8R7ZNjI3JmrRl8qXjFjaiMAC+Qod5blL/Dt1dHYxVBug
         e+tu3dty9eQvp0qTcqJZ1+YSJEeawPLg3YfR2rALmHV1vCV6x6ZtiAUMT0uLILtLYvFX
         RHe04nZWiWiAjLygU1kyAmPSmWBab/zd9c6C1FDwNBlV0V7wBnYfIxBdOGwEdoYQnuHj
         iOc9+MvgA52agmf2ngid4Tbw0tcPyGUuUTd/JY+M91LXR+qZT+ajJjB84XLTFVvqC4wN
         9kZtn2C99u6xycq834JpGyC7BWuohjZ5vF4wfPeurG6b/bdIKvg9NnNPzt8FDYeSjKLo
         zNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNLrC3xn/EJ4tCCyd6W1ssXumNURL3TkwWzu/8GDQlU=;
        b=PXKAW/hTaII7VPWsHkIfVysyHosTWV90v9jS9xYFi6fuW8PsotuoUYHzEESHxpLf2S
         b+8i4X5+gwm+0hLiXrqYZacjnfBVcrZQd1R7E6QUqQl5mNJUGGDS/KybTe5sj8XnXl07
         uRWBvg5JuMuxECV2yi2mG6oESne0wlFagQrDI5pJGvpz31SxhNL5EG/0evibqxfwzUkL
         EqIBABZUKlQv5CugKfQDe3K90YFbB/VQ1mu4cEe7m4OcSKtg1JgfL510Y+Z65pObTiyM
         a63hm//ivRM69fNtzH+Ibtu7rmhTSmB5FR3kBCPcGdmeoz9e5p2eFnnbvX/zKTwOeOor
         inFA==
X-Gm-Message-State: AOAM533KJCRZjfa5qz7AkyomlZKqd1z+lICq3dteBvUdmVHXfCxMqVOu
        OTMyWxV/Yj5NNSgTKbQ+z3I=
X-Google-Smtp-Source: ABdhPJyGZHP8Y357IdwlflXZ5qUHrsA2va+/5mQC0lhFLhMkwedRyoHGdqPtOYKXOvzPdBRP11YiJA==
X-Received: by 2002:a17:90a:390a:: with SMTP id y10mr11765295pjb.9.1619939113139;
        Sun, 02 May 2021 00:05:13 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:12 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/amd: Selective flush on unmap
Date:   Sat,  1 May 2021 23:59:58 -0700
Message-Id: <20210502070001.1559127-4-namit@vmware.com>
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
index 6723cbcf4030..b8cabbbeed71 100644
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

