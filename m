Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAD3D1645
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhGURlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:41:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238550AbhGURko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26BD712FC;
        Wed, 21 Jul 2021 11:21:20 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A81CB3F694;
        Wed, 21 Jul 2021 11:21:18 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 20/23] iommu: Allow choosing DMA strictness at build time
Date:   Wed, 21 Jul 2021 19:20:31 +0100
Message-Id: <002cd8280cc4935e294d79bef838fbfb633bb3ed.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To parallel the sysfs behaviour, extend the build-time configuration
for default domains to include the new type as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

This effectively replaces patch #3 of John's "iommu: Enhance IOMMU
default DMA mode build options" series.
---
 drivers/iommu/Kconfig | 48 +++++++++++++++++++++++++++++++++++--------
 drivers/iommu/iommu.c |  2 +-
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 07b7c25cbed8..e3f7990046ae 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -79,16 +79,48 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
-config IOMMU_DEFAULT_PASSTHROUGH
-	bool "IOMMU passthrough by default"
+choice
+	prompt "Default IOMMU domain type"
 	depends on IOMMU_API
-	help
-	  Enable passthrough by default, removing the need to pass in
-	  iommu.passthrough=on or iommu=pt through command line. If this
-	  is enabled, you can still disable with iommu.passthrough=off
-	  or iommu=nopt depending on the architecture.
+	default IOMMU_DEFAULT_DMA_LAZY if INTEL_IOMMU || AMD_IOMMU
+	default IOMMU_DEFAULT_DMA_STRICT
 
-	  If unsure, say N here.
+config IOMMU_DEFAULT_DMA_STRICT
+	bool "Translated - Strict"
+	help
+	  Trusted devices use translation to restrict their access to only
+	  DMA-mapped pages, with strict TLB invalidation on unmap. Equivalent
+	  to passing "iommu.passthrough=0 iommu.strict=1" on the command line.
+
+	  Untrusted devices always use this mode, with an additional layer of
+	  bounce-buffering such that they cannot gain access to any unrelated
+	  data within a mapped page.
+
+config IOMMU_DEFAULT_DMA_LAZY
+	bool "Translated - Lazy"
+	help
+	  Trusted devices use translation to restrict their access to only
+	  DMA-mapped pages, but with "lazy" batched TLB invalidation. This
+	  mode allows higher performance with some IOMMUs due to reduced TLB
+	  flushing, but at the cost of reduced isolation since devices may be
+	  able to access memory for some time after it has been unmapped.
+	  Equivalent to passing "iommu.passthrough=0 iommu.strict=0" on the
+	  command line.
+
+	  If this mode is not supported by the IOMMU driver, the effective
+	  runtime default will fall back to IOMMU_DEFAULT_DMA_STRICT.
+
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "Passthrough"
+	help
+	  Trusted devices are identity-mapped, giving them unrestricted access
+	  to memory with minimal performance overhead. Equivalent to passing
+	  "iommu.passthrough=1" (historically "iommu=pt") on the command line.
+
+	  If this mode is not supported by the IOMMU driver, the effective
+	  runtime default will fall back to IOMMU_DEFAULT_DMA_STRICT.
+
+endchoice
 
 config OF_IOMMU
 	def_bool y
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d3b562a33ac4..4fad6d427d9d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -30,7 +30,7 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = true;
+static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
-- 
2.25.1

