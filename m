Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1E39431D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhE1NCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:02:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5134 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbhE1NCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:02:20 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fs4VM2RNLzYmqd;
        Fri, 28 May 2021 20:58:03 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 21:00:43 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 21:00:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iommu/amd: use DEVICE_ATTR_RO macro
Date:   Fri, 28 May 2021 20:59:51 +0800
Message-ID: <20210528125951.9268-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/amd/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..4ffb694bd297 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1731,23 +1731,21 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	return;
 }
 
-static ssize_t amd_iommu_show_cap(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+static ssize_t cap_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
 	return sprintf(buf, "%x\n", iommu->cap);
 }
-static DEVICE_ATTR(cap, S_IRUGO, amd_iommu_show_cap, NULL);
+static DEVICE_ATTR_RO(cap);
 
-static ssize_t amd_iommu_show_features(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
+static ssize_t features_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->features);
 }
-static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
+static DEVICE_ATTR_RO(features);
 
 static struct attribute *amd_iommu_attrs[] = {
 	&dev_attr_cap.attr,
-- 
2.17.1

