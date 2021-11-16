Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC3452ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhKPKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:19:13 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52215 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhKPKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637057704; x=1668593704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IHIuORtqeun9GVgjDMu3cbGr/0wnU/GwaJwVB3nCXNA=;
  b=tAe9nLguBM7faNa2rmIHvn5kOrpyBzW1vnwTEqQCAatLeFzoGy2b+eY6
   jdR6dphRFZsWo5oF2RKS9BDGts/z/Eex9ubWXw4v0tJ9JCMdMg/tKURWS
   nXKU+JpDhp5iCrvuD35wY83J0NNrJJbQpqhUw+1gZXXEaXAfc6VRLppj1
   13nQC2rTfQvm8hQUBWC55HD1GcIMn6Pc1HzQfDM3+ULKI35flopzECI12
   8Tj48sYBhAA4VH9O16UkcOvTxK8/M8DNq1x+G/A42OBWcjfQxvJS3DVkQ
   proCQSeGnyW0w/NnbDMlHw7thnhXE63f0vY+K2qHocHHU5YN35X/UtmYt
   g==;
IronPort-SDR: zz2OGg1+hHGxlgXiTEdPfSquf+onkCIjPDAdJVljskIWX2vqoBKJvnKhanvekQXN4mf2q7VCp5
 dfYoJjp7naZQMP62hI+oy4JrJfcgGyET0wBINOn2+u2MVVu2uB3lnAMieXFrT3P+torpl5r00f
 FkT/QUugdOm02JHXjUWV9YZI9QI8C3/LOEbatoAGsBmSy88a/GfJzufIfMGSGh0Tg4M6Vmlgp7
 RKPemQK5mkV0wfbxaetnYXGCaOcxBoBmEynqsXBlFBUbWPnvBExZfaUu/peUkDDGMGxPOfp8sy
 CJELbdwWi5AsS/Qf8gvU9Fel
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="143495523"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 03:15:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:15:02 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 03:15:00 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <kuba@kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH resend v4 3/3] phy: Add lan966x ethernet serdes PHY driver
Date:   Tue, 16 Nov 2021 11:08:18 +0100
Message-ID: <20211116100818.1615762-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Microchip lan966x ethernet serdes PHY driver for interfaces
available in the lan966x SoC.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/phy/microchip/Kconfig               |   8 +
 drivers/phy/microchip/Makefile              |   1 +
 drivers/phy/microchip/lan966x_serdes.c      | 548 ++++++++++++++++++++
 drivers/phy/microchip/lan966x_serdes_regs.h | 209 ++++++++
 4 files changed, 766 insertions(+)
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h

diff --git a/drivers/phy/microchip/Kconfig b/drivers/phy/microchip/Kconfig
index 3728a284bf64..38039ed0754c 100644
--- a/drivers/phy/microchip/Kconfig
+++ b/drivers/phy/microchip/Kconfig
@@ -11,3 +11,11 @@ config PHY_SPARX5_SERDES
 	depends on HAS_IOMEM
 	help
 	  Enable this for support of the 10G/25G SerDes on Microchip Sparx5.
+
+config PHY_LAN966X_SERDES
+	tristate "SerDes PHY driver for Microchip LAN966X"
+	select GENERIC_PHY
+	depends on OF
+	depends on MFD_SYSCON
+	help
+	  Enable this for supporting SerDes muxing with Microchip LAN966X
diff --git a/drivers/phy/microchip/Makefile b/drivers/phy/microchip/Makefile
index 7b98345712aa..fd73b87960a5 100644
--- a/drivers/phy/microchip/Makefile
+++ b/drivers/phy/microchip/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_PHY_SPARX5_SERDES) := sparx5_serdes.o
+obj-$(CONFIG_PHY_LAN966X_SERDES) := lan966x_serdes.o
diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
new file mode 100644
index 000000000000..262bb616b4bb
--- /dev/null
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/phy/phy-lan966x-serdes.h>
+#include "lan966x_serdes_regs.h"
+
+#define PLL_CONF_MASK		GENMASK(4, 3)
+#define PLL_CONF_25MHZ		0
+#define PLL_CONF_125MHZ		1
+#define PLL_CONF_SERDES_125MHZ	2
+#define PLL_CONF_BYPASS		3
+
+#define lan_offset_(id, tinst, tcnt,			\
+		   gbase, ginst, gcnt, gwidth,		\
+		   raddr, rinst, rcnt, rwidth)		\
+	(gbase + ((ginst) * gwidth) + raddr + ((rinst) * rwidth))
+#define lan_offset(...) lan_offset_(__VA_ARGS__)
+
+#define lan_rmw(val, mask, reg, off)		\
+	lan_rmw_(val, mask, reg, lan_offset(off))
+
+#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) { \
+	.idx = _idx,						\
+	.port = _port,						\
+	.mode = _mode,						\
+	.submode = _submode,					\
+	.mask = _mask,						\
+	.mux = _mux,						\
+}
+
+#define SERDES_MUX_GMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_GMII, m, c)
+#define SERDES_MUX_SGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_SGMII, m, c)
+#define SERDES_MUX_QSGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_QSGMII, m, c)
+#define SERDES_MUX_RGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII, m, c)
+
+static void lan_rmw_(u32 val, u32 mask, void __iomem *mem, u32 offset)
+{
+	u32 v;
+
+	v = readl(mem + offset);
+	v = (v & ~mask) | (val & mask);
+	writel(v, mem + offset);
+}
+
+struct serdes_mux {
+	u8			idx;
+	u8			port;
+	enum phy_mode		mode;
+	int			submode;
+	u32			mask;
+	u32			mux;
+};
+
+static const struct serdes_mux lan966x_serdes_muxes[] = {
+	SERDES_MUX_QSGMII(SERDES6G(1), 0, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(0))),
+	SERDES_MUX_QSGMII(SERDES6G(1), 1, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(0))),
+	SERDES_MUX_QSGMII(SERDES6G(1), 2, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(0))),
+	SERDES_MUX_QSGMII(SERDES6G(1), 3, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(0))),
+
+	SERDES_MUX_QSGMII(SERDES6G(2), 4, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(1))),
+	SERDES_MUX_QSGMII(SERDES6G(2), 5, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(1))),
+	SERDES_MUX_QSGMII(SERDES6G(2), 6, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(1))),
+	SERDES_MUX_QSGMII(SERDES6G(2), 7, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA_SET(BIT(1))),
+
+	SERDES_MUX_GMII(CU(0), 0, HSIO_HW_CFG_GMII_ENA,
+			HSIO_HW_CFG_GMII_ENA_SET(BIT(0))),
+	SERDES_MUX_GMII(CU(1), 1, HSIO_HW_CFG_GMII_ENA,
+			HSIO_HW_CFG_GMII_ENA_SET(BIT(1))),
+
+	SERDES_MUX_SGMII(SERDES6G(0), 0, HSIO_HW_CFG_SD6G_0_CFG, 0),
+	SERDES_MUX_SGMII(SERDES6G(1), 1, HSIO_HW_CFG_SD6G_1_CFG, 0),
+	SERDES_MUX_SGMII(SERDES6G(0), 2, HSIO_HW_CFG_SD6G_0_CFG,
+			 HSIO_HW_CFG_SD6G_0_CFG_SET(1)),
+	SERDES_MUX_SGMII(SERDES6G(1), 3, HSIO_HW_CFG_SD6G_1_CFG,
+			 HSIO_HW_CFG_SD6G_1_CFG_SET(1)),
+
+	SERDES_MUX_RGMII(RGMII(0), 2, HSIO_HW_CFG_RGMII_0_CFG |
+			 HSIO_HW_CFG_RGMII_ENA,
+			 HSIO_HW_CFG_RGMII_0_CFG_SET(BIT(0)) |
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(0))),
+	SERDES_MUX_RGMII(RGMII(1), 3, HSIO_HW_CFG_RGMII_1_CFG |
+			 HSIO_HW_CFG_RGMII_ENA,
+			 HSIO_HW_CFG_RGMII_1_CFG_SET(BIT(0)) |
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(1))),
+	SERDES_MUX_RGMII(RGMII(0), 5, HSIO_HW_CFG_RGMII_0_CFG |
+			 HSIO_HW_CFG_RGMII_ENA,
+			 HSIO_HW_CFG_RGMII_0_CFG_SET(BIT(0)) |
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(0))),
+	SERDES_MUX_RGMII(RGMII(1), 6, HSIO_HW_CFG_RGMII_1_CFG |
+			 HSIO_HW_CFG_RGMII_ENA,
+			 HSIO_HW_CFG_RGMII_1_CFG_SET(BIT(0)) |
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(1))),
+};
+
+struct serdes_ctrl {
+	void __iomem		*regs;
+	struct device		*dev;
+	struct phy		*phys[SERDES_MAX];
+	int			ref125;
+};
+
+struct serdes_macro {
+	u8			idx;
+	int			port;
+	struct serdes_ctrl	*ctrl;
+	int			speed;
+	phy_interface_t		mode;
+};
+
+enum lan966x_sd6g40_mode {
+	LAN966X_SD6G40_MODE_QSGMII,
+	LAN966X_SD6G40_MODE_SGMII,
+};
+
+enum lan966x_sd6g40_ltx2rx {
+	LAN966X_SD6G40_TX2RX_LOOP_NONE,
+	LAN966X_SD6G40_LTX2RX
+};
+
+struct lan966x_sd6g40_setup_args {
+	enum lan966x_sd6g40_mode	mode;
+	enum lan966x_sd6g40_ltx2rx	tx2rx_loop;
+	bool				txinvert;
+	bool				rxinvert;
+	bool				refclk125M;
+	bool				mute;
+};
+
+struct lan966x_sd6g40_mode_args {
+	enum lan966x_sd6g40_mode	mode;
+	u8				 lane_10bit_sel;
+	u8				 mpll_multiplier;
+	u8				 ref_clkdiv2;
+	u8				 tx_rate;
+	u8				 rx_rate;
+};
+
+struct lan966x_sd6g40_setup {
+	u8	rx_term_en;
+	u8	lane_10bit_sel;
+	u8	tx_invert;
+	u8	rx_invert;
+	u8	mpll_multiplier;
+	u8	lane_loopbk_en;
+	u8	ref_clkdiv2;
+	u8	tx_rate;
+	u8	rx_rate;
+};
+
+static int lan966x_sd6g40_reg_cfg(struct serdes_macro *macro,
+				  struct lan966x_sd6g40_setup *res_struct,
+				  u32 idx)
+{
+	u32 value;
+
+	/* Note: SerDes HSIO is configured in 1G_LAN mode */
+	lan_rmw(HSIO_SD_CFG_LANE_10BIT_SEL_SET(res_struct->lane_10bit_sel) |
+		HSIO_SD_CFG_RX_RATE_SET(res_struct->rx_rate) |
+		HSIO_SD_CFG_TX_RATE_SET(res_struct->tx_rate) |
+		HSIO_SD_CFG_TX_INVERT_SET(res_struct->tx_invert) |
+		HSIO_SD_CFG_RX_INVERT_SET(res_struct->rx_invert) |
+		HSIO_SD_CFG_LANE_LOOPBK_EN_SET(res_struct->lane_loopbk_en) |
+		HSIO_SD_CFG_RX_RESET_SET(0) |
+		HSIO_SD_CFG_TX_RESET_SET(0),
+		HSIO_SD_CFG_LANE_10BIT_SEL |
+		HSIO_SD_CFG_RX_RATE |
+		HSIO_SD_CFG_TX_RATE |
+		HSIO_SD_CFG_TX_INVERT |
+		HSIO_SD_CFG_RX_INVERT |
+		HSIO_SD_CFG_LANE_LOOPBK_EN |
+		HSIO_SD_CFG_RX_RESET |
+		HSIO_SD_CFG_TX_RESET,
+		macro->ctrl->regs, HSIO_SD_CFG(idx));
+
+	lan_rmw(HSIO_MPLL_CFG_MPLL_MULTIPLIER_SET(res_struct->mpll_multiplier) |
+		HSIO_MPLL_CFG_REF_CLKDIV2_SET(res_struct->ref_clkdiv2),
+		HSIO_MPLL_CFG_MPLL_MULTIPLIER |
+		HSIO_MPLL_CFG_REF_CLKDIV2,
+		macro->ctrl->regs, HSIO_MPLL_CFG(idx));
+
+	lan_rmw(HSIO_SD_CFG_RX_TERM_EN_SET(res_struct->rx_term_en),
+		HSIO_SD_CFG_RX_TERM_EN,
+		macro->ctrl->regs, HSIO_SD_CFG(idx));
+
+	lan_rmw(HSIO_MPLL_CFG_REF_SSP_EN_SET(1),
+		HSIO_MPLL_CFG_REF_SSP_EN,
+		macro->ctrl->regs, HSIO_MPLL_CFG(idx));
+
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	lan_rmw(HSIO_SD_CFG_PHY_RESET_SET(0),
+		HSIO_SD_CFG_PHY_RESET,
+		macro->ctrl->regs, HSIO_SD_CFG(idx));
+
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	lan_rmw(HSIO_MPLL_CFG_MPLL_EN_SET(1),
+		HSIO_MPLL_CFG_MPLL_EN,
+		macro->ctrl->regs, HSIO_MPLL_CFG(idx));
+
+	usleep_range(7 * USEC_PER_MSEC, 8 * USEC_PER_MSEC);
+
+	value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
+	value = HSIO_SD_STAT_MPLL_STATE_GET(value);
+	if (value != 0x1) {
+		dev_err(macro->ctrl->dev,
+			"Unexpected sd_sd_stat[%u] mpll_state was 0x1 but is 0x%x\n",
+			idx, value);
+		return -EIO;
+	}
+
+	lan_rmw(HSIO_SD_CFG_TX_CM_EN_SET(1),
+		HSIO_SD_CFG_TX_CM_EN,
+		macro->ctrl->regs, HSIO_SD_CFG(idx));
+
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
+	value = HSIO_SD_STAT_TX_CM_STATE_GET(value);
+	if (value != 0x1) {
+		dev_err(macro->ctrl->dev,
+			"Unexpected sd_sd_stat[%u] tx_cm_state was 0x1 but is 0x%x\n",
+			idx, value);
+		return -EIO;
+	}
+
+	lan_rmw(HSIO_SD_CFG_RX_PLL_EN_SET(1) |
+		HSIO_SD_CFG_TX_EN_SET(1),
+		HSIO_SD_CFG_RX_PLL_EN |
+		HSIO_SD_CFG_TX_EN,
+		macro->ctrl->regs, HSIO_SD_CFG(idx));
+
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	/* Waiting for serdes 0 rx DPLL to lock...  */
+	value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
+	value = HSIO_SD_STAT_RX_PLL_STATE_GET(value);
+	if (value != 0x1) {
+		dev_err(macro->ctrl->dev,
+			"Unexpected sd_sd_stat[%u] rx_pll_state was 0x1 but is 0x%x\n",
+			idx, value);
+		return -EIO;
+	}
+
+	/* Waiting for serdes 0 tx operational...  */
+	value = readl(macro->ctrl->regs + lan_offset(HSIO_SD_STAT(idx)));
+	value = HSIO_SD_STAT_TX_STATE_GET(value);
+	if (value != 0x1) {
+		dev_err(macro->ctrl->dev,
+			"Unexpected sd_sd_stat[%u] tx_state was 0x1 but is 0x%x\n",
+			idx, value);
+		return -EIO;
+	}
+
+	lan_rmw(HSIO_SD_CFG_TX_DATA_EN_SET(1) |
+		HSIO_SD_CFG_RX_DATA_EN_SET(1),
+		HSIO_SD_CFG_TX_DATA_EN |
+		HSIO_SD_CFG_RX_DATA_EN,
+		macro->ctrl->regs, HSIO_SD_CFG(idx));
+
+	return 0;
+}
+
+static int lan966x_sd6g40_get_conf_from_mode(struct serdes_macro *macro,
+					     enum lan966x_sd6g40_mode f_mode,
+					     bool ref125M,
+					     struct lan966x_sd6g40_mode_args *ret_val)
+{
+	switch (f_mode) {
+	case LAN966X_SD6G40_MODE_QSGMII:
+		ret_val->lane_10bit_sel = 0;
+		if (ref125M) {
+			ret_val->mpll_multiplier = 40;
+			ret_val->ref_clkdiv2 = 0x1;
+			ret_val->tx_rate = 0x0;
+			ret_val->rx_rate = 0x0;
+		} else {
+			ret_val->mpll_multiplier = 100;
+			ret_val->ref_clkdiv2 = 0x0;
+			ret_val->tx_rate = 0x0;
+			ret_val->rx_rate = 0x0;
+		}
+		break;
+
+	case LAN966X_SD6G40_MODE_SGMII:
+		ret_val->lane_10bit_sel = 1;
+		if (ref125M) {
+			ret_val->mpll_multiplier = macro->speed == SPEED_2500 ? 50 : 40;
+			ret_val->ref_clkdiv2 = 0x1;
+			ret_val->tx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
+			ret_val->rx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
+		} else {
+			ret_val->mpll_multiplier = macro->speed == SPEED_2500 ? 125 : 100;
+			ret_val->ref_clkdiv2 = 0x0;
+			ret_val->tx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
+			ret_val->rx_rate = macro->speed == SPEED_2500 ? 0x1 : 0x2;
+		}
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int lan966x_calc_sd6g40_setup_lane(struct serdes_macro *macro,
+					  struct lan966x_sd6g40_setup_args config,
+					  struct lan966x_sd6g40_setup *ret_val)
+{
+	struct lan966x_sd6g40_mode_args sd6g40_mode;
+	struct lan966x_sd6g40_mode_args *mode_args = &sd6g40_mode;
+	int ret;
+
+	ret = lan966x_sd6g40_get_conf_from_mode(macro, config.mode,
+						config.refclk125M, mode_args);
+	if (ret)
+		return ret;
+
+	ret_val->lane_10bit_sel = mode_args->lane_10bit_sel;
+	ret_val->rx_rate = mode_args->rx_rate;
+	ret_val->tx_rate = mode_args->tx_rate;
+	ret_val->mpll_multiplier = mode_args->mpll_multiplier;
+	ret_val->ref_clkdiv2 = mode_args->ref_clkdiv2;
+	ret_val->rx_term_en = 0;
+
+	if (config.tx2rx_loop == LAN966X_SD6G40_LTX2RX)
+		ret_val->lane_loopbk_en = 1;
+	else
+		ret_val->lane_loopbk_en = 0;
+
+	ret_val->tx_invert = !!config.txinvert;
+	ret_val->rx_invert = !!config.rxinvert;
+
+	return 0;
+}
+
+static int lan966x_sd6g40_setup_lane(struct serdes_macro *macro,
+				     struct lan966x_sd6g40_setup_args config,
+				     u32 idx)
+{
+	struct lan966x_sd6g40_setup calc_results = {};
+	int ret;
+
+	ret = lan966x_calc_sd6g40_setup_lane(macro, config, &calc_results);
+	if (ret)
+		return ret;
+
+	return lan966x_sd6g40_reg_cfg(macro, &calc_results, idx);
+}
+
+static int lan966x_sd6g40_setup(struct serdes_macro *macro, u32 idx, int mode)
+{
+	struct lan966x_sd6g40_setup_args conf = {};
+
+	conf.refclk125M = macro->ctrl->ref125;
+
+	if (mode == PHY_INTERFACE_MODE_QSGMII)
+		conf.mode = LAN966X_SD6G40_MODE_QSGMII;
+	else
+		conf.mode = LAN966X_SD6G40_MODE_SGMII;
+
+	return lan966x_sd6g40_setup_lane(macro, conf, idx);
+}
+
+static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct serdes_macro *macro = phy_get_drvdata(phy);
+	unsigned int i;
+	int val;
+
+	/* As of now only PHY_MODE_ETHERNET is supported */
+	if (mode != PHY_MODE_ETHERNET)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < ARRAY_SIZE(lan966x_serdes_muxes); i++) {
+		if (macro->idx != lan966x_serdes_muxes[i].idx ||
+		    mode != lan966x_serdes_muxes[i].mode ||
+		    submode != lan966x_serdes_muxes[i].submode ||
+		    macro->port != lan966x_serdes_muxes[i].port)
+			continue;
+
+		val = readl(macro->ctrl->regs + lan_offset(HSIO_HW_CFG));
+		val |= lan966x_serdes_muxes[i].mux;
+		lan_rmw(val, lan966x_serdes_muxes[i].mask,
+			macro->ctrl->regs, HSIO_HW_CFG);
+
+		macro->mode = lan966x_serdes_muxes[i].submode;
+
+		if (macro->idx < CU_MAX)
+			return 0;
+
+		if (macro->idx < SERDES6G_MAX)
+			return lan966x_sd6g40_setup(macro,
+						    macro->idx - (CU_MAX + 1),
+						    macro->mode);
+
+		if (macro->idx < RGMII_MAX)
+			return 0;
+
+		return -EOPNOTSUPP;
+	}
+
+	return -EINVAL;
+}
+
+static int serdes_set_speed(struct phy *phy, int speed)
+{
+	struct serdes_macro *macro = phy_get_drvdata(phy);
+
+	macro->speed = speed;
+
+	return lan966x_sd6g40_setup(macro, macro->idx - (CU_MAX + 1),
+				    macro->mode);
+}
+
+static const struct phy_ops serdes_ops = {
+	.set_mode	= serdes_set_mode,
+	.set_speed	= serdes_set_speed,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *serdes_simple_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	struct serdes_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int port, idx, i;
+
+	if (args->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	port = args->args[0];
+	idx = args->args[1];
+
+	for (i = 0; i < SERDES_MAX; i++) {
+		struct serdes_macro *macro = phy_get_drvdata(ctrl->phys[i]);
+
+		if (idx != macro->idx)
+			continue;
+
+		macro->port = port;
+		return ctrl->phys[i];
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int serdes_phy_create(struct serdes_ctrl *ctrl, u8 idx, struct phy **phy)
+{
+	struct serdes_macro *macro;
+
+	*phy = devm_phy_create(ctrl->dev, NULL, &serdes_ops);
+	if (IS_ERR(*phy))
+		return PTR_ERR(*phy);
+
+	macro = devm_kzalloc(ctrl->dev, sizeof(*macro), GFP_KERNEL);
+	if (!macro)
+		return -ENOMEM;
+
+	macro->idx = idx;
+	macro->ctrl = ctrl;
+	macro->speed = SPEED_1000;
+	macro->port = -1;
+
+	phy_set_drvdata(*phy, macro);
+
+	return 0;
+}
+
+static int serdes_probe(struct platform_device *pdev)
+{
+	struct phy_provider *provider;
+	struct serdes_ctrl *ctrl;
+	void __iomem *hw_stat;
+	unsigned int i;
+	u32 val;
+	int ret;
+
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->dev = &pdev->dev;
+	ctrl->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(ctrl->regs))
+		return PTR_ERR(ctrl->regs);
+
+	hw_stat = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+	if (IS_ERR(hw_stat))
+		return PTR_ERR(hw_stat);
+
+	for (i = 0; i < SERDES_MAX; i++) {
+		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);
+		if (ret)
+			return ret;
+	}
+
+	val = readl(hw_stat);
+	val = FIELD_GET(PLL_CONF_MASK, val);
+	ctrl->ref125 = (val == PLL_CONF_125MHZ ||
+			val == PLL_CONF_SERDES_125MHZ);
+
+	dev_set_drvdata(&pdev->dev, ctrl);
+
+	provider = devm_of_phy_provider_register(ctrl->dev,
+						 serdes_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id serdes_ids[] = {
+	{ .compatible = "microchip,lan966x-serdes", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, serdes_ids);
+
+static struct platform_driver mscc_lan966x_serdes = {
+	.probe		= serdes_probe,
+	.driver		= {
+		.name	= "microchip,lan966x-serdes",
+		.of_match_table = of_match_ptr(serdes_ids),
+	},
+};
+
+module_platform_driver(mscc_lan966x_serdes);
+
+MODULE_DESCRIPTION("Microchip lan966x switch serdes driver");
+MODULE_AUTHOR("Horatiu Vultur <horatiu.vultur@microchip.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/microchip/lan966x_serdes_regs.h b/drivers/phy/microchip/lan966x_serdes_regs.h
new file mode 100644
index 000000000000..ea30f64ffd5c
--- /dev/null
+++ b/drivers/phy/microchip/lan966x_serdes_regs.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LAN966X_SERDES_REGS_H_
+#define _LAN966X_SERDES_REGS_H_
+
+#include <linux/bitfield.h>
+#include <linux/types.h>
+#include <linux/bug.h>
+
+enum lan966x_target {
+	TARGET_HSIO = 32,
+	NUM_TARGETS = 66
+};
+
+#define __REG(...)    __VA_ARGS__
+
+/*      HSIO:SD:SD_CFG */
+#define HSIO_SD_CFG(g)            __REG(TARGET_HSIO, 0, 1, 8, g, 3, 32, 0, 0, 1, 4)
+
+#define HSIO_SD_CFG_PHY_RESET                    BIT(27)
+#define HSIO_SD_CFG_PHY_RESET_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_PHY_RESET, x)
+#define HSIO_SD_CFG_PHY_RESET_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_PHY_RESET, x)
+
+#define HSIO_SD_CFG_TX_RESET                     BIT(18)
+#define HSIO_SD_CFG_TX_RESET_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_TX_RESET, x)
+#define HSIO_SD_CFG_TX_RESET_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_TX_RESET, x)
+
+#define HSIO_SD_CFG_TX_RATE                      GENMASK(17, 16)
+#define HSIO_SD_CFG_TX_RATE_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_TX_RATE, x)
+#define HSIO_SD_CFG_TX_RATE_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_TX_RATE, x)
+
+#define HSIO_SD_CFG_TX_INVERT                    BIT(15)
+#define HSIO_SD_CFG_TX_INVERT_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_TX_INVERT, x)
+#define HSIO_SD_CFG_TX_INVERT_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_TX_INVERT, x)
+
+#define HSIO_SD_CFG_TX_EN                        BIT(14)
+#define HSIO_SD_CFG_TX_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_TX_EN, x)
+#define HSIO_SD_CFG_TX_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_TX_EN, x)
+
+#define HSIO_SD_CFG_TX_DATA_EN                   BIT(12)
+#define HSIO_SD_CFG_TX_DATA_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_TX_DATA_EN, x)
+#define HSIO_SD_CFG_TX_DATA_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_TX_DATA_EN, x)
+
+#define HSIO_SD_CFG_TX_CM_EN                     BIT(11)
+#define HSIO_SD_CFG_TX_CM_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_TX_CM_EN, x)
+#define HSIO_SD_CFG_TX_CM_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_TX_CM_EN, x)
+
+#define HSIO_SD_CFG_LANE_10BIT_SEL               BIT(10)
+#define HSIO_SD_CFG_LANE_10BIT_SEL_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_LANE_10BIT_SEL, x)
+#define HSIO_SD_CFG_LANE_10BIT_SEL_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_LANE_10BIT_SEL, x)
+
+#define HSIO_SD_CFG_RX_TERM_EN                   BIT(9)
+#define HSIO_SD_CFG_RX_TERM_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_RX_TERM_EN, x)
+#define HSIO_SD_CFG_RX_TERM_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_RX_TERM_EN, x)
+
+#define HSIO_SD_CFG_RX_RESET                     BIT(8)
+#define HSIO_SD_CFG_RX_RESET_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_RX_RESET, x)
+#define HSIO_SD_CFG_RX_RESET_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_RX_RESET, x)
+
+#define HSIO_SD_CFG_RX_RATE                      GENMASK(7, 6)
+#define HSIO_SD_CFG_RX_RATE_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_RX_RATE, x)
+#define HSIO_SD_CFG_RX_RATE_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_RX_RATE, x)
+
+#define HSIO_SD_CFG_RX_PLL_EN                    BIT(5)
+#define HSIO_SD_CFG_RX_PLL_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_RX_PLL_EN, x)
+#define HSIO_SD_CFG_RX_PLL_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_RX_PLL_EN, x)
+
+#define HSIO_SD_CFG_RX_INVERT                    BIT(3)
+#define HSIO_SD_CFG_RX_INVERT_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_RX_INVERT, x)
+#define HSIO_SD_CFG_RX_INVERT_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_RX_INVERT, x)
+
+#define HSIO_SD_CFG_RX_DATA_EN                   BIT(2)
+#define HSIO_SD_CFG_RX_DATA_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_RX_DATA_EN, x)
+#define HSIO_SD_CFG_RX_DATA_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_RX_DATA_EN, x)
+
+#define HSIO_SD_CFG_LANE_LOOPBK_EN               BIT(0)
+#define HSIO_SD_CFG_LANE_LOOPBK_EN_SET(x)\
+	FIELD_PREP(HSIO_SD_CFG_LANE_LOOPBK_EN, x)
+#define HSIO_SD_CFG_LANE_LOOPBK_EN_GET(x)\
+	FIELD_GET(HSIO_SD_CFG_LANE_LOOPBK_EN, x)
+
+/*      HSIO:SD:MPLL_CFG */
+#define HSIO_MPLL_CFG(g)          __REG(TARGET_HSIO, 0, 1, 8, g, 3, 32, 8, 0, 1, 4)
+
+#define HSIO_MPLL_CFG_REF_SSP_EN                 BIT(18)
+#define HSIO_MPLL_CFG_REF_SSP_EN_SET(x)\
+	FIELD_PREP(HSIO_MPLL_CFG_REF_SSP_EN, x)
+#define HSIO_MPLL_CFG_REF_SSP_EN_GET(x)\
+	FIELD_GET(HSIO_MPLL_CFG_REF_SSP_EN, x)
+
+#define HSIO_MPLL_CFG_REF_CLKDIV2                BIT(17)
+#define HSIO_MPLL_CFG_REF_CLKDIV2_SET(x)\
+	FIELD_PREP(HSIO_MPLL_CFG_REF_CLKDIV2, x)
+#define HSIO_MPLL_CFG_REF_CLKDIV2_GET(x)\
+	FIELD_GET(HSIO_MPLL_CFG_REF_CLKDIV2, x)
+
+#define HSIO_MPLL_CFG_MPLL_EN                    BIT(16)
+#define HSIO_MPLL_CFG_MPLL_EN_SET(x)\
+	FIELD_PREP(HSIO_MPLL_CFG_MPLL_EN, x)
+#define HSIO_MPLL_CFG_MPLL_EN_GET(x)\
+	FIELD_GET(HSIO_MPLL_CFG_MPLL_EN, x)
+
+#define HSIO_MPLL_CFG_MPLL_MULTIPLIER            GENMASK(6, 0)
+#define HSIO_MPLL_CFG_MPLL_MULTIPLIER_SET(x)\
+	FIELD_PREP(HSIO_MPLL_CFG_MPLL_MULTIPLIER, x)
+#define HSIO_MPLL_CFG_MPLL_MULTIPLIER_GET(x)\
+	FIELD_GET(HSIO_MPLL_CFG_MPLL_MULTIPLIER, x)
+
+/*      HSIO:SD:SD_STAT */
+#define HSIO_SD_STAT(g)           __REG(TARGET_HSIO, 0, 1, 8, g, 3, 32, 12, 0, 1, 4)
+
+#define HSIO_SD_STAT_MPLL_STATE                  BIT(6)
+#define HSIO_SD_STAT_MPLL_STATE_SET(x)\
+	FIELD_PREP(HSIO_SD_STAT_MPLL_STATE, x)
+#define HSIO_SD_STAT_MPLL_STATE_GET(x)\
+	FIELD_GET(HSIO_SD_STAT_MPLL_STATE, x)
+
+#define HSIO_SD_STAT_TX_STATE                    BIT(5)
+#define HSIO_SD_STAT_TX_STATE_SET(x)\
+	FIELD_PREP(HSIO_SD_STAT_TX_STATE, x)
+#define HSIO_SD_STAT_TX_STATE_GET(x)\
+	FIELD_GET(HSIO_SD_STAT_TX_STATE, x)
+
+#define HSIO_SD_STAT_TX_CM_STATE                 BIT(2)
+#define HSIO_SD_STAT_TX_CM_STATE_SET(x)\
+	FIELD_PREP(HSIO_SD_STAT_TX_CM_STATE, x)
+#define HSIO_SD_STAT_TX_CM_STATE_GET(x)\
+	FIELD_GET(HSIO_SD_STAT_TX_CM_STATE, x)
+
+#define HSIO_SD_STAT_RX_PLL_STATE                BIT(0)
+#define HSIO_SD_STAT_RX_PLL_STATE_SET(x)\
+	FIELD_PREP(HSIO_SD_STAT_RX_PLL_STATE, x)
+#define HSIO_SD_STAT_RX_PLL_STATE_GET(x)\
+	FIELD_GET(HSIO_SD_STAT_RX_PLL_STATE, x)
+
+/*      HSIO:HW_CFGSTAT:HW_CFG */
+#define HSIO_HW_CFG               __REG(TARGET_HSIO, 0, 1, 104, 0, 1, 52, 0, 0, 1, 4)
+
+#define HSIO_HW_CFG_RGMII_1_CFG                  BIT(15)
+#define HSIO_HW_CFG_RGMII_1_CFG_SET(x)\
+	(((x) << 15) & GENMASK(15, 15))
+#define HSIO_HW_CFG_RGMII_1_CFG_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_RGMII_1_CFG, x)
+
+#define HSIO_HW_CFG_RGMII_0_CFG                  BIT(14)
+#define HSIO_HW_CFG_RGMII_0_CFG_SET(x)\
+	(((x) << 14) & GENMASK(14, 14))
+#define HSIO_HW_CFG_RGMII_0_CFG_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_RGMII_0_CFG, x)
+
+#define HSIO_HW_CFG_RGMII_ENA                    GENMASK(13, 12)
+#define HSIO_HW_CFG_RGMII_ENA_SET(x)\
+	(((x) << 12) & GENMASK(13, 12))
+#define HSIO_HW_CFG_RGMII_ENA_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_RGMII_ENA, x)
+
+#define HSIO_HW_CFG_SD6G_0_CFG                   BIT(11)
+#define HSIO_HW_CFG_SD6G_0_CFG_SET(x)\
+	(((x) << 11) & GENMASK(11, 11))
+#define HSIO_HW_CFG_SD6G_0_CFG_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_SD6G_0_CFG, x)
+
+#define HSIO_HW_CFG_SD6G_1_CFG                   BIT(10)
+#define HSIO_HW_CFG_SD6G_1_CFG_SET(x)\
+	(((x) << 10) & GENMASK(10, 10))
+#define HSIO_HW_CFG_SD6G_1_CFG_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_SD6G_1_CFG, x)
+
+#define HSIO_HW_CFG_GMII_ENA                     GENMASK(9, 2)
+#define HSIO_HW_CFG_GMII_ENA_SET(x)\
+	(((x) << 2) & GENMASK(9, 2))
+#define HSIO_HW_CFG_GMII_ENA_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_GMII_ENA, x)
+
+#define HSIO_HW_CFG_QSGMII_ENA                   GENMASK(1, 0)
+#define HSIO_HW_CFG_QSGMII_ENA_SET(x)\
+	((x) & GENMASK(1, 0))
+#define HSIO_HW_CFG_QSGMII_ENA_GET(x)\
+	FIELD_GET(HSIO_HW_CFG_QSGMII_ENA, x)
+
+#endif /* _LAN966X_HSIO_REGS_H_ */
-- 
2.33.0

