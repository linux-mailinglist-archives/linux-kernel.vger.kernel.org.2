Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB933D1659
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhGURqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:46:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53160 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhGURqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:46:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LIRFKB018350;
        Wed, 21 Jul 2021 13:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626892035;
        bh=AAmZWojQo9ONsCFEwdKYb2NXdYDGQvHNHW+g3WsirsQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dvSEv0FttKdh5y76dH/rQgCNDkvBqy9rRhpx6BQVzUm3pJKG9SH1qYWHldk9TTjU/
         r9s6FET/6/5O5KbqVx2vHANpbpCMCWruwAXJlwinXjVhqWV7ScUNqcNnVHssBX726r
         V8O1OFT+47fCpBJ49ncl8PHybTDLkllWT9NfyJ2o=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LIRFWP004304
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 13:27:15 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 13:27:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 13:27:15 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LIRCxD029757;
        Wed, 21 Jul 2021 13:27:13 -0500
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
References: <20210721113625.17299-1-lokeshvutla@ti.com>
 <20210721113625.17299-3-lokeshvutla@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fd45489b-c7f1-6a5d-09cc-25f3bf4826ef@ti.com>
Date:   Wed, 21 Jul 2021 21:27:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721113625.17299-3-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2021 14:36, Lokesh Vutla wrote:
> There are 3 instances of ecap modules that are capable of generating
> a pwm when configured in apwm mode. Add DT nodes for these 3 ecap
> instances.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 27 ++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index 9e762f64b631..42d1d219a3fd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -946,4 +946,31 @@ epwm8: pwm@23080000 {
>   		clocks = <&epwm_tbclk 8>, <&k3_clks 94 0>;
>   		clock-names = "tbclk", "fck";
>   	};
> +
> +	ecap0: pwm@23100000 {
> +		compatible = "ti,am64-ecap", "ti,am3352-ecap";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x23100000 0x0 0x60>;
> +		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 51 0>;
> +		clock-names = "fck";
> +	};
> +
> +	ecap1: pwm@23110000 {
> +		compatible = "ti,am64-ecap", "ti,am3352-ecap";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x23110000 0x0 0x60>;
> +		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 52 0>;
> +		clock-names = "fck";
> +	};
> +
> +	ecap2: pwm@23120000 {
> +		compatible = "ti,am64-ecap", "ti,am3352-ecap";
> +		#pwm-cells = <3>;
> +		reg = <0x0 0x23120000 0x0 0x60>;
> +		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 53 0>;
> +		clock-names = "fck";
> +	};
>   };
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
