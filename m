Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962D83FEE8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhIBNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhIBNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:20:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C4C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:19:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g138so1261248wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zwMnIW+8aBEuFpIkL2gH05aG0DkWnEDuuhYGJ3rTyUA=;
        b=rL7LXy8hTCz7qQYLsGAA6iNJVXQxkAQSA/TpJRiU3cM5hc7cRwLkal9+eyGchtRa2k
         Bkb2mGSwTWex8mBFlk0wLWEcfyLft9vOotdZvVNGylhdMAtEBdlAiC/JwmBN8cvAneV8
         SLmxkjB9fxtWGquOa9/r9nOhmCePqj4tfCk6ZnEVxlQ57KMnL29qMceoznoz7coaGzlk
         l4pQfrHXk4Cwt1XSxRdp5fnYne8PHkIoMAlotwfxB5Yu1HZXzVdpYsYeeDWZbJxt8ea2
         b2bBOUn6Jpy3PkBncdXq0abwRhK/f1i8u3pJPheUIQCKhp4SupTEC6QX5u/homf3H8HZ
         gjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zwMnIW+8aBEuFpIkL2gH05aG0DkWnEDuuhYGJ3rTyUA=;
        b=Bkubl8KOcrVZF1pT3h7uFcVJuHfkmSQl6pCCtq6Il3vAYlKRSWCN7D8bO42oOgfj/+
         RtEj2Rsw6qNhMKG+HUJSQp/b2f6HuZFQ8pqRk9V1Vv9Xbkbn/53CEZHLjkB3j1xj5p33
         sJ35SbbLC8HJkKbvS/Evan6HxYkSTJvvDxxirF51npvZ/yMx+Hpo/4BbABFN6DS6E6yw
         R88wFykMM0aunKGJ1gHKHsGF1gzM2nPiZkRlDbHqozTdyp6HUQG8EvypWqEDnYvGfX05
         FPBnQEwEAEVh0QFoShJvcmq9YJmvgcqmtbmfRzNHv2vHdFBR7zDgtOfCnukgubib2gf/
         Dyuw==
X-Gm-Message-State: AOAM5333ifR+R7x0BOjm+cZE3m7ZEi/bDm4R5wSV3C14R+IzBNc+9NG0
        CfsUz+vi66zJhoz+BahDvalB6I6OObpdRhFC
X-Google-Smtp-Source: ABdhPJy8cv4sTOUo7KyJ3wCCZh93/f57bmoN+0yaQJeZV0H0yGX20GeyCNh5OsmV9vKGNy8Un9i+YQ==
X-Received: by 2002:a05:600c:4152:: with SMTP id h18mr3085857wmm.55.1630588757467;
        Thu, 02 Sep 2021 06:19:17 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:98:6312:3c8:6531? ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id f17sm2144766wrt.63.2021.09.02.06.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:19:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: dts: meson-gxl: add support for JetHub H1
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210902130516.3892452-1-adeep@lexina.in>
 <20210902130516.3892452-2-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <48238ebf-842d-b752-8b9a-f6f408e57dd2@baylibre.com>
Date:   Thu, 2 Sep 2021 15:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902130516.3892452-2-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/09/2021 15:05, Vyacheslav Bocharov wrote:
> JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller with the following features:
> 
> - square plastic case
> - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
> - no video out
> - 1GB LPDDR4
> - 8/16GB eMMC flash
> - 2 x USB 2.0
> - 1 x 10/100Mbps ethernet
> - WiFi / Bluetooth RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0.
> - TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
> - MicroSD 2.x/3.x/4.x DS/HS cards.
> - 1 x gpio LED
> - ADC user Button
> - DC source 5V microUSB

Thanks for submitting a new board !

> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../meson-gxl-s905w-jethome-jethub-j80.dts    | 325 ++++++++++++++++++
>  2 files changed, 326 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index faa0a79a34f5..2c3ce7c401a5 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-minix-neo-u9h.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> new file mode 100644
> index 000000000000..7b14c7c4eed5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -0,0 +1,325 @@

Please add a proper SPDX Licence identifier.

Don't you want to add a proper copyright header ?

> +
> +/dts-v1/;
> +
> +#include "meson-gxl.dtsi"
> +
> +/ {
> +	compatible = "jethome,j80", "amlogic,s905w", "amlogic,meson-gxl";
> +	model = "JetHome JetHub J80";
> +	amlogic-dt-id = "gxl_jethubj80_v1";

This attribute hasn't any upstream bindings, please remove it.

> +
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
> +	aliases {
> +		serial0 = &uart_AO;   /* Console */
> +		serial1 = &uart_A;    /* Bluetooth */
> +		serial2 = &uart_AO_B; /* Wireless module 1 */
> +		serial3 = &uart_C;    /* Wireless module 2 */
> +		ethernet0 = &ethmac;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vddio_boot: regulator-vddio_boot {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_BOOT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible = "pwm-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
> +		clocks = <&wifi32k>;
> +		clock-names = "ext_clock";
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
> +			key-device = "efuse";
> +			key-permit = "read","write";
> +		};
> +		keysn_1: key_1 {
> +			key-name = "mac";
> +			key-device = "efuse";
> +			key-permit = "read","write";
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
> +			key-device = "efuse";
> +			key-permit = "read","write";
> +		};
> +		keysn_5:key_5 {
> +			key-name = "deviceid";
> +			key-device = "normal";
> +			key-permit = "read","write","del";
> +		};
> +	}; //End unifykey
> +};


This node hasn't any upstream bindings, please remove it.

> +
> +&usb {
> +	status = "okay";
> +	dr_mode = "host";
> +};
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
> +&pwm_ef {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> +
> +/* Wireless SDIO Module */
> +&sd_emmc_a {
> +	status = "okay";
> +	pinctrl-0 = <&sdio_pins>;
> +	pinctrl-1 = <&sdio_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <50000000>;
> +
> +	non-removable;
> +	disable-wp;
> +
> +	/* WiFi firmware requires power to be kept while in suspend */
> +	keep-power-in-suspend;
> +
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* SD card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-1 = <&sdcard_clk_gate_pins>;
> +	pinctrl-names = "default", "clk-gate";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <50000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* eMMC */
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
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> +
> +/* Console UART */
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +/* S905X only has access to its internal PHY */

Did you mean S905W ?

> +&ethmac {
> +	reg = <0x0 0xc9410000 0x0 0x10000
> +		0x0 0xc8834540 0x0 0x4
> +		0x0 0xc8834558 0x0 0xc
> +		0x0 0xc1104408 0x0 0x4>;
> +	amlogic,eth-leds = <0x91>;

This attribute isn't defined in upstream bindings.

> +	status = "okay";
> +	phy-mode = "rmii";
> +	phy-handle = <&internal_phy>;
> +};
> +
> +&internal_phy {
> +	status = "okay";
> +	pinctrl-0 = <&eth_link_led_pins>, <&eth_act_led_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +};
> +
> +&uart_C {
> +	status = "okay";
> +	pinctrl-0 = <&uart_c_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&uart_AO_B {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_b_pins>, <&uart_ao_b_cts_rts_pins>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +};
> +
> +&i2c_B {
> +	status = "okay";
> +	pinctrl-names="default";
> +	pinctrl-0=<&i2c_b_pins>;

Please add spaces before and after the "=".

> +
> +	pcf8563: pcf8563@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +		status = "okay";
> +	};
> +};
> +
> 

Thanks,
Neil
