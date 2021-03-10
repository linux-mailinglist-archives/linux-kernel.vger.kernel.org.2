Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2986334256
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhCJQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:01:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:32101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhCJQBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:01:05 -0500
IronPort-SDR: L248e8oKzi1L4CQmw61Gz1WB9J+jABcpi6AxjgIsT9+tpW7r7zdBDvGVDK59Z0thjoE05anAkF
 5I5Te+/CsbKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167770838"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="167770838"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:01:00 -0800
IronPort-SDR: 7dmDcXSc4bRTCKhlunrYeVM8/XaSL+B97baCvjohPz6wwBSEXOX9Evcly6YI1K1CJkdwsmVElo
 wL5WiJfFA0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="588877412"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2021 08:00:56 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 3/4] mfd: intel-m10-bmc: Add access table configuration to the regmap
Date:   Wed, 10 Mar 2021 23:55:47 +0800
Message-Id: <1615391748-1733-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
References: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch adds access tables to the MAX 10 BMC regmap. This prevents
the host from accessing the unwanted I/O space. It also filters out the
invalid outputs when reading the regmap debugfs interface.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: Use the new macro M10BMC_LEGACY_BUILD_VER
v3: No change, rebased to 5.12-rc1
v4: Add Lee's Acked-by, no other change
---
 drivers/mfd/intel-m10-bmc.c       | 13 +++++++++++++
 include/linux/mfd/intel-m10-bmc.h |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 90d0448..1161933 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -23,10 +23,23 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-secure" },
 };
 
+static const struct regmap_range m10bmc_regmap_range[] = {
+	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
+	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
+	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
+};
+
+static const struct regmap_access_table m10bmc_access_table = {
+	.yes_ranges	= m10bmc_regmap_range,
+	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
+};
+
 static struct regmap_config intel_m10bmc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
+	.wr_table = &m10bmc_access_table,
+	.rd_table = &m10bmc_access_table,
 	.max_register = M10BMC_MEM_END,
 };
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 4f1071f..c4eb38c 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,7 +11,10 @@
 
 #define M10BMC_LEGACY_BUILD_VER		0x300468
 #define M10BMC_SYS_BASE			0x300800
-#define M10BMC_MEM_END			0x1fffffff
+#define M10BMC_SYS_END			0x300fff
+#define M10BMC_FLASH_BASE		0x10000000
+#define M10BMC_FLASH_END		0x1fffffff
+#define M10BMC_MEM_END			M10BMC_FLASH_END
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
-- 
2.7.4

