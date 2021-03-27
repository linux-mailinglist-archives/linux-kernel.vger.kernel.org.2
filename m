Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA634B931
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 20:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC0T4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 15:56:33 -0400
Received: from mout.web.de ([212.227.15.3]:45735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhC0T4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 15:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616874935;
        bh=Zhxf+bRoM2zVapnWktmEqeJNFqZvPsKsM5mX1cMqpXE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IVslmV94MQ5jq+vKWnFCmidklxbc2QZC6+lguhXAwZBsHfkYRe2/XSEUQKrmGXnH2
         4M1inxXGqFx3Zyy5SE1+kfgblBrUW0RD8MCvWBBK06g17m5RwV8iVWGMQiNqXL5+hj
         yAO5DtZuLqwqWsPlmFb5IAUj4gJwUIrwC+ijkILo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01Za-1lbjjU3UlK-00xKwF; Sat, 27
 Mar 2021 20:55:35 +0100
Subject: Re: [PATCH 1/3] arm64: dts: xilinx: Add the clock nodes for zynqmp
To:     Rajan Vaja <rajan.vaja@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        harini.katakam@xilinx.com, ulf.hansson@linaro.org,
        xuwei5@hisilicon.com, mripard@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
 <1573119856-13548-2-git-send-email-rajan.vaja@xilinx.com>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <8b039dac-06c4-6b33-f53b-44b8fa144495@web.de>
Date:   Sat, 27 Mar 2021 20:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1573119856-13548-2-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4S5uwohHvdoKkCEbFzuBSd4yA80SGk5A3tynzpHjvbBsO7NsVaF
 ZOsOOSMkzdeF02h8mnsFZHOaiJhrXRisSShwVO3+kUMF6wH4Gwy6dRfZqzMP3eO6REJ0O8y
 x+ZnVaQsRjY6GwGivmnjpFdX3Tqpr/KqGGcbrj5E0c1yBCny59DOm/xqo4TQS6Kt2gtsFQ8
 cTZ2yUlA3/lmbMVWJoIiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZmKfKLkeZgM=:H+czIA5MLzkeg4q3jcsX3y
 eUideN5IGnjnsIUFfpaMLeWgq4wFMTu7I8MEpjtVZ/zif1/vmVZElMvS/cUsnuQA7yM5AufSS
 FaL+C2t5r2snjpSHBk+mkFgRFDz5nLST1Y32Tv+qaT5Jg+WCguFwnUcM2UKgNzjxBBvWXk7Pl
 yh14Vriz2HGO6cgiLpiSmQNNLYzkDhPj3Ao/HQvWN9jnMIokqL5LrWtWBsj7IyHZz5uRITDvh
 6FvDMq7sLk2gucaFqDTBPOHieIqzhgTe7he55rCkj8bTeAmrJjoX9Ad9J7jm0ih8IMWgEwZaj
 35C4suU5C0EtHmqBFxGcOYeRVQKN7Tw6NM+sDhGenPuSPiM3nReDMquL+KeAbqb2txml4Ctre
 Vob2g49msWdBgwc/sACDifCYLyLeO9vgqttoopCx0rB7UheCtTN8d1bdmYzRVKv4R3/SgRh0j
 A7XjVbkp3qulmJpjJFIkBsMx+6oVmFrqHIngCaGeXqkUv7i5+mRW19yyp2crvCtSSA8O2adbW
 rI0t4RwXDAifSNm32BGFJiUhm72MRnRZQIq9oLjp54TKJswBaVlBe5p1s068/wXU/uoHm6Uo8
 8KO3ALpU9grwzqS5NrrTEUY0pfhDGgdeatuXdA6kJPcw94SAmyVSl6285CJkninG+2Pz1SfGe
 hqr96LZdX5WUJ+YEoMWkdMFJ9nx9Bwp8mrEyhgJxCgZ3qAquYaitClBDQ1nyAFPgrkPPE5KF6
 cqehMNPU7HZYrvACkSl/sctsCuWNDaCJF3kdNmtnnpHo8G/d1eLLnFpVn+sio6v/Z9Ev5Gqks
 lnw+5H3q9PiPfTE0ZeaQrkAB7RI8ra6eia9qFQgFXdFhc5gBuThWTZiozsBvOB+pMQfVGRaqr
 DhNbBy0XJUhvzELMJFPnKtq99FmaPHIbgdSNb5R/EZbfHtwdNZbGxNMX/levpcCVfojqn/LLA
 tu0m7fuLsiEjczSGKxLYENqVF06GKIn5+fkP8GpH50di01UizVRFkvP164nPwQltNotyOBlkj
 U84VBZfaBgl8vz64fjKqN2YQhIduTChRTHzsQr0diZjyZ3NcrvRVXfrzqYhbdkFVKscVE/5eR
 oMtAZlf9lE68SNiLETOHPrjCu2iL//z8MtfdeJOCXWSRwOhVTQUx5pn717eBuhk6x0/Yv/y+X
 gBHb8dKlCtdsNR5EnqugBEz8KKPoXfODjq0+u/fttIXcpY8tb73H9koUP2ygwvAuQcjQ8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.19 10:44, Rajan Vaja wrote:
> Add clock nodes for zynqmp based on CCF.
>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 ++++++++++++++=
+++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>  15 files changed, 270 insertions(+), 26 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64=
/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> new file mode 100644
> index 0000000..9868ca1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Clock specification for Xilinx ZynqMP
> + *
> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
> +/ {
> +	pss_ref_clk: pss_ref_clk {
> +		u-boot,dm-pre-reloc;
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <33333333>;
> +	};
> +
> +	video_clk: video_clk {
> +		u-boot,dm-pre-reloc;
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <27000000>;
> +	};
> +
> +	pss_alt_ref_clk: pss_alt_ref_clk {
> +		u-boot,dm-pre-reloc;
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <0>;
> +	};
> +
> +	gt_crx_ref_clk: gt_crx_ref_clk {
> +		u-boot,dm-pre-reloc;
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <108000000>;
> +	};
> +
> +	aux_ref_clk: aux_ref_clk {
> +		u-boot,dm-pre-reloc;
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <27000000>;
> +	};
> +};
> +
> +&can0 {
> +	clocks =3D <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&can1 {
> +	clocks =3D <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&cpu0 {
> +	clocks =3D <&zynqmp_clk ACPU>;
> +};
> +
> +&fpd_dma_chan1 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan2 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan3 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan4 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan5 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan6 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan7 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&fpd_dma_chan8 {
> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan1 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan2 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan3 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan4 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan5 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan6 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan7 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&lpd_dma_chan8 {
> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&gem0 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
> +		 <&zynqmp_clk GEM_TSU>;
> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> +};
> +
> +&gem1 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
> +		 <&zynqmp_clk GEM_TSU>;
> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> +};
> +
> +&gem2 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
> +		 <&zynqmp_clk GEM_TSU>;
> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> +};
> +
> +&gem3 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
> +		 <&zynqmp_clk GEM_TSU>;
> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> +};
> +
> +&gpio {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&i2c0 {
> +	clocks =3D <&zynqmp_clk I2C0_REF>;
> +};
> +
> +&i2c1 {
> +	clocks =3D <&zynqmp_clk I2C1_REF>;
> +};
> +
> +&pcie {
> +	clocks =3D <&zynqmp_clk PCIE_REF>;
> +};
> +
> +&sata {
> +	clocks =3D <&zynqmp_clk SATA_REF>;
> +};
> +
> +&sdhci0 {
> +	clocks =3D <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&sdhci1 {
> +	clocks =3D <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&spi0 {
> +	clocks =3D <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&spi1 {
> +	clocks =3D <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&ttc0 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&ttc1 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&ttc2 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&ttc3 {
> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&uart0 {
> +	clocks =3D <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&uart1 {
> +	clocks =3D <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
> +};
> +
> +&usb0 {
> +	clocks =3D <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
> +};
> +
> +&usb1 {
> +	clocks =3D <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
> +};
> +
> +&watchdog0 {
> +	clocks =3D <&zynqmp_clk WDT>;
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> index 0f7b4cf..2e05fa4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZC1232
>   *
> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>
>  / {
>  	model =3D "ZynqMP ZC1232 RevA";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> index 9092828..3d0aaa0 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZC1254
>   *
> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
> @@ -11,7 +11,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>
>  / {
>  	model =3D "ZynqMP ZC1254 RevA";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> index 4f404c5..1a8127d4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
> @@ -11,7 +11,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>
>  / {
>  	model =3D "ZynqMP ZC1275 RevA";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index 9a3e39d..fa7eb1b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>   *
> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 2421ec7..4191dfa 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>   *
> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> index 7a49dee..3750690 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>   *
> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>
>  / {
>  	model =3D "ZynqMP zc1751-xm017-dc3 RevA";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> index 54c7b4f..2366cd9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>   *
> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>
>  / {
>  	model =3D "ZynqMP zc1751-xm018-dc4";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> index b8b5ff1..9a894e6 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>   *
> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>   *
>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>   * Michal Simek <michal.simek@xilinx.com>
> @@ -11,7 +11,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index e5699d0..3e39454 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU100 revC
>   *
> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   * Nathalie Chan King Choy
> @@ -11,7 +11,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 2a3b665..f6e9558 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU102 RevA
>   *
> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 8f45614..f457f8a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU104
>   *
> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 93ce7eb..f15b99a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU106
>   *
> - * (C) Copyright 2016, Xilinx, Inc.
> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/ar=
m64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 8bb0001..e27cd60 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP ZCU111
>   *
> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   */
> @@ -10,7 +10,7 @@
>  /dts-v1/;
>
>  #include "zynqmp.dtsi"
> -#include "zynqmp-clk.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dt=
s/xilinx/zynqmp.dtsi
> index 9aa6734..59a547b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP
>   *
> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   *
> @@ -124,6 +124,28 @@
>  			     <1 10 0xf08>;
>  	};
>
> +	firmware {
> +		zynqmp_firmware: zynqmp-firmware {
> +			compatible =3D "xlnx,zynqmp-firmware";
> +			method =3D "smc";
> +			zynqmp_clk: clock-controller {
> +				u-boot,dm-pre-reloc;
> +				#clock-cells =3D <1>;
> +				compatible =3D "xlnx,zynqmp-clk";
> +				clocks =3D <&pss_ref_clk>,
> +					 <&video_clk>,
> +					 <&pss_alt_ref_clk>,
> +					 <&aux_ref_clk>,
> +					 <&gt_crx_ref_clk>;
> +				clock-names =3D "pss_ref_clk",
> +					      "video_clk",
> +					      "pss_alt_ref_clk",
> +					      "aux_ref_clk",
> +					      "gt_crx_ref_clk";
> +			};
> +		};
> +	};
> +
>  	amba_apu: amba-apu@0 {
>  		compatible =3D "simple-bus";
>  		#address-cells =3D <2>;
>

Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
Starting from this commit on, I'm no longer getting the kernel to boot
on both revision 1 and 2 (arm64 defconfig as reference). If I switch the
DTBs back before this commit, even a kernel from today's head is fine.

Further versions of potential relevance:
 - PMUFW 2019.1 and 2020.2
 - TF-A 2.3
 - U-Boot 2020.10

What's missing? I suspect someone forgot to document a subtle dependency
of this change.

Thanks,
Jan
