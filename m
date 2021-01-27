Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB17305F60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhA0PTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:19:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53670 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhA0POs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:14:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RFCuh1053913;
        Wed, 27 Jan 2021 09:12:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611760376;
        bh=bypYKIW/QcBaXurae0qgKgxzwZFIrfQz9a7cz6+CsTo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VqysvBLRXCrAh6Z6HAztWnjXrKUxHQRlOVZLk1TNhuMIB3BVScJapLNVHIx9i4jPx
         2hNvcMJmN7EgfD/fgSC9yJp2MWh3rJDmkOkveCIDkK4hYE9ISp8WossG32bc7Jied1
         UApMwgZOo4PDHM8fFAiijRyV9lScVXt4hfKGaPL0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RFCuO3075853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 09:12:56 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 09:12:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 09:12:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RFCusX050134;
        Wed, 27 Jan 2021 09:12:56 -0600
Date:   Wed, 27 Jan 2021 09:12:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dts: ti: k3-j7200-main: Add support for zeroth
 instance of GPIO subsystem
Message-ID: <20210127151256.tgbhpngy6fi43edj@create>
References: <20210127150815.16991-1-a-govindraju@ti.com>
 <20210127150815.16991-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127150815.16991-2-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:38-20210127, Aswath Govindraju wrote:
> Add support for the zeroth instance of GPIO subsystem in the main domain.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>


I really dont want to pick up one patch per node instance. It is hard
to scale and just creates a lot of noise.

> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 4cc2e9094d0e..75dffbb26d52 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -294,6 +294,23 @@
>  		pinctrl-single,function-mask = <0xffffffff>;
>  	};
>  
> +	main_gpio0: gpio@600000 {
> +		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
> +		reg = <0x0 0x00600000 0x0 0x100>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&main_gpio_intr>;
> +		interrupts = <145>, <146>, <147>, <148>,
> +			     <149>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		ti,ngpio = <69>;
> +		ti,davinci-gpio-unbanked = <0>;
> +		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 105 0>;
> +		clock-names = "gpio";
> +	};
> +
>  	main_uart0: serial@2800000 {
>  		compatible = "ti,j721e-uart", "ti,am654-uart";
>  		reg = <0x00 0x02800000 0x00 0x100>;
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
