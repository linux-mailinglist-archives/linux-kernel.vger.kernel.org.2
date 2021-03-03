Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A532BE38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385389AbhCCRKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:10:12 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43977 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359030AbhCCNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:20:55 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id E7FB33B4AB3;
        Wed,  3 Mar 2021 08:56:34 +0000 (UTC)
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1BC33C0002;
        Wed,  3 Mar 2021 08:56:08 +0000 (UTC)
Date:   Wed, 3 Mar 2021 09:56:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] arm64: dts: reset: add microchip sparx5 switch
 reset driver
Message-ID: <YD9PKB8Xw3lfHlob@piout.net>
References: <20210303081158.684532-1-steen.hegelund@microchip.com>
 <20210303081158.684532-4-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303081158.684532-4-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 09:11:58+0100, Steen Hegelund wrote:
> This provides reset driver support for the Microchip Sparx5 PCB134 and
> PCB135 reference boards.
> 
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> index 380281f312d8..dc3ada5cf9fc 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> @@ -132,9 +132,12 @@ mux: mux-controller {
>  			};
>  		};
>  
> -		reset@611010008 {
> -			compatible = "microchip,sparx5-chip-reset";
> +		reset: reset-controller@611010008 {
> +			compatible = "microchip,sparx5-switch-reset";
>  			reg = <0x6 0x11010008 0x4>;
> +			reg-names = "gcb";
> +			#reset-cells = <1>;
> +			cpu-syscon = <&cpu_ctrl>;
>  		};
>  
>  		uart0: serial@600100000 {
> -- 
> 2.30.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
