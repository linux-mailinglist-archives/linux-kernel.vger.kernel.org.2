Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F93C5B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbhGLLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:21:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3382 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbhGLLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:19:44 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNgxC5LVBz6G8qL;
        Mon, 12 Jul 2021 19:08:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 13:16:55 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:16:51 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>,
        <dianders@chromium.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v15 1/6] iommu: Deprecate Intel and AMD cmdline methods to enable strict mode
Date:   Mon, 12 Jul 2021 19:12:15 +0800
Message-ID: <1626088340-5838-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
References: <1626088340-5838-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the x86 drivers support iommu.strict, deprecate the custom
methods.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 ++-------
 drivers/iommu/amd/init.c                        | 4 +++-
 drivers/iommu/intel/iommu.c                     | 1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb22006f713..a04d2748c99a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -290,10 +290,7 @@
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
-			fullflush - enable flushing of IO/TLB entries when
-				    they are unmapped. Otherwise they are
-				    flushed before they will be reused, which
-				    is a lot of faster
+			fullflush - Deprecated, equivalent to iommu.strict=1
 			off	  - do not initialize any AMD IOMMU found in
 				    the system
 			force_isolation - Force device isolation for all
@@ -1944,9 +1941,7 @@
 			this case, gfx device will use physical address for
 			DMA.
 		strict [Default Off]
-			With this option on every unmap_single operation will
-			result in a hardware IOTLB flush operation as opposed
-			to batching them for performance.
+			Deprecated, equivalent to iommu.strict=1.
 		sp_off [Default Off]
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..3a2fb805f11e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
 static int __init parse_amd_iommu_options(char *str)
 {
 	for (; *str; ++str) {
-		if (strncmp(str, "fullflush", 9) == 0)
+		if (strncmp(str, "fullflush", 9) == 0) {
+			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
 			amd_iommu_unmap_flush = true;
+		}
 		if (strncmp(str, "force_enable", 12) == 0)
 			amd_iommu_force_enable = true;
 		if (strncmp(str, "off", 3) == 0)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a6a07d985709..67c52b60f8de 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
 			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
 			iommu_dma_forcedac = true;
 		} else if (!strncmp(str, "strict", 6)) {
+			pr_warn("intel_iommu=strict deprecated; use iommu.strict=1 instead\n");
 			pr_info("Disable batched IOTLB flush\n");
 			intel_iommu_strict = 1;
 		} else if (!strncmp(str, "sp_off", 6)) {
-- 
2.26.2

