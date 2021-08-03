Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E134C3DEDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhHCMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:09:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233906AbhHCMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:09:54 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C7Kx6008225;
        Tue, 3 Aug 2021 14:09:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=aYSWEcURB8BtPp5N5TZSHnzVK8P43wEB0RJvLkkwXoQ=;
 b=qbYI69LiXMlQ2/qS7JXpcOhCx3EtJyrhnLNF6SJWAPtg7+JLRLnlixA2RgBhFL0DmYPI
 8GmR44Sba2nVgHBHStkDxf5OTW6F1Xg/b1fU1QbI0G1G7Qq0Ij55ollcPcWUpGCgd1mU
 I7lilGZ/2BxliIFkRo5k4vd8rDgOfpxgFLKTMBD0El4o20IIH1tkbKKwGZ0Jqi51edoK
 CKyAfpuiADQvAbEx4Q1U5pH1CZA6vVzVeB8MPrg6UIEDuO30WKYV09j1nrcVd+CTXCCT
 ZqBh6har34lLeWO1PIYSsJ6ibzumUUuFaHl1Q2a5bpLTP+GesNjz3gWC/fpBHUYk6+GW 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a74mx88k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:09:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FE6D10002A;
        Tue,  3 Aug 2021 14:09:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62E28220F52;
        Tue,  3 Aug 2021 14:09:34 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:09:33 +0200
Subject: Re: [PATCH v3 13/13] ARM: dts: sti: Introduce 4KOpen (stih418-b2264)
 board
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-14-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <7dcac1f0-8eda-1a62-3328-c8daac8daddf@foss.st.com>
Date:   Tue, 3 Aug 2021 14:09:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-14-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/31/21 10:42 PM, Alain Volmat wrote:
> 4KOpen (B2264) is a board based on the STMicroelectronics STiH418 soc:
>   - 2GB DDR
>   - HDMI
>   - Ethernet 1000-BaseT
>   - PCIe (mini PCIe connector)
>   - MicroSD slot
>   - USB2 and USB3 connectors
>   - Sata
>   - 40 pins GPIO header
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: add 300MHz opp, add led, add ethernet pinctrl
> v2: fix bootargs (removal of console=)
>     removal of rng11 node, moved into stih418.dtsi
> 
>  arch/arm/boot/dts/Makefile          |   3 +-
>  arch/arm/boot/dts/stih418-b2264.dts | 151 ++++++++++++++++++++++++++++
>  2 files changed, 153 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/stih418-b2264.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8e5d4ab4e75e..3c1877627e91 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1061,7 +1061,8 @@ dtb-$(CONFIG_ARCH_STI) += \
>  	stih407-b2120.dtb \
>  	stih410-b2120.dtb \
>  	stih410-b2260.dtb \
> -	stih418-b2199.dtb
> +	stih418-b2199.dtb \
> +	stih418-b2264.dtb
>  dtb-$(CONFIG_ARCH_STM32) += \
>  	stm32f429-disco.dtb \
>  	stm32f469-disco.dtb \
> diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/stih418-b2264.dts
> new file mode 100644
> index 000000000000..a99604bebf8c
> --- /dev/null
> +++ b/arch/arm/boot/dts/stih418-b2264.dts
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 STMicroelectronics
> + * Author: Alain Volmat <avolmat@me.com>
> + */
> +/dts-v1/;
> +#include "stih418.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +/ {
> +	model = "STiH418 B2264";
> +	compatible = "st,stih418-b2264", "st,stih418";
> +
> +	chosen {
> +		stdout-path = &sbc_serial0;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0xc0000000>;
> +	};
> +
> +	cpus {
> +		cpu@0 {
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
> +			cpu-release-addr = <0x94100b8>;
> +		};
> +		cpu@1 {
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
> +			cpu-release-addr = <0x94100b8>;
> +		};
> +		cpu@2 {
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
> +			cpu-release-addr = <0x94100b8>;
> +		};
> +		cpu@3 {
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* u-boot puts hpen in SBC dmem at 0xb8 offset */
> +			cpu-release-addr = <0x94100b8>;
> +		};
> +	};
> +
> +	cpu_opp_table: opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <784000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <784000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <784000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <784000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <1500000000>;
> +			opp-microvolt = <784000>;
> +		};
> +	};
> +
> +	aliases {
> +		ttyAS0 = &sbc_serial0;
> +		ethernet0 = &ethernet0;
> +	};
> +
> +	soc {
> +		leds {
> +			compatible = "gpio-leds";
> +			green {
> +				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
> +				default-state = "off";
> +			};
> +		};
> +
> +		pin-controller-sbc@961f080 {
> +			gmac1 {
> +				rgmii1-0 {
> +					st,pins {
> +						rxd0 = <&pio1 4 ALT1 IN DE_IO 300 CLK_A>;
> +						rxd1 = <&pio1 5 ALT1 IN DE_IO 300 CLK_A>;
> +						rxd2 = <&pio1 6 ALT1 IN DE_IO 300 CLK_A>;
> +						rxd3 = <&pio1 7 ALT1 IN DE_IO 300 CLK_A>;
> +						rxdv = <&pio2 0 ALT1 IN DE_IO 300 CLK_A>;
> +					};
> +				};
> +			};
> +		};
> +
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ethernet0 {
> +	phy-mode = "rgmii";
> +	pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii1_mdio_1>;
> +	st,tx-retime-src = "clkgen";
> +
> +	snps,reset-gpio = <&pio0 7 0>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +
> +	status = "okay";
> +};
> +
> +&miphy28lp_phy {
> +	phy_port0: port@9b22000 {
> +		st,sata-gen = <2>; /* SATA GEN3 */
> +		st,osc-rdy;
> +	};
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&sata0 {
> +	status = "okay";
> +};
> +
> +&sbc_serial0 {
> +	status = "okay";
> +};
> +
> +&spifsm {
> +	status = "okay";
> +};
> +
> +&st_dwc3 {
> +	status = "okay";
> +};
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
