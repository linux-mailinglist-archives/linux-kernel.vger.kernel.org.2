Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1136BF85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhD0GzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhD0GzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:55:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:54:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14so23522074pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoy6Ekq5jH9Tw9gGr9lOGa5VhJ1MFtvj5t8kolnOQas=;
        b=yby5o42Jpw0hWsMTehYovn8yfKTZcga75OQnLp4wS7e4turDKnxaSkZnIulOj+qv6o
         FOzvroMdnEqf02+iP/0vnpSvu8hGmNRLWRDeGhz//+RrWNR1OnApQM2kobcGZsB0P3DC
         D4gsn3+vDzBHlzgrR8OE5+gdrbNEj1tXajcTC5xU0gCVUUD0KbCq+B89df6IUgpIwdzy
         OQOJ7fw58CHUfc+60Ur32Q30X60ziVJ5DPvyUJd6inAZZM46e7cVana7fCH/vFGl7pMh
         GQOJRAYy+QL8LIYydGqQFmotkwSWICcrh1wLTuSlAUzqLznrzfadJZjwZLWi2pA5Or92
         sACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoy6Ekq5jH9Tw9gGr9lOGa5VhJ1MFtvj5t8kolnOQas=;
        b=T22K0P5kYJUaIaMqJTV6tpIOj1xdBZbOzjCEbvNolG6R6S91a4ExnipHGQtPeDsMzm
         T/yuZvefWCRv8VjL4LW0IZDDJeWAeWLjCryNwLD+WgsfxRuzWqcFlYDhmSz5XkwZi82p
         SquX19320pwh2YujJhRH90zG6CxeSScPJ4A7SsazwM3gXeesjWyT/DowP7Ja2RlOfC33
         SGlmrNtlVlOxfjuD7GTFRSV6jmmfwJCJF/4C1QGVax136LTl74yfBBpgqURoksbZt0p1
         /yQY6WucvFzdckG+gQl0DdvskPNk2l8lWyZoC5tqABFU+SCE0THXgHstOEWklzUTbvOc
         Y9lw==
X-Gm-Message-State: AOAM531QKHcJxeHUo44c7Zq2YgbK9cQINqURKG7baMKznWawv4d06XKI
        IhXLGuooy2CBpKLLr29vO2vt
X-Google-Smtp-Source: ABdhPJz6PvbY+Wb9LSwJNg40wpVVV0GYrUui0TQPF72A0gGl33SZHADW8pgy61kaTV9DX4hvl2Hm7g==
X-Received: by 2002:a17:90b:4a04:: with SMTP id kk4mr26941859pjb.68.1619506465632;
        Mon, 26 Apr 2021 23:54:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6d89:3c72:ece6:56fb:d9ac:583c])
        by smtp.gmail.com with ESMTPSA id x22sm13391986pgx.19.2021.04.26.23.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 23:54:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, kishon@ti.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] phy: qcom-qmp: Add support for SDX55 QMP PCIe PHY
Date:   Tue, 27 Apr 2021 12:24:00 +0530
Message-Id: <20210427065400.18958-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427065400.18958-1-manivannan.sadhasivam@linaro.org>
References: <20210427065400.18958-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe PHY version used in SDX55 is v4.20 which has different register
offsets compared to the v4.0x PHYs. So separate register defines are
used for init sequence and PHY status.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 131 ++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h |  64 +++++++++++++-
 2 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index c9934b2407c4..bf4d8f22475c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -35,6 +35,7 @@
 #define PLL_READY_GATE_EN			BIT(3)
 /* QPHY_PCS_STATUS bit */
 #define PHYSTATUS				BIT(6)
+#define PHYSTATUS_4_20				BIT(7)
 /* QPHY_PCS_READY_STATUS & QPHY_COM_PCS_READY_STATUS bit */
 #define PCS_READY				BIT(0)
 
@@ -2030,6 +2031,101 @@ static const struct qmp_phy_init_tbl sdx55_usb3_uniphy_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
 };
 
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BG_TIMER, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYS_CLK_CTRL, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x50),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE1, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE0, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_CONFIG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_MISC1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_INTERNAL_DIG_CORECLK_DIV, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_MODE, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_DC_LEVEL_CTRL, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x56),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x22),
+};
+
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_TX_LANE_MODE_2, 0xf6),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_TX_LANE_MODE_3, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_TX_VMODE_CTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_TX_PI_QEC_CTRL, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_UCDR_PI_CONTROLS, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_AUX_DATA_TCOARSE_TFINE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_DFE_3, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_DFE_DAC_ENABLE1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_DFE_DAC_ENABLE2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_VGA_CAL_CNTRL2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x27),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B1, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B2, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B4, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE2_B0, 0xbd),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE2_B1, 0xf9),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE2_B2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE2_B3, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE2_B4, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE3_B0, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE3_B1, 0x7d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE3_B2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE3_B3, 0xcf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_RX_MODE_RATE3_B4, 0xd6),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_PHPRE_CTRL, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V4_20_RX_MARG_COARSE_CTRL2, 0x12),
+};
+
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_RX_SIGDET_LVL, 0x77),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_EQ_CONFIG2, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_EQ_CONFIG4, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_EQ_CONFIG5, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_EQ_CONFIG1, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_G3_RXEQEVAL_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_G4_RXEQEVAL_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_G4_EQ_CONFIG2, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_G4_EQ_CONFIG5, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_SW_CTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
+};
+
 static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
@@ -3175,6 +3271,38 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
+static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 2,
+
+	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
+	.tx_tbl			= sdx55_qmp_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_tx_tbl),
+	.rx_tbl			= sdx55_qmp_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_rx_tbl),
+	.pcs_tbl		= sdx55_qmp_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sdx55_qmp_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sdx55_qmp_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sdx55_qmp_pcie_pcs_misc_tbl),
+	.clk_list		= sdm845_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8250_pcie_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.phy_status		= PHYSTATUS_4_20,
+
+	.is_dual_lane_phy	= true,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 	.type			= PHY_TYPE_UFS,
 	.nlanes			= 2,
@@ -4619,6 +4747,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8250-qmp-modem-pcie-phy",
 		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdx55-qmp-pcie-phy",
+		.data = &sdx55_qmp_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
 		.data = &sdx55_usb3_uniphy_cfg,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 71ce3aa174ae..27de9749560a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -396,6 +396,7 @@
 #define QSERDES_V3_DP_PHY_STATUS			0x0c0
 
 /* Only for QMP V4 PHY - QSERDES COM registers */
+#define QSERDES_V4_COM_BG_TIMER				0x00c
 #define QSERDES_V4_COM_SSC_EN_CENTER			0x010
 #define QSERDES_V4_COM_SSC_PER1				0x01c
 #define QSERDES_V4_COM_SSC_PER2				0x020
@@ -403,7 +404,9 @@
 #define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0		0x028
 #define QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1		0x030
 #define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1		0x034
+#define QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN		0x044
 #define QSERDES_V4_COM_CLK_ENABLE1			0x048
+#define QSERDES_V4_COM_SYS_CLK_CTRL			0x04c
 #define QSERDES_V4_COM_SYSCLK_BUF_ENABLE		0x050
 #define QSERDES_V4_COM_PLL_IVCO				0x058
 #define QSERDES_V4_COM_CMN_IPTRIM			0x060
@@ -415,6 +418,7 @@
 #define QSERDES_V4_COM_PLL_CCTRL_MODE1			0x088
 #define QSERDES_V4_COM_SYSCLK_EN_SEL			0x094
 #define QSERDES_V4_COM_LOCK_CMP_EN			0x0a4
+#define QSERDES_V4_COM_LOCK_CMP_CFG			0x0a8
 #define QSERDES_V4_COM_LOCK_CMP1_MODE0			0x0ac
 #define QSERDES_V4_COM_LOCK_CMP2_MODE0			0x0b0
 #define QSERDES_V4_COM_LOCK_CMP1_MODE1			0x0b4
@@ -427,6 +431,10 @@
 #define QSERDES_V4_COM_DIV_FRAC_START1_MODE1		0x0d8
 #define QSERDES_V4_COM_DIV_FRAC_START2_MODE1		0x0dc
 #define QSERDES_V4_COM_DIV_FRAC_START3_MODE1		0x0e0
+#define QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0		0x0ec
+#define QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0		0x0f0
+#define QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE1		0x0f4
+#define QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE1		0x0f8
 #define QSERDES_V4_COM_VCO_TUNE_MAP			0x10c
 #define QSERDES_V4_COM_VCO_TUNE1_MODE0			0x110
 #define QSERDES_V4_COM_VCO_TUNE2_MODE0			0x114
@@ -436,13 +444,19 @@
 #define QSERDES_V4_COM_CLK_SELECT			0x154
 #define QSERDES_V4_COM_HSCLK_SEL			0x158
 #define QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL		0x15c
+#define QSERDES_V4_COM_CORECLK_DIV_MODE0		0x168
 #define QSERDES_V4_COM_CORECLK_DIV_MODE1		0x16c
+#define QSERDES_V4_COM_CMN_CONFIG			0x17c
 #define QSERDES_V4_COM_SVS_MODE_CLK_SEL			0x184
+#define QSERDES_V4_COM_CMN_MISC1			0x19c
+#define QSERDES_V4_COM_INTERNAL_DIG_CORECLK_DIV		0x1a0
+#define QSERDES_V4_COM_CMN_MODE				0x1a4
+#define QSERDES_V4_COM_VCO_DC_LEVEL_CTRL		0x1a8
 #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
 #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
 #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
-#define QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
 #define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
+#define QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
 
 /* Only for QMP V4 PHY - TX registers */
 #define QSERDES_V4_TX_RES_CODE_LANE_TX			0x34
@@ -459,6 +473,13 @@
 #define QSERDES_V4_TX_TRAN_DRVR_EMP_EN			0xb8
 #define QSERDES_V4_TX_PI_QEC_CTRL		0x104
 
+/* Only for QMP V4_20 PHY - TX registers */
+#define QSERDES_V4_20_TX_LANE_MODE_1			0x88
+#define QSERDES_V4_20_TX_LANE_MODE_2			0x8c
+#define QSERDES_V4_20_TX_LANE_MODE_3			0x90
+#define QSERDES_V4_20_TX_VMODE_CTRL1			0xc4
+#define QSERDES_V4_20_TX_PI_QEC_CTRL			0xe0
+
 /* Only for QMP V4 PHY - RX registers */
 #define QSERDES_V4_RX_UCDR_FO_GAIN			0x008
 #define QSERDES_V4_RX_UCDR_SO_GAIN			0x014
@@ -514,6 +535,33 @@
 #define QSERDES_V4_RX_DCC_CTRL1				0x1bc
 #define QSERDES_V4_RX_VTH_CODE				0x1c4
 
+/* Only for QMP V4_20 PHY - RX registers */
+#define QSERDES_V4_20_RX_FO_GAIN_RATE2			0x008
+#define QSERDES_V4_20_RX_UCDR_PI_CONTROLS		0x058
+#define QSERDES_V4_20_RX_AUX_DATA_TCOARSE_TFINE		0x0ac
+#define QSERDES_V4_20_RX_DFE_3				0x110
+#define QSERDES_V4_20_RX_DFE_DAC_ENABLE1		0x134
+#define QSERDES_V4_20_RX_DFE_DAC_ENABLE2		0x138
+#define QSERDES_V4_20_RX_VGA_CAL_CNTRL2			0x150
+#define QSERDES_V4_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x178
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B1		0x1c8
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B2		0x1cc
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B3		0x1d0
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B4		0x1d4
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B0		0x1d8
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B1		0x1dc
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B2		0x1e0
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B3		0x1e4
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B4		0x1e8
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B0		0x1ec
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B1		0x1f0
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B2		0x1f4
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B3		0x1f8
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B4		0x1fc
+#define QSERDES_V4_20_RX_PHPRE_CTRL			0x200
+#define QSERDES_V4_20_RX_DFE_CTLE_POST_CAL_OFFSET	0x20c
+#define QSERDES_V4_20_RX_MARG_COARSE_CTRL2		0x23c
+
 /* Only for QMP V4 PHY - UFS PCS registers */
 #define QPHY_V4_PCS_UFS_PHY_START				0x000
 #define QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL			0x004
@@ -799,6 +847,12 @@
 #define QPHY_V4_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x354
 #define QPHY_V4_PCS_USB3_TEST_CONTROL			0x358
 
+/* Only for QMP V4_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V4_20_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V4_20_PCS_EQ_CONFIG2			0x1d8
+#define QPHY_V4_20_PCS_EQ_CONFIG4			0x1e0
+#define QPHY_V4_20_PCS_EQ_CONFIG5			0x1e4
+
 /* Only for QMP V4 PHY - UNI has 0x300 offset for PCS_USB3 regs */
 #define QPHY_V4_PCS_USB3_UNI_LFPS_DET_HIGH_COUNT_VAL	0x618
 #define QPHY_V4_PCS_USB3_UNI_RXEQTRAINING_DFE_TIME_S2	0x638
@@ -824,6 +878,14 @@
 #define QPHY_V4_PCS_PCIE_PRESET_P10_PRE			0xbc
 #define QPHY_V4_PCS_PCIE_PRESET_P10_POST		0xe0
 
+#define QPHY_V4_20_PCS_PCIE_EQ_CONFIG1			0x0a0
+#define QPHY_V4_20_PCS_PCIE_G3_RXEQEVAL_TIME		0x0f0
+#define QPHY_V4_20_PCS_PCIE_G4_RXEQEVAL_TIME		0x0f4
+#define QPHY_V4_20_PCS_PCIE_G4_EQ_CONFIG2		0x0fc
+#define QPHY_V4_20_PCS_PCIE_G4_EQ_CONFIG5		0x108
+#define QPHY_V4_20_PCS_LANE1_INSIG_SW_CTRL2		0x824
+#define QPHY_V4_20_PCS_LANE1_INSIG_MX_CTRL2		0x828
+
 /* Only for QMP V5 PHY - QSERDES COM registers */
 #define QSERDES_V5_COM_PLL_IVCO				0x058
 #define QSERDES_V5_COM_CP_CTRL_MODE0			0x074
-- 
2.25.1

