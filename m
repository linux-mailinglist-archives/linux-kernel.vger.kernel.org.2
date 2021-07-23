Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3F3D3E10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhGWQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhGWQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55933C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e10so3951256pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRGkXhFVPDCN6lHFCDskTpMUgejvDkPOTh0TQ1SmxgY=;
        b=kqMNWSv+DGS0mWFaqPpv1UMyTiwjjOpQQHyZFVsfWaC+2Xy5Tm881HC9sEq2X3OWCc
         0yPMLBYHaSRhUBiBgqoU3041TgLO6io+C8wO5I8b+8j+Xr2ezZCpXGPCNd0X8Pp0RHEy
         iSe3J8bGQsTmZcxpzPq7x/4NTXkUpL2/z/2tj+FUoLfadLgsDOK2kSct+MGINjUeDPip
         mfnws1qZoRSRibbdFwJhuhmtm0BHRFBm01uaLd2zNtbfCOfVTaLl9n6KY1CoYIiPJLp/
         6Vy/iyRqaKX0dkr3oXGwXRLGIsSmsqrL4w572nOZrwhcsjQKBC9TAUYwbMa2PVpRKDKr
         iJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRGkXhFVPDCN6lHFCDskTpMUgejvDkPOTh0TQ1SmxgY=;
        b=GLFfoBzF0XMxprXDurxTgA2awXGwVOWpRtcgLmbF73tce+nI0bZZIiTymrGS18UQhM
         8pP6RxQnnmQPxMJOPujhwUNOQJm9/Mt6GhOIdA0uko1X8FdIVdGPBE/ceiY5iabh/Stt
         +CrsU5i+Xx/VLG1NPNjHo6teBy87BFxdZm0+lGOzhtJPxJDA7a8oiiJVaDfuEKSTAc9C
         IuvYw2Cyaa6tZ2efGLQDlZl643wjsg8p9rUC4OB8ciPpCxYXQ0bup60Wnia6fm0qMsoK
         bLaGfXRbWyAOXL39DZN7RcylZzKXTYFowGFui/eAFXZeoHJuZFi/8cQ1SG51cYuMwMys
         CB2w==
X-Gm-Message-State: AOAM533FFgZv4uihkjCnQDPfeKB1aS1YcfEHqH/794AQv43Qn5pJFyL7
        IBBIbAaKftaQ2B+GxG4Tqic=
X-Google-Smtp-Source: ABdhPJz+uCdl5dDuZlVhexy7b6MtXYblXRkG+BBEUi5vIyEnimRH9/Y/SYERTz3kqEV5yBN72IHrFg==
X-Received: by 2002:a63:5064:: with SMTP id q36mr5696945pgl.196.1627059719660;
        Fri, 23 Jul 2021 10:01:59 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:01:59 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/7] iommu/amd: Selective flush on unmap
Date:   Fri, 23 Jul 2021 02:32:03 -0700
Message-Id: <20210723093209.714328-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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

