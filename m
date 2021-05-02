Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB5370AA6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhEBHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhEBHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B34BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t4so393447plc.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
        b=HZVuO6/Rey41sy8z0pQayPzweV8rnRftn35sAiSoX5e1Kkqh46ZUmwXTz5crnp5MDD
         KqRPfVQo+19EYhm93km29tf3f3RkxPcBy5WTshI1nUf1OXz8DGqbuH3QughkiO5ww0YJ
         09cV7VS/gPCuKq7997LUBtf830okwiYk8vfPczoCIMUlrdWD2uFwL2DP/Nsq+XYnAock
         JbUm9G6T6w4Ml7jiMAwR9lcVCEg/QhxtK3UVycjLmRYqXSneZgmeTMsVUPlKHO8+N7Ur
         JT3fRPicXILbS8zocKyhYL8XhodzQeXgF/cAWu9y00beZ3WM0g/bbbRrU3l08MT+vdeY
         Zl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
        b=Th8EBZMJ0+ddBvcSKwYsanX9VrXFNO/dr92QiV6YEh/O/PWoZcDOYS+O3osleHjm0h
         J6ZZkLY/l8L6MV+iQHgA0Qi6MPF5sAoEjorSkJzPnAobpFo0JyqSSXtr90UJL5gQtFEE
         39Ozil23x2nUmLiP3l2xm68nQBM2mF+seRCaiawu5jTofvD3c4MyldBBAeJec+DHFy3E
         0P3DF84dsr4KPZdDbbCes0FogqWn+iqHtlQhj548AERSPAw9w3sLOSabNxfqEi942TVr
         ozrpBLJJUNlmC7lXA7D4X1cprXBka5Yiz6pRy4+wS39R2EH9PC8hYmb2K5vEc+6gN6AQ
         wBLg==
X-Gm-Message-State: AOAM531u5qyQE2ffSZp5Vfo8dFRe7odIuNiykmaa8enM3hzQ4ZbMoYtC
        j06uGuETgaI3ViDJPN87ZGQ=
X-Google-Smtp-Source: ABdhPJzn2WBeI+9e6UMooihx3lJshAQ6hxiV/ubr3YTZswhh59uGo5pknPlopUPOlZpRpWoJI2avfQ==
X-Received: by 2002:a17:90a:a611:: with SMTP id c17mr10388845pjq.53.1619939114598;
        Sun, 02 May 2021 00:05:14 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:14 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/amd: Do not sync on page size changes
Date:   Sat,  1 May 2021 23:59:59 -0700
Message-Id: <20210502070001.1559127-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502070001.1559127-1-namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Some IOMMU architectures perform invalidations regardless of the page
size. In such architectures there is no need to sync when the page size
changes or to regard pgsize when making interim flush in
iommu_iotlb_gather_add_page().

Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
whether gather's pgsize is tracked and triggers a flush.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 1 +
 include/linux/iommu.h     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b8cabbbeed71..1849b53f2149 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2215,6 +2215,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.ignore_gather_pgsize = true,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_sync = amd_iommu_iotlb_sync,
 	.def_domain_type = amd_iommu_def_domain_type,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..1fb2695418e9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -284,6 +284,7 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 
 	unsigned long pgsize_bitmap;
+	bool ignore_gather_pgsize;
 	struct module *owner;
 };
 
@@ -508,7 +509,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
+	if ((gather->pgsize != size && !domain->ops->ignore_gather_pgsize) ||
 	    end + 1 < gather->start || start > gather->end + 1) {
 		if (gather->pgsize)
 			iommu_iotlb_sync(domain, gather);
-- 
2.25.1

