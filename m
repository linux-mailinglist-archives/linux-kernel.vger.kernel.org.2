Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF233EAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCQIDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhCQICz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:02:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0956764F7F;
        Wed, 17 Mar 2021 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615968175;
        bh=VBWyC0AQWdK/gpdmOt5WMEjE86RYZxAY4NgdfMK7TXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKOs3Mg065I+HEsUnyyeIVRxZFZWT0+hJHuzmmJ9zpXeXXkN3nb0gvR8P96ngqJaF
         ZcIlXOrHsyHfo/KAwz241qxNE5oRO6duJ/RyRyoZjMGI15LxFOdD/xDRKmtHjLupNs
         2C3YX11P+gwdw3bF81OiJ0EVfequzNs1yUetfeWKQb9S3BX0V70mLYNHCgb61zfcJe
         hegJnwegVpFUHE37qpLvlizw/jAjogWcvUtPeMR1HKBjeSd0fh2ceVs8GXWXamCxBE
         esH81ICKY58szCtC3bcHuPCMbiot6c2AYxC6BVGRMdCVzJydatb9QtZfZSep2p3GrC
         NQmyTacwf4KEQ==
Date:   Wed, 17 Mar 2021 16:02:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] arm64: configs: Enable PCIe support for imx8mq boards
Message-ID: <20210317080249.GT11246@dragon>
References: <20210311192746.7362-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311192746.7362-1-heiko.thiery@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 08:27:47PM +0100, Heiko Thiery wrote:
> Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
> v2:
>  - slightly modified the commit message (Fabio Estevam)
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1f673b00c5f5..522bae6a8f21 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -225,6 +225,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=y
>  CONFIG_PCI_HOST_THUNDER_ECAM=y
>  CONFIG_PCIE_ROCKCHIP_HOST=m
>  CONFIG_PCIE_BRCMSTB=m
> +CONFIG_PCI_IMX6=y

Do we really want it to be built-in?  If so, it would be nice to have some
comments about that in commit log.

Shawn

>  CONFIG_PCI_LAYERSCAPE=y
>  CONFIG_PCIE_LAYERSCAPE_GEN4=y
>  CONFIG_PCI_HISI=y
> -- 
> 2.30.0
> 
