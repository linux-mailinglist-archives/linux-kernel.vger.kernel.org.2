Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E1739F7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhFHNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:24:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3177 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhFHNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:24:50 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzrKG0ljGz6H6xs;
        Tue,  8 Jun 2021 21:13:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:22:56 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:22:52 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <rdunlap@infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v11 1/3] iommu: Enhance IOMMU default DMA mode build options
Date:   Tue, 8 Jun 2021 21:18:26 +0800
Message-ID: <1623158308-180604-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
opportunity to set {lazy|strict} mode as default at build time. Then put
the two config options in a choice, as they are mutually exclusive.

[jpg: Make choice between strict and lazy only (and not passthrough)]
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/Kconfig | 35 +++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c |  3 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f111b399bca..369a3af9e5bf 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -90,6 +90,41 @@ config IOMMU_DEFAULT_PASSTHROUGH
 
 	  If unsure, say N here.
 
+choice
+	prompt "IOMMU default DMA mode"
+	depends on IOMMU_API
+	depends on X86 || IA64 || X86_64 || ARM || ARM64
+
+	default IOMMU_DEFAULT_STRICT
+	help
+	  This option allows an IOMMU DMA mode to be chosen at build time, to
+	  override the default DMA mode of each ARCH, removing the need to
+	  pass in kernel parameters through command line. It is still possible
+	  to provide ARCH-specific or common boot options to override this
+	  option.
+
+	  If unsure, keep the default.
+
+config IOMMU_DEFAULT_LAZY
+	bool "lazy"
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused.
+
+config IOMMU_DEFAULT_STRICT
+	bool "strict"
+	help
+	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
+	  the free operation of IOVA are guaranteed to be done in the unmap
+	  function.
+
+	  This mode is safer than lazy mode, but it may be slower in some high
+	  performance scenarios.
+
+endchoice
+
 config OF_IOMMU
 	def_bool y
 	depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 966426a96520..177b0dafc535 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = true;
+static bool iommu_dma_strict __read_mostly =
+			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
-- 
2.26.2

