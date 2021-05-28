Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DE39437F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhE1NoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:44:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3107 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhE1Nn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:43:59 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fs5CV18f1z6P3GH;
        Fri, 28 May 2021 21:30:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 15:42:23 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 14:42:20 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] iommu: Print default strict or lazy mode at init time
Date:   Fri, 28 May 2021 21:37:54 +0800
Message-ID: <1622209074-37899-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As well as the default domain type, it's useful to know whether strict
or lazy mode is default for DMA domains, so add this info in a separate
print.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..f25fae62f077 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -138,6 +138,11 @@ static int __init iommu_subsys_init(void)
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
 			"(set via kernel command line)" : "");
 
+	pr_info("Default DMA domain mode: %s %s\n",
+		iommu_dma_strict ? "strict" : "lazy",
+		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
+			"(set via kernel command line)" : "");
+
 	return 0;
 }
 subsys_initcall(iommu_subsys_init);
-- 
2.26.2

