Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECB370AA4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhEBHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhEBHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C53C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h7so1187186plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkBwgwXs+4jvJxjQud3WrSBilsdtFonBHCFrnhB3HGo=;
        b=GsZkw0z4oL6vGd0oEaLLS9wU7WtNKvQxU4C9agSNsQPRrkTI4UONrk6q1mc10WGag0
         hlCvZ/+yn1OJKYF0Z85/l7/OXE16U67OF33sNfRnarWZwStLreY3yPis1vpH/ZCKb0dg
         ZYptl4CsCUW+FDkRZTISNmpDoHd/+o95Eqfl/5vDAmYynB70oNshRlaiYCTMs203nchg
         odmIb7YFQeW1KmfutT0h4WVb30hbrAAEZCYWmUaWRP3XxeSBjqi7GSZtYlUZ3I7kJWgH
         /DVE3EnGKBgmpR0XTXgacv4C0NKrGkq2KvTrgEtu5nLe+y/NdXgOkbYKeMJJCS8B+mI8
         CfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkBwgwXs+4jvJxjQud3WrSBilsdtFonBHCFrnhB3HGo=;
        b=Cpenh9xCZVxH78i1efvmqO67gWSiNCInFsfu4kanDdjrsyIJRvZWm0/gbfS5gOO8Dj
         B9e9E53jbDqiGOwOT2rnAZ2WJtq2M4HkvRlTVh+7BgSA3gkRwxHE+qNKuTHuE693hu+0
         MRKKU6hA0Q5COHHi3ThBVqB7FLMrO1FTJ31m0qvLIR6eQItITIxGJ1wAlXlEYz4SgKmH
         cWsf28nT4ecCOjoYllFyA0Kxy7bLQ+NFaxVkwqNuxnZr92ur87vBGEApOzWABxClvUYg
         E68DvE+ksPJ1wegbFlzASzDNUr0trx+SZc6wND50XNWVsc/RSCMI3IafF4MheCrT3RfW
         6mkQ==
X-Gm-Message-State: AOAM532GoXb3uWH3WFaRkmke0BcvbIuZVPsHBTRWJuZbpEb+26+3D5Cb
        9KwXRoPlFGCTL2oWwK4w11FASTWGxKzMYA==
X-Google-Smtp-Source: ABdhPJxj+vmr2G9NHQBUOYaj0xUU1m5zqVf+s++g/nVi+l8GFvpPUZYqy7JIO0Hfoc3IvS5E7j0DUw==
X-Received: by 2002:a17:90a:4482:: with SMTP id t2mr14687194pjg.141.1619939111881;
        Sun, 02 May 2021 00:05:11 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:11 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/amd: Do not sync on page size changes
Date:   Sat,  1 May 2021 23:59:57 -0700
Message-Id: <20210502070001.1559127-3-namit@vmware.com>
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
changes. In such architecture, there is no need to regard pgsize when
making interim flush in iommu_iotlb_gather_add_page().

Add a "no_sync_on_pgsize_change" property for each IOMMU ops to decide
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
index 6723cbcf4030..8a71ad477c34 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2204,6 +2204,7 @@ const struct iommu_ops amd_iommu_ops = {
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

