Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75697327E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhCAMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:20:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60736 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhCAMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:20:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 121CINN4016728;
        Mon, 1 Mar 2021 06:18:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614601103;
        bh=x4LPJmKeBqRXsGwfQnRCq0VGX9dDRQCgzdu7oBdNx9w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ix2yMC+tWQ+newOxsXRINmqGyKD12HnGODluaXNRaYRXqAOpnJsIhFj29ItrdcLYe
         TeCbViq3W+9tKwSaTc0LYzEJutda6ZJM6+tX9/9NiIeTcJbULJ8sH8mtft1ji0zrQf
         oerD94csykFvYmsmyFO21cTqj5UzEvA6+Rqxk4FU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 121CINL0101056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 06:18:23 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 06:18:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 06:18:23 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 121CIKe6090793;
        Mon, 1 Mar 2021 06:18:20 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add GPIO DT nodes
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210301061908.22460-1-a-govindraju@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b517aa1b-66b2-58d0-8527-0ead3fe17ff2@ti.com>
Date:   Mon, 1 Mar 2021 14:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301061908.22460-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2021 08:19, Aswath Govindraju wrote:
> Add device tree nodes for GPIO modules and interrupt controller in main
> domain.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> This patch depends on,
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
> 
> 
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index a36ebddf3a4c..8b4d76d83342 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -367,6 +367,51 @@
>   		clocks = <&k3_clks 145 0>;
>   	};
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
>   	sdhci0: mmc@fa10000 {
>   		compatible = "ti,am64-sdhci-8bit";
>   		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
