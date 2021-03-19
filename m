Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0664634155A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhCSGZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:25:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46340 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhCSGZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:25:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12J6PWUP099188;
        Fri, 19 Mar 2021 01:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616135132;
        bh=9chgDqoD1UxYGC4NutX/T+3ytMmCVetZiooHAF2T+dQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KZvO6j0VEJoSckt1duMotqEPfekp5W2AXSoU43oq8aFd4htxcchqpXmHyo5leLMyF
         Hv1VGZhnhfow6pLCW62NOkWLvW8rFZQvRA6UV10bU6oZylHAk7360L/ZOokc5uAHMJ
         b32rKlvar3cwd7cWmQ3ySikqKZp3EzEEv+LvBmdg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12J6PWPA004672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 01:25:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 01:25:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 01:25:32 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12J6PTk2068016;
        Fri, 19 Mar 2021 01:25:30 -0500
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am64: Add GPIO DT nodes
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210319051950.17549-1-a-govindraju@ti.com>
 <20210319051950.17549-2-a-govindraju@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <b736ac35-6f2b-a31f-2704-2412ab3bbec4@ti.com>
Date:   Fri, 19 Mar 2021 11:55:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319051950.17549-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/21 10:49 am, Aswath Govindraju wrote:
> Add device tree nodes for GPIO modules and interrupt controller in main
> and mcu domains.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 27 ++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index a03b66456062..b997d13f9ec5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -373,6 +373,51 @@
>  		clocks = <&k3_clks 145 0>;
>  	};
>  
> +	main_gpio_intr: interrupt-controller0 {
> +		compatible = "ti,sci-intr";
> +		ti,intr-trigger-type = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic500>;
> +		#interrupt-cells = <1>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <3>;
> +		ti,interrupt-ranges = <0 32 16>;
> +	};
> +
> +	main_gpio0: gpio@600000 {
> +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> +		reg = <0x0 0x00600000 0x0 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <190>, <191>, <192>,
> +			     <193>, <194>, <195>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <87>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 77 0>;
> +		clock-names = "gpio";
> +	};
> +
> +	main_gpio1: gpio@601000 {
> +		compatible = "ti,am64-gpio", "ti,keystone-gpio";
> +		reg = <0x0 0x00601000 0x0 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <180>, <181>, <182>,
> +			     <183>, <184>, <185>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <88>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 78 0>;
> +		clock-names = "gpio";
> +	};
> +
>  	sdhci0: mmc@fa10000 {
>  		compatible = "ti,am64-sdhci-8bit";
>  		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> index 1d2be485a669..99e94dee1bd4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> @@ -73,4 +73,31 @@
>  		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 148 0>;
>  	};
> +
> +	mcu_gpio_intr: interrupt-controller1 {
> +		compatible = "ti,sci-intr";
> +		ti,intr-trigger-type = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic500>;
> +		#interrupt-cells = <1>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <5>;
> +		ti,interrupt-ranges = <0 104 4>;
> +	};
> +
> +	mcu_gpio0: gpio@4201000 {
> +		compatible = "ti,am64-gpio", "keystone-gpio";
> +		reg = <0x0 0x4201000 0x0 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&mcu_gpio_intr>;
> +		interrupts = <30>, <31>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <23>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 79 0>;
> +		clock-names = "gpio";
> +	};
>  };
> 
