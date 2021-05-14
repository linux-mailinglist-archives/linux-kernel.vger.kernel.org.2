Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E140438092F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhENMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:11:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08511C061574;
        Fri, 14 May 2021 05:09:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k10so13117876ejj.8;
        Fri, 14 May 2021 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Go5OSz4/H+uPDLDGGgQ0MKW8Mm4VQjGQmcRsSfCNjhk=;
        b=nD4+69L0GyZ2kV1uA2c1GTo/HMZ/EwsYCcl5GHssbzJpZ+D9vMPWQCPTEaQD39HZas
         SMqHD02OWB4MeDbgtjJiRznlEVZ4oAL7xBeX1jKBOqN0JFLQLwqLpsdH2H4iWAyK3t5l
         ekdbOWF2G6Js328yV3c4NJzRJWujby5zvV6XP90+7maeQ5yF7u8NV7QaAG+NrSKY/0ZN
         ohGCc8yaGYndmDKouASKQlLz4/OLbKU9mdJeC93rcApDsP7fY+/6tUrpYTa+Q1/3v/Xp
         4e+LRZ/sK2MeoFOvS683JBwCUp9a030AItFCwn4rI541vd396RfYD+a/3zypC6Xadphn
         Ho5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Go5OSz4/H+uPDLDGGgQ0MKW8Mm4VQjGQmcRsSfCNjhk=;
        b=qVljTajgMQmOWSXBfAltptRivkoEASRzn6tG1KWjSOdIV3cBvqKcM66m8o8jCBH1lG
         5GYOoUIVITHPh+p+Xs36FT+KeDy5gmktRyJuo/dcxGlXU2YthQhV42yOrmiinEQHhUW9
         jSE4NEnF4RtXjrS9BV9PtNbPCeFiH/jWKJNiWnmxCW/02Mla34jENpCht08cyRhNlSJU
         hVpEwuEiE4+3neOIPs8dw5GCGjuAUi4BGFVcWT8pI7ZVbQqb6TPiJkZ8LlcRRNWRVTKJ
         bE4D+X2mKl9AbGKGmP4gtMaDHV1uF1szmGlKo21ktLZkWmr6LEko0gnLcHSQNdSnGqK/
         HGfA==
X-Gm-Message-State: AOAM532Ez8LsY4I59AXIoCyIct1Im5P7mABnIWJUAa7STouxDby7y2ZS
        +FABZAj7/lMIiV/wrUQbgNXVC6Vz0bs=
X-Google-Smtp-Source: ABdhPJyAnROvySSX2j8qEuTumlWsloarcCjIII71QSFBa3JDkrFykrLpk6GMnrwn96PJCPZnt2nMIA==
X-Received: by 2002:a17:906:60d6:: with SMTP id f22mr48909457ejk.177.1620994188724;
        Fri, 14 May 2021 05:09:48 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i5sm749805ejv.120.2021.05.14.05.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 05:09:48 -0700 (PDT)
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add USB support to RK3308 dts
To:     Tobias Schramm <t.schramm@manjaro.org>, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210514102734.2091238-1-t.schramm@manjaro.org>
 <20210514102734.2091238-5-t.schramm@manjaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <01388394-603e-6a43-2044-ae1e93eb0ff3@gmail.com>
Date:   Fri, 14 May 2021 14:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514102734.2091238-5-t.schramm@manjaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

Just sent a patch for grf.yaml and rockchip-usb-phy.yaml conversion myself.

Added { .compatible = "rockchip,rk3308-usb2phy", .data =
&rk3308_phy_cfgs }, to phy-rockchip-inno-usb2.c

Added is "rockchip,rk3308-usb-phy" to rockchip-usb-phy.txt

compatible = "rockchip,rk3308-usb2phy"; is used in this patch.

Maybe try phy-rockchip-inno-usb2.yaml?

"rockchip,rk3308-usb2phy-grf", "syscon", "simple-mfd" document missing.

Could someone recheck the reg memory size?
Is this still correct then?

===
compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
reg = <0x0 0xff000000 0x0 0x10000>;

Do we still need "0x0 0x10000" here?
===
compatible = "rockchip,rk3308-usb2phy-grf", "syscon", "simple-mfd";
reg = <0x0 0xff008000 0x0 0x4000>;
===
compatible = "rockchip,rk3308-detect-grf", "syscon", "simple-mfd";
reg = <0x0 0xff00b000 0x0 0x1000>;
===
compatible = "rockchip,rk3308-core-grf", "syscon", "simple-mfd";
reg = <0x0 0xff00c000 0x0 0x1000>;
===

Johan

On 5/14/21 12:27 PM, Tobias Schramm wrote:
> The Rockchip RK3308 features an integrated USB 2.0 phy, an USB OTG
> controller and OHCI/EHCI interfaces.
> This patch adds all of those to the RK3308 dtsi and thereby enables USB
> support on the RK3308.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 75 ++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 0c5fa9801e6f..80fd802d6c15 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -177,6 +177,43 @@ reboot-mode {
>  		};
>  	};
>  
> +	usb2phy_grf: syscon@ff008000 {
> +		compatible = "rockchip,rk3308-usb2phy-grf", "syscon",
> +			     "simple-mfd";
> +		reg = <0x0 0xff008000 0x0 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		u2phy: usb2-phy@100 {

> +			compatible = "rockchip,rk3308-usb2phy";
> +			reg = <0x100 0x10>;
> +			clocks = <&cru SCLK_USBPHY_REF>;
> +			clock-names = "phyclk";
> +			clock-output-names = "usb480m_phy";
> +			#clock-cells = <0>;
> +			assigned-clocks = <&cru USB480M>;
> +			assigned-clock-parents = <&u2phy>;
> +			status = "disabled";
> +

Looks like

> +			u2phy_otg: otg-port {
> +				#phy-cells = <0>;
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "otg-bvalid", "otg-id",
> +						  "linestate";
> +				status = "disabled";
> +			};
> +
> +			u2phy_host: host-port {
> +				#phy-cells = <0>;
> +				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "linestate";
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
>  	detect_grf: syscon@ff00b000 {
>  		compatible = "rockchip,rk3308-detect-grf", "syscon", "simple-mfd";
>  		reg = <0x0 0xff00b000 0x0 0x1000>;
> @@ -579,6 +616,44 @@ spdif_tx: spdif-tx@ff3a0000 {
>  		status = "disabled";
>  	};
>  
> +	usb20_otg: usb@ff400000 {
> +		compatible = "rockchip,rk3308-usb", "rockchip,rk3066-usb",
> +			     "snps,dwc2";
> +		reg = <0x0 0xff400000 0x0 0x40000>;
> +		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_OTG>;
> +		clock-names = "otg";
> +		dr_mode = "otg";
> +		g-np-tx-fifo-size = <16>;
> +		g-rx-fifo-size = <280>;
> +		g-tx-fifo-size = <256 128 128 64 32 16>;
> +		phys = <&u2phy_otg>;
> +		phy-names = "usb2-phy";
> +		status = "disabled";
> +	};
> +
> +	usb_host_ehci: usb@ff440000 {
> +		compatible = "generic-ehci";
> +		reg = <0x0 0xff440000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
> +		clock-names = "usbhost", "arbiter", "utmi";
> +		phys = <&u2phy_host>;
> +		phy-names = "usb";
> +		status = "disabled";
> +	};
> +
> +	usb_host_ohci: usb@ff450000 {
> +		compatible = "generic-ohci";
> +		reg = <0x0 0xff450000 0x0 0x10000>;
> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
> +		clock-names = "usbhost", "arbiter", "utmi";
> +		phys = <&u2phy_host>;
> +		phy-names = "usb";
> +		status = "disabled";
> +	};
> +
>  	sdmmc: mmc@ff480000 {
>  		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
>  		reg = <0x0 0xff480000 0x0 0x4000>;
> 
