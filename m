Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C43A98D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhFPLK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:10:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3244 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhFPLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:10:50 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4htF2Kgpz6JBBm;
        Wed, 16 Jun 2021 18:55:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 13:08:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 12:08:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v13 1/6] iommu: Deprecate Intel and AMD cmdline methods to enable strict mode
Date:   Wed, 16 Jun 2021 19:03:52 +0800
Message-ID: <1623841437-211832-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the x86 drivers support iommu.strict, deprecate the custom
methods.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 drivers/iommu/amd/init.c                        | 4 +++-
 drivers/iommu/intel/iommu.c                     | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 30e9dd52464e..fcbb36d6eea7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -290,7 +290,8 @@
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
-			fullflush - enable flushing of IO/TLB entries when
+			fullflush   [Deprecated, use iommu.strict instead]
+				  - enable flushing of IO/TLB entries when
 				    they are unmapped. Otherwise they are
 				    flushed before they will be reused, which
 				    is a lot of faster
@@ -1947,7 +1948,7 @@
 			bypassed by not enabling DMAR with this option. In
 			this case, gfx device will use physical address for
 			DMA.
-		strict [Default Off]
+		strict [Default Off] [Deprecated, use iommu.strict instead]
 			With this option on every unmap_single operation will
 			result in a hardware IOTLB flush operation as opposed
 			to batching them for performance.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 46280e6e1535..9f3096d650aa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3098,8 +3098,10 @@ static int __init parse_amd_iommu_intr(char *str)
 static int __init parse_amd_iommu_options(char *str)
 {
 	for (; *str; ++str) {
-		if (strncmp(str, "fullflush", 9) == 0)
+		if (strncmp(str, "fullflush", 9) == 0) {
+			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");
 			amd_iommu_unmap_flush = true;
+		}
 		if (strncmp(str, "force_enable", 12) == 0)
 			amd_iommu_force_enable = true;
 		if (strncmp(str, "off", 3) == 0)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bd93c7ec879e..821d8227a4e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -454,6 +454,7 @@ static int __init intel_iommu_setup(char *str)
 			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
 			iommu_dma_forcedac = true;
 		} else if (!strncmp(str, "strict", 6)) {
+			pr_warn("intel_iommu=strict deprecated; use iommu.strict instead\n");
 			pr_info("Disable batched IOTLB flush\n");
 			intel_iommu_strict = 1;
 		} else if (!strncmp(str, "sp_off", 6)) {
-- 
2.26.2

