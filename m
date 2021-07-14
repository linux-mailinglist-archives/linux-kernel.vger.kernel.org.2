Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11C3C7CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhGNDZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:25:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:61186 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237871AbhGNDZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:25:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="295924119"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="295924119"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459818221"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 20:22:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 10/10] soundwire: cadence: override PDI configurations to create loopback
Date:   Wed, 14 Jul 2021 11:22:09 +0800
Message-Id: <20210714032209.11284-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When we set a source PDI, the target PDI parameters will be overridden
by the source register values. The loopback streams can be
independently enabled on each link.

While the loopback source and target can be configured before any
stream is active on each link, the loopback stream should only be
prepared/triggered when the playback stream is prepared. Otherwise all
registers might be programmed to their reset values and the loopback
will not succeed. The SoundWire bus driver currently does not allow
two streams to be triggered at the same time, so the playback will
have to be started first, and later the loopback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 130 +++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 35 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 3e740fcebdfe..c7372519452b 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1329,20 +1329,37 @@ static int cdns_port_params(struct sdw_bus *bus,
 			    struct sdw_port_params *p_params, unsigned int bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	int dpn_config = 0, dpn_config_off;
+	int dpn_config_off_source;
+	int dpn_config_off_target;
+	int target_num = p_params->num;
+	int source_num = p_params->num;
+	bool override = false;
+	int dpn_config;
 
-	if (bank)
-		dpn_config_off = CDNS_DPN_B1_CONFIG(p_params->num);
-	else
-		dpn_config_off = CDNS_DPN_B0_CONFIG(p_params->num);
+	if (target_num == cdns->pdi_loopback_target &&
+	    cdns->pdi_loopback_source != -1) {
+		source_num = cdns->pdi_loopback_source;
+		override = true;
+	}
 
-	dpn_config = cdns_readl(cdns, dpn_config_off);
+	if (bank) {
+		dpn_config_off_source = CDNS_DPN_B1_CONFIG(source_num);
+		dpn_config_off_target = CDNS_DPN_B1_CONFIG(target_num);
+	} else {
+		dpn_config_off_source = CDNS_DPN_B0_CONFIG(source_num);
+		dpn_config_off_target = CDNS_DPN_B0_CONFIG(target_num);
+	}
 
-	u32p_replace_bits(&dpn_config, (p_params->bps - 1), CDNS_DPN_CONFIG_WL);
-	u32p_replace_bits(&dpn_config, p_params->flow_mode, CDNS_DPN_CONFIG_PORT_FLOW);
-	u32p_replace_bits(&dpn_config, p_params->data_mode, CDNS_DPN_CONFIG_PORT_DAT);
+	dpn_config = cdns_readl(cdns, dpn_config_off_source);
 
-	cdns_writel(cdns, dpn_config_off, dpn_config);
+	/* use port params if there is no loopback, otherwise use source as is */
+	if (!override) {
+		u32p_replace_bits(&dpn_config, p_params->bps - 1, CDNS_DPN_CONFIG_WL);
+		u32p_replace_bits(&dpn_config, p_params->flow_mode, CDNS_DPN_CONFIG_PORT_FLOW);
+		u32p_replace_bits(&dpn_config, p_params->data_mode, CDNS_DPN_CONFIG_PORT_DAT);
+	}
+
+	cdns_writel(cdns, dpn_config_off_target, dpn_config);
 
 	return 0;
 }
@@ -1352,11 +1369,27 @@ static int cdns_transport_params(struct sdw_bus *bus,
 				 enum sdw_reg_bank bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	int dpn_offsetctrl = 0, dpn_offsetctrl_off;
-	int dpn_config = 0, dpn_config_off;
-	int dpn_hctrl = 0, dpn_hctrl_off;
-	int num = t_params->port_num;
-	int dpn_samplectrl_off;
+	int dpn_config;
+	int dpn_config_off_source;
+	int dpn_config_off_target;
+	int dpn_hctrl;
+	int dpn_hctrl_off_source;
+	int dpn_hctrl_off_target;
+	int dpn_offsetctrl;
+	int dpn_offsetctrl_off_source;
+	int dpn_offsetctrl_off_target;
+	int dpn_samplectrl;
+	int dpn_samplectrl_off_source;
+	int dpn_samplectrl_off_target;
+	int source_num = t_params->port_num;
+	int target_num = t_params->port_num;
+	bool override = false;
+
+	if (target_num == cdns->pdi_loopback_target &&
+	    cdns->pdi_loopback_source != -1) {
+		source_num = cdns->pdi_loopback_source;
+		override = true;
+	}
 
 	/*
 	 * Note: Only full data port is supported on the Master side for
@@ -1364,32 +1397,59 @@ static int cdns_transport_params(struct sdw_bus *bus,
 	 */
 
 	if (bank) {
-		dpn_config_off = CDNS_DPN_B1_CONFIG(num);
-		dpn_samplectrl_off = CDNS_DPN_B1_SAMPLE_CTRL(num);
-		dpn_hctrl_off = CDNS_DPN_B1_HCTRL(num);
-		dpn_offsetctrl_off = CDNS_DPN_B1_OFFSET_CTRL(num);
+		dpn_config_off_source = CDNS_DPN_B1_CONFIG(source_num);
+		dpn_hctrl_off_source = CDNS_DPN_B1_HCTRL(source_num);
+		dpn_offsetctrl_off_source = CDNS_DPN_B1_OFFSET_CTRL(source_num);
+		dpn_samplectrl_off_source = CDNS_DPN_B1_SAMPLE_CTRL(source_num);
+
+		dpn_config_off_target = CDNS_DPN_B1_CONFIG(target_num);
+		dpn_hctrl_off_target = CDNS_DPN_B1_HCTRL(target_num);
+		dpn_offsetctrl_off_target = CDNS_DPN_B1_OFFSET_CTRL(target_num);
+		dpn_samplectrl_off_target = CDNS_DPN_B1_SAMPLE_CTRL(target_num);
+
 	} else {
-		dpn_config_off = CDNS_DPN_B0_CONFIG(num);
-		dpn_samplectrl_off = CDNS_DPN_B0_SAMPLE_CTRL(num);
-		dpn_hctrl_off = CDNS_DPN_B0_HCTRL(num);
-		dpn_offsetctrl_off = CDNS_DPN_B0_OFFSET_CTRL(num);
+		dpn_config_off_source = CDNS_DPN_B0_CONFIG(source_num);
+		dpn_hctrl_off_source = CDNS_DPN_B0_HCTRL(source_num);
+		dpn_offsetctrl_off_source = CDNS_DPN_B0_OFFSET_CTRL(source_num);
+		dpn_samplectrl_off_source = CDNS_DPN_B0_SAMPLE_CTRL(source_num);
+
+		dpn_config_off_target = CDNS_DPN_B0_CONFIG(target_num);
+		dpn_hctrl_off_target = CDNS_DPN_B0_HCTRL(target_num);
+		dpn_offsetctrl_off_target = CDNS_DPN_B0_OFFSET_CTRL(target_num);
+		dpn_samplectrl_off_target = CDNS_DPN_B0_SAMPLE_CTRL(target_num);
 	}
 
-	dpn_config = cdns_readl(cdns, dpn_config_off);
-	u32p_replace_bits(&dpn_config, t_params->blk_grp_ctrl, CDNS_DPN_CONFIG_BGC);
-	u32p_replace_bits(&dpn_config, t_params->blk_pkg_mode, CDNS_DPN_CONFIG_BPM);
-	cdns_writel(cdns, dpn_config_off, dpn_config);
+	dpn_config = cdns_readl(cdns, dpn_config_off_source);
+	if (!override) {
+		u32p_replace_bits(&dpn_config, t_params->blk_grp_ctrl, CDNS_DPN_CONFIG_BGC);
+		u32p_replace_bits(&dpn_config, t_params->blk_pkg_mode, CDNS_DPN_CONFIG_BPM);
+	}
+	cdns_writel(cdns, dpn_config_off_target, dpn_config);
 
-	u32p_replace_bits(&dpn_offsetctrl, t_params->offset1, CDNS_DPN_OFFSET_CTRL_1);
-	u32p_replace_bits(&dpn_offsetctrl, t_params->offset2, CDNS_DPN_OFFSET_CTRL_2);
-	cdns_writel(cdns, dpn_offsetctrl_off,  dpn_offsetctrl);
+	if (!override) {
+		dpn_offsetctrl = 0;
+		u32p_replace_bits(&dpn_offsetctrl, t_params->offset1, CDNS_DPN_OFFSET_CTRL_1);
+		u32p_replace_bits(&dpn_offsetctrl, t_params->offset2, CDNS_DPN_OFFSET_CTRL_2);
+	} else {
+		dpn_offsetctrl = cdns_readl(cdns, dpn_offsetctrl_off_source);
+	}
+	cdns_writel(cdns, dpn_offsetctrl_off_target,  dpn_offsetctrl);
 
-	u32p_replace_bits(&dpn_hctrl, t_params->hstart, CDNS_DPN_HCTRL_HSTART);
-	u32p_replace_bits(&dpn_hctrl, t_params->hstop, CDNS_DPN_HCTRL_HSTOP);
-	u32p_replace_bits(&dpn_hctrl, t_params->lane_ctrl, CDNS_DPN_HCTRL_LCTRL);
+	if (!override) {
+		dpn_hctrl = 0;
+		u32p_replace_bits(&dpn_hctrl, t_params->hstart, CDNS_DPN_HCTRL_HSTART);
+		u32p_replace_bits(&dpn_hctrl, t_params->hstop, CDNS_DPN_HCTRL_HSTOP);
+		u32p_replace_bits(&dpn_hctrl, t_params->lane_ctrl, CDNS_DPN_HCTRL_LCTRL);
+	} else {
+		dpn_hctrl = cdns_readl(cdns, dpn_hctrl_off_source);
+	}
+	cdns_writel(cdns, dpn_hctrl_off_target, dpn_hctrl);
 
-	cdns_writel(cdns, dpn_hctrl_off, dpn_hctrl);
-	cdns_writel(cdns, dpn_samplectrl_off, (t_params->sample_interval - 1));
+	if (!override)
+		dpn_samplectrl = t_params->sample_interval - 1;
+	else
+		dpn_samplectrl = cdns_readl(cdns, dpn_samplectrl_off_source);
+	cdns_writel(cdns, dpn_samplectrl_off_target, dpn_samplectrl);
 
 	return 0;
 }
-- 
2.17.1

