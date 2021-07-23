Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB853D39D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhGWLOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:14:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:17835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234774AbhGWLOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:14:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211921829"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="211921829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="455069803"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 04:55:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 6/6] soundwire: intel: introduce shim and alh base
Date:   Fri, 23 Jul 2021 19:54:51 +0800
Message-Id: <20210723115451.7245-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shim base and alh base are platform-dependent. Adding these two
parameters allows us to use different shim/alh base for each
platform.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel_init.c      | 8 +++++---
 include/linux/soundwire/sdw_intel.h | 8 ++++++++
 sound/soc/sof/intel/hda.c           | 2 ++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 03ff69ab1797..e329022e1669 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -63,8 +63,8 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 	link->mmio_base = res->mmio_base;
 	link->registers = res->mmio_base + SDW_LINK_BASE
 		+ (SDW_LINK_SIZE * link_id);
-	link->shim = res->mmio_base + SDW_SHIM_BASE;
-	link->alh = res->mmio_base + SDW_ALH_BASE;
+	link->shim = res->mmio_base + res->shim_base;
+	link->alh = res->mmio_base + res->alh_base;
 
 	link->ops = res->ops;
 	link->dev = res->dev;
@@ -214,6 +214,8 @@ static struct sdw_intel_ctx
 	}
 
 	ctx->mmio_base = res->mmio_base;
+	ctx->shim_base = res->shim_base;
+	ctx->alh_base = res->alh_base;
 	ctx->link_mask = res->link_mask;
 	ctx->handle = res->handle;
 	mutex_init(&ctx->shim_lock);
@@ -302,7 +304,7 @@ sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 		return -EINVAL;
 
 	/* Check SNDWLCAP.LCOUNT */
-	caps = ioread32(ctx->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
+	caps = ioread32(ctx->mmio_base + ctx->shim_base + SDW_SHIM_LCAP);
 	caps &= GENMASK(2, 0);
 
 	/* Check HW supported vs property value */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 7fce6aee0c36..8a463b8fc12a 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -195,6 +195,8 @@ struct sdw_intel_slave_id {
  * @link_list: list to handle interrupts across all links
  * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
  * @shim_mask: flags to track initialization of SHIM shared registers
+ * @shim_base: sdw shim base.
+ * @alh_base: sdw alh base.
  */
 struct sdw_intel_ctx {
 	int count;
@@ -207,6 +209,8 @@ struct sdw_intel_ctx {
 	struct list_head link_list;
 	struct mutex shim_lock; /* lock for access to shared SHIM registers */
 	u32 shim_mask;
+	u32 shim_base;
+	u32 alh_base;
 };
 
 /**
@@ -225,6 +229,8 @@ struct sdw_intel_ctx {
  * machine-specific quirks are handled in the DSP driver.
  * @clock_stop_quirks: mask array of possible behaviors requested by the
  * DSP driver. The quirks are common for all links for now.
+ * @shim_base: sdw shim base.
+ * @alh_base: sdw alh base.
  */
 struct sdw_intel_res {
 	int count;
@@ -236,6 +242,8 @@ struct sdw_intel_res {
 	struct device *dev;
 	u32 link_mask;
 	u32 clock_stop_quirks;
+	u32 shim_base;
+	u32 alh_base;
 };
 
 /*
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index c979581c6812..b4e35fbbe693 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -166,6 +166,8 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	memset(&res, 0, sizeof(res));
 
 	res.mmio_base = sdev->bar[HDA_DSP_BAR];
+	res.shim_base = hdev->desc->sdw_shim_base;
+	res.alh_base = hdev->desc->sdw_alh_base;
 	res.irq = sdev->ipc_irq;
 	res.handle = hdev->info.handle;
 	res.parent = sdev->dev;
-- 
2.17.1

