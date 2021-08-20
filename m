Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43F3F2F89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhHTPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235928AbhHTPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38DC76023E;
        Fri, 20 Aug 2021 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629473749;
        bh=gVTnjd7qDeSDn7OXiciCkcJVukEZlvqXyiue/VedwNc=;
        h=From:To:Cc:Subject:Date:From;
        b=r3PrEttVV9sIIcDzYc6uD7EUb9243D/dEE6taCn1ottMEVSiAfyTZX0dThcVo0Zkc
         Y4SZ12fgrnnjQA+naq2X79vWbZLBv7nspUZ2RY7E37hSLL+5RkOfZJoWtZ0lKXVZ+j
         Xl1alUR/+gIMQXi/0br0ziranmOsa9alFrXlDN8GhBzCUKrjMxwrcVMdrY5U/alH4a
         kTuOFSXdbDyyxql8PA9icQh3ufwhB0zFeZKW9hTTB6Ct8aGM3ThM2kDNj8j+qlrong
         qdjQaaOA6Arkzo3bbyJmnj9M143RpvYjRG1a0j5KDDMgI7YZo9vFeiF+tmhSokHRAD
         gVWyI5ZUo7E0g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mH6Yd-00Gcrn-4i; Fri, 20 Aug 2021 17:35:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: HiSilicon: clk-hi3670: mark critical clocks as such
Date:   Fri, 20 Aug 2021 17:35:43 +0200
Message-Id: <92f1641972bf899847e54ee041a95bb7c1bbff71.1629473738.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed-rate and fixed_factor clocks are critical to the
system: disabling them causes HiKey970 to not finish booting.

There are a couple of other clocks that makes the Kernel to
panic with SError if they got disabled.

So, mark them with CLK_IS_CRITICAL, in order to prevent the
Clock core to disable them if they're not explicitly used by
some driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3670.c | 96 +++++++++++++++---------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index 4d05a71683a5..f24bb88deb26 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -14,66 +14,66 @@
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3670_fixed_rate_clks[] = {
-	{ HI3670_CLKIN_SYS, "clkin_sys", NULL, 0, 19200000, },
-	{ HI3670_CLKIN_REF, "clkin_ref", NULL, 0, 32764, },
-	{ HI3670_CLK_FLL_SRC, "clk_fll_src", NULL, 0, 134400000, },
-	{ HI3670_CLK_PPLL0, "clk_ppll0", NULL, 0, 1660000000, },
-	{ HI3670_CLK_PPLL1, "clk_ppll1", NULL, 0, 1866000000, },
-	{ HI3670_CLK_PPLL2, "clk_ppll2", NULL, 0, 1920000000, },
-	{ HI3670_CLK_PPLL3, "clk_ppll3", NULL, 0, 1200000000, },
-	{ HI3670_CLK_PPLL4, "clk_ppll4", NULL, 0, 900000000, },
-	{ HI3670_CLK_PPLL6, "clk_ppll6", NULL, 0, 393216000, },
-	{ HI3670_CLK_PPLL7, "clk_ppll7", NULL, 0, 1008000000, },
-	{ HI3670_CLK_PPLL_PCIE, "clk_ppll_pcie", NULL, 0, 100000000, },
-	{ HI3670_CLK_PCIEPLL_REV, "clk_pciepll_rev", NULL, 0, 100000000, },
-	{ HI3670_CLK_SCPLL, "clk_scpll", NULL, 0, 245760000, },
-	{ HI3670_PCLK, "pclk", NULL, 0, 20000000, },
-	{ HI3670_CLK_UART0_DBG, "clk_uart0_dbg", NULL, 0, 19200000, },
-	{ HI3670_CLK_UART6, "clk_uart6", NULL, 0, 19200000, },
-	{ HI3670_OSC32K, "osc32k", NULL, 0, 32764, },
-	{ HI3670_OSC19M, "osc19m", NULL, 0, 19200000, },
-	{ HI3670_CLK_480M, "clk_480m", NULL, 0, 480000000, },
-	{ HI3670_CLK_INVALID, "clk_invalid", NULL, 0, 10000000, },
+	{ HI3670_CLKIN_SYS, "clkin_sys", NULL, CLK_IS_CRITICAL, 19200000, },
+	{ HI3670_CLKIN_REF, "clkin_ref", NULL, CLK_IS_CRITICAL, 32764, },
+	{ HI3670_CLK_FLL_SRC, "clk_fll_src", NULL, CLK_IS_CRITICAL, 134400000, },
+	{ HI3670_CLK_PPLL0, "clk_ppll0", NULL, CLK_IS_CRITICAL, 1660000000, },
+	{ HI3670_CLK_PPLL1, "clk_ppll1", NULL, CLK_IS_CRITICAL, 1866000000, },
+	{ HI3670_CLK_PPLL2, "clk_ppll2", NULL, CLK_IS_CRITICAL, 1920000000, },
+	{ HI3670_CLK_PPLL3, "clk_ppll3", NULL, CLK_IS_CRITICAL, 1200000000, },
+	{ HI3670_CLK_PPLL4, "clk_ppll4", NULL, CLK_IS_CRITICAL, 900000000, },
+	{ HI3670_CLK_PPLL6, "clk_ppll6", NULL, CLK_IS_CRITICAL, 393216000, },
+	{ HI3670_CLK_PPLL7, "clk_ppll7", NULL,  CLK_IS_CRITICAL, 1008000000, },
+	{ HI3670_CLK_PPLL_PCIE, "clk_ppll_pcie", NULL, CLK_IS_CRITICAL, 100000000, },
+	{ HI3670_CLK_PCIEPLL_REV, "clk_pciepll_rev", NULL, CLK_IS_CRITICAL, 100000000, },
+	{ HI3670_CLK_SCPLL, "clk_scpll", NULL, CLK_IS_CRITICAL, 245760000, },
+	{ HI3670_PCLK, "pclk", NULL, CLK_IS_CRITICAL, 20000000, },
+	{ HI3670_CLK_UART0_DBG, "clk_uart0_dbg", NULL, CLK_IS_CRITICAL, 19200000, },
+	{ HI3670_CLK_UART6, "clk_uart6", NULL, CLK_IS_CRITICAL, 19200000, },
+	{ HI3670_OSC32K, "osc32k", NULL, CLK_IS_CRITICAL, 32764, },
+	{ HI3670_OSC19M, "osc19m", NULL, CLK_IS_CRITICAL, 19200000, },
+	{ HI3670_CLK_480M, "clk_480m", NULL, CLK_IS_CRITICAL, 480000000, },
+	{ HI3670_CLK_INVALID, "clk_invalid", NULL, CLK_IS_CRITICAL, 10000000, },
 };
 
 /* crgctrl */
 static const struct hisi_fixed_factor_clock hi3670_crg_fixed_factor_clks[] = {
 	{ HI3670_CLK_DIV_SYSBUS, "clk_div_sysbus", "clk_mux_sysbus",
-	  1, 7, 0, },
+	  1, 7, CLK_IS_CRITICAL },
 	{ HI3670_CLK_FACTOR_MMC, "clk_factor_mmc", "clkin_sys",
-	  1, 6, 0, },
+	  1, 6, CLK_IS_CRITICAL },
 	{ HI3670_CLK_SD_SYS, "clk_sd_sys", "clk_sd_sys_gt",
-	  1, 6, 0, },
+	  1, 6, CLK_IS_CRITICAL },
 	{ HI3670_CLK_SDIO_SYS, "clk_sdio_sys", "clk_sdio_sys_gt",
-	  1, 6, 0, },
+	  1, 6, CLK_IS_CRITICAL },
 	{ HI3670_CLK_DIV_A53HPM, "clk_div_a53hpm", "clk_a53hpm_andgt",
-	  1, 4, 0, },
+	  1, 4, CLK_IS_CRITICAL },
 	{ HI3670_CLK_DIV_320M, "clk_div_320m", "clk_320m_pll_gt",
-	  1, 5, 0, },
+	  1, 5, CLK_IS_CRITICAL },
 	{ HI3670_PCLK_GATE_UART0, "pclk_gate_uart0", "clk_mux_uartl",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_CLK_FACTOR_UART0, "clk_factor_uart0", "clk_mux_uart0",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_CLK_FACTOR_USB3PHY_PLL, "clk_factor_usb3phy_pll", "clk_ppll0",
-	  1, 60, 0, },
+	  1, 60, CLK_IS_CRITICAL },
 	{ HI3670_CLK_GATE_ABB_USB, "clk_gate_abb_usb", "clk_gate_usb_tcxo_en",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_CLK_GATE_UFSPHY_REF, "clk_gate_ufsphy_ref", "clkin_sys",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_ICS_VOLT_HIGH, "ics_volt_high", "peri_volt_hold",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_ICS_VOLT_MIDDLE, "ics_volt_middle", "peri_volt_middle",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_VENC_VOLT_HOLD, "venc_volt_hold", "peri_volt_hold",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_VDEC_VOLT_HOLD, "vdec_volt_hold", "peri_volt_hold",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_EDC_VOLT_HOLD, "edc_volt_hold", "peri_volt_hold",
-	  1, 1, 0, },
+	  1, 1, CLK_IS_CRITICAL },
 	{ HI3670_CLK_ISP_SNCLK_FAC, "clk_isp_snclk_fac", "clk_isp_snclk_angt",
-	  1, 10, 0, },
+	  1, 10, CLK_IS_CRITICAL },
 	{ HI3670_CLK_FACTOR_RXDPHY, "clk_factor_rxdphy", "clk_andgt_rxdphy",
-	  1, 6, 0, },
+	  1, 6, CLK_IS_CRITICAL },
 };
 
 static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
@@ -82,13 +82,13 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_PPLL2_EN_ACPU, "ppll2_en_acpu", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x0, 3, 0, },
 	{ HI3670_PPLL3_EN_ACPU, "ppll3_en_acpu", "clk_ppll3",
-	  CLK_SET_RATE_PARENT, 0x0, 27, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x0, 27, 0, },
 	{ HI3670_PPLL1_GT_CPU, "ppll1_gt_cpu", "clk_ppll1",
 	  CLK_SET_RATE_PARENT, 0x460, 16, 0, },
 	{ HI3670_PPLL2_GT_CPU, "ppll2_gt_cpu", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x460, 18, 0, },
 	{ HI3670_PPLL3_GT_CPU, "ppll3_gt_cpu", "clk_ppll3",
-	  CLK_SET_RATE_PARENT, 0x460, 20, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x460, 20, 0, },
 	{ HI3670_CLK_GATE_PPLL2_MEDIA, "clk_gate_ppll2_media", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0x410, 27, 0, },
 	{ HI3670_CLK_GATE_PPLL3_MEDIA, "clk_gate_ppll3_media", "clk_ppll3",
@@ -158,7 +158,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_MMC0_IOC, "pclk_gate_mmc0_ioc", "clk_div_mmc0bus",
 	  CLK_SET_RATE_PARENT, 0x40, 13, 0, },
 	{ HI3670_PCLK_GATE_MMC1_IOC, "pclk_gate_mmc1_ioc", "clk_div_mmc1bus",
-	  CLK_SET_RATE_PARENT, 0x420, 21, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x420, 21, 0, },
 	{ HI3670_CLK_GATE_DMAC, "clk_gate_dmac", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x30, 1, 0, },
 	{ HI3670_CLK_GATE_VCODECBUS2DDR, "clk_gate_vcodecbus2ddr", "clk_div_vcodecbus",
@@ -166,7 +166,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_CLK_CCI400_BYPASS, "clk_cci400_bypass", "clk_ddrc_freq",
 	  CLK_SET_RATE_PARENT, 0x22C, 28, 0, },
 	{ HI3670_CLK_GATE_CCI400, "clk_gate_cci400", "clk_ddrc_freq",
-	  CLK_SET_RATE_PARENT, 0x50, 14, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x50, 14, 0, },
 	{ HI3670_CLK_GATE_SD, "clk_gate_sd", "clk_mux_sd_sys",
 	  CLK_SET_RATE_PARENT, 0x40, 17, 0, },
 	{ HI3670_HCLK_GATE_SD, "hclk_gate_sd", "clk_div_sysbus",
@@ -248,7 +248,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_sep_clks[] = {
 	{ HI3670_CLK_GATE_AO_ASP, "clk_gate_ao_asp", "clk_div_ao_asp",
 	  CLK_SET_RATE_PARENT, 0x0, 26, 0, },
 	{ HI3670_PCLK_GATE_PCTRL, "pclk_gate_pctrl", "clk_div_ptp",
-	  CLK_SET_RATE_PARENT, 0x20, 31, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x20, 31, 0, },
 	{ HI3670_CLK_CSI_TRANS_GT, "clk_csi_trans_gt", "clk_div_csi_trans",
 	  CLK_SET_RATE_PARENT, 0x30, 24, 0, },
 	{ HI3670_CLK_DSI_TRANS_GT, "clk_dsi_trans_gt", "clk_div_dsi_trans",
@@ -301,7 +301,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_clks[] = {
 	{ HI3670_PCLK_ANDGT_MMC1_PCIE, "pclk_andgt_mmc1_pcie", "clk_div_320m",
 	  CLK_SET_RATE_PARENT, 0xf8, 13, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_GATE_VCODECBUS_GT, "clk_gate_vcodecbus_gt", "clk_mux_vcodecbus",
-	  CLK_SET_RATE_PARENT, 0x0F0, 8, CLK_GATE_HIWORD_MASK, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x0F0, 8, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_SD, "clk_andgt_sd", "clk_mux_sd_pll",
 	  CLK_SET_RATE_PARENT, 0xF4, 3, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_SD_SYS_GT, "clk_sd_sys_gt", "clkin_sys",
@@ -331,7 +331,7 @@ static const struct hisi_gate_clock hi3670_crgctrl_gate_clks[] = {
 	{ HI3670_CLK_GATE_DSI_TRANS, "clk_gate_dsi_trans", "clk_ppll2",
 	  CLK_SET_RATE_PARENT, 0xF4, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_PTP, "clk_andgt_ptp", "clk_div_320m",
-	  CLK_SET_RATE_PARENT, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0xF8, 5, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT0, "clk_andgt_out0", "clk_ppll0",
 	  CLK_SET_RATE_PARENT, 0xF0, 10, CLK_GATE_HIWORD_MASK, },
 	{ HI3670_CLK_ANDGT_OUT1, "clk_andgt_out1", "clk_ppll0",
@@ -569,9 +569,9 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_SPI, "pclk_gate_spi", "clk_div_ioperi",
 	  CLK_SET_RATE_PARENT, 0x1B0, 10, 0, },
 	{ HI3670_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_ufs_subsys",
-	  CLK_SET_RATE_PARENT, 0x1B0, 14, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x1B0, 14, 0, },
 	{ HI3670_CLK_GATE_UFSIO_REF, "clk_gate_ufsio_ref", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x1b0, 12, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x1b0, 12, 0, },
 	{ HI3670_PCLK_AO_GPIO0, "pclk_ao_gpio0", "clk_div_aobus",
 	  CLK_SET_RATE_PARENT, 0x160, 11, 0, },
 	{ HI3670_PCLK_AO_GPIO1, "pclk_ao_gpio1", "clk_div_aobus",
@@ -593,7 +593,7 @@ static const struct hisi_gate_clock hi3670_sctrl_gate_sep_clks[] = {
 	{ HI3670_PCLK_GATE_SYSCNT, "pclk_gate_syscnt", "clk_div_aobus",
 	  CLK_SET_RATE_PARENT, 0x160, 19, 0, },
 	{ HI3670_CLK_GATE_SYSCNT, "clk_gate_syscnt", "clkin_sys",
-	  CLK_SET_RATE_PARENT, 0x160, 20, 0, },
+	  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0x160, 20, 0, },
 	{ HI3670_CLK_GATE_ASP_SUBSYS_PERI, "clk_gate_asp_subsys_peri",
 	  "clk_mux_asp_subsys_peri",
 	  CLK_SET_RATE_PARENT, 0x170, 6, 0, },
-- 
2.31.1

