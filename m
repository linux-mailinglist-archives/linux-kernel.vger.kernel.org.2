Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBC330FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCHNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCHNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50182C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so11481235wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MW7ODsa8ZPOJ2wtKEsEStbxhTSE0uu/mJWC0btG95F0=;
        b=irYdJyTrbxvsETNMy/ytJfj1HXu8aUiUR0KBpwLfvm59i5y6ouhQWOlT2kCHqExFBe
         55VQY1fNoHQmThNmuwyBudkFyUIYXhPNNxM4E4Y1sKVzHpIrnvPPv5mlbrVaXEePLX37
         MWPz/YcT3GprARMrSlfJs9Lxmd0EWpShClrSHyl+GJGYOd8QaMwCOF5PGfTj9/08ffkT
         uN5CJcugkE6X9p+nCFyZpOoYkuHxOrWvibHXax/AnRxgGc+vxzUk7hom3j7C08OrhVQV
         aJPnXVduqhbDtrb2n3xOoKlHm7j1tLh+7+U3ckN0WsqvgOpc4URXJ6dQBX1/2Di9BOXG
         xTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MW7ODsa8ZPOJ2wtKEsEStbxhTSE0uu/mJWC0btG95F0=;
        b=ZNDsgicwUCWUw1c33L6R2CcgyydEF8B7DyJVHqpIn7DIrh+hwpNyUVkKmk81oR3DO/
         iVARDevePO2EOJk9BqacRFY9AhN7AsiJg9O/hTLIn18GOokdIcXJyhARLHAypkkSW8Uc
         9hToUH8QRkqNLf3RUvYOberRc07iQOkbEDn+APu1LJu9N9mGv4RSsFi/KRcwzpxhkTP/
         0K6NhqRc+1XBXjKCkeBdYm1VzftOMQu20QNOxmO4tq1talVmU2HIUcjFmn+IXFbkayMC
         CrE/JL7/WokMYMeE00GeDenR4PzANmIiCmufdWT4Wzaz2vATCF2CtdTnfHvrguZoNnij
         q0HQ==
X-Gm-Message-State: AOAM533FluwMWtc8RQ6g96zeavkS5lT2guPJ0HWdAkaYJ++xcsxSsq5O
        LhPF+p2J6zUoZzw5r9Qx5SleN3aDo+rpDA==
X-Google-Smtp-Source: ABdhPJzDFL5k4u3aWb1QAP/jmZeZMbVysgrtL5ORYfMlw0Jk+YanK3P0UaradN9LKy9/aaJdpID1GQ==
X-Received: by 2002:adf:e411:: with SMTP id g17mr22889112wrm.225.1615211408052;
        Mon, 08 Mar 2021 05:50:08 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h22sm19490589wmb.36.2021.03.08.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/9] soundwire: qcom: add support to missing transport params
Date:   Mon,  8 Mar 2021 13:49:50 +0000
Message-Id: <20210308134957.16024-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/qcom.c | 107 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6d22df01f354..6c7b811eea94 100644
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
@@ -396,8 +410,11 @@ static int qcom_swrm_port_params(struct sdw_bus *bus,
 				 struct sdw_port_params *p_params,
 				 unsigned int bank)
 {
-	/* TBD */
-	return 0;
+	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+
+	return ctrl->reg_write(ctrl, SWRM_DP_BLOCK_CTRL_1(p_params->num),
+			       p_params->bps - 1);
+
 }
 
 static int qcom_swrm_transport_params(struct sdw_bus *bus,
@@ -405,20 +422,45 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 				      enum sdw_reg_bank bank)
 {
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+	struct qcom_swrm_port_config *pcfg;
 	u32 value;
 	int reg = SWRM_DP_PORT_CTRL_BANK((params->port_num), bank);
 	int ret;
 
-	value = params->offset1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
-	value |= params->offset2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
-	value |= params->sample_interval - 1;
+	pcfg = &ctrl->pconfig[params->port_num - 1];
+
+	value = pcfg->off1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
+	value |= pcfg->off2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
+	value |= pcfg->si;
 
 	ret = ctrl->reg_write(ctrl, reg, value);
 
-	if (!ret && params->blk_pkg_mode) {
-		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+	if (pcfg->lane_control != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
+		value = pcfg->lane_control;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	}
+
+	if (pcfg->blk_group_count != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_BLOCK_CTRL2_BANK(params->port_num, bank);
+		value = pcfg->blk_group_count;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	}
+
+	if (pcfg->hstart != SWR_INVALID_PARAM
+			&& pcfg->hstop != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
+		value = (pcfg->hstop << 4) | pcfg->hstart;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	} else {
+		reg = SWRM_DP_PORT_HCTRL_BANK(params->port_num, bank);
+		value = (SWR_HSTOP_MAX_VAL << 4) | SWR_HSTART_MIN_VAL;
+		ret = ctrl->reg_write(ctrl, reg, value);
+	}
 
-		ret = ctrl->reg_write(ctrl, reg, 1);
+	if (pcfg->bp_mode != SWR_INVALID_PARAM) {
+		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+		ret = ctrl->reg_write(ctrl, reg, pcfg->bp_mode);
 	}
 
 	return ret;
@@ -466,10 +508,13 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
 			pcfg = &ctrl->pconfig[p_rt->num - 1];
 			p_rt->transport_params.port_num = p_rt->num;
-			p_rt->transport_params.sample_interval = pcfg->si + 1;
-			p_rt->transport_params.offset1 = pcfg->off1;
-			p_rt->transport_params.offset2 = pcfg->off2;
-			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
+			if (pcfg->word_length != SWR_INVALID_PARAM) {
+				sdw_fill_port_params(&p_rt->port_params,
+					     p_rt->num,  pcfg->word_length + 1,
+					     SDW_PORT_FLOW_MODE_ISOCH,
+					     SDW_PORT_DATA_MODE_NORMAL);
+			}
+
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
@@ -481,6 +526,18 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
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
@@ -728,6 +785,11 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
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
@@ -772,11 +834,32 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
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

