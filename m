Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB8414CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhIVPR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Sep 2021 11:17:56 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56421 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhIVPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:17:54 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B80F9E0006;
        Wed, 22 Sep 2021 15:16:22 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 5/6] arm64: dts: marvell: armada-37xx: add
 device node for UART clock and use it
In-Reply-To: <20210922105433.11744-6-pali@kernel.org>
References: <20210922105433.11744-1-pali@kernel.org>
 <20210922105433.11744-6-pali@kernel.org>
Date:   Wed, 22 Sep 2021 17:16:22 +0200
Message-ID: <87o88k63p5.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> This change defines DT node for UART clock "marvell,armada-3700-uart-clock"
> and use this UART clock as a base clock for all UART devices.

Sorry to not have pointed this earlier but I found something a little
unusual, see below:

>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
>  .../boot/dts/marvell/armada-3720-espressobin.dtsi |  4 ++++
>  .../boot/dts/marvell/armada-3720-turris-mox.dts   |  4 ++++
>  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts  |  4 ++++
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 15 +++++++++++++--
>  5 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 3e5789f37206..accf014a6a1e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -191,6 +191,10 @@
>  	};
>  };
>  
> +&uartclk {
> +	status = "okay";

I found unusual to have to enable the clock at device tree level.
Usually the clock driver is always loaded and then the clock is really
enabled or disabled through the clock framework.

[...]

> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 9acc5d2b5a00..5bc61c9615f5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -132,10 +132,21 @@
>  				reg = <0x11500 0x40>;
>  			};
>  
> +			uartclk: uartclk@12000 {
> +				compatible = "marvell,armada-3700-uart-clock";
> +				reg = <0x12010 0x4>, <0x12210 0x4>;
> +				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
> +					<&tbg 3>, <&xtalclk>;
> +				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
> +					"TBG-B-S", "xtal";
> +				#clock-cells = <1>;

I think you could remove the following line and thanks to this there
won't be any change in the dts of the board:
> +				status = "disabled";
> +			};
> +

Gregory


>  			uart0: serial@12000 {
>  				compatible = "marvell,armada-3700-uart";
>  				reg = <0x12000 0x18>;
> -				clocks = <&xtalclk>;
> +				clocks = <&uartclk 0>;
>  				interrupts =
>  				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>  				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> @@ -147,7 +158,7 @@
>  			uart1: serial@12200 {
>  				compatible = "marvell,armada-3700-uart-ext";
>  				reg = <0x12200 0x30>;
> -				clocks = <&xtalclk>;
> +				clocks = <&uartclk 1>;
>  				interrupts =
>  				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
>  				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
