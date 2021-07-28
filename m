Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7767E3D9363
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhG1Qng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:43:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51656 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhG1Qn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:43:28 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m8meT-0006pT-8b; Wed, 28 Jul 2021 18:43:25 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add gmac0 node to rk3568
Date:   Wed, 28 Jul 2021 18:43:24 +0200
Message-ID: <2193550.atdPhlSkOF@diego>
In-Reply-To: <20210728161020.3905-2-michael.riesch@wolfvision.net>
References: <20210728161020.3905-1-michael.riesch@wolfvision.net> <20210728161020.3905-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 28. Juli 2021, 18:10:19 CEST schrieb Michael Riesch:
> While both RK3566 and RK3568 feature the gmac1 node, the gmac0
> node is exclusive to the RK3568.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 51 ++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index da01a59f6f26..ec39a2c593b6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -22,6 +22,57 @@
>  		compatible = "rockchip,rk3568-qos", "syscon";
>  		reg = <0x0 0xfe190200 0x0 0x20>;
>  	};
> +
> +	gmac0: ethernet@fe2a0000 {
> +		compatible = "rockchip,rk3568-gmac", "snps,dwmac-4.20a";
> +		reg = <0x0 0xfe2a0000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "macirq", "eth_wake_irq";
> +		rockchip,grf = <&grf>;
> +		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
> +			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
> +			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
> +			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
> +			 <&cru PCLK_XPCS>;
> +		clock-names = "stmmaceth", "mac_clk_rx",
> +			      "mac_clk_tx", "clk_mac_refout",
> +			      "aclk_mac", "pclk_mac",
> +			      "clk_mac_speed", "ptp_ref",
> +			      "pclk_xpcs";
> +		resets = <&cru SRST_A_GMAC0>;
> +		reset-names = "stmmaceth";
> +

is this missing a rockchip,grf phandle?

gmac1 has one and the driver side also does want to access the grf for both
controllers.


Heiko

> +		snps,mixed-burst;
> +		snps,tso;
> +
> +		snps,axi-config = <&gmac0_stmmac_axi_setup>;
> +		snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> +		snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> +		status = "disabled";
> +
> +		mdio0: mdio {
> +			compatible = "snps,dwmac-mdio";
> +			#address-cells = <0x1>;
> +			#size-cells = <0x0>;
> +		};
> +
> +		gmac0_stmmac_axi_setup: stmmac-axi-config {
> +			snps,wr_osr_lmt = <4>;
> +			snps,rd_osr_lmt = <8>;
> +			snps,blen = <0 0 0 0 16 8 4>;
> +		};
> +
> +		gmac0_mtl_rx_setup: rx-queues-config {
> +			snps,rx-queues-to-use = <1>;
> +			queue0 {};
> +		};
> +
> +		gmac0_mtl_tx_setup: tx-queues-config {
> +			snps,tx-queues-to-use = <1>;
> +			queue0 {};
> +		};
> +	};
>  };
>  
>  &cpu0_opp_table {
> 




