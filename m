Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852CC3F7187
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbhHYJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:16:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3689 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbhHYJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:16:33 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GvgKG6n2yz67VXK;
        Wed, 25 Aug 2021 17:14:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 25 Aug 2021 11:15:46 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 25 Aug 2021 10:15:44 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] drivers/perf: Improve build test coverage
Date:   Wed, 25 Aug 2021 17:10:56 +0800
Message-ID: <1629882656-217983-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629882656-217983-1-git-send-email-john.garry@huawei.com>
References: <1629882656-217983-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve build test cover by allowing some drivers to build under
COMPILE_TEST where possible.

Some notes:
- Mostly a dependency on CONFIG_ACPI is not really required for only
  building (but left untouched), but is required for TX2 which uses ACPI
  functions which have no stubs
- XGENE required 64b dependency as it relies on some unsigned long perf
  struct fields being 64b
- I don't see why TX2 requires NUMA to build, but left untouched
- Added an explicit dependency on GENERIC_MSI_IRQ_DOMAIN for
  ARM_SMMU_V3_PMU, which is required for platform MSI functions

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/Kconfig | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 77522e5efe11..4374af292e6d 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -36,7 +36,7 @@ config ARM_CCI5xx_PMU
 
 config ARM_CCN
 	tristate "ARM CCN driver support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  PMU (perf) driver supporting the ARM CCN (Cache Coherent Network)
 	  interconnect.
@@ -62,7 +62,8 @@ config ARM_PMU_ACPI
 
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
-	 depends on ARM64 && ACPI
+	 depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
+	 depends on GENERIC_MSI_IRQ_DOMAIN
 	   help
 	   Provides support for the ARM SMMUv3 Performance Monitor Counter
 	   Groups (PMCG), which provide monitoring of transactions passing
@@ -80,7 +81,7 @@ config ARM_DSU_PMU
 
 config FSL_IMX8_DDR_PMU
 	tristate "Freescale i.MX8 DDR perf monitor"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	  help
 	  Provides support for the DDR performance monitor in i.MX8, which
 	  can give information about memory throughput and other related
@@ -108,7 +109,8 @@ config QCOM_L3_PMU
 
 config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
-	depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
+	depends on ARCH_THUNDER2 || COMPILE_TEST
+	depends on NUMA && ACPI
 	default m
 	help
 	   Provides support for ThunderX2 UNCORE events.
@@ -116,7 +118,7 @@ config THUNDERX2_PMU
 	   in the DDR4 Memory Controller (DMC).
 
 config XGENE_PMU
-        depends on ARCH_XGENE
+        depends on ARCH_XGENE || (COMPILE_TEST && 64BIT)
         bool "APM X-Gene SoC PMU"
         default n
         help
-- 
2.26.2

