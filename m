Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0863E90A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhHKMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:41 -0400
Received: from foss.arm.com ([217.140.110.172]:49080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237858AbhHKMXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0855139F;
        Wed, 11 Aug 2021 05:22:37 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACE8D3F718;
        Wed, 11 Aug 2021 05:22:35 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v4 23/24] iommu: Merge strictness and domain type configs
Date:   Wed, 11 Aug 2021 13:21:37 +0100
Message-Id: <d04af35b9c0f2a1d39605d7a9b451f5e1f0c7736.1628682049.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To parallel the sysfs behaviour, merge the new build-time option
for DMA domain strictness into the default domain type choice.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

v3: Remember to update parameter documentation as well
---
 .../admin-guide/kernel-parameters.txt         |  8 +-
 drivers/iommu/Kconfig                         | 80 +++++++++----------
 drivers/iommu/iommu.c                         |  2 +-
 3 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 90b525cf0ec2..19192b39952a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2045,11 +2045,9 @@
 			1 - Strict mode.
 			  DMA unmap operations invalidate IOMMU hardware TLBs
 			  synchronously.
-			unset - Use value of CONFIG_IOMMU_DEFAULT_{LAZY,STRICT}.
-			Note: on x86, the default behaviour depends on the
-			equivalent driver-specific parameters, but a strict
-			mode explicitly specified by either method takes
-			precedence.
+			unset - Use value of CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT}.
+			Note: on x86, strict mode specified via one of the
+			legacy driver-specific options takes precedence.
 
 	iommu.passthrough=
 			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c84da8205be7..6e06f876d75a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -79,55 +79,55 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
-config IOMMU_DEFAULT_PASSTHROUGH
-	bool "IOMMU passthrough by default"
-	depends on IOMMU_API
-	help
-	  Enable passthrough by default, removing the need to pass in
-	  iommu.passthrough=on or iommu=pt through command line. If this
-	  is enabled, you can still disable with iommu.passthrough=off
-	  or iommu=nopt depending on the architecture.
-
-	  If unsure, say N here.
-
 choice
-	prompt "IOMMU default DMA IOTLB invalidation mode"
-	depends on IOMMU_DMA
-
-	default IOMMU_DEFAULT_LAZY if (AMD_IOMMU || INTEL_IOMMU)
-	default IOMMU_DEFAULT_STRICT
+	prompt "IOMMU default domain type"
+	depends on IOMMU_API
+	default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
+	default IOMMU_DEFAULT_DMA_STRICT
 	help
-	  This option allows an IOMMU DMA IOTLB invalidation mode to be
-	  chosen at build time, to override the default mode of each ARCH,
-	  removing the need to pass in kernel parameters through command line.
-	  It is still possible to provide common boot params to override this
-	  config.
+	  Choose the type of IOMMU domain used to manage DMA API usage by
+	  device drivers. The options here typically represent different
+	  levels of tradeoff between robustness/security and performance,
+	  depending on the IOMMU driver. Not all IOMMUs support all options.
+	  This choice can be overridden at boot via the command line, and for
+	  some devices also at runtime via sysfs.
 
 	  If unsure, keep the default.
 
-config IOMMU_DEFAULT_STRICT
-	bool "strict"
+config IOMMU_DEFAULT_DMA_STRICT
+	bool "Translated - Strict"
 	help
-	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
-	  the free operation of IOVA are guaranteed to be done in the unmap
-	  function.
+	  Trusted devices use translation to restrict their access to only
+	  DMA-mapped pages, with strict TLB invalidation on unmap. Equivalent
+	  to passing "iommu.passthrough=0 iommu.strict=1" on the command line.
 
-config IOMMU_DEFAULT_LAZY
-	bool "lazy"
+	  Untrusted devices always use this mode, with an additional layer of
+	  bounce-buffering such that they cannot gain access to any unrelated
+	  data within a mapped page.
+
+config IOMMU_DEFAULT_DMA_LAZY
+	bool "Translated - Lazy"
 	help
-	  Support lazy mode, where for every IOMMU DMA unmap operation, the
-	  flush operation of IOTLB and the free operation of IOVA are deferred.
-	  They are only guaranteed to be done before the related IOVA will be
-	  reused.
+	  Trusted devices use translation to restrict their access to only
+	  DMA-mapped pages, but with "lazy" batched TLB invalidation. This
+	  mode allows higher performance with some IOMMUs due to reduced TLB
+	  flushing, but at the cost of reduced isolation since devices may be
+	  able to access memory for some time after it has been unmapped.
+	  Equivalent to passing "iommu.passthrough=0 iommu.strict=0" on the
+	  command line.
 
-	  The isolation provided in this mode is not as secure as STRICT mode,
-	  such that a vulnerable time window may be created between the DMA
-	  unmap and the mappings cached in the IOMMU IOTLB or device TLB
-	  finally being invalidated, where the device could still access the
-	  memory which has already been unmapped by the device driver.
-	  However this mode may provide better performance in high throughput
-	  scenarios, and is still considerably more secure than passthrough
-	  mode or no IOMMU.
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
 
 endchoice
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63face36fc49..480ad6a538a9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -31,7 +31,7 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
+static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
-- 
2.25.1

