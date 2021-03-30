Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE134E373
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhC3Io1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhC3IoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:44:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6996660249;
        Tue, 30 Mar 2021 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617093845;
        bh=r0uuupAdCxJJpbeB1aFZbKAUjWGXy0u+SLRJVqsmgrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRY8eWdMHM92iseYUCBLzBhB2dkTjb8iSrZ7HNQ+pLUZsMjvmDDXOF3+Y1ya1qEzP
         sw4EPexb6rdaLXPt0IUMxd3qq4yRAeKYwCo8EYYuJCEdsQ+uEvUzcaOctAC+av866l
         p4cvWT548YWUkuP1GMYp5dQ6P2ngixUameHPgsIEXeUXi92FY6aIl1Sz0KmNYSiI/j
         ZilMmOCMSeCZVxYeZ+dX7wfaEj9RfOQZweUc4UMthTGThZXuEVEy4QDwcFjRbhykZb
         d9tXef3yeq9sXZbg9v+4BHQCZoKUifvf8xodmSfvYlEdyuqmuwh/sjfI1kgXWFOF+n
         9IIQwqgDqBK4g==
Date:   Tue, 30 Mar 2021 11:44:01 +0300
From:   Abel Vesa <abelvesa@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     abel.vesa@nxp.com, shawnguo@kernel.org, ping.bai@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
Message-ID: <YGLk0S2LO4GiKAOC@ryzen.lan>
References: <1615796268-9011-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615796268-9011-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-15 16:17:47, Richard Zhu wrote:
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

Applied, thanks.

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
