Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF9341F63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCSOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:30:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47490 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCSOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:30:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JEU3C3023173;
        Fri, 19 Mar 2021 09:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616164203;
        bh=x5HWx753qFh0Ql2F6Fz017bjNiIxJNOMTdfDAHzPS7E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=He2K8arL0DQLD/U+5Arhl81cyff1E4R3iM3l3yOdhn/jGng2a8hy2BHqWDdrd5XxL
         WcYy2NMadZx7vkR6ykDK0VO02c0iCXv9G2On9X3F8PFk6xY8hrITfIF444Y4Te5yY8
         uMHRyMpPfqrfQFq4NGx5L6CSUQDWVIaHudITYcAw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JEU2IQ011208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 09:30:03 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 09:30:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 09:30:02 -0500
Received: from [10.250.232.114] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JETwnh097198;
        Fri, 19 Mar 2021 09:29:59 -0500
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am64: Add SERDES DT node
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210319080038.10521-1-a-govindraju@ti.com>
 <20210319080038.10521-2-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <eb05e914-9fa6-d12d-918a-949e1d243e43@ti.com>
Date:   Fri, 19 Mar 2021 19:59:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319080038.10521-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 19/03/21 1:30 pm, Aswath Govindraju wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Add SERDES DT node for the single one lane SERDES present in
> AM64.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 52 ++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index a03b66456062..5a62a96c048c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -5,6 +5,17 @@
>   * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> +#include <dt-bindings/phy/phy-cadence-torrent.h>

One of my patches in other series which renames the header file will
cause issues here :-/
http://lore.kernel.org/r/20210319124128.13308-9-kishon@ti.com

We'll need a immutable tag for this as well.
> +#include <dt-bindings/phy/phy-ti.h>
> +
> +/ {
> +	serdes_refclk: serdes-refclk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <100000000>;
> +	};

Clock frequency of serdes_refclk depends on how it is tied in the EVM.
In the case of AM64EVM there is no external clock generator.

It should be something like in
https://github.com/kishon/linux-wip/commit/e5196b0819d334ce8a21b398b7c47557a145d250

Thanks
Kishon

> +};
> +
>  &cbass_main {
>  	oc_sram: sram@70000000 {
>  		compatible = "mmio-sram";
> @@ -184,6 +195,12 @@
>  			reg = <0x4044 0x8>;
>  			#phy-cells = <1>;
>  		};
> +
> +		serdes_ln_ctrl: mux {
> +			compatible = "mmio-mux";
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x4080 0x3>; /* SERDES0 lane0 select */
> +		};
>  	};
>  
>  	main_uart0: serial@2800000 {
> @@ -477,6 +494,41 @@
>  		};
>  	};
>  
> +	serdes_wiz0: wiz@f000000 {
> +		compatible = "ti,am64-wiz-10g";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 162 0>, <&k3_clks 162 1>, <&serdes_refclk>;
> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +		num-lanes = <1>;
> +		#reset-cells = <1>;
> +		#clock-cells = <1>;
> +		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
> +		assigned-clocks = <&k3_clks 162 1>;
> +		assigned-clock-parents = <&k3_clks 162 5>;
> +
> +		serdes0: serdes@f000000 {
> +			compatible = "ti,j721e-serdes-10g";
> +			reg = <0x0f000000 0x00010000>;
> +			reg-names = "torrent_phy";
> +			resets = <&serdes_wiz0 0>;
> +			reset-names = "torrent_reset";
> +			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
> +			clock-names = "refclk", "phy_en_refclk";
> +			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
> +					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
> +			assigned-clock-parents = <&k3_clks 162 1>,
> +						 <&k3_clks 162 1>,
> +						 <&k3_clks 162 1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
>  	cpts@39000000 {
>  		compatible = "ti,j721e-cpts";
>  		reg = <0x0 0x39000000 0x0 0x400>;
> 
