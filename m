Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B09334255
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhCJQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:01:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:32101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232799AbhCJQBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:01:03 -0500
IronPort-SDR: UQE4x0+jvl/5FAa6ICma2M5aZzxWCPnJcGteYhm7WyAq6LzAoPOhXIzlWud1tmtVOwE805Xk6t
 q5FiYdN6rCBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167770820"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="167770820"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:00:56 -0800
IronPort-SDR: ClR3runuJVzNzaumeX9DdnDLHiI1RRXbX1xPwM29YFX1WziHfRsxoMm2aVokRJTML4dZLZV3hl
 OLMsCvzZEwPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="588877364"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 08:00:52 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 2/4] mfd: intel-m10-bmc: Simplify the legacy version reg definition
Date:   Wed, 10 Mar 2021 23:55:46 +0800
Message-Id: <1615391748-1733-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
References: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version register is the only one in the legacy I/O space to be
accessed, so it is not necessary to define the legacy base & version
register offset. A direct definition of the legacy version register
address would be fine.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3: no change, rebased to 5.12-rc1
v4: improve the comments for valid version check.
---
 drivers/mfd/intel-m10-bmc.c       | 17 +++++++----------
 include/linux/mfd/intel-m10-bmc.h |  2 +-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 06c9775..90d0448 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -116,17 +116,14 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
 	int ret;
 
 	/*
-	 * This check is to filter out the very old legacy BMC versions,
-	 * M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio
-	 * registers. In the old BMC chips, the BMC version info is stored
-	 * in this old version register (M10BMC_LEGACY_SYS_BASE +
-	 * M10BMC_BUILD_VER), so its read out value would have not been
-	 * LEGACY_INVALID (0xffffffff). But in new BMC chips that the
-	 * driver supports, the value of this register should be
-	 * LEGACY_INVALID.
+	 * This check is to filter out the very old legacy BMC versions. In the
+	 * old BMC chips, the BMC version info is stored in the old version
+	 * register (M10BMC_LEGACY_BUILD_VER), so its read out value would have
+	 * not been M10BMC_VER_LEGACY_INVALID (0xffffffff). But in new BMC
+	 * chips that the driver supports, the value of this register should be
+	 * M10BMC_VER_LEGACY_INVALID.
 	 */
-	ret = m10bmc_raw_read(ddata,
-			      M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER, &v);
+	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
 	if (ret)
 		return -ENODEV;
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 9b54ca1..4f1071f 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -9,7 +9,7 @@
 
 #include <linux/regmap.h>
 
-#define M10BMC_LEGACY_SYS_BASE		0x300400
+#define M10BMC_LEGACY_BUILD_VER		0x300468
 #define M10BMC_SYS_BASE			0x300800
 #define M10BMC_MEM_END			0x1fffffff
 
-- 
2.7.4

