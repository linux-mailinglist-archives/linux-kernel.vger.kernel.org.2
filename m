Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A673A41F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhFKM21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:28:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3213 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhFKM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:28:23 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1frV2X34z6J9Z4;
        Fri, 11 Jun 2021 20:13:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:26:21 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 13:26:18 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v12 1/5] iommu: Print strict or lazy mode at init time
Date:   Fri, 11 Jun 2021 20:20:39 +0800
Message-ID: <1623414043-40745-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As well as the default domain type, it's useful to know whether strict
or lazy for DMA domains, so add this info in a separate print.

The (stict/lazy) mode may be also set via iommu.strict earlyparm, but
this will be processed prior to iommu_subsys_init(), so that print will be
accurate for drivers which don't set the mode via custom means.

For the drivers which do set the mode via custom means - the AMD and Intel
drivers - they still maintain prints to notify the change in policy.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..cf58949cc2f3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -138,6 +138,11 @@ static int __init iommu_subsys_init(void)
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
 			"(set via kernel command line)" : "");
 
+	pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
+		iommu_dma_strict ? "strict" : "lazy",
+		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
+			"(set via kernel command line)" : "");
+
 	return 0;
 }
 subsys_initcall(iommu_subsys_init);
-- 
2.26.2

