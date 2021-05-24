Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1386D38FA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhEYGMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhEYGMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:12:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7873C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so12604734pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
        b=QgBp8x8FA2KPnES/dXAn7UcCsCOFA05H9EKrKDO48k6YYBUAhh07XYM9uYgjpSP//s
         wjwVjOuQhIZOhQEECLcGg8hM8x+tMr0DhXvrv5JX8aKFXsjnPjpkcv4A2+6/39D+JqYl
         yj1Dr3DlNH5pqAVISRx7Q3riYVQKMkhHsNkGwMBNAMBIEMyO7VSDyXBv45RvG8FvFEUM
         QJcXdStU7Sj+E3O4JNeMoKi649ar/p8H8qDeGIhvzpyAU8557NGj2Ny3YEXafUcmU7sP
         /gVg9F81tv19dJtui3KYYQdnwvAe/jUiVUViABHrxt5r7+NzvmCP1gwfe9V2ceyQoIrf
         6q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5X0JTQzlcxqdyb4573dS6/kX2Ui7vOskaKMybRf6Z5M=;
        b=Q330EDEDR9HC2rtxVcVyEeIyQEGeAbL4FdG1IxEzTk1eDPrDitlu9in8YuXsfaznoC
         e+Lm+XlXVweEdxlVY7GG6wE7ikbWvy652ng9tt38Xn3nLp77drJIrVC6iSvKqVH1r7HV
         JU9eqxEmEvIpmtam1rO+zBLeqZu6xuQitPvnQf1lgZh7IO3s9DhLZmecTtrVnbETwoUg
         1pEIYzE3Vg5DdrqHOSiQuMEYNihcxI/BJExQatcNlZmo7uKrRPxefMXUrNA6QONGnvIm
         LnblMfpZBdT4ZpJaFVZ+XKlc0yttRImD1hG0hNOba2/8BqA8Tds4bplzyUBgwKO+4R1u
         gm6w==
X-Gm-Message-State: AOAM530b+cYoyjkHlhmZ7RXa/picRrHkqj0NkyVm3lShGLHpc8nS0jGU
        BFMpTdhrPNf6z4diVhKcZXgQ5K9BfA8iuw==
X-Google-Smtp-Source: ABdhPJwhUvJIWH0mcgvnZ+wLhlOua8AfWHv+OxZnzNEVOB4+EUASL4Y1XAHQzwLi8Mqxf+5g9X+giA==
X-Received: by 2002:a17:902:d643:b029:ef:62cd:eeed with SMTP id y3-20020a170902d643b02900ef62cdeeedmr29296314plh.42.1621923078362;
        Mon, 24 May 2021 23:11:18 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:11:17 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iommu/amd: Do not sync on page size changes
Date:   Mon, 24 May 2021 15:41:58 -0700
Message-Id: <20210524224159.32807-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
References: <20210524224159.32807-1-namit@vmware.com>
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

