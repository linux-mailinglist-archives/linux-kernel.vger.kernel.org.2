Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA532651A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBZP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:59:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C52C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i7so1256124wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YAKRy5fkxKacpBgIFQx0d76By/15lDXdzbFdBPsYEY=;
        b=hPjEA1Msnq4UYqlb9zLDgoFP997Ex+SPM5ZPT/wm32GQNAQSjVLqoTQuGETvwFF+y0
         NcGKZPKTzP3+YrpD3TmDwb8eH0cO3zRAVsh/8GtgpbLwWByIwq73ZAEtH3YaKAwsnNbi
         vzRtjvQEmZK5KVg58xNPvqtD+ZN4eoGAsIws7vznfrSOLLXWPa0Blh5G16vfPh5fEAyq
         d0eQWWcinZL+FSIlaEGLH7nHM6Hk4e7pOhAewZkQBhQbYle1VGvbTI4zbQnEbA26xF4l
         8G82utE+iJ6Nub/5QWs98Z9ebVCvu+4HexbSqMtQuKOdqbV9KKPlTqFW7JmaDohOxpSB
         Ieyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YAKRy5fkxKacpBgIFQx0d76By/15lDXdzbFdBPsYEY=;
        b=fF2+wZfUh+en7mK0qZfj413INnu8mXBU+Cz22elUTUnJAJQMIHKqw1tt1WMfK6L7t2
         fuJvTG86/Md/pSD6aS6GpwrKXT1zjzDAapwj/kgYYWAZQ54EAjuwgqXSuyrMiAHSeHgB
         lK+xaYfmDrIj0gCQHyD5v2ClRMG87XCIoprlYxRAy5SpAnx5XfS6eUOrvaD5VNg+MDCb
         Zuq0me5dipopzhsd3OQQLWgQSz25qIMkSArueRhOb3Kfp9SdEhe8KGxaHGdZi0ehc4Ps
         cw8nTl9JelYtTSs/OA5LuK+YFJNB+xUR4ctJ0iSJCsAdWGW5xLRuE9gas7b5OVnogZBP
         ycHA==
X-Gm-Message-State: AOAM532/uc+60tYDVi9dpe/YXapSE1X3++o422Oya+vljl6r+0H1PWtw
        MZgWuguSq2t681YjNRaPZAqugg==
X-Google-Smtp-Source: ABdhPJy/Qghn8HSdJxrUTB4cFgfaV/sOfPH8wxvhwh6xm/3tGvKatfO0glnzZHtwT2hPR7d+v7fZug==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr3549967wmc.100.1614355107687;
        Fri, 26 Feb 2021 07:58:27 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v6sm14398945wrx.32.2021.02.26.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:58:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] soundwire: qcom: add support to missing transport params
Date:   Fri, 26 Feb 2021 15:58:10 +0000
Message-Id: <20210226155814.27536-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
References: <20210226155814.27536-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the transport parameters derived from device tree
are not fully parsed by the driver.

This patch adds support to parse those missing parameters.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 99 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6d22df01f354..fee7465c72c2 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -54,7 +54,13 @@
 #define SWRM_MCP_SLV_STATUS					0x1090
 #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
 #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_PORT_CTRL_2_BANK(n, m)	(0x1128 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_BLOCK_CTRL_1(n)		(0x112C + 0x100 * (n - 1))
+#define SWRM_DP_BLOCK_CTRL2_BANK(n, m)	(0x1130 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_PORT_HCTRL_BANK(n, m)	(0x1134 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
+
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
 #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
@@ -73,12 +79,20 @@
 #define QCOM_SDW_MAX_PORTS	14
 #define DEFAULT_CLK_FREQ	9600000
 #define SWRM_MAX_DAIS		0xF
+#define SWR_INVALID_PARAM 0xFF
+#define SWR_HSTOP_MAX_VAL 0xF
+#define SWR_HSTART_MIN_VAL 0x0
 
 struct qcom_swrm_port_config {
 	u8 si;
 	u8 off1;
 	u8 off2;
 	u8 bp_mode;
+	u8 hstart;
+	u8 hstop;
+	u8 word_length;
+	u8 blk_group_count;
+	u8 lane_control;
 };
 
 struct qcom_swrm_ctrl {
@@ -396,7 +410,13 @@ static int qcom_swrm_port_params(struct sdw_bus *bus,
 				 struct sdw_port_params *p_params,
 				 unsigned int bank)
 {
-	/* TBD */
+	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+
+	if (p_params->bps != SWR_INVALID_PARAM)
+		return ctrl->reg_write(ctrl,
+				       SWRM_DP_BLOCK_CTRL_1(p_params->num),
+				       p_params->bps - 1);
+
 	return 0;
 }
 
@@ -415,10 +435,32 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 
 	ret = ctrl->reg_write(ctrl, reg, value);
 
-	if (!ret && params->blk_pkg_mode) {
-		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+	if (params->lane_ctrl != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
+		value = params->lane_ctrl;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	}
 
-		ret = ctrl->reg_write(ctrl, reg, 1);
+	if (params->blk_grp_ctrl != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_BLOCK_CTRL2_BANK(params->port_num, bank);
+		value = params->blk_grp_ctrl;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	}
+
+	if (params->hstart != SWR_INVALID_PARAM
+			&& params->hstop != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
+		value = (params->hstop << 4) | params->hstart;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	} else {
+		reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
+		value = (SWR_HSTOP_MAX_VAL << 4) | SWR_HSTART_MIN_VAL;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	}
+
+	if (params->blk_pkg_mode != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+		ret = ctrl->reg_write(ctrl, reg, params->blk_pkg_mode);
 	}
 
 	return ret;
@@ -470,6 +512,17 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 			p_rt->transport_params.offset1 = pcfg->off1;
 			p_rt->transport_params.offset2 = pcfg->off2;
 			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
+			p_rt->transport_params.blk_grp_ctrl = pcfg->blk_group_count;
+			p_rt->transport_params.hstart = pcfg->hstart;
+			p_rt->transport_params.hstop = pcfg->hstop;
+			p_rt->transport_params.lane_ctrl = pcfg->lane_control;
+			if (pcfg->word_length != SWR_INVALID_PARAM) {
+				sdw_fill_port_params(&p_rt->port_params,
+					     p_rt->num,  pcfg->word_length + 1,
+					     SDW_PORT_FLOW_MODE_ISOCH,
+					     SDW_PORT_DATA_MODE_NORMAL);
+			}
+
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
@@ -481,6 +534,18 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 				p_rt->transport_params.offset1 = pcfg->off1;
 				p_rt->transport_params.offset2 = pcfg->off2;
 				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
+				p_rt->transport_params.blk_grp_ctrl = pcfg->blk_group_count;
+
+				p_rt->transport_params.hstart = pcfg->hstart;
+				p_rt->transport_params.hstop = pcfg->hstop;
+				p_rt->transport_params.lane_ctrl = pcfg->lane_control;
+				if (pcfg->word_length != SWR_INVALID_PARAM) {
+					sdw_fill_port_params(&p_rt->port_params,
+						     p_rt->num,
+						     pcfg->word_length + 1,
+						     SDW_PORT_FLOW_MODE_ISOCH,
+						     SDW_PORT_DATA_MODE_NORMAL);
+				}
 				i++;
 			}
 		}
@@ -728,6 +793,11 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	u8 off2[QCOM_SDW_MAX_PORTS];
 	u8 si[QCOM_SDW_MAX_PORTS];
 	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
+	u8 hstart[QCOM_SDW_MAX_PORTS];
+	u8 hstop[QCOM_SDW_MAX_PORTS];
+	u8 word_length[QCOM_SDW_MAX_PORTS];
+	u8 blk_group_count[QCOM_SDW_MAX_PORTS];
+	u8 lane_control[QCOM_SDW_MAX_PORTS];
 	int i, ret, nports, val;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
@@ -772,11 +842,32 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
 	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
 					bp_mode, nports);
+
+	memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+	of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
+
+	memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+	of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
+
+	memset(word_length, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+	of_property_read_u8_array(np, "qcom,ports-word-length", word_length, nports);
+
+	memset(blk_group_count, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+	of_property_read_u8_array(np, "qcom,ports-block-group-count", blk_group_count, nports);
+
+	memset(lane_control, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+	of_property_read_u8_array(np, "qcom,ports-lane-control", lane_control, nports);
+
 	for (i = 0; i < nports; i++) {
 		ctrl->pconfig[i].si = si[i];
 		ctrl->pconfig[i].off1 = off1[i];
 		ctrl->pconfig[i].off2 = off2[i];
 		ctrl->pconfig[i].bp_mode = bp_mode[i];
+		ctrl->pconfig[i].hstart = hstart[i];
+		ctrl->pconfig[i].hstop = hstop[i];
+		ctrl->pconfig[i].word_length = word_length[i];
+		ctrl->pconfig[i].blk_group_count = blk_group_count[i];
+		ctrl->pconfig[i].lane_control = lane_control[i];
 	}
 
 	return 0;
-- 
2.21.0

