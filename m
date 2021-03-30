Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5334EC42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhC3PZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhC3PZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:25:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592E4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:25:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c8so16618898wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bFbGRcM54PcoFFrJNaAyx00F7Jf8sd2b9QRt7gGOII=;
        b=IIL/4TJj1Lc8pQKDI+tV8K0ZmTO+m0lZnMFZtDohRK03yE5MoKAkLuXMXObAy4JlEy
         QhKi90MM/l5f1vW8a0bo79MZZnxgKak4+9zXMuvyrf+oIXwNnrmj4su1xvdRT+If/oyw
         xUxmWwyB8W8b+tHKtO3/jC9X1wG2Fpy4q8HhR60U92CYfUQADP5dYxdUPDj7Kiz+ATgl
         VOm8B526KXObUQD+h2CR3h/tVEjGT775pCxmr4YAznkMj2nUMzkEwbg/GU2Oge5WGAtm
         dPEOdfLmxjqg+07yuyP+rGRXXpa1lNF8s5lfswtgCrkec1AjbZjHFoiqsk2llmx/NHeN
         8kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+bFbGRcM54PcoFFrJNaAyx00F7Jf8sd2b9QRt7gGOII=;
        b=NVYYqVcNb/t7hPg8+a/+BJX/STfXDDnW2wHz8Mh4I9jSira8dh5UZ0EEDfoa0eIuK9
         Iqqu5AFZb6fdYVDAeHfyet81PwtfU3E1p8txEgFBZkyMM0BAU2mnk6teWhmbt1bXIYBC
         HVbR890xxulNsLyEzT/iiCTYQ8F4KtlRBFBjduukbUE70VonxwurnUdcwZrwJOUBFN23
         ToZdqxonGNmUy9f1EIDESS9cWSf1l7jcg72uuPiuu9DttSf+S/eVz8IiJ55aC8GMfDd7
         gcRWgGx6Eh1gEytedtAzaiA1835ZKYpY0/otCohkpOOWo/RmiR+1FLhAzBLDukY0Ejar
         /22A==
X-Gm-Message-State: AOAM530CDY6LR+QIP5VI9YxsDQwkrWnIy/XhxuTUUBpqryEGQrJOsYUF
        6tsM5SrHls7JhaYxmrYGCJwRuA==
X-Google-Smtp-Source: ABdhPJyuvNMOMwv4i8D1t7uU2BOwCCAKUFRLlZ7FlwqJYZTC6jFDPS/G/flc1Tqzwz15W42NUl+cjA==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr34223616wrt.280.1617117912036;
        Tue, 30 Mar 2021 08:25:12 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:2d11:7929:c1dd:292? ([2a01:e0a:90c:e290:2d11:7929:c1dd:292])
        by smtp.gmail.com with ESMTPSA id a6sm5862970wmm.0.2021.03.30.08.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:25:11 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: dts: meson: add initial device-tree for MeCool
 KII Pro
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Drazen Spio <drazsp@gmail.com>
References: <20210329154753.30074-1-christianshewitt@gmail.com>
 <20210329154753.30074-3-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <8d1c1ca7-8a90-1369-2046-e52d2c2a54c5@baylibre.com>
Date:   Tue, 30 Mar 2021 17:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329154753.30074-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2021 17:47, Christian Hewitt wrote:
> MeCool (Videostrong) KII Pro is based on the Amlogic P230 reference
> board with an S905D chip and the following specs:
> 
> - 2GB DDR3 RAM
> - 16GB eMMC
> - 10/100 Base-T Ethernet
> - BCM4335 Wireless (802.11 b/g/n/ac, BT 4.0)
> - DVB-C/T/T2/S/S2 (AVL6862TA demod + R848 tuner)
> - HDMI 2.0a video
> - S/PDIF optical output
> - CVBS/Analogue output
> - 4x USB 2.0 ports
> - IR receiver
> - 1x Power button (with integrated blue LED)
> - 1x micro SD card slot
> 
> Tested-by: Drazen Spio <drazsp@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../meson-gxl-s905d-mecool-kii-pro.dts        | 86 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index aebd49c88719..f8f515c93055 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-mecool-kii-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts
> new file mode 100644
> index 000000000000..5ab5d3aa0646
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/*
> + * Author: Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905d.dtsi"
> +#include "meson-gx-p23x-q20x.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	compatible = "videostrong,gxl-kii-pro", "amlogic,s905d", "amlogic,meson-gxl";
> +	model = "MeCool KII Pro";
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1710000>;
> +
> +		button-function {
> +			label = "Update";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <10000>;
> +		};
> +	};
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <100>;
> +
> +		button@0 {
> +			label = "power";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		blue {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			panic-indicator;
> +		};
> +	};
> +};
> +
> +&ethmac {
> +	phy-mode = "rmii";
> +	phy-handle = <&internal_phy>;
> +};
> +
> +&ir {
> +	linux,rc-map-name = "rc-mecool-kii-pro";
> +};
> +
> +&sd_emmc_a {
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		max-speed = <2000000>;
> +		clocks = <&wifi32k>;
> +		clock-names = "lpo";
> +	};
> +};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
