Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72763D54C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhGZHUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhGZHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:20:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D9C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:00:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h14so1990145wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q59twgfa+FeEQtVy2D8Ev2ETY/cVtZPoYvkK2eCUnjw=;
        b=hpvOzN/KAig7+OUzRL4S+LB0gZf8i0GqTijEG7k1KQKP1LLS/aeSF1us+5j0JG+gTS
         ye8EWJ2N0CMWl6hVXer67x/jfgeuG0aNQM/h8UOLqKgNdbkyN1+3kH7vsbcRHNy3H7df
         R/naq0SfdHNJHUt5m3a65CUr0Lv5TlQanlNUxUK8MsbfMJ9voR0xmsk2xJCpzCKEo7Kt
         3b/TPzNVCUOE6hgBedEVMBM8yvk5zTKK+gUNtpmJXFZvZV76TDLeu/ei/MLh8BfY+lHR
         5kGmSh6LY2f9lEaf9lBpeklN9q+j1mC9epJy1KJbTza3EBpLBUhvK0hwe45W85BIzNXa
         Wu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q59twgfa+FeEQtVy2D8Ev2ETY/cVtZPoYvkK2eCUnjw=;
        b=Yp4m3ePPW9nVzNeuOT2lJhI60O5Inm+R5XCjA5XN7aE0NRU2Jco1T23vEMrlnJ8hHK
         4qRxF3rxIedJ3JY9UBxXuJUo94rLqzEGCtGrrJD68MuOqRo/0zkl8+ID8pNNUlDV3+Wo
         XH1yyzEq5AqycX4T6SDK2UnfUf8xPjGtZhTlysPVGwyG8K4j8T7kr6whxhD/ZJ7zTl0e
         qLFs/Ah2DPlwqxXicDHl9uRGSFOIgCkATm/PTc8Y1sg5QONfP0ZJx68i0DJbSYt0oEr8
         +fDiNNrO+URd1b3u1BJomby3+Vvev2actKFiiy9JQZkYvKMW0yQ5Ify9x8IdJuUFtq07
         U8SQ==
X-Gm-Message-State: AOAM5308Ovee/AZheFBSj0CXe8DfHZyVR3A9xkUX5wNyad/Ecq3eQH/a
        zMUg/Xrf8L4l9BBTEGQJrKcBrUdq3E/hkeRE
X-Google-Smtp-Source: ABdhPJz/Z2jYtoBkZHOZZfKrdjl4coISzKdv9e4USG4jdwOPJ86qy4fy0xa1bGusXEHS4Usc2NWb5w==
X-Received: by 2002:a5d:6b91:: with SMTP id n17mr17673714wrx.385.1627286440817;
        Mon, 26 Jul 2021 01:00:40 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:32b6:aa71:d2df:4f1d? ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id f15sm12416743wmj.15.2021.07.26.01.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 01:00:40 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] ARM: dts: meson8b: ec100: wire up the RT5640 audio
 codec
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
 <20210717233030.331273-3-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <fbcf5556-4c32-151a-7e45-9577c6a1349b@baylibre.com>
Date:   Mon, 26 Jul 2021 10:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717233030.331273-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2021 01:30, Martin Blumenstingl wrote:
> The Realtek RT5640 codec is connected to the SoC's I2S interface.
> Describe this in the .dts together with the codec's LDO1 enable GPIO so
> audio can be played on the Endless Mini.
> While here, add a note about the realtek,ldo1-en-gpios for which the
> EC100 uses GPIO_BSD_EN. Due to driver limitations this pin cannot be
> used currently.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8b-ec100.dts | 44 +++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
> index 8e48ccc6b634..e404bdccdab9 100644
> --- a/arch/arm/boot/dts/meson8b-ec100.dts
> +++ b/arch/arm/boot/dts/meson8b-ec100.dts
> @@ -96,6 +96,32 @@ rtc32k_xtal: rtc32k-xtal-clk {
>  		#clock-cells = <0>;
>  	};
>  
> +	sound {
> +		compatible = "amlogic,gx-sound-card";
> +		model = "M8B-EC100";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>,
> +				  <&clkc CLKID_MPLL2>;
> +		assigned-clock-rates = <270950400>,
> +				       <294912000>,
> +				       <393216000>;
> +
> +		dai-link-0 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +
> +			codec-0 {
> +				sound-dai = <&rt5640>;
> +			};
> +		};
> +	};
> +
>  	usb_vbus: regulator-usb-vbus {
>  		/*
>  		 * Silergy SY6288CCAC-GP 2A Power Distribution Switch.
> @@ -242,6 +268,14 @@ vddee: regulator-vddee {
>  	};
>  };
>  
> +&aiu {
> +	status = "okay";
> +
> +	pinctrl-0 = <&i2s_am_clk_pins>, <&i2s_out_ao_clk_pins>,
> +		    <&i2s_out_lr_clk_pins>, <&i2s_out_ch01_ao_pins>;
> +	pinctrl-names = "default";
> +};
> +
>  &cpu0 {
>  	cpu-supply = <&vcck>;
>  };
> @@ -283,9 +317,19 @@ &i2c_A {
>  
>  	rt5640: codec@1c {
>  		compatible = "realtek,rt5640";
> +
>  		reg = <0x1c>;
> +
> +		#sound-dai-cells = <0>;
> +
>  		interrupt-parent = <&gpio_intc>;
>  		interrupts = <13 IRQ_TYPE_EDGE_BOTH>; /* GPIOAO_13 */
> +
> +		/*
> +		 * TODO: realtek,ldo1-en-gpios is connected to GPIO_BSD_EN.
> +		 * We currently cannot configure this pin correctly.
> +		 * Luckily for us it's in the "right" state by default.
> +		 */
>  		realtek,in1-differential;
>  	};
>  };
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
