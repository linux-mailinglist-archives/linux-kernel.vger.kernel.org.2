Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0210F3A10E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbhFIKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:11:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3920 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbhFIKLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:11:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0N6f2jcQz6wWB;
        Wed,  9 Jun 2021 18:06:18 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 18:09:22 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 18:09:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v2] uacce: add print information if not enable sva
Date:   Wed, 9 Jun 2021 18:09:05 +0800
Message-ID: <1623233345-8765-1-git-send-email-yekai13@huawei.com>
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

changes v1->v2:
	use %pe, ERR_PTR(ret) to descriptive error output
---
 drivers/misc/uacce/uacce.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bae18ef0..488eeb2 100644
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
+		dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
 		return flags;
+	}
 
-	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
+	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
+	if (ret) {
+		dev_err(parent, "failed to enable SVA feature! ret = %pe\n", ERR_PTR(ret));
 		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
 		return flags;
 	}
-- 
2.7.4

