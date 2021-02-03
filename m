Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64E30DC22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBCODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:03:42 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:35426 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232448AbhBCOBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:01:14 -0500
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id CF14B440849;
        Wed,  3 Feb 2021 16:00:31 +0200 (IST)
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-4-kostap@marvell.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, jaz@semihalf.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, nadavh@marvell.com, robh+dt@kernel.org,
        stefanc@marvell.com, mw@semihalf.com, bpeled@marvell.com,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/11] dts: mvebu: Add pin control definitions for SDIO
 interafce
In-reply-to: <20210203133138.10754-4-kostap@marvell.com>
Date:   Wed, 03 Feb 2021 16:00:31 +0200
Message-ID: <87eehxcku8.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

On Wed, Feb 03 2021, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
>
> Add SDIO mode pin control configration for CP0 on A8K DB.

This patch does not touch the A8K DB device-tree file.

baruch

>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi | 6 ++++++
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> index 293403a1a333..179218774ba9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> @@ -47,6 +47,12 @@
>  	cp0_pinctrl: pinctrl {
>  		compatible = "marvell,armada-7k-pinctrl";
>  
> +		sdhci_pins: sdhi-pins {
> +			marvell,pins = "mpp56", "mpp57", "mpp58",
> +				       "mpp59", "mpp60", "mpp61", "mpp62";
> +			marvell,function = "sdio";
> +		};
> +
>  		nand_pins: nand-pins {
>  			marvell,pins =
>  			"mpp15", "mpp16", "mpp17", "mpp18",
> diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> index ee67c70bf02e..64100ae204da 100644
> --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> @@ -70,6 +70,12 @@
>  &cp0_syscon0 {
>  	cp0_pinctrl: pinctrl {
>  		compatible = "marvell,armada-8k-cpm-pinctrl";
> +
> +		sdhci_pins: sdhi-pins {
> +			marvell,pins = "mpp56", "mpp57", "mpp58",
> +				       "mpp59", "mpp60", "mpp61", "mpp62";
> +			marvell,function = "sdio";
> +		};
>  	};
>  };


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
