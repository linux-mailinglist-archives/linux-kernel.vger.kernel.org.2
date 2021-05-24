Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E938FA89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhEYGMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhEYGMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:12:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C17C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so12604699pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNLrC3xn/EJ4tCCyd6W1ssXumNURL3TkwWzu/8GDQlU=;
        b=npyEvkdaNArfqRQuIDC+XsB2irFyKhScKGWZpjaW6UXNLHFKvndA7eFiCOzKu5bg7a
         ZRhvV0LfrvhXZacK71iG8ZxAei8Ncl6LxL8mMRHdTJIe4hVrOM/Ncef6x50hio/BI+jJ
         cI3sHoIc6vcpe7d/pS6zgr9npJq5zGqPtzUPr4jJRmAdsLddu74Plp8h2jrBx1cNDhaT
         hQIl5B1iGk5xwkETPqJHmcPsuJBTpbp3S+KN6zEnBC+Pf0omM3/mfV2NiUCQd2wQKwQQ
         twNcJWyLbivQLkHeWB5DXf1T54xm0qK7GiRh8EkIO7eN6ozNIf3hTwlVjYbdcnvyBWiM
         hkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNLrC3xn/EJ4tCCyd6W1ssXumNURL3TkwWzu/8GDQlU=;
        b=oSSMPWJTMO9j4Vv1J5n/l1WE8KSpm1Cl4vwaYsT/ulpF30M8imOhpSRSR7E7ElBZiN
         +keKWtrJOk1bYiUTZ6zC9gWNl8pgQknk3k2MkVDPHooDQCcsT5JLPzQuV+1RpAPt6wpB
         97mg9vhznr+/vj7vr9YwAv9hHt1w4Ly65bQXQSJFx+dFeovml9A54XoQwsgHnQw4ZOoB
         XPQxIXhmeDoRseF4iGqBYgwDWc9DRjmgJ1PkkD7fMU0oVMJ2EfYLhowDXn1RniCWfoAx
         1SRg3urZn88Dstp2+u0F8Q285So0YGYHtpLb0Vm1ODHr0pcCYBdiqCjZyp73IPfT8KLp
         lRVQ==
X-Gm-Message-State: AOAM531Nd4WggTW2cljS5aioWuZ/n8WhYmQHi88D4REePfn4zrsghF4z
        qFhZavFY31M7cbot4cPW+EA=
X-Google-Smtp-Source: ABdhPJwMDM79giShnau33iKxsbIRK6Oy7cikXwREviGHIrkL1IHtzOyMc/Ndw2F+Nc0tijdPTEowMg==
X-Received: by 2002:a17:90a:ac04:: with SMTP id o4mr28262632pjq.114.1621923076653;
        Mon, 24 May 2021 23:11:16 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:11:16 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iommu/amd: Selective flush on unmap
Date:   Mon, 24 May 2021 15:41:57 -0700
Message-Id: <20210524224159.32807-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
References: <20210524224159.32807-1-namit@vmware.com>
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

