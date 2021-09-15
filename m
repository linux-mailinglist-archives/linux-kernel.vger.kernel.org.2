Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBC40C4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhIOMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:02:09 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56051 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232793AbhIOMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:02:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yaohongbo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UoUEEjp_1631707246;
Received: from localhost(mailfrom:yaohongbo@linux.alibaba.com fp:SMTPD_---0UoUEEjp_1631707246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 20:00:46 +0800
From:   Yao Hongbo <yaohongbo@linux.alibaba.com>
To:     yaohongbo@linux.alibaba.com
Cc:     zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ACPI/IORT: Add 'smmu=off' command line option
Date:   Wed, 15 Sep 2021 20:00:46 +0800
Message-Id: <20210915120046.62936-1-yaohongbo@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic command line option to disable arm smmu drivers.
iommu.passthrough can only bypass the IOMMU for DMA, but
sometimes we need to ignore all available SMMUs.

This patch is only used for acpi on arm64.

Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/acpi/arm64/iort.c                       | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f..6cffd91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5198,6 +5198,10 @@
 	smart2=		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
 
+	smmu=           [ARM64]
+			Format: {off}
+			off: Disable arm smmu driver.
+
 	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
 	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
 	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3b23fb7..70f92e7 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -40,6 +40,22 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+static bool acpi_smmu_disabled;
+
+static int __init acpi_smmu_parse(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strncmp(str, "off", 3)) {
+		acpi_smmu_disabled = true;
+		pr_info("SMMU disabled\n");
+	}
+
+	return 0;
+}
+__setup("smmu=", acpi_smmu_parse);
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -1596,7 +1612,7 @@ static void __init iort_init_platform_devices(void)
 		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
-		if (ops) {
+		if (ops && !acpi_smmu_disabled) {
 			fwnode = acpi_alloc_fwnode_static();
 			if (!fwnode)
 				return;
-- 
1.8.3.1

