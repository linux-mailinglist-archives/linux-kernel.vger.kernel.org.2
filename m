Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB10401B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbhIFM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbhIFM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:27:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5178C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 05:26:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so4691530wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+jy8x9WOAR7Bo/LjNZP6GY2MDzsVGbtEkDP2KKI1OI=;
        b=BjA4qv5kdwQ/J0zpaMUVyNptNA8SDUERNN2uUNPqs5poc1wEVoxfHAyz+2+k8m0hjq
         UI1fHpLpGvJXr6mc+HXouUTIKpaJdRiZkYFTE/XAR2paqeXg0fvtoHXDSgfLun587SrW
         /du69DRv+qs7WVUJXpKIfHZFzWktkuMDE+dGxTSHyDaNQm2wBwlPXZdBz9mtPtsqITLK
         jXIl0y4Tnkpu0X+Q907MTviH8NDwmv/FzlliTyXL06m/XXVCx+aja6LDdwvGyA9AlNpz
         /uU2BdANW1g5zm9KSgsDM6H/Knw1dXQWkZZvxEy5vF1waFd+DIA7OjLwUUaI6OTLGpgQ
         VjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W+jy8x9WOAR7Bo/LjNZP6GY2MDzsVGbtEkDP2KKI1OI=;
        b=roZDjJpqP0zuq+0LMnuM/+J0Nq7GiIJof/hzTRntnoqL0PcU/ma3F/IaRFHhkVjXmz
         Ba8d0Z2cgAOuiYJRhRbYy/MogfxSF+ZKf12F3VDajiexVkvnUl6dNfIcYvLtBGhj9w3J
         DbSFgxFBnPRQwf/x6MD3+N8V6CuA5U94ijZ15v4QBY82woluYkofE2iCTdy4RmRus7e5
         GYDebSHtKQDtQjk+qsk8Ec/9dn6SQ3Y8xQlos08lZt2LPoFfigYwMxkOOrZ3ncEhg2Ap
         sIIcfGVssUAdUcC2ynKAHT5p0e0Fx77ALk/tfuQwThzrcnM5X0fwbma7ILkSHaG8UVS8
         08Ag==
X-Gm-Message-State: AOAM530vDJMvbdya0WEzM7/4FS3ZfKtqBXRe9CvD2XmGbGFSZtQKxDW8
        /CjK4l5sn3sMVicKIpBR/m30KNarxq3C+OiB
X-Google-Smtp-Source: ABdhPJz+HFE2XbNX+QPFYhRCqk3MwCIVuWOja+nFOKyBBOI8s3Bu0GUnK5epJcZc1vsJFazXE85UqQ==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr11125491wmj.1.1630931193602;
        Mon, 06 Sep 2021 05:26:33 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:9afb:57ba:5ea:2010? ([2001:861:44c0:66c0:9afb:57ba:5ea:2010])
        by smtp.gmail.com with ESMTPSA id e9sm8243132wrd.69.2021.09.06.05.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:26:33 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] arm64: dts: meson-axg: add support for JetHub D1
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210904142745.183875-1-adeep@lexina.in>
 <20210904142745.183875-5-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <77699dc0-88d5-3462-15fe-eb376c862d30@baylibre.com>
Date:   Mon, 6 Sep 2021 14:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904142745.183875-5-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2021 16:27, Vyacheslav Bocharov wrote:
> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
> controller with the following features:
> - DIN Rail Mounting
> - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
> - no video out
> - 512Mb/1GB LPDDR4
> - 8/16GB eMMC flash
> - 1 x USB 2.0
> - 1 x 10/100Mbps ethernet
> - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac,
>   Bluetooth 4.2.
> - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power
>   and Zigbee 3.0 support.
> - 2 x gpio LEDS
> - GPIO user Button
> - 1 x 1-Wire
> - 2 x RS-485
> - 4 x dry contact digital GPIO inputs
> - 3 x relay GPIO outputs
> - DC source with a voltage of 9 to 56 V / Passive POE
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../amlogic/meson-axg-jethome-jethub-j100.dts | 354 ++++++++++++++++++
>  2 files changed, 355 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 2c3ce7c401a5..3ba6f58b9833 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> new file mode 100644
> index 000000000000..bc10f3357c09
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Vyacheslav Bocharov <adeep@lexina.in>
> + * Copyright (c) 2020 JetHome
> + * Author: Aleksandr Kazantsev <ak@tvip.ru>
> + * Author: Alexey Shevelkin <ash@tvip.ru>
> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-axg.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	compatible = "jethome,jethub-j100", "amlogic,a113d", "amlogic,meson-axg";
> +	model = "JetHome JetHub J100";
> +	aliases {
> +		serial0 = &uart_AO;   /* Console */
> +		serial1 = &uart_AO_B; /* External UART (Wireless Module) */
> +		ethernet0 = &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	/* 1024MB RAM */
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		linux,cma {
> +			size = <0x0 0x400000>;
> +		};
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vcc_5v: regulator-vcc_5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_5v>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_boot: regulator-vddio_boot {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_BOOT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	usb_pwr: regulator-usb_pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB_PWR";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_5v>;
> +		regulator-always-on;
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
> +		clocks = <&wifi32k>;
> +		clock-names = "ext_clock";
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible = "pwm-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&scpi_sensors 0>;
> +			trips {
> +				cpu_passive: cpu-passive {
> +					temperature = <70000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +
> +				cpu_hot: cpu-hot {
> +					temperature = <80000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "hot";
> +				};
> +
> +				cpu_critical: cpu-critical {
> +					temperature = <100000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu_cooling_maps: cooling-maps {
> +			map0 {
> +				trip = <&cpu_passive>;
> +				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +
> +			map1 {
> +				trip = <&cpu_hot>;
> +				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +	};
> +};
> +
> +&efuse {
> +	sn: sn@32 {
> +		reg = <0x32 0x20>;
> +	};
> +
> +	eth_mac: eth_mac@0 {
> +		reg = <0x0 0x6>;
> +	};
> +
> +	bt_mac: bt_mac@6 {
> +		reg = <0x6 0x6>;
> +	};
> +
> +	wifi_mac: wifi_mac@c {
> +		reg = <0xc 0x6>;
> +	};
> +
> +	bid: bid@12 {
> +		reg = <0x12 0x20>;
> +	};
> +};
> +
> +&ethmac {
> +	status = "okay";
> +	pinctrl-0 = <&eth_rmii_x_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&eth_phy0>;
> +	phy-mode = "rmii";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* ICPlus IP101A/G Ethernet PHY (vendor_id=0x0243, model_id=0x0c54) */
> +		eth_phy0: ethernet-phy@0 {
> +			/* compatible = "ethernet-phy-id0243.0c54";*/
> +			max-speed = <100>;
> +			reg = <0>;
> +
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <10000>;
> +			reset-gpios = <&gpio GPIOZ_5 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +/* Internal I2C bus (on CPU module) */
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-0 = <&i2c1_z_pins>;
> +	pinctrl-names = "default";
> +
> +	/* RTC */
> +	pcf8563: pcf8563@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +		status = "okay";
> +	};
> +};
> +
> +/* Peripheral I2C bus (on motherboard) */
> +&i2c_AO {
> +	status = "okay";
> +	pinctrl-0 = <&i2c_ao_sck_10_pins>, <&i2c_ao_sda_11_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&pwm_ab {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_a_x20_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +/* wifi module */
> +&sd_emmc_b {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr104;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +/* emmc storage */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_pins>, <&emmc_ds_pins>;
> +	pinctrl-1 = <&emmc_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* UART Bluetooth */
> +&uart_B {
> +	status = "okay";
> +	pinctrl-0 = <&uart_b_z_pins>, <&uart_b_z_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		shutdown-gpios = <&gpio GPIOZ_7 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +/* UART Console */
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +/* UART Wireless module */
> +&uart_AO_B {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_b_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb {
> +	status = "okay";
> +	phy-supply = <&usb_pwr>;
> +};
> +
> +&spicc1 {
> +	status = "okay";
> +};

Why enabling it without pinctrl properties ?

> +
> +&gpio {
> +	gpio-line-names =
> +		"", "", "", "", "", // 0 - 4
> +		"", "", "", "", "", // 5 - 9
> +		"UserButton", "", "", "", "", // 10 - 14
> +		"", "", "", "", "", // 15 - 19
> +		"", "", "", "", "", // 20 - 24
> +		"", "LedRed", "LedGreen", "Output3", "Output2", // 25 - 29
> +		"Output1", "", "", "", "", // 30 - 34
> +		"", "ZigBeeBOOT", "", "", "", // 35 - 39
> +		"", "ZigBeeRESET", "", "Input4", "Input3", // 40 - 44
> +		"Input2", "Input1", "", "", "", // 45 - 49
> +		"", "", "", "", "", // 50 - 54
> +		"", "", "", "", "", // 55 - 59
> +		"", "", "", "", "", // 60 - 64
> +		"", "", "", "", "", // 65 - 69
> +		"", "", "", "", "", // 70 - 74
> +		"", "", "", "", "", // 75 - 79
> +		"", "", "", "", "", // 80 - 84
> +		"", ""; // 85-86
> +};
> +
> +&cpu0 {
> +	#cooling-cells = <2>;
> +};
> +
> +&cpu1 {
> +	#cooling-cells = <2>;
> +};
> +
> +&cpu2 {
> +	#cooling-cells = <2>;
> +};
> +
> +&cpu3 {
> +	#cooling-cells = <2>;
> +};
> 

Apart the spicc node without properties, it looks good.

Neil
