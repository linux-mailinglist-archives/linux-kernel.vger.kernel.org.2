Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54441394327
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE1NE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:04:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2453 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhE1NE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:04:27 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fs4XY0Kj8z66qQ;
        Fri, 28 May 2021 20:59:57 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 21:02:47 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 21:02:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iommu/vt-d: use DEVICE_ATTR_RO macro
Date:   Fri, 28 May 2021 21:02:29 +0800
Message-ID: <20210528130229.22108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/intel/iommu.c | 42 ++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..0638ea8f6f7d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4138,62 +4138,56 @@ static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
 	return container_of(iommu_dev, struct intel_iommu, iommu);
 }
 
-static ssize_t intel_iommu_show_version(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static ssize_t version_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	u32 ver = readl(iommu->reg + DMAR_VER_REG);
 	return sprintf(buf, "%d:%d\n",
 		       DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver));
 }
-static DEVICE_ATTR(version, S_IRUGO, intel_iommu_show_version, NULL);
+static DEVICE_ATTR_RO(version);
 
-static ssize_t intel_iommu_show_address(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static ssize_t address_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->reg_phys);
 }
-static DEVICE_ATTR(address, S_IRUGO, intel_iommu_show_address, NULL);
+static DEVICE_ATTR_RO(address);
 
-static ssize_t intel_iommu_show_cap(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t cap_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->cap);
 }
-static DEVICE_ATTR(cap, S_IRUGO, intel_iommu_show_cap, NULL);
+static DEVICE_ATTR_RO(cap);
 
-static ssize_t intel_iommu_show_ecap(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
+static ssize_t ecap_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->ecap);
 }
-static DEVICE_ATTR(ecap, S_IRUGO, intel_iommu_show_ecap, NULL);
+static DEVICE_ATTR_RO(ecap);
 
-static ssize_t intel_iommu_show_ndoms(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+static ssize_t domains_supported_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%ld\n", cap_ndoms(iommu->cap));
 }
-static DEVICE_ATTR(domains_supported, S_IRUGO, intel_iommu_show_ndoms, NULL);
+static DEVICE_ATTR_RO(domains_supported);
 
-static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t domains_used_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%d\n", bitmap_weight(iommu->domain_ids,
 						  cap_ndoms(iommu->cap)));
 }
-static DEVICE_ATTR(domains_used, S_IRUGO, intel_iommu_show_ndoms_used, NULL);
+static DEVICE_ATTR_RO(domains_used);
 
 static struct attribute *intel_iommu_attrs[] = {
 	&dev_attr_version.attr,
-- 
2.17.1

