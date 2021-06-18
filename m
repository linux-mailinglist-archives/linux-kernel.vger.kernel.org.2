Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B373ACBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhFRNKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:10:49 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45216 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhFRNKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:10:43 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1luEEZ-00022y-QZ; Fri, 18 Jun 2021 15:08:31 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     devicetree@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add RK3399 Rock Pi 4a plus board
Date:   Fri, 18 Jun 2021 15:08:31 +0200
Message-ID: <4545451.QWXsJ6tzlI@diego>
In-Reply-To: <20210617044955.598994-2-knaerzche@gmail.com>
References: <20210617044955.598994-1-knaerzche@gmail.com> <20210617044955.598994-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 17. Juni 2021, 06:49:54 CEST schrieb Alex Bee:
> Rock Pi 4a plus board is the successor of Rock Pi 4a board.
> 
> Differences to the original version are
> - has RK3399 OP1 SoC revision
> - has eMMC (16 or 32 GB) soldered on board (no changes required,
>   since it is enabled in rk3399-rock-pi-4.dtsi)
> - dev boards have SPI flash soldered, but as per manufacturer response,
>   this won't be the case for mass production boards
> 
> I didn't add yet another compatible, since the small set of differences
> are captured by the device tree.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile              |  1 +
>  .../boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts   | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index c3e00c0e2db7..dbd7d37950f1 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -43,6 +43,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
> new file mode 100644
> index 000000000000..2deaab7f9307
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
> + * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
> + */
> +
> +/dts-v1/;
> +#include "rk3399-rock-pi-4.dtsi"
> +#include "rk3399-op1-opp.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK Pi 4A plus";
> +	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";

hmm, I don't really follow why you're re-using the radxa,rockpi4a
compatible. I'd assume this should be radxa,rockpi4a+ or something?

I.e. if a bootloader needs to select the matching devicetree from a list
of available devicetrees, this could end up running a regular rockpi4a
(without +) using the OP1 operating points and thus at way too high
frequencies.


Heiko


> +};
> 




