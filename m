Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91331E64D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBRGZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:25:34 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42424 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhBRGGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:06:53 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3818B1A073E;
        Thu, 18 Feb 2021 07:06:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 826301A074A;
        Thu, 18 Feb 2021 07:05:57 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 66215402BE;
        Thu, 18 Feb 2021 07:05:53 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org, ping.bai@nxp.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Date:   Thu, 18 Feb 2021 13:54:14 +0800
Message-Id: <1613627654-29801-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the i.MX8MP PCIe design, the PCIe PHY REF clock comes from external
OSC or internal system PLL. It is configured in the IOMUX_GPR14 register
directly, and can't be contolled by CCM at all.
Remove the PCIE PHY clock from clock driver to clean up codes.
There is only one PCIe in i.MX8MP, remove the none exist second PCIe
related clocks.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 2f4e1d674e1c..afbeb6bf1909 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -152,10 +152,6 @@ static const char * const imx8mp_can2_sels[] = {"osc_24m", "sys_pll2_200m", "sys
 						"sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						"sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mp_pcie_phy_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll2_500m",
-						    "clk_ext1", "clk_ext2", "clk_ext3",
-						    "clk_ext4", "sys_pll1_400m", };
-
 static const char * const imx8mp_pcie_aux_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m",
 						    "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
 						    "sys_pll1_160m", "sys_pll1_200m", };
@@ -380,14 +376,6 @@ static const char * const imx8mp_memrepair_sels[] = {"osc_24m", "sys_pll2_100m",
 							"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
 							"clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mp_pcie2_ctrl_sels[] = {"osc_24m", "sys_pll2_250m", "sys_pll2_200m",
-						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
-						      "sys_pll2_333m", "sys_pll3_out", };
-
-static const char * const imx8mp_pcie2_phy_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll2_500m",
-						     "clk_ext1", "clk_ext2", "clk_ext3",
-						     "clk_ext4", "sys_pll1_400m", };
-
 static const char * const imx8mp_media_mipi_test_byte_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m",
 								"sys_pll3_out", "sys_pll2_100m",
 								"sys_pll1_80m", "sys_pll1_160m",
@@ -585,7 +573,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
 	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
-	hws[IMX8MP_CLK_PCIE_PHY] = imx8m_clk_hw_composite("pcie_phy", imx8mp_pcie_phy_sels, ccm_base + 0xa380);
 	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
 	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
 	hws[IMX8MP_CLK_I2C6] = imx8m_clk_hw_composite("i2c6", imx8mp_i2c6_sels, ccm_base + 0xa500);
@@ -643,8 +630,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
 	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
 	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
-	hws[IMX8MP_CLK_PCIE2_CTRL] = imx8m_clk_hw_composite("pcie2_ctrl", imx8mp_pcie2_ctrl_sels, ccm_base + 0xc000);
-	hws[IMX8MP_CLK_PCIE2_PHY] = imx8m_clk_hw_composite("pcie2_phy", imx8mp_pcie2_phy_sels, ccm_base + 0xc080);
 	hws[IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE] = imx8m_clk_hw_composite("media_mipi_test_byte", imx8mp_media_mipi_test_byte_sels, ccm_base + 0xc100);
 	hws[IMX8MP_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mp_ecspi3_sels, ccm_base + 0xc180);
 	hws[IMX8MP_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mp_pdm_sels, ccm_base + 0xc200);
-- 
2.17.1

