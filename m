Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE308BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhA2Rhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhA2Rdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:33:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D267C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m1so4530325wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrfMb2btWYXDI0dhTmJUwlSxUe7orre+0l2Xpgv0jlU=;
        b=Og78MR30tRmWm6Ra2LUI2T1Cvmq3/JKJwP1LPAA9RyvOSFRSCOWkEmJ2kIpmzgEqzM
         lCNW+7yGPH6+dYfKdh5EVgFjiIloL9BcPPNEAm6LorWKESp3zB3ScGteMaD9W12Ply/q
         QWppbYe17mcRw6PmxmbgwXXJnlqpqH+guNXg3/KyAH9q1Do4MaKzJgLWlBR6u45lsio1
         FD18Jnt9myxb0sbsATI1P6OtZ6jpYtSzkxKKfJfpwfB5pkMEPUAxmvx0b1ei5nu61Ipr
         Oxt4YCWt4MQtIylDXFrPYMrZwF3a4ETfEF3lroFBORPH/Rhav5W+uEvsQ38KTQ5z0YNX
         QkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrfMb2btWYXDI0dhTmJUwlSxUe7orre+0l2Xpgv0jlU=;
        b=V1H1hcB0CSqtjOi5DZ/UY2ftu8kiIb8GZ+83TZwUkvilwJ23do2dP/ma66CoEopbUH
         Z/3MXNvMqBM7H+vReQZBps0oSwHj9+5DPXT5ewv0MQkmwT3vh8DU66OKe7La8QPzb/sJ
         k52pfFwNY0Y1Vi7esfJhcKddKpp+1042uEmKAXmocJ73a32esXpvD8i+xklI0Tw00wAC
         9Z2xk6awKJJkI0fQxzLsjXC3SJFyO95ty0ZWt4/u6ZMmtj4dMZhbm0BD8n7weFqz2Y83
         vbcKNiTpg89CFYwyTKJjTUi6cYLZuPeceRX4v8+Bph601Tj3rlPbAgZ9dyYWpv7aLr9z
         Fgjw==
X-Gm-Message-State: AOAM533hmqTaUuZck7LjnRb0Ne4SGs689CA0boacOzR6yBWAYxSFD5qN
        8qSVIs44at2Ef5XNdGVVqHt2wA==
X-Google-Smtp-Source: ABdhPJxXaF7oNYITgDnpFtMdgKGL673SBJHP1Jb3LQxwWSOccUuj6+W+AYq+O8cEvdXVcoHGWzIEXw==
X-Received: by 2002:a1c:9cc5:: with SMTP id f188mr4695712wme.171.1611941574907;
        Fri, 29 Jan 2021 09:32:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id h18sm13202294wru.65.2021.01.29.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:32:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] soundwire: qcom: add support to missing transport params
Date:   Fri, 29 Jan 2021 17:32:43 +0000
Message-Id: <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/qcom.c | 107 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6d22df01f354..36e273795cbe 100644
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
+	u8 bgp_count;
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
+			p_rt->transport_params.blk_grp_ctrl = pcfg->bgp_count;
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
+				p_rt->transport_params.blk_grp_ctrl = pcfg->bgp_count;
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
+	u8 bgp_count[QCOM_SDW_MAX_PORTS];
+	u8 lane_control[QCOM_SDW_MAX_PORTS];
 	int i, ret, nports, val;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
@@ -772,11 +842,40 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
 	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
 					bp_mode, nports);
+
+	ret = of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
+	if (ret)
+		memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+
+	ret = of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
+	if (ret)
+		memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+
+	ret = of_property_read_u8_array(np, "qcom,ports-word-length",
+					word_length, nports);
+	if (ret)
+		memset(word_length, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+
+	ret = of_property_read_u8_array(np, "qcom,ports-block-group-count",
+					bgp_count, nports);
+	if (ret)
+		memset(bgp_count, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+
+	ret = of_property_read_u8_array(np, "qcom,ports-lane-control",
+					lane_control, nports);
+	if (ret)
+		memset(lane_control, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+
 	for (i = 0; i < nports; i++) {
 		ctrl->pconfig[i].si = si[i];
 		ctrl->pconfig[i].off1 = off1[i];
 		ctrl->pconfig[i].off2 = off2[i];
 		ctrl->pconfig[i].bp_mode = bp_mode[i];
+		ctrl->pconfig[i].hstart = hstart[i];
+		ctrl->pconfig[i].hstop = hstop[i];
+		ctrl->pconfig[i].word_length = word_length[i];
+		ctrl->pconfig[i].bgp_count = bgp_count[i];
+		ctrl->pconfig[i].lane_control = lane_control[i];
 	}
 
 	return 0;
-- 
2.21.0

