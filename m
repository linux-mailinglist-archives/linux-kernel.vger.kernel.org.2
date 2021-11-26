Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3174845F4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKZTEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:04:34 -0500
Received: from gloria.sntech.de ([185.11.138.130]:52722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231223AbhKZTCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:02:33 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mqgRE-0002UE-75; Fri, 26 Nov 2021 19:59:12 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add spi nodes on rk356x
Date:   Fri, 26 Nov 2021 19:59:07 +0100
Message-ID: <2081013.RVSJ30BxBx@diego>
In-Reply-To: <7562cf5c-c606-6bdc-bee9-328508a40952@gmail.com>
References: <20211126154344.724316-1-frattaroli.nicolas@gmail.com> <20211126154344.724316-3-frattaroli.nicolas@gmail.com> <7562cf5c-c606-6bdc-bee9-328508a40952@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 26. November 2021, 18:51:29 CET schrieb Johan Jonker:
> Hi Nicolas,
> 
> Could you test with:
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> 
> On 11/26/21 4:43 PM, Nicolas Frattaroli wrote:
> > This adds the four spi nodes (spi0, spi1, spi2, spi3) to the
> > rk356x dtsi. These are from the downstream device tree, though
> > I have double-checked that their interrupts and DMA numbers are
> > correct. I have also tested spi1 with an SPI device.
> > 
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 68 ++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > index 46d9552f6028..57c0197cc65a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > @@ -39,6 +39,10 @@ aliases {
> >  		serial7 = &uart7;
> >  		serial8 = &uart8;
> >  		serial9 = &uart9;
> > +		spi0 = &spi0;
> > +		spi1 = &spi1;
> > +		spi2 = &spi2;
> > +		spi3 = &spi3;
> >  	};
> >  
> >  	cpus {
> > @@ -742,6 +746,70 @@ wdt: watchdog@fe600000 {
> >  		clock-names = "tclk", "pclk";
> >  	};
> >  
> > +	spi0: spi@fe610000 {
> > +		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
> > +		reg = <0x0 0xfe610000 0x0 0x1000>;
> > +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> 
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> 
> Move above status.
> 
> > +		clocks = <&cru CLK_SPI0>, <&cru PCLK_SPI0>;
> > +		clock-names = "spiclk", "apb_pclk";
> > +		dmas = <&dmac0 20>, <&dmac0 21>;
> > +		dma-names = "tx", "rx";
> 
> > +		pinctrl-names = "default", "high_speed";
> 
> Keep position of pinctrl-names in line with other nodes in this file
> below pinctrl-0.

I do believe we always have pinctrl-names on top in most dts files, as it
describes what the -0, -1 etc are, i.e.
	pinctrl-names = "statename-for-0", "statename-for-1", "statename-for-2"...
	pinctrl-0 =
	pinctrl-1 =


Heiko

> arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dt.yaml: spi@fe610000:
> pinctrl-names:1: 'sleep' was expected
> 	From schema: /Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> 
> Missing "high_speed" support?
> 
> spi: rockchip: set higher io driver when sclk higher than 24MHz
> https://github.com/rockchip-linux/kernel/commit/7e4349ec9d70dbcfe7f78125700d2685539ea1bd
> 
> > +		pinctrl-0 = <&spi0m0_cs0 &spi0m0_cs1 &spi0m0_pins>;
> 
> > +		pinctrl-1 = <&spi0m0_cs0 &spi0m0_cs1 &spi0m0_pins_hs>;
> 
> Missing Linux mainline driver and document support? Maybe skip for now?
> 
> spi0m0_cs0_hs spi0m0_cs1_hs ???
> 
> > +		status = "disabled";
> > +	};
> > +
> 
> 
> 
> 	spi0 {
> 		/omit-if-no-ref/
> 		spi0m0_pins: spi0m0-pins {
> 			rockchip,pins =
> 				/* spi0_clkm0 */
> 				<0 RK_PB5 2 &pcfg_pull_none>,
> 				/* spi0_misom0 */
> 				<0 RK_PC5 2 &pcfg_pull_none>,
> 				/* spi0_mosim0 */
> 				<0 RK_PB6 2 &pcfg_pull_none>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m0_cs0: spi0m0-cs0 {
> 			rockchip,pins =
> 				/* spi0_cs0m0 */
> 				<0 RK_PC6 2 &pcfg_pull_none>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m0_cs1: spi0m0-cs1 {
> 			rockchip,pins =
> 				/* spi0_cs1m0 */
> 				<0 RK_PC4 2 &pcfg_pull_none>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m1_pins: spi0m1-pins {
> 			rockchip,pins =
> 				/* spi0_clkm1 */
> 				<2 RK_PD3 3 &pcfg_pull_none>,
> 				/* spi0_misom1 */
> 				<2 RK_PD0 3 &pcfg_pull_none>,
> 				/* spi0_mosim1 */
> 				<2 RK_PD1 3 &pcfg_pull_none>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m1_cs0: spi0m1-cs0 {
> 			rockchip,pins =
> 				/* spi0_cs0m1 */
> 				<2 RK_PD2 3 &pcfg_pull_none>;
> 		};
> 	};
> 
> 	spi0-hs {
> 		/omit-if-no-ref/
> 		spi0m0_pins_hs: spi0m0-pins {
> 			rockchip,pins =
> 				/* spi0_clkm0 */
> 				<0 RK_PB5 2 &pcfg_pull_up_drv_level_1>,
> 				/* spi0_misom0 */
> 				<0 RK_PC5 2 &pcfg_pull_up_drv_level_1>,
> 				/* spi0_mosim0 */
> 				<0 RK_PB6 2 &pcfg_pull_up_drv_level_1>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m0_cs0_hs: spi0m0-cs0 {
> 			rockchip,pins =
> 				/* spi0_cs0m0 */
> 				<0 RK_PC6 2 &pcfg_pull_up_drv_level_1>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m0_cs1_hs: spi0m0-cs1 {
> 			rockchip,pins =
> 				/* spi0_cs1m0 */
> 				<0 RK_PC4 2 &pcfg_pull_up_drv_level_1>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m1_pins_hs: spi0m1-pins {
> 			rockchip,pins =
> 				/* spi0_clkm1 */
> 				<2 RK_PD3 3 &pcfg_pull_up_drv_level_1>,
> 				/* spi0_misom1 */
> 				<2 RK_PD0 3 &pcfg_pull_up_drv_level_1>,
> 				/* spi0_mosim1 */
> 				<2 RK_PD1 3 &pcfg_pull_up_drv_level_1>;
> 		};
> 
> 		/omit-if-no-ref/
> 		spi0m1_cs0_hs: spi0m1-cs0 {
> 			rockchip,pins =
> 				/* spi0_cs0m1 */
> 				<2 RK_PD2 3 &pcfg_pull_up_drv_level_1>;
> 		};
> 	};
> 
> 
> 
> > +	spi1: spi@fe620000 {
> > +		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
> > +		reg = <0x0 0xfe620000 0x0 0x1000>;
> > +		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
> > +		clock-names = "spiclk", "apb_pclk";
> > +		dmas = <&dmac0 22>, <&dmac0 23>;
> > +		dma-names = "tx", "rx";
> > +		pinctrl-names = "default", "high_speed";
> > +		pinctrl-0 = <&spi1m0_cs0 &spi1m0_cs1 &spi1m0_pins>;
> > +		pinctrl-1 = <&spi1m0_cs0 &spi1m0_cs1 &spi1m0_pins_hs>;
> > +		status = "disabled";
> > +	};
> > +
> > +	spi2: spi@fe630000 {
> > +		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
> > +		reg = <0x0 0xfe630000 0x0 0x1000>;
> > +		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		clocks = <&cru CLK_SPI2>, <&cru PCLK_SPI2>;
> > +		clock-names = "spiclk", "apb_pclk";
> > +		dmas = <&dmac0 24>, <&dmac0 25>;
> > +		dma-names = "tx", "rx";
> > +		pinctrl-names = "default", "high_speed";
> > +		pinctrl-0 = <&spi2m0_cs0 &spi2m0_cs1 &spi2m0_pins>;
> > +		pinctrl-1 = <&spi2m0_cs0 &spi2m0_cs1 &spi2m0_pins_hs>;
> > +		status = "disabled";
> > +	};
> > +
> > +	spi3: spi@fe640000 {
> > +		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
> > +		reg = <0x0 0xfe640000 0x0 0x1000>;
> > +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		clocks = <&cru CLK_SPI3>, <&cru PCLK_SPI3>;
> > +		clock-names = "spiclk", "apb_pclk";
> > +		dmas = <&dmac0 26>, <&dmac0 27>;
> > +		dma-names = "tx", "rx";
> > +		pinctrl-names = "default", "high_speed";
> > +		pinctrl-0 = <&spi3m0_cs0 &spi3m0_cs1 &spi3m0_pins>;
> > +		pinctrl-1 = <&spi3m0_cs0 &spi3m0_cs1 &spi3m0_pins_hs>;
> > +		status = "disabled";
> > +	};
> > +
> >  	uart1: serial@fe650000 {
> >  		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
> >  		reg = <0x0 0xfe650000 0x0 0x100>;
> > 
> 




