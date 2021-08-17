Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84533EEB22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhHQKnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239532AbhHQKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:43:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F4560F5C;
        Tue, 17 Aug 2021 10:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629196961;
        bh=qyvu3o7ZJY+LvfAyrXDyaik1HESpr7qHGm8p/EBGR+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4MKPkK++ZqbO136kmb8g5CAVT/lfqiHgU8NFLSvQjyeYh4h4n9Gamgs+qHMFjVuJ
         rqMESPWZc9aNYE6p81+a5RZvVGTCpgWfbNPkBSvoRzvF1DQqybaRFclgmxQU0sKMwg
         MLQWW9dQ9jxzqKIF4DLBQI/IWNCJ6m4H1QoMTidgWVsyf97qUgLEX4XpHNRl7dkNaV
         YDoQSg7PNEQb5xYsBFw4Nwc8i037hZyMWrL97iNBqC8NJWC8QR84LHu8AhIvftSyVC
         bKN2ugxjtM6koAAx6XtuWsgJq4eC4cUiwqFPFybk3u2GeV1aqyJc9MVRSFoPATGPTd
         hNKUmNw6lqTDA==
Date:   Tue, 17 Aug 2021 16:12:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v11 01/11] phy: HiSilicon: Add driver for Kirin 970 PCIe
 PHY
Message-ID: <YRuSnXHSZHhBC40r@matsya>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
 <7788c5ead6d6f5a6f9e5faaee4460eb2149967c4.1628755058.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7788c5ead6d6f5a6f9e5faaee4460eb2149967c4.1628755058.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-08-21, 10:02, Mauro Carvalho Chehab wrote:

> +static void hi3670_pcie_set_eyeparam(struct hi3670_pcie_phy *phy)
> +{
> +	u32 val;
> +
> +	val = kirin_apb_natural_phy_readl(phy,
> +					  RAWLANEN_DIG_PCS_XF_TX_OVRD_IN_1);

Maybe use one line for this (hint: we can go beyong 80 now)

> +static void hi3670_pcie_natural_cfg(struct hi3670_pcie_phy *phy)
> +{
> +	u32 val;
> +
> +	/* change 2p mem_ctrl */
> +	regmap_write(phy->apb, SOC_PCIECTRL_CTRL20_ADDR,
> +		     SOC_PCIECTRL_CTRL20_2P_MEM_CTRL);
> +
> +	regmap_read(phy->apb, SOC_PCIECTRL_CTRL7_ADDR, &val);
> +	val |= PCIE_PULL_UP_SYS_AUX_PWR_DET;
> +	regmap_write(phy->apb, SOC_PCIECTRL_CTRL7_ADDR, val);
> +
> +	/* output, pull down */
> +	regmap_read(phy->apb, SOC_PCIECTRL_CTRL12_ADDR, &val);
> +	val &= ~PCIE_OUTPUT_PULL_BITS;
> +	val |= PCIE_OUTPUT_PULL_DOWN;
> +	regmap_write(phy->apb, SOC_PCIECTRL_CTRL12_ADDR, val);
> +
> +	/* Handle phy_reset and lane0_reset to HW */
> +	val = hi3670_apb_phy_readl(phy, SOC_PCIEPHY_CTRL1_ADDR);
> +	val |= PCIEPHY_RESET_BIT;
> +	val &= ~PCIEPHY_PIPE_LINE0_RESET_BIT;
> +	hi3670_apb_phy_writel(phy, val, SOC_PCIEPHY_CTRL1_ADDR);
> +
> +	/* fix chip bug: TxDetectRx fail */
> +	val = hi3670_apb_phy_readl(phy, SOC_PCIEPHY_CTRL38_ADDR);
> +	val |= PCIE_TXDETECT_RX_FAIL;
> +	hi3670_apb_phy_writel(phy, val, SOC_PCIEPHY_CTRL38_ADDR);

maybe add a hi3670_apb_phy_updatel() so that above would become:

        hi3670_apb_phy_updatel(phy, val, mask);

> +static int hi3670_pcie_pll_ctrl(struct hi3670_pcie_phy *phy, bool enable)
> +{
> +	struct device *dev = phy->dev;
> +	u32 val;
> +	int time = PLL_CTRL_WAIT_TIME;
> +
> +	if (enable) {
> +		/* pd = 0 */
> +		val = hi3670_apb_phy_readl(phy, SOC_PCIEPHY_MMC1PLL_CTRL16);
> +		val &= ~PCIE_PHY_MMC1PLL_DISABLE;
> +		hi3670_apb_phy_writel(phy, val, SOC_PCIEPHY_MMC1PLL_CTRL16);
> +
> +		val = hi3670_apb_phy_readl(phy, SOC_PCIEPHY_MMC1PLL_STAT0);
> +
> +		/* choose FNPLL */
> +		while (!(val & FNPLL_HAS_LOCKED)) {
> +			if (!time) {
> +				dev_err(dev, "wait for pll_lock timeout\n");
> +				return -EINVAL;
> +			}
> +			time--;
> +			udelay(1);
> +			val = hi3670_apb_phy_readl(phy,
> +						   SOC_PCIEPHY_MMC1PLL_STAT0);

single line here too

> +static void hi3670_pcie_phyref_gt(struct hi3670_pcie_phy *phy, bool open)
> +{
> +	unsigned int val;
> +
> +	regmap_read(phy->crgctrl, CRGPERIPH_PCIECTRL0, &val);
> +
> +	if (open)
> +		val &= ~IO_OE_HARD_GT_MODE; // enable hard gt mode
> +	else
> +		val |= IO_OE_HARD_GT_MODE; // disable hard gt mode

pls change the comment style here and above, we dont use c99 style!

> +static int hi3670_pcie_phy_power_off(struct phy *generic_phy)
> +{
> +	struct hi3670_pcie_phy *phy = phy_get_drvdata(generic_phy);
> +
> +	hi3670_pcie_phy_oe_enable(phy, false);
> +
> +	hi3670_pcie_allclk_ctrl(phy, false);
> +
> +	/* Drop power supply for Host */
> +	regmap_write(phy->sysctrl, SCTRL_PCIE_CMOS_OFFSET, 0);
> +
> +	/* FIXME: calling it causes an Asynchronous SError interrupt */
> +//	kirin_pcie_clk_ctrl(phy, false);

when will you fix the fixme and pls remove the deadcode
-- 
~Vinod
