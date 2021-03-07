Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2633330120
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 14:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhCGNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 08:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhCGNP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 08:15:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C48BA65101;
        Sun,  7 Mar 2021 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615122959;
        bh=UiDPOCbalAXRXfE7w6/jPoptwzkmB0I2pUlCkFrlA8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hs5ZuoZBN/kPNVJVrlhAyAmi8BsQ72HL2Ua1/aI5uZXr1gHn4Jv7qM2CLSfl+DSi6
         cjrfq+XwCeHTgNRY1Rz3okT0PxQ8vR7uk4gUJKv+/80qGCR8y4v9QDktpFdo+lEOc5
         7G9IuJd6O136/UBQfGPGY0YoI4Ee128Rex7fjUUCKY3nNmwviXDBNgQ+UZn6GEoU5g
         KzVGaIHQemYnrcTVR+yBn/UOrE64OfH1LFsmth87bfSMRvky/sdVMSdBb0P7dLGPVP
         s50y6m9A0sS9dgLewDMkosI7HHiJi/AbgcXrEaNKR1mJIPv1MORR5HVKJw12hkxnVT
         3wEQzJ+oVFVFQ==
Date:   Sun, 7 Mar 2021 21:15:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Cc:     ping.bai@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx8mp: Remove the none exist pcie clocks
Message-ID: <20210307131553.GE543@dragon>
References: <1613637226-31447-1-git-send-email-hongxing.zhu@nxp.com>
 <1613637226-31447-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613637226-31447-2-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy Abel who is stepping up to maintain i.MX clock drivers.

Shawn

On Thu, Feb 18, 2021 at 04:33:46PM +0800, Richard Zhu wrote:
> In the i.MX8MP PCIe design, the PCIe PHY REF clock comes from external
> OSC or internal system PLL. It is configured in the IOMUX_GPR14 register
> directly, and can't be contolled by CCM at all.
> Remove the PCIE PHY clock from clock driver to clean up codes.
> There is only one PCIe in i.MX8MP, remove the none exist second PCIe
> related clocks.
> Remove the none exsits clocks IDs together.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c             | 15 ---------------
>  include/dt-bindings/clock/imx8mp-clock.h |  3 ---
>  2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 2f4e1d674e1c..afbeb6bf1909 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -152,10 +152,6 @@ static const char * const imx8mp_can2_sels[] = {"osc_24m", "sys_pll2_200m", "sys
>  						"sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
>  						"sys_pll2_250m", "audio_pll2_out", };
>  
> -static const char * const imx8mp_pcie_phy_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll2_500m",
> -						    "clk_ext1", "clk_ext2", "clk_ext3",
> -						    "clk_ext4", "sys_pll1_400m", };
> -
>  static const char * const imx8mp_pcie_aux_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m",
>  						    "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
>  						    "sys_pll1_160m", "sys_pll1_200m", };
> @@ -380,14 +376,6 @@ static const char * const imx8mp_memrepair_sels[] = {"osc_24m", "sys_pll2_100m",
>  							"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
>  							"clk_ext3", "audio_pll2_out", };
>  
> -static const char * const imx8mp_pcie2_ctrl_sels[] = {"osc_24m", "sys_pll2_250m", "sys_pll2_200m",
> -						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
> -						      "sys_pll2_333m", "sys_pll3_out", };
> -
> -static const char * const imx8mp_pcie2_phy_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll2_500m",
> -						     "clk_ext1", "clk_ext2", "clk_ext3",
> -						     "clk_ext4", "sys_pll1_400m", };
> -
>  static const char * const imx8mp_media_mipi_test_byte_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m",
>  								"sys_pll3_out", "sys_pll2_100m",
>  								"sys_pll1_80m", "sys_pll1_160m",
> @@ -585,7 +573,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
>  	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
>  	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
> -	hws[IMX8MP_CLK_PCIE_PHY] = imx8m_clk_hw_composite("pcie_phy", imx8mp_pcie_phy_sels, ccm_base + 0xa380);
>  	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
>  	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
>  	hws[IMX8MP_CLK_I2C6] = imx8m_clk_hw_composite("i2c6", imx8mp_i2c6_sels, ccm_base + 0xa500);
> @@ -643,8 +630,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
>  	hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
>  	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
> -	hws[IMX8MP_CLK_PCIE2_CTRL] = imx8m_clk_hw_composite("pcie2_ctrl", imx8mp_pcie2_ctrl_sels, ccm_base + 0xc000);
> -	hws[IMX8MP_CLK_PCIE2_PHY] = imx8m_clk_hw_composite("pcie2_phy", imx8mp_pcie2_phy_sels, ccm_base + 0xc080);
>  	hws[IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE] = imx8m_clk_hw_composite("media_mipi_test_byte", imx8mp_media_mipi_test_byte_sels, ccm_base + 0xc100);
>  	hws[IMX8MP_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mp_ecspi3_sels, ccm_base + 0xc180);
>  	hws[IMX8MP_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mp_pdm_sels, ccm_base + 0xc200);
> diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
> index e8d68fbb6e3f..43927a1b9e94 100644
> --- a/include/dt-bindings/clock/imx8mp-clock.h
> +++ b/include/dt-bindings/clock/imx8mp-clock.h
> @@ -125,7 +125,6 @@
>  #define IMX8MP_CLK_CAN1				116
>  #define IMX8MP_CLK_CAN2				117
>  #define IMX8MP_CLK_MEMREPAIR			118
> -#define IMX8MP_CLK_PCIE_PHY			119
>  #define IMX8MP_CLK_PCIE_AUX			120
>  #define IMX8MP_CLK_I2C5				121
>  #define IMX8MP_CLK_I2C6				122
> @@ -182,8 +181,6 @@
>  #define IMX8MP_CLK_MEDIA_CAM2_PIX		173
>  #define IMX8MP_CLK_MEDIA_LDB			174
>  #define IMX8MP_CLK_MEDIA_MIPI_CSI2_ESC		175
> -#define IMX8MP_CLK_PCIE2_CTRL			176
> -#define IMX8MP_CLK_PCIE2_PHY			177
>  #define IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE		178
>  #define IMX8MP_CLK_ECSPI3			179
>  #define IMX8MP_CLK_PDM				180
> -- 
> 2.17.1
> 
