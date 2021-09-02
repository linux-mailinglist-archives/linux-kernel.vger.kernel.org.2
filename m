Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86803FEEA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbhIBN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345033AbhIBN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:28:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45CC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:27:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1152728wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41iInlP0qtV7FfTJrQwV4wjvKaXbX/VARiMGZp0eTBc=;
        b=Gk1wey6hIkkCVbnVAy8vbVLogOQwicuG9NyJEXA6zGzIEZdfPL1suUboUmMujm/1Ok
         IzBdPuHh7edJSanwNZxgDZN7iRVbKlYCa3pphKBF9KP6xqiNsAmDuy43tNr6XWdevxez
         tgYUdaYqE6pUsYbbLu+tet7WzF+nCxs8j+scR3ub8hROwo/jIlsDjda6B5zLJtIqnjOq
         bNZyRikM9uDb2F8ZWmTGjBqRxCrL2dsxe2teHRX6/YupX4Zux+V9YN9rSduuH8dYQLNx
         DaMH9vYLjf3R6iuYqT8BlXGZP62DYmubbSA7mnoM67fsRafIrCSzBWi8NY5Zc4f6Ndtp
         BGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=41iInlP0qtV7FfTJrQwV4wjvKaXbX/VARiMGZp0eTBc=;
        b=iIfcSkUK4ytyoYDGYyTn6znMltEoKk4ko/yOS1ZjtfnL74rJ20wuWfXDMGLHNtwJdy
         GZa3cTZ7JPW8FDsoS+Dv9w0U1aa99ZaMoYkj+ETe/Uj2AZYMm3bYk0Tikm0P9HxAf5oo
         KQe4VS62UmZXkOiyFgFRlVMl8GvEh8P8Elt8lQlwO+/LqquM0yw7eZzuFA7bVPCtnBkl
         BWTKvXYIlt0daYv0YEPYrOWD5/cSU8jEYW/NaSoXtiLap0QYJnhobgoH1vEd+Q6yhWRw
         n/qHGQ5hpoDo4CGkLZ4nnEpIXcH/bB7z4Q3eX6vHeMBkiC9kv118LYbVpKLG5Np8YlUh
         uGjQ==
X-Gm-Message-State: AOAM531P0xPpBM/D3fFG9O6PrI0G5w7JokgaCinjX8s21TsEWDY7zOJO
        13iy8qtMXJHVUkNA7Jy7ChTeTuQ7B7/00Kh4
X-Google-Smtp-Source: ABdhPJxG7LWAQ8pO0S2DWQR3pXrXIMqOl53eD26NvAtdjJL0epwu9pTE1pvv65lGt3dRAzwpGSKybQ==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr3234162wmh.60.1630589274290;
        Thu, 02 Sep 2021 06:27:54 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:98:6312:3c8:6531? ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id o7sm1590888wmc.46.2021.09.02.06.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:27:53 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: dts: meson-axg: add support for JetHub D1
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210902130516.3892452-1-adeep@lexina.in>
 <20210902130516.3892452-3-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <71edb4ed-f57a-e384-22f9-4e0a6799c10f@baylibre.com>
Date:   Thu, 2 Sep 2021 15:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902130516.3892452-3-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 02/09/2021 15:05, Vyacheslav Bocharov wrote:
> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller with the following features:
> - DIN Rail Mounting
> - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
> - no video out
> - 512Mb/1GB LPDDR4
> - 8/16GB eMMC flash
> - 1 x USB 2.0
> - 1 x 10/100Mbps ethernet
> - WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4.2.
> - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
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
>  .../amlogic/meson-axg-jethome-jethub-j100.dts | 439 ++++++++++++++++++
>  2 files changed, 440 insertions(+)
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
> index 000000000000..68d688528c86
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> @@ -0,0 +1,439 @@

Please add a proper SPDX Licence identifier.

Don't you want to add a proper copyright header ?

> +
> +/dts-v1/;
> +
> +#include "meson-axg.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	compatible = "jethome,j100", "amlogic,a113d", "amlogic,meson-axg";
> +	model = "JetHome JetHub J100";
> +	amlogic-dt-id = "axg_jethubj100_v1";

This attribute hasn't any upstream bindings, please remove it.

> +
> +	aliases {
> +		serial0 = &uart_AO;   /* Console */
> +		serial1 = &uart_B;    /* Bluetooth */

Usually we don't add an alias for a serial port with a subnode (here bluetooth).

> +		serial2 = &uart_AO_B; /* External UART (Wireless Module) */
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
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable; size = <0x0 0x400000>;
> +			alignment = <0x0 0x400000>;
> +			linux,cma-default;
> +		};
> +	};

If you want to reduce the cma pool size, simply add:

reserved-memory {
	linux,cma {
		size = <0x0 0x400000>;
	};
};

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
> +	partitions: partitions {
> +		parts = <1>;
> +		part-0 = <&rootfs>;
> +		rootfs: rootfs {
> +			pname = "rootfs";
> +			size = <0xffffffff 0xffffffff>;
> +			mask = <4>;
> +		};
> +	};

This node hasn't any upstream bindings, please remove it.

> +
> +	efusekey: efusekey {
> +		keynum = <5>;
> +		key0 = <&key_0>;
> +		key1 = <&key_1>;
> +		key2 = <&key_2>;
> +		key3 = <&key_3>;
> +		key4 = <&key_4>;
> +
> +		key_0: key_0 {
> +			keyname = "mac";
> +			offset = <0>;
> +			size = <6>;
> +		};
> +		key_1: key_1 {
> +			keyname = "mac_bt";
> +			offset = <6>;
> +			size = <6>;
> +		};
> +		key_2: key_2 {
> +			keyname = "mac_wifi";
> +			offset = <12>;
> +			size = <6>;
> +		};
> +		key_3: key_3 {
> +			keyname = "usid";
> +			offset = <18>;
> +			size = <32>;
> +		};
> +		key_4: key_4 {
> +			keyname = "serial";
> +			offset = <50>;
> +			size = <32>;
> +		};
> +	}; //End efusekey

This node hasn't any upstream bindings, please remove it.

> +
> +	unifykey {
> +		compatible = "amlogic, unifykey";
> +		status = "ok";
> +		unifykey-num = <6>;
> +		unifykey-index-0 = <&keysn_0>;
> +		unifykey-index-1 = <&keysn_1>;
> +		unifykey-index-2 = <&keysn_2>;
> +		unifykey-index-3 = <&keysn_3>;
> +		unifykey-index-4 = <&keysn_4>;
> +		unifykey-index-5 = <&keysn_5>;
> +
> +		keysn_0: key_0 {
> +			key-name = "usid";
> +			key-device = "normal";
> +			key-permit = "read";
> +		};
> +		keysn_1: key_1 {
> +			key-name = "mac";
> +			key-device = "normal";
> +			key-permit = "read";
> +		};
> +		keysn_2: key_2 {
> +			key-name = "mac_bt";
> +			key-device = "normal";
> +			key-permit = "read","write","del";
> +			key-type  = "mac";
> +		};
> +		keysn_3: key_3 {
> +			key-name = "mac_wifi";
> +			key-device = "normal";
> +			key-permit = "read","write","del";
> +			key-type = "mac";
> +		};
> +		keysn_4: key_4 {
> +			key-name = "serial";
> +			key-device = "normal";
> +			key-permit = "read";
> +		};
> +		keysn_5:key_5 {
> +			key-name = "deviceid";
> +			key-device = "normal";
> +			key-permit = "read","write","del";
> +		};
> +	}; //End unifykey

This node hasn't any upstream bindings, please remove it.

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
> +				cpu_hot: cpu-hot {
> +					temperature = <80000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "hot";
> +				};
> +				cpu_critical: cpu-critical {
> +					temperature = <100000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +		cpu_cooling_maps: cooling-maps {
> +			map0 {
> +				trip = <&cpu_passive>;
> +				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
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
> +&ethmac {
> +	status = "okay";
> +	pinctrl-0 = <&eth_rmii_x_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&eth_phy0>;
> +	phy-mode = "rmii";
> +	internal_phy=<0>;

This attribute hasn't any upstream bindings, please remove it.

> +	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;

This is already defined in meson-axg.dtsi

> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* ICPlus IP101A/G Ethernet PHY (vendor_id=0x0243, model_id=0x0c54) */
> +		eth_phy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-id0243.0c54";

Is there an issue with autodetection of the PHY ? if no you can remove the compatible here.

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
> +
> +&audio {
> +	status = "disabled";
> +};

This is brutal, all the externally connected nodes are only disabled, so you can avoid disabling the bus entirely.

> +
> +&efuse {
> +	status = "okay";
> +	compatible = "amlogic,meson-gxbb-efuse", "amlogic, efuse";
> +	read_cmd = <0x82000030>;
> +	write_cmd = <0x82000031>;
> +	get_max_cmd = <0x82000033>;
> +	key = <&efusekey>;
> +	clock-names = "efuse_clk";
> +};

Looking at Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt :
remove "amlogic, efuse", and all the other attributes.

> +
> +&gpio {
> +	interrupt-parent = <&gpio_intc>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;

This is not supported on upstream bindings, please remove.

> +	gpio-line-names = 
> +		"", "", "", "", "", // 0 - 4
> +		"", "", "", "", "", // 5 - 9
> +		"UserButton", "", "", "", "", // 10 - 14
> +		"", "", "", "", "", // 15 - 19
> +		"", "", "", "", "", // 20 - 24
> +		"", "LEDRED", "LEDGREEN", "Output3", "Output2", // 25 - 29
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
> +
> 

Thanks,
Neil
