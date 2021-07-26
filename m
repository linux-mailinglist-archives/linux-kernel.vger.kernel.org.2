Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16783D54C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhGZHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhGZHTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:19:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4766C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:00:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l4so9948594wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJpyEeHTDudroREb/Jyt5I/e4kbgAgcH314KeB9WrAE=;
        b=XJPIJtQcxc3JCZhnqQoBM4SWGnvoSWYYIoIeUkb8F+5tGmSoSKviWG4CC3pL6MJPSW
         xwi6Yx6KDnqzZkRvQp6k+DauGfZjchvG7RqsVZeR+74PRqET+IJzmRYrbzLN+lyVdv0C
         NajS5n3FPISZ9KAasG/jOR2hZLXtRgQ7yGa7+gWI6rNx2ntY+ODMZKtAlDpb3HcT0jx9
         g19E74bWWT2t312gSrB4exubXfq6oJKrR0vhgsmcXKRHmzSV+lA6SF9QrEAwuFAr7MFZ
         9uLtRKAUHTrPR48TdGHtduMAjHTDa4mrYsJQrW/fcIdbRAAkmp6J8181WgWfnRcDsq4Q
         J7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BJpyEeHTDudroREb/Jyt5I/e4kbgAgcH314KeB9WrAE=;
        b=k6KdktleDPECU/EfXF+vfD0y27vzFdqEkFa8tnHd34hALYuk63cBn8F7mioOn1fsTC
         c931kP75s6Ws/MOEaBUpChx/+zC2kDEzfS37SX9LvA0FW7XqPZWUcqfuEYWhZWYvWcSQ
         S54Nmc8j3BQSRjEkNz9DlaWHNVJ1IXCcBD6vq0X1/hllqRb5raUwLcT5DJVPa3boNVr8
         Gb9I4/tYmLSMUQj7688DlIu2lXRPwupIWm63vO1dzQLS1FQQmdoHlX+5sSnUoShmfR/h
         Z8mnl923dYhc8nzqi9uVBM4UTX+UHgD6/W5N9GMk7bRVGP8vm1ZWr9vcz1emW19GmCVQ
         PxWw==
X-Gm-Message-State: AOAM533arqrQtDj8t4u8d8kzv9B1uSwP3M8q3+HwsnrGctcWZkMbYZFa
        SjShooe4UUnap1AaxJ9v/EHQHmW7Rq+aWTbs
X-Google-Smtp-Source: ABdhPJwEEKx0yAZ8gOlSwvDVdvwmXCM0J0EKT9gCXWOSr3C62EOI7n31GiLfh97VnYbZ4TCHs14CnQ==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr17751961wro.281.1627286409776;
        Mon, 26 Jul 2021 01:00:09 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:32b6:aa71:d2df:4f1d? ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id r19sm43916628wrr.32.2021.07.26.01.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 01:00:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ARM: dts: meson: Add the AIU audio controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
 <20210717233030.331273-2-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <48116849-8a76-7048-2d71-9a2853db94b5@baylibre.com>
Date:   Mon, 26 Jul 2021 10:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717233030.331273-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2021 01:30, Martin Blumenstingl wrote:
> Add the AIU audio controller to the Amlogic Meson6/8/8b/8m2 SoC DT. This
> provides I2S and SPDIF outputs as well as codec glues for the internal
> HDMI controller.
> Also add the clock inputs and pin mux definitions on Meson8/8b/8m2. On
> Meson6 this is omitted because we neither have a clock nor pin
> controller node there yet.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson.dtsi   | 12 +++++++
>  arch/arm/boot/dts/meson8.dtsi  | 63 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/meson8b.dtsi | 63 ++++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index bd0e864964e9..3be7cba603d5 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/sound/meson-aiu.h>
>  
>  / {
>  	#address-cells = <1>;
> @@ -36,6 +37,17 @@ hhi: system-controller@4000 {
>  				reg = <0x4000 0x400>;
>  			};
>  
> +			aiu: audio-controller@5400 {
> +				compatible = "amlogic,aiu";
> +				#sound-dai-cells = <2>;
> +				sound-name-prefix = "AIU";
> +				reg = <0x5400 0x2ac>;
> +				interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names = "i2s", "spdif";
> +				status = "disabled";
> +			};
> +
>  			assist: assist@7c00 {
>  				compatible = "amlogic,meson-mx-assist", "syscon";
>  				reg = <0x7c00 0x200>;
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 686c7b7c79d5..f80ddc98d3a2 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -317,6 +317,29 @@ mali: gpu@c0000 {
>  	};
>  }; /* end of / */
>  
> +&aiu {
> +	compatible = "amlogic,aiu-meson8", "amlogic,aiu";
> +	clocks = <&clkc CLKID_AIU_GLUE>,
> +		 <&clkc CLKID_I2S_OUT>,
> +		 <&clkc CLKID_AOCLK_GATE>,
> +		 <&clkc CLKID_CTS_AMCLK>,
> +		 <&clkc CLKID_MIXER_IFACE>,
> +		 <&clkc CLKID_IEC958>,
> +		 <&clkc CLKID_IEC958_GATE>,
> +		 <&clkc CLKID_CTS_MCLK_I958>,
> +		 <&clkc CLKID_CTS_I958>;
> +	clock-names = "pclk",
> +		      "i2s_pclk",
> +		      "i2s_aoclk",
> +		      "i2s_mclk",
> +		      "i2s_mixer",
> +		      "spdif_pclk",
> +		      "spdif_aoclk",
> +		      "spdif_mclk",
> +		      "spdif_mclk_sel";
> +	resets = <&reset RESET_AIU>;
> +};
> +
>  &aobus {
>  	pmu: pmu@e0 {
>  		compatible = "amlogic,meson8-pmu", "syscon";
> @@ -340,6 +363,38 @@ gpio_ao: ao-bank@14 {
>  			gpio-ranges = <&pinctrl_aobus 0 0 16>;
>  		};
>  
> +		i2s_am_clk_pins: i2s-am-clk-out {
> +			mux {
> +				groups = "i2s_am_clk_out_ao";
> +				function = "i2s_ao";
> +				bias-disable;
> +			};
> +		};
> +
> +		i2s_out_ao_clk_pins: i2s-ao-clk-out {
> +			mux {
> +				groups = "i2s_ao_clk_out_ao";
> +				function = "i2s_ao";
> +				bias-disable;
> +			};
> +		};
> +
> +		i2s_out_lr_clk_pins: i2s-lr-clk-out {
> +			mux {
> +				groups = "i2s_lr_clk_out_ao";
> +				function = "i2s_ao";
> +				bias-disable;
> +			};
> +		};
> +
> +		i2s_out_ch01_ao_pins: i2s-out-ch01 {
> +			mux {
> +				groups = "i2s_out_ch01_ao";
> +				function = "i2s_ao";
> +				bias-disable;
> +			};
> +		};
> +
>  		uart_ao_a_pins: uart_ao_a {
>  			mux {
>  				groups = "uart_tx_ao_a", "uart_rx_ao_a";
> @@ -460,6 +515,14 @@ mux {
>  			};
>  		};
>  
> +		spdif_out_pins: spdif-out {
> +			mux {
> +				groups = "spdif_out";
> +				function = "spdif";
> +				bias-disable;
> +			};
> +		};
> +
>  		spi_nor_pins: nor {
>  			mux {
>  				groups = "nor_d", "nor_q", "nor_c", "nor_cs";
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index c02b03cbcdf4..b49b7cbaed4e 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -279,6 +279,29 @@ mali: gpu@c0000 {
>  	};
>  }; /* end of / */
>  
> +&aiu {
> +	compatible = "amlogic,aiu-meson8b", "amlogic,aiu";
> +	clocks = <&clkc CLKID_AIU_GLUE>,
> +		 <&clkc CLKID_I2S_OUT>,
> +		 <&clkc CLKID_AOCLK_GATE>,
> +		 <&clkc CLKID_CTS_AMCLK>,
> +		 <&clkc CLKID_MIXER_IFACE>,
> +		 <&clkc CLKID_IEC958>,
> +		 <&clkc CLKID_IEC958_GATE>,
> +		 <&clkc CLKID_CTS_MCLK_I958>,
> +		 <&clkc CLKID_CTS_I958>;
> +	clock-names = "pclk",
> +		      "i2s_pclk",
> +		      "i2s_aoclk",
> +		      "i2s_mclk",
> +		      "i2s_mixer",
> +		      "spdif_pclk",
> +		      "spdif_aoclk",
> +		      "spdif_mclk",
> +		      "spdif_mclk_sel";
> +	resets = <&reset RESET_AIU>;
> +};
> +
>  &aobus {
>  	pmu: pmu@e0 {
>  		compatible = "amlogic,meson8b-pmu", "syscon";
> @@ -302,6 +325,46 @@ gpio_ao: ao-bank@14 {
>  			gpio-ranges = <&pinctrl_aobus 0 0 16>;
>  		};
>  
> +		i2s_am_clk_pins: i2s-am-clk-out {
> +			mux {
> +				groups = "i2s_am_clk_out";
> +				function = "i2s";
> +				bias-disable;
> +			};
> +		};
> +
> +		i2s_out_ao_clk_pins: i2s-ao-clk-out {
> +			mux {
> +				groups = "i2s_ao_clk_out";
> +				function = "i2s";
> +				bias-disable;
> +			};
> +		};
> +
> +		i2s_out_lr_clk_pins: i2s-lr-clk-out {
> +			mux {
> +				groups = "i2s_lr_clk_out";
> +				function = "i2s";
> +				bias-disable;
> +			};
> +		};
> +
> +		i2s_out_ch01_ao_pins: i2s-out-ch01 {
> +			mux {
> +				groups = "i2s_out_01";
> +				function = "i2s";
> +				bias-disable;
> +			};
> +		};
> +
> +		spdif_out_1_pins: spdif-out-1 {
> +			mux {
> +				groups = "spdif_out_1";
> +				function = "spdif_1";
> +				bias-disable;
> +			};
> +		};
> +
>  		uart_ao_a_pins: uart_ao_a {
>  			mux {
>  				groups = "uart_tx_ao_a", "uart_rx_ao_a";
> 


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
