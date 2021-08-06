Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E663E2B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbhHFNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241700AbhHFNR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97FDC610FB;
        Fri,  6 Aug 2021 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628255861;
        bh=1Z7LeDLFF5o7wMGR7j6uGiu9CbMJ/5b/kBdkKapBM2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6aOhBvVE95DQ5TDZZRAEVrvHVt+JWyLemQ+ii70p+RwZMPY5SNy2o85TR2vpeC7S
         RTKSlYqOpQJc81+WkXJwpdv6aeE3hF+hoe6UrgS/HsJL163Yk2XHRveLWxDYLcZL4A
         cA731tXahQBaZgnKAnb04eYdcv+28zGp7KrV5N2TvHuKi2JHB178bpVwpgv2XBAv4V
         EwAmMZH9bVfUOTxDPY00APqyZ6SZwKiVx1rHVo79yb2S4xh4OleOB6m8w5qXDRUpgO
         sP6cTyXXos1HHaQ5Mz5zdUYJm0wnm22kWShrQl7u7WvLBy9xi38IJ70jX7MdBznfgV
         fTmcHx+Zz5FPg==
Date:   Fri, 6 Aug 2021 18:47:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v9 01/11] phy: HiSilicon: Add driver for Kirin 970 PCIe
 PHY
Message-ID: <YQ02cc1dtqQBlT4/@matsya>
References: <cover.1628092716.git.mchehab+huawei@kernel.org>
 <90aada2f51b58c162e199faf823ba887e50f1dc6.1628092716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90aada2f51b58c162e199faf823ba887e50f1dc6.1628092716.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-08-21, 18:02, Mauro Carvalho Chehab wrote:

> +/* define ie,oe cfg */
> +#define IO_IE_EN_HARD_BYPASS         (0x1 << 27)
> +#define IO_OE_EN_HARD_BYPASS         (0x1 << 11)
> +#define IO_HARD_CTRL_DEBOUNCE_BYPASS (0x1 << 10)
> +#define IO_OE_GT_MODE                (0x2 << 7)
> +#define DEBOUNCE_WAITCFG_IN          (0xf << 20)
> +#define DEBOUNCE_WAITCFG_OUT         (0xf << 13)

Why not use BIT() or GENMASK for these?

> +/* Registers in PCIePHY */
> +static inline void hi3670_apb_phy_writel(struct hi3670_pcie_phy *phy,
> +					 u32 val, u32 reg)
> +{
> +	writel(val, phy->base + 0x40000 + reg);

magic 0x40000?

> +}
> +
> +static inline u32 hi3670_apb_phy_readl(struct hi3670_pcie_phy *phy, u32 reg)
> +{
> +	return readl(phy->base + 0x40000 + reg);
> +}
> +
> +static inline void kirin_apb_natural_phy_writel(struct hi3670_pcie_phy *phy,
> +						u32 val, u32 reg)
> +{
> +	writel(val, phy->base + reg * 4);

why * 4 ..?

> +static void hi3670_pcie_set_eyeparam(struct hi3670_pcie_phy *phy)
> +{
> +	u32 val;
> +
> +	val = kirin_apb_natural_phy_readl(phy, RAWLANEN_DIG_PCS_XF_TX_OVRD_IN_1);
> +
> +	if (phy->eye_param[1] != EYEPARAM_NOCFG) {
> +		val &= (~0xf00);
> +		val |= (phy->eye_param[1] << 8) | (0x1 << 12);
> +	}

again too many magic numbers, Do check FIELD_GET/PREP macros for these?
-- 
~Vinod
