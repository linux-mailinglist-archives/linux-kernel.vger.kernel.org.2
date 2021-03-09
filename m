Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6633266E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhCINSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:18:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35340 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhCINRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:17:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129DHljc009506;
        Tue, 9 Mar 2021 07:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615295867;
        bh=smtatFk4X24dbVUr8RE9Upqig6n15jPncVKOFCUoLtQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=M4IiOHalSUx+KD4enPIDAx+ZK+tAfvNEDxoCe5mj56gs+x2kCK3KacT8hAtM8EwEC
         /XzPdwwxbpLDindHPKBoj0F04w/g/jwza9d7n80rent9Xo7drt5KrBXKzDCGvIQRTc
         0lGTS9c/ivJrDgpRiiZPEUC2eh6GJRsXPW3NAWQI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129DHlG8047846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 07:17:47 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 07:17:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 07:17:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129DHknu117546;
        Tue, 9 Mar 2021 07:17:46 -0600
Date:   Tue, 9 Mar 2021 18:47:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am64-evm/sk: Add OSPI flash DT
 node
Message-ID: <20210309131745.mgxee5735fae4gte@ti.com>
References: <20210309130514.11740-1-vigneshr@ti.com>
 <20210309130514.11740-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210309130514.11740-2-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 06:35PM, Vignesh Raghavendra wrote:
> Both AM64 EVM and SK have a 512Mb S28HS512T Octal SPI NOR flash.
> Add DT node for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> ---
> 
> Bootlog:
> 
> SK: https://pastebin.ubuntu.com/p/gvxg7cFrXH/
> EVM: https://pastebin.ubuntu.com/p/jb39GqkB78/
> 
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 36 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 36 +++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 1f1787750fef..7dd8e94b108d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -133,6 +133,22 @@ AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
>  			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
>  		>;
>  	};
> +
> +	ospi0_pins_default: ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (N20) OSPI0_CLK */
> +			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (L19) OSPI0_CSn0 */
> +			AM64X_IOPAD(0x000c, PIN_INPUT, 0) /* (M19) OSPI0_D0 */
> +			AM64X_IOPAD(0x0010, PIN_INPUT, 0) /* (M18) OSPI0_D1 */
> +			AM64X_IOPAD(0x0014, PIN_INPUT, 0) /* (M20) OSPI0_D2 */
> +			AM64X_IOPAD(0x0018, PIN_INPUT, 0) /* (M21) OSPI0_D3 */
> +			AM64X_IOPAD(0x001c, PIN_INPUT, 0) /* (P21) OSPI0_D4 */
> +			AM64X_IOPAD(0x0020, PIN_INPUT, 0) /* (P20) OSPI0_D5 */
> +			AM64X_IOPAD(0x0024, PIN_INPUT, 0) /* (N18) OSPI0_D6 */
> +			AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
> +			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
> +		>;
> +	};
>  };
>  
>  &main_uart0 {
> @@ -244,3 +260,23 @@ &sdhci1 {
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
>  };
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
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
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index aa6ca4c49153..fc27470fc083 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -90,6 +90,22 @@ AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
>  			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
>  		>;
>  	};
> +
> +	ospi0_pins_default: ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (N20) OSPI0_CLK */
> +			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (L19) OSPI0_CSn0 */
> +			AM64X_IOPAD(0x000c, PIN_INPUT, 0) /* (M19) OSPI0_D0 */
> +			AM64X_IOPAD(0x0010, PIN_INPUT, 0) /* (M18) OSPI0_D1 */
> +			AM64X_IOPAD(0x0014, PIN_INPUT, 0) /* (M20) OSPI0_D2 */
> +			AM64X_IOPAD(0x0018, PIN_INPUT, 0) /* (M21) OSPI0_D3 */
> +			AM64X_IOPAD(0x001c, PIN_INPUT, 0) /* (P21) OSPI0_D4 */
> +			AM64X_IOPAD(0x0020, PIN_INPUT, 0) /* (P20) OSPI0_D5 */
> +			AM64X_IOPAD(0x0024, PIN_INPUT, 0) /* (N18) OSPI0_D6 */
> +			AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
> +			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
> +		>;
> +	};
>  };
>  
>  &mcu_uart0 {
> @@ -171,3 +187,23 @@ &sdhci1 {
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
>  };
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
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
> -- 
> 2.30.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
