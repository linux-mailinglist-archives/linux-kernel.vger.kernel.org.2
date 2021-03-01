Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2DC32775B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhCAGGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:06:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:53885 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhCAGGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:06:10 -0500
IronPort-SDR: eddvGXfsc3fLUs1UJiP1DJCUNui7ctptMInRhMYGrNVARjf6uL10Q5AwDyF5vBPdHmivxp9Iv8
 /pc7ukRKdSDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="165599705"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="165599705"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 22:04:44 -0800
IronPort-SDR: QYw6yFGFFTE6OuZlaIAPrcGAlrVMnS3Xvl2bM/pQMGL1tEEgIuRDyxjlaCOPLmtei7N3VK/beC
 Zgsqzg32Iyfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="397574208"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2021 22:04:43 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v3 2/4] mfd: intel-m10-bmc: Simplify the legacy version reg definition
Date:   Mon,  1 Mar 2021 13:59:43 +0800
Message-Id: <1614578385-26955-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
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
---
 drivers/mfd/intel-m10-bmc.c       | 12 +++++-------
 include/linux/mfd/intel-m10-bmc.h |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 06c9775..0d2c03f 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -117,16 +117,14 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
 
 	/*
 	 * This check is to filter out the very old legacy BMC versions,
-	 * M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio
-	 * registers. In the old BMC chips, the BMC version info is stored
-	 * in this old version register (M10BMC_LEGACY_SYS_BASE +
-	 * M10BMC_BUILD_VER), so its read out value would have not been
-	 * LEGACY_INVALID (0xffffffff). But in new BMC chips that the
+	 * 0x300400 is the offset to this old block of mmio registers. In the
+	 * old BMC chips, the BMC version info is stored in this old version
+	 * register (0x300400 + 0x68), so its read out value would have not
+	 * been LEGACY_INVALID (0xffffffff). But in new BMC chips that the
 	 * driver supports, the value of this register should be
 	 * LEGACY_INVALID.
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

