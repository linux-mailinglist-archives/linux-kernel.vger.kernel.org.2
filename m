Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6139B442
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFDHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:48:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4355 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhFDHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:48:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FxF990qr5z68CZ;
        Fri,  4 Jun 2021 15:42:37 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 15:46:22 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 15:46:22 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH] uacce: add print information if not enable sva
Date:   Fri, 4 Jun 2021 15:46:09 +0800
Message-ID: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add print information necessary if user not enable sva.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/misc/uacce/uacce.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bae18ef0..fe38af8 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -387,15 +387,22 @@ static void uacce_release(struct device *dev)
 
 static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
 {
+	int ret;
+
 	if (!(flags & UACCE_DEV_SVA))
 		return flags;
 
 	flags &= ~UACCE_DEV_SVA;
 
-	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
+	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
+	if (ret) {
+		dev_err(parent, "failed to enable IOPF feature! ret = %d\n", ret);
 		return flags;
+	}
 
-	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
+	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
+	if (ret) {
+		dev_err(parent, "failed to enable SVA feature! ret = %d\n", ret);
 		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
 		return flags;
 	}
-- 
2.7.4

