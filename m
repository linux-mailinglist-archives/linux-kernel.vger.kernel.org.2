Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146ED37ED4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386207AbhELUUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:20:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49134 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379706AbhELTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:41:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CJeNuY099245;
        Wed, 12 May 2021 14:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620848423;
        bh=XAxS0SFmIO1s0BnTAqYY39TUgH1g7xZH22mM1kqhW6w=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=K4aN4KrilSsAyG3k6eLAjq4S8oceXLPdhroGnMK0UzdGg3DxTS8OfW4H7fGJpQWCI
         cqbG/pGXWqaPa2Dq2QWM5j82uSh2PKKRLKq0mAkevmfzWWEPmrtUhgH7mekVdslMbV
         kS9TkdfHIi/ZuazLQj7ljNKIgSPKNiFVPN+uqG0w=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CJeNKu023795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 14:40:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 14:40:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 14:40:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CJeMA5084821;
        Wed, 12 May 2021 14:40:22 -0500
Date:   Wed, 12 May 2021 14:40:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: Re: [PATCH 4/5] arm64: dts: ti: k3-am642-sk: Enable USB Super-Speed
 HOST port
Message-ID: <20210512194022.27h53llpxmvg3eoe@splurge>
References: <20210512150107.26793-1-kishon@ti.com>
 <20210512150107.26793-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210512150107.26793-5-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:31-20210512, Kishon Vijay Abraham I wrote:
> Enable USB Super-Speed HOST port.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 8424cd071955..056c1b2df559 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -5,6 +5,8 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/mux/ti-serdes.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include "k3-am642.dtsi"
> @@ -85,6 +87,12 @@
>  		>;
>  	};
>  
> +	main_usb0_pins_default: main-usb0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
> +		>;
> +	};
> +
>  	main_i2c1_pins_default: main-i2c1-pins-default {
>  		pinctrl-single,pins = <
>  			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
> @@ -235,6 +243,37 @@
>  	disable-wp;
>  };
>  
> +&serdes_ln_ctrl {
> +	idle-states = <AM64_SERDES0_LANE0_USB>;
> +};
> +
> +&serdes_wiz0 {
> +	status = "okay";


not sure I understand why default of okay needs to be explicitly stated
as okay in board dts.

> +};
> +
> +&serdes0 {
> +	serdes0_usb_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_USB3>;
> +		resets = <&serdes_wiz0 1>;
> +	};
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +	maximum-speed = "super-speed";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb0_pins_default>;
> +	phys = <&serdes0_usb_link>;
> +	phy-names = "cdns3,usb3-phy";
> +};
> +
>  &cpsw3g {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mdio1_pins_default
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
