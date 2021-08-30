Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E63FB20E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhH3HqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhH3HqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:46:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C4C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:45:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t15so14852977wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JmmtJ+a+mV12UNw1rZr4wpix3L8Nuoi+h1F+J6JIITU=;
        b=jgDIyApDbeuxGB4yb1kORYbMRMQKQ4DPtMap5Rcl3Wkw0Et/Z2++NHx+0M5LT1KQwv
         r0pGok1bF5nZVO9Cw1uVYplSp+nb1LyfdaC6ZU74/80lgIJQTc619hruPhEBrIgkAb8t
         KJ9jY8J4udNnfndgInbSFlP1wlYHU5HJHEus8mThb296XKldMQp/TiSlOqycbF2D79KS
         zk4GjcQ8x+v/7tQnFqMrPlt/JTEclApC5w/n8U9BYgCInWILNu8EqOPEOYjRLJCtvJws
         lCxZ4zfuOd2TbEtZ9UqElX9UbAVU/muPliuvvy49R8t9iJ6oSlamhTm65wvB1RvAu9IG
         wTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JmmtJ+a+mV12UNw1rZr4wpix3L8Nuoi+h1F+J6JIITU=;
        b=OJtoOcAL9NokagCNpy+mYJJWzw5aLV5eIAeDKlLzsfOBDLdXdjZPaJJf9xUuNfrdRc
         6alBMgrSep0zGHJxgbRVxvrh4wGCNlvNLAFqrH1GGbRnaVBISeLNjO6lcwceD7YuYoXG
         f7bPNaEeUGKKhkBVspD6iEPBjOTye7ylqzvBUynGiuT90WArUiUrjmYPTsq8G+CK8Y1c
         zc/56ukkFGdaXphOIA+pCwrbxWvfqFf/mYz9y6C4Q1PvesmMBAdTj4Yg2lShLKy8gEk7
         tTgPbOpGU9IimeSE2TSJ9wvJ2SGtwI/HTLQXKRUKkZ/SRo3o07SCnAC9GtRmfKBzmDkT
         fO7Q==
X-Gm-Message-State: AOAM532YhKEtL50Mcv1zRDHNb8+ufbcUTh+jqBjkgPVf54PZ4HOcf4Sr
        iQSxuhf0xzVsRc5bC3pSarOdMg==
X-Google-Smtp-Source: ABdhPJx0KFabuLNOqRvUQkIv6P6jI44f7L82OW4/X1oIRfnWJn1JU1qIsaCvVIKvykvKmrvlL81w4g==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr24464082wrn.122.1630309527740;
        Mon, 30 Aug 2021 00:45:27 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:2ecd:4eac:486d:7a1? ([2001:861:44c0:66c0:2ecd:4eac:486d:7a1])
        by smtp.gmail.com with ESMTPSA id n8sm14723382wra.24.2021.08.30.00.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 00:45:27 -0700 (PDT)
Subject: Re: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
 <20210817041548.1276-2-linux.amoon@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <c7f6213b-5ddc-881c-1aea-9cc7b03e6a4f@baylibre.com>
Date:   Mon, 30 Aug 2021 09:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817041548.1276-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/08/2021 06:15, Anand Moon wrote:
> Add missing usb phy power node for usb node fix below warning.
> P5V0 regulator supply input voltage range to USB host controller.
> As described in the C1+ schematics, GPIO GPIOAO_5 is used to
> enable input power to USB ports, set it to Active Low.
> 
> [    1.260772] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
> [    1.260784] dwc2 c90c0000.usb: Looking up vbus-supply property in
> 		mode /soc/usb@c90c0000 failed

First of all, DT is not here to fix boot message.

Secondly, if the vbus-supply is optional, the message should be removed from
the driver/regulator core instead.

Finally, I looked at the Odroid-C1 schematics and the GPIOAO.BIT5 is an input
to the S805, and the PWREN signal is controlled by the USB Hub so this regulator
should not be added at all.

Neil

> 
> Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host
> 		controller on Odroid-C1/C1+ board)
> 
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V2 > changes gpio polarity ACTIVE_HIGH to ACTIVE_LOW.
>      Fix the source power from phy-supply to vbus-supply.
> 
> [1] https://lore.kernel.org/linux-devicetree/20210716103651.1455-2-linux.amoon@gmail.com/
> 
> V1 > Fix the Input GPIO polarity from HIGH to LOW.
> 
> previous version
> [0] https://patchwork.kernel.org/project/linux-amlogic/patch/20190113181808.5768-1-linux.amoon@gmail.com
> 
> changes fix the vbus-suppy to phy-supply, drop enable usb0
> 
>     USB_PWR                       2    1      0 unknown  5000mV     0mA  5000mV  5000mV
>        phy-c1108820.phy.0-phy     2                                 0mA     0mV     0mV
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index c440ef94e082..30ec6a7f20c7 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -32,6 +32,23 @@ emmc_pwrseq: emmc-pwrseq {
>  		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
>  	};
>  
> +	usb_pwr_en: regulator-usb-pwr-en {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "USB_OTG_PWR";
> +
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		/*
> +		 * signal name from schematics: USB_POWER - P5V0
> +		 */
> +		vin-supply = <&p5v0>;
> +		/*
> +		 * signal name from schematics: PWREN - GPIOAO.BIT5
> +		 */
> +		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		blue {
> @@ -119,7 +136,6 @@ vcc_3v3: regulator-vcc-3v3 {
>  		regulator-name = "VCC3V3";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> -
>  		vin-supply = <&p5v0>;

As martin said, only a single functional change per patch please, this line removal should go in another patch.

>  	};
>  
> @@ -382,4 +398,5 @@ &usb1_phy {
>  
>  &usb1 {
>  	status = "okay";
> +	vbus-supply = <&usb_pwr_en>;
>  };
> 

