Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FB3D3AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhGWMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:17:25 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55557 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhGWMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:17:21 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D772E60009;
        Fri, 23 Jul 2021 12:57:51 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] arm64: dts: armada-3720-turris-mox: fixed
 indices for the SDHC controllers
In-Reply-To: <20210722101134.2514089-1-vladimir.oltean@nxp.com>
References: <20210722101134.2514089-1-vladimir.oltean@nxp.com>
Date:   Fri, 23 Jul 2021 14:57:51 +0200
Message-ID: <87im11192o.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

> Since drivers/mmc/host/sdhci-xenon.c declares the PROBE_PREFER_ASYNCHRONOUS
> probe type, it is not guaranteed whether /dev/mmcblk0 will belong to
> sdhci0 or sdhci1. In turn, this will break booting by:
>
> root=/dev/mmcblk0p1
>
> Fix the issue by adding aliases so that the old MMC controller indices
> are preserved.
>
> Fixes: 7320915c8861 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.14")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index ce2bcddf396f..f2d7d6f071bc 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -19,6 +19,8 @@ / {
>  	aliases {
>  		spi0 = &spi0;
>  		ethernet1 = &eth1;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
>  	};
>  
>  	chosen {
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
