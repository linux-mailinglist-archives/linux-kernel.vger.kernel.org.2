Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E313D936A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhG1Qpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1Qpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:45:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9564C061757;
        Wed, 28 Jul 2021 09:45:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p21so4087780edi.9;
        Wed, 28 Jul 2021 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGfA1NrZyQu1R2a0GsuAljWypmKOfYdM6LECx2rex44=;
        b=HRJgApN2/CKWbs9hr+WFXtAIgadljNcdJPQRjHz7pIzlU8wYsvU2xwPdYaZctom5YM
         868KASENk4JOJZVCvGOomxLzc2xczWUPAC82JHgtK75pCNnsrwCXPnvFnO74TuGmr3ku
         5c7IBjOT/2DNJuPypDpKomQOXdDVLBLvLzBZCPNgv9pXCNcqe7i0myBvEEWurCB2F812
         fWJvsjOrVG30AMDEcGsTz3A+F946LOimskwfiYe8uG862hEvGSo9OF/Qf01pdc9w47+p
         MYgkcOnBOaFu6vtOmXhrhL1PI6aqjY+Ab82HUoOJBO6L1qzY+7oO3IqTfuw+ICsovIvP
         wKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGfA1NrZyQu1R2a0GsuAljWypmKOfYdM6LECx2rex44=;
        b=gMi8copXUk55a5YpQkFPl8JyMFJRpt873GIyoZ8B5jzOfXNIVyQprJUP6s3kkNC2bB
         PeL6yjzL+qNIya6EWzpIjIfKBIEHIps4t3eggqcZ0HJyaGfYAHOqZxTGhGTC4zobwBel
         7xE9Eh0v9tdvki8Bqu82QW31XFx5D6qVyaNQlijiEbKxfs9agcEjdB49Mdiy5z3lNyVs
         jaS30hGPMKnFPyVRi1X/6ZcvhjQ7Sf1ElaO/28J0yXMfFrMR6nPro4ku342lyYRA/0ja
         snPw9A0nubgQANraco9o5MkpGy4Yi+uwepQ0mg0GjAPkJZtIk/+CHksspAwdGFHqDOMv
         ym1A==
X-Gm-Message-State: AOAM533/Z4g3UldGHCVFmrXXHoXbm3G01KiGxVeZbyYFx9K2zCsgAMM+
        /loWZ4KbKZbOemrJco5GvPc=
X-Google-Smtp-Source: ABdhPJytWGmxMlsX7P0Mt6mcG7wJoKfTFU8iv0Jiw9IHj/VGfVHrqPBGug3j3yVFepDVDbGW+XESLw==
X-Received: by 2002:a05:6402:2228:: with SMTP id cr8mr854158edb.309.1627490747347;
        Wed, 28 Jul 2021 09:45:47 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c7sm121524edn.45.2021.07.28.09.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:45:46 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3568-evb1-v10: add ethernet
 support
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>
References: <20210728161020.3905-1-michael.riesch@wolfvision.net>
 <20210728161020.3905-3-michael.riesch@wolfvision.net>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <eb5932de-bd6c-de5e-d130-5252f98a12c7@gmail.com>
Date:   Wed, 28 Jul 2021 18:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728161020.3905-3-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 7/28/21 6:10 PM, Michael Riesch wrote:
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> index 69786557093d..8f4c40d71914 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> @@ -13,6 +13,11 @@
>  	model = "Rockchip RK3568 EVB1 DDR4 V10 Board";
>  	compatible = "rockchip,rk3568-evb1-v10", "rockchip,rk3568";
>  
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
>  	chosen: chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
> @@ -67,6 +72,70 @@
>  	};
>  };
>  
> +&gmac0 {
> +	phy-mode = "rgmii";
> +	clock_in_out = "output";
> +
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> +	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +
> +	tx_delay = <0x3c>;
> +	rx_delay = <0x2f>;
> +
> +	phy-handle = <&rgmii_phy0>;
> +	status = "okay";
> +};
> +
> +&gmac1 {
> +	phy-mode = "rgmii";
> +	clock_in_out = "output";
> +
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_rgmii_bus>;
> +
> +	tx_delay = <0x4f>;
> +	rx_delay = <0x26>;
> +
> +	phy-handle = <&rgmii_phy1>;
> +	status = "okay";
> +};
> +
> +&mdio0 {

> +	rgmii_phy0: phy@0 {

Could you test with ethernet-phy.yaml?

  $nodename:
    pattern: "^ethernet-phy(@[a-f0-9]+)?$"

> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reg = <0x0>;

Sort order is:
compatible
reg
(interrupts)
The rest in alphabetical order.

> +	};
> +};
> +
> +&mdio1 {

> +	rgmii_phy1: phy@0 {

dito

> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reset-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reg = <0x0>;

dito

> +	};
> +};
> +
>  &sdhci {
>  	bus-width = <8>;
>  	max-frequency = <200000000>;
> 
