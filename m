Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB493D39CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhGWLOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:14:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:17835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhGWLOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:14:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211921786"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="211921786"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455069758"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:02 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 1/6] soundwire: move intel sdw register definitions to sdw_intel.h
Date:   Fri, 23 Jul 2021 19:54:46 +0800
Message-Id: <20210723115451.7245-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those Intel sdw registers will be used by ASoC SOF drivers in the
following commits. So move those definitions to sdw_intel.h and it can
be visible to SOF drivers.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel.c           | 74 ---------------------------
 drivers/soundwire/intel_init.c      |  6 ---
 include/linux/soundwire/sdw_intel.h | 79 +++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 80 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c11e3d8cd308..15668d6fecd6 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -40,80 +40,6 @@ static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
 MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
 
-/* Intel SHIM Registers Definition */
-#define SDW_SHIM_LCAP			0x0
-#define SDW_SHIM_LCTL			0x4
-#define SDW_SHIM_IPPTR			0x8
-#define SDW_SHIM_SYNC			0xC
-
-#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
-#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * (x))
-#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * (x))
-#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * (x))
-#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * (x))
-#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * (x))
-
-#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
-#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
-#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * (x))
-#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
-#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
-
-#define SDW_SHIM_WAKEEN			0x190
-#define SDW_SHIM_WAKESTS		0x192
-
-#define SDW_SHIM_LCTL_SPA		BIT(0)
-#define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
-#define SDW_SHIM_LCTL_CPA		BIT(8)
-#define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
-
-#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
-#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
-#define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
-#define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
-#define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
-#define SDW_SHIM_SYNC_CMDSYNC		BIT(16)
-#define SDW_SHIM_SYNC_SYNCGO		BIT(24)
-
-#define SDW_SHIM_PCMSCAP_ISS		GENMASK(3, 0)
-#define SDW_SHIM_PCMSCAP_OSS		GENMASK(7, 4)
-#define SDW_SHIM_PCMSCAP_BSS		GENMASK(12, 8)
-
-#define SDW_SHIM_PCMSYCM_LCHN		GENMASK(3, 0)
-#define SDW_SHIM_PCMSYCM_HCHN		GENMASK(7, 4)
-#define SDW_SHIM_PCMSYCM_STREAM		GENMASK(13, 8)
-#define SDW_SHIM_PCMSYCM_DIR		BIT(15)
-
-#define SDW_SHIM_PDMSCAP_ISS		GENMASK(3, 0)
-#define SDW_SHIM_PDMSCAP_OSS		GENMASK(7, 4)
-#define SDW_SHIM_PDMSCAP_BSS		GENMASK(12, 8)
-#define SDW_SHIM_PDMSCAP_CPSS		GENMASK(15, 13)
-
-#define SDW_SHIM_IOCTL_MIF		BIT(0)
-#define SDW_SHIM_IOCTL_CO		BIT(1)
-#define SDW_SHIM_IOCTL_COE		BIT(2)
-#define SDW_SHIM_IOCTL_DO		BIT(3)
-#define SDW_SHIM_IOCTL_DOE		BIT(4)
-#define SDW_SHIM_IOCTL_BKE		BIT(5)
-#define SDW_SHIM_IOCTL_WPDD		BIT(6)
-#define SDW_SHIM_IOCTL_CIBD		BIT(8)
-#define SDW_SHIM_IOCTL_DIBD		BIT(9)
-
-#define SDW_SHIM_CTMCTL_DACTQE		BIT(0)
-#define SDW_SHIM_CTMCTL_DODS		BIT(1)
-#define SDW_SHIM_CTMCTL_DOAIS		GENMASK(4, 3)
-
-#define SDW_SHIM_WAKEEN_ENABLE		BIT(0)
-#define SDW_SHIM_WAKESTS_STATUS		BIT(0)
-
-/* Intel ALH Register definitions */
-#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
-#define SDW_ALH_NUM_STREAMS		64
-
-#define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
-#define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
-#define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
-
 enum intel_pdi_type {
 	INTEL_PDI_IN = 0,
 	INTEL_PDI_OUT = 1,
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 9e283bef53d2..03ff69ab1797 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -18,12 +18,6 @@
 #include "cadence_master.h"
 #include "intel.h"
 
-#define SDW_SHIM_LCAP		0x0
-#define SDW_SHIM_BASE		0x2C000
-#define SDW_ALH_BASE		0x2C800
-#define SDW_LINK_BASE		0x30000
-#define SDW_LINK_SIZE		0x10000
-
 static void intel_link_dev_release(struct device *dev)
 {
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 1ebea7764011..7fce6aee0c36 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -7,6 +7,85 @@
 #include <linux/irqreturn.h>
 #include <linux/soundwire/sdw.h>
 
+#define SDW_SHIM_BASE			0x2C000
+#define SDW_ALH_BASE			0x2C800
+#define SDW_LINK_BASE			0x30000
+#define SDW_LINK_SIZE			0x10000
+
+/* Intel SHIM Registers Definition */
+#define SDW_SHIM_LCAP			0x0
+#define SDW_SHIM_LCTL			0x4
+#define SDW_SHIM_IPPTR			0x8
+#define SDW_SHIM_SYNC			0xC
+
+#define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
+#define SDW_SHIM_CTLS0CM(x)		(0x012 + 0x60 * (x))
+#define SDW_SHIM_CTLS1CM(x)		(0x014 + 0x60 * (x))
+#define SDW_SHIM_CTLS2CM(x)		(0x016 + 0x60 * (x))
+#define SDW_SHIM_CTLS3CM(x)		(0x018 + 0x60 * (x))
+#define SDW_SHIM_PCMSCAP(x)		(0x020 + 0x60 * (x))
+
+#define SDW_SHIM_PCMSYCHM(x, y)		(0x022 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PCMSYCHC(x, y)		(0x042 + (0x60 * (x)) + (0x2 * (y)))
+#define SDW_SHIM_PDMSCAP(x)		(0x062 + 0x60 * (x))
+#define SDW_SHIM_IOCTL(x)		(0x06C + 0x60 * (x))
+#define SDW_SHIM_CTMCTL(x)		(0x06E + 0x60 * (x))
+
+#define SDW_SHIM_WAKEEN			0x190
+#define SDW_SHIM_WAKESTS		0x192
+
+#define SDW_SHIM_LCTL_SPA		BIT(0)
+#define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
+#define SDW_SHIM_LCTL_CPA		BIT(8)
+#define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
+
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
+#define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
+#define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
+#define SDW_SHIM_SYNC_CMDSYNC		BIT(16)
+#define SDW_SHIM_SYNC_SYNCGO		BIT(24)
+
+#define SDW_SHIM_PCMSCAP_ISS		GENMASK(3, 0)
+#define SDW_SHIM_PCMSCAP_OSS		GENMASK(7, 4)
+#define SDW_SHIM_PCMSCAP_BSS		GENMASK(12, 8)
+
+#define SDW_SHIM_PCMSYCM_LCHN		GENMASK(3, 0)
+#define SDW_SHIM_PCMSYCM_HCHN		GENMASK(7, 4)
+#define SDW_SHIM_PCMSYCM_STREAM		GENMASK(13, 8)
+#define SDW_SHIM_PCMSYCM_DIR		BIT(15)
+
+#define SDW_SHIM_PDMSCAP_ISS		GENMASK(3, 0)
+#define SDW_SHIM_PDMSCAP_OSS		GENMASK(7, 4)
+#define SDW_SHIM_PDMSCAP_BSS		GENMASK(12, 8)
+#define SDW_SHIM_PDMSCAP_CPSS		GENMASK(15, 13)
+
+#define SDW_SHIM_IOCTL_MIF		BIT(0)
+#define SDW_SHIM_IOCTL_CO		BIT(1)
+#define SDW_SHIM_IOCTL_COE		BIT(2)
+#define SDW_SHIM_IOCTL_DO		BIT(3)
+#define SDW_SHIM_IOCTL_DOE		BIT(4)
+#define SDW_SHIM_IOCTL_BKE		BIT(5)
+#define SDW_SHIM_IOCTL_WPDD		BIT(6)
+#define SDW_SHIM_IOCTL_CIBD		BIT(8)
+#define SDW_SHIM_IOCTL_DIBD		BIT(9)
+
+#define SDW_SHIM_CTMCTL_DACTQE		BIT(0)
+#define SDW_SHIM_CTMCTL_DODS		BIT(1)
+#define SDW_SHIM_CTMCTL_DOAIS		GENMASK(4, 3)
+
+#define SDW_SHIM_WAKEEN_ENABLE		BIT(0)
+#define SDW_SHIM_WAKESTS_STATUS		BIT(0)
+
+/* Intel ALH Register definitions */
+#define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
+#define SDW_ALH_NUM_STREAMS		64
+
+#define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
+#define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
+#define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
+
 /**
  * struct sdw_intel_stream_params_data: configuration passed during
  * the @params_stream callback, e.g. for interaction with DSP
-- 
2.17.1

