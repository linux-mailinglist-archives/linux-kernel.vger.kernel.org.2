Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93A632EFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCEQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:13:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50454 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhCEQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:13:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 125GDaXw111852;
        Fri, 5 Mar 2021 10:13:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614960816;
        bh=2Nq+FG81TbTrzmxX49w84LoZUCSVdMDwMvSqxxTjUz8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=kiEweBHJzeods30Yiu/Fuw/Uw0EEECnEUmYpLwVSnhQK9jHItAr6ZkF+Dc9IquOCw
         4K4uQ8CFaQgAkq3ThnuOR6TcAtWiXamMZ/JUcDsHtCgREEwhwf3D/EpipLDtSfi2/N
         lySn4Pve9OSIDT8gI9VITzo/V/Oazq/42RxYr42c=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 125GDaMI045422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Mar 2021 10:13:36 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Mar
 2021 10:13:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Mar 2021 10:13:35 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 125GDX7t041189;
        Fri, 5 Mar 2021 10:13:33 -0600
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-j7200-som-p0: Add nodes for
 OSPI0
To:     Pratyush Yadav <p.yadav@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210305153926.3479-1-p.yadav@ti.com>
 <20210305153926.3479-4-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <cbc23906-68cd-d885-2a81-c6088c402caf@ti.com>
Date:   Fri, 5 Mar 2021 21:43:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305153926.3479-4-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/21 9:09 PM, Pratyush Yadav wrote:
> TI J7200 has the Cadence OSPI controller for interfacing with OSPI
> flashes. Add its node to allow using SPI flashes.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>



> 
> Notes:
>     Changes in v2:
>     - Do not force a pulldown on the DQS line because it already has a
>       pulldown resistor.
> 
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 17 +++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 36 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 359e3e8a8cd0..5408ec815d58 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -269,6 +269,23 @@ hbmc: hyperbus@47034000 {
>  			#size-cells = <1>;
>  			mux-controls = <&hbmc_mux 0>;
>  		};
> +
> +		ospi0: spi@47040000 {
> +			compatible = "ti,am654-ospi";
> +			reg = <0x0 0x47040000 0x0 0x100>,
> +			      <0x5 0x00000000 0x1 0x0000000>;
> +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,fifo-depth = <256>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x0>;
> +			clocks = <&k3_clks 103 0>;
> +			assigned-clocks = <&k3_clks 103 0>;
> +			assigned-clock-parents = <&k3_clks 103 2>;
> +			assigned-clock-rates = <166666666>;
> +			power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
>  	};
>  
>  	tscadc0: tscadc@40200000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> index a988e2ab2ba1..34724440171a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -100,6 +100,22 @@ J721E_WKUP_IOPAD(0x24, PIN_INPUT, 1) /* (A8) MCU_OSPI0_D6.MCU_HYPERBUS0_DQ6 */
>  			J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
>  		>;
>  	};
> +
> +	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_OSPI0_CLK */
> +			J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
> +			J721E_WKUP_IOPAD(0x000c, PIN_INPUT, 0)  /* MCU_OSPI0_D0 */
> +			J721E_WKUP_IOPAD(0x0010, PIN_INPUT, 0)  /* MCU_OSPI0_D1 */
> +			J721E_WKUP_IOPAD(0x0014, PIN_INPUT, 0)  /* MCU_OSPI0_D2 */
> +			J721E_WKUP_IOPAD(0x0018, PIN_INPUT, 0)  /* MCU_OSPI0_D3 */
> +			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0)  /* MCU_OSPI0_D4 */
> +			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0)  /* MCU_OSPI0_D5 */
> +			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* MCU_OSPI0_D6 */
> +			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* MCU_OSPI0_D7 */
> +			J721E_WKUP_IOPAD(0x0008, PIN_INPUT, 0)  /* MCU_OSPI0_DQS */
> +		>;
> +	};
>  };
>  
>  &main_pmx0 {
> @@ -235,3 +251,23 @@ exp_som: gpio@21 {
>  				  "GPIO_LIN_EN", "CAN_STB";
>  	};
>  };
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
> +
> +	flash@0{
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <4>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> 
