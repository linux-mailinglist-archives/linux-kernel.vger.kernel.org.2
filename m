Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79369405ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbhIIVci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:32:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64519 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhIIVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:32:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631223082; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nClHlZglHDxNoKH8ii6ekEJ1aJcw9SAJw7GXszGM+gs=; b=lT+1ynP3QZVXn80DaInXuv1qnSj6iCAlRCkn2vFGniU110o6QMr3P6ZwhSkPgzGG9rs89mAR
 ndWtlaXl86jQOosl9WbokJPcuyUDCv5N/fGHcoG87U5Fbf9qzSd70C8jb+503FcwdMWk4GF9
 2XAwC3OyxYC6jRRigEo8vKUXyWk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 613a7d22e34848cb6ac9765d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Sep 2021 21:31:14
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D83FC4361B; Thu,  9 Sep 2021 21:31:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07939C4338F;
        Thu,  9 Sep 2021 21:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 07939C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        khsieh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, p.zabel@pengutronix.de
Subject: [PATCH v3] phy: qcom-qmp: add support for display port voltage and pre-emphasis swing
Date:   Thu,  9 Sep 2021 14:31:05 -0700
Message-Id: <1631223065-12607-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both voltage and pre-emphasis swing level are set during link training
negotiation between host and sink. There are totally four tables added.
A voltage swing table for both hbr and hbr1, a voltage table for both
hbr2 and hbr3, a pre-emphasis table for both hbr and hbr1 and a pre-emphasis
table for both hbr2 and hbr3. In addition, write 0x0a to TX_TX_POL_INV is
added to complete the sequence of configure dp phy base on HPG.

Chnages in v2:
-- revise commit test
-- add Fixes tag
-- replaced voltage_swing_cfg with voltage
-- replaced pre_emphasis_cfg with emphasis
-- delete drv_lvl_reg and emp_post_reg parameters from qcom_qmp_v4_phy_configure_dp_swing()
-- delete drv_lvl_reg and emp_post_reg parameters from qcom_qmp_phy_configure_dp_swing()

Changes in V3:
-- add __qcom_qmp_phy_configure_dp_swing() to commit swing/pre-emphasis level

Fixes: aff188feb5e1 ("phy: qcom-qmp: add support for sm8250-usb3-dp phy")
Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 102 +++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 31036aa..a8097ee 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3546,40 +3546,46 @@ static const u8 qmp_dp_v3_voltage_swing_hbr_rbr[4][4] = {
 	{ 0x1f, 0xff, 0xff, 0xff }
 };
 
-static int qcom_qmp_phy_configure_dp_swing(struct qmp_phy *qphy,
-		unsigned int drv_lvl_reg, unsigned int emp_post_reg)
+static int __qcom_qmp_phy_configure_dp_swing(struct qmp_phy *qphy,
+				unsigned int drv_lvl_reg,
+				unsigned int emp_post_reg,
+				const u8 *voltage_swing_hbr_rbr,
+				const u8 *pre_emphasis_hbr_rbr,
+				const u8 *voltage_swing_hbr3_hbr2,
+				const u8 *pre_emphasis_hbr3_hbr2)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
 	unsigned int v_level = 0, p_level = 0;
-	u8 voltage_swing_cfg, pre_emphasis_cfg;
-	int i;
+	u8 voltage, emphasis;
+	int i, offset;
 
 	for (i = 0; i < dp_opts->lanes; i++) {
 		v_level = max(v_level, dp_opts->voltage[i]);
 		p_level = max(p_level, dp_opts->pre[i]);
 	}
 
+	offset = v_level * 4 + p_level;
+
 	if (dp_opts->link_rate <= 2700) {
-		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr_rbr[v_level][p_level];
-		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr_rbr[v_level][p_level];
+		voltage = *(voltage_swing_hbr_rbr + offset);
+		emphasis = *(pre_emphasis_hbr_rbr + offset);
 	} else {
-		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr3_hbr2[v_level][p_level];
-		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr3_hbr2[v_level][p_level];
+		voltage = *(voltage_swing_hbr3_hbr2 + offset);
+		emphasis = *(pre_emphasis_hbr3_hbr2 + offset);
 	}
 
 	/* TODO: Move check to config check */
-	if (voltage_swing_cfg == 0xFF && pre_emphasis_cfg == 0xFF)
+	if (voltage == 0xFF && emphasis == 0xFF)
 		return -EINVAL;
 
 	/* Enable MUX to use Cursor values from these registers */
-	voltage_swing_cfg |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
-	pre_emphasis_cfg |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
-
-	writel(voltage_swing_cfg, qphy->tx + drv_lvl_reg);
-	writel(pre_emphasis_cfg, qphy->tx + emp_post_reg);
-	writel(voltage_swing_cfg, qphy->tx2 + drv_lvl_reg);
-	writel(pre_emphasis_cfg, qphy->tx2 + emp_post_reg);
+	voltage |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
+	emphasis |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
 
+	writel(voltage, qphy->tx + drv_lvl_reg);
+	writel(emphasis, qphy->tx + emp_post_reg);
+	writel(voltage, qphy->tx2 + drv_lvl_reg);
+	writel(emphasis, qphy->tx2 + emp_post_reg);
 	return 0;
 }
 
@@ -3588,9 +3594,13 @@ static void qcom_qmp_v3_phy_configure_dp_tx(struct qmp_phy *qphy)
 	const struct phy_configure_opts_dp *dp_opts = &qphy->dp_opts;
 	u32 bias_en, drvr_en;
 
-	if (qcom_qmp_phy_configure_dp_swing(qphy,
-				QSERDES_V3_TX_TX_DRV_LVL,
-				QSERDES_V3_TX_TX_EMP_POST1_LVL) < 0)
+	if (__qcom_qmp_phy_configure_dp_swing(qphy,
+			QSERDES_V3_TX_TX_DRV_LVL,
+			QSERDES_V3_TX_TX_EMP_POST1_LVL,
+			(const u8 *)qmp_dp_v3_voltage_swing_hbr_rbr,
+			(const u8 *)qmp_dp_v3_pre_emphasis_hbr_rbr,
+			(const u8 *)qmp_dp_v3_voltage_swing_hbr3_hbr2,
+			(const u8 *)qmp_dp_v3_pre_emphasis_hbr3_hbr2) < 0)
 		return;
 
 	if (dp_opts->lanes == 1) {
@@ -3728,6 +3738,35 @@ static int qcom_qmp_v3_dp_phy_calibrate(struct qmp_phy *qphy)
 	return 0;
 }
 
+/* The values in these tables are given without MUX_EN (0x20) bit set */
+static const u8 qmp_dp_v4_pre_emphasis_hbr3_hbr2[4][4] = {
+	{ 0x00, 0x0c, 0x15, 0x1b },
+	{ 0x02, 0x0e, 0x16, 0xff },
+	{ 0x02, 0x11, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v4_voltage_swing_hbr3_hbr2[4][4] = {
+	{ 0x02, 0x12, 0x16, 0x1a },
+	{ 0x09, 0x19, 0x1f, 0xff },
+	{ 0x10, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v4_pre_emphasis_hbr_rbr[4][4] = {
+	{ 0x00, 0x0e, 0x15, 0x1b },
+	{ 0x00, 0x0e, 0x15, 0xff },
+	{ 0x00, 0x0e, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v4_voltage_swing_hbr_rbr[4][4] = {
+	{ 0x08, 0x0f, 0x16, 0x1f },
+	{ 0x11, 0x1e, 0x1f, 0xff },
+	{ 0x16, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
+};
+
 static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
 {
 	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_PSR_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
@@ -3757,16 +3796,14 @@ static void qcom_qmp_v4_phy_dp_aux_init(struct qmp_phy *qphy)
 
 static void qcom_qmp_v4_phy_configure_dp_tx(struct qmp_phy *qphy)
 {
-	/* Program default values before writing proper values */
-	writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
-	writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
-
-	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-
-	qcom_qmp_phy_configure_dp_swing(qphy,
+	if (__qcom_qmp_phy_configure_dp_swing(qphy,
 			QSERDES_V4_TX_TX_DRV_LVL,
-			QSERDES_V4_TX_TX_EMP_POST1_LVL);
+			QSERDES_V4_TX_TX_EMP_POST1_LVL,
+			(const u8 *)qmp_dp_v4_voltage_swing_hbr_rbr,
+			(const u8 *)qmp_dp_v4_pre_emphasis_hbr_rbr,
+			(const u8 *)qmp_dp_v4_voltage_swing_hbr3_hbr2,
+			(const u8 *)qmp_dp_v4_pre_emphasis_hbr3_hbr2) < 0)
+		return;
 }
 
 static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
@@ -3885,6 +3922,9 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
 	writel(drvr1_en, qphy->tx2 + QSERDES_V4_TX_HIGHZ_DRVR_EN);
 	writel(bias1_en, qphy->tx2 + QSERDES_V4_TX_TRANSCEIVER_BIAS_EN);
 
+	writel(0x0a, qphy->tx + QSERDES_V4_TX_TX_POL_INV);
+	writel(0x0a, qphy->tx2 + QSERDES_V4_TX_TX_POL_INV);
+
 	writel(0x18, qphy->pcs + QSERDES_DP_PHY_CFG);
 	udelay(2000);
 	writel(0x19, qphy->pcs + QSERDES_DP_PHY_CFG);
@@ -3896,11 +3936,9 @@ static int qcom_qmp_v4_phy_configure_dp_phy(struct qmp_phy *qphy)
 			10000))
 		return -ETIMEDOUT;
 
-	writel(0x0a, qphy->tx + QSERDES_V4_TX_TX_POL_INV);
-	writel(0x0a, qphy->tx2 + QSERDES_V4_TX_TX_POL_INV);
 
-	writel(0x27, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
-	writel(0x27, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x22, qphy->tx + QSERDES_V4_TX_TX_DRV_LVL);
+	writel(0x22, qphy->tx2 + QSERDES_V4_TX_TX_DRV_LVL);
 
 	writel(0x20, qphy->tx + QSERDES_V4_TX_TX_EMP_POST1_LVL);
 	writel(0x20, qphy->tx2 + QSERDES_V4_TX_TX_EMP_POST1_LVL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

