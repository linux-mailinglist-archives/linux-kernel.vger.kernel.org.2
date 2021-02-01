Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235D630A484
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhBAJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhBAJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:39:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA7CC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:38:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c2so18018220edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Epj4AQG4WvwGi2xLXahHcUHICDObw7tCg8AgI8t3VgI=;
        b=p8zwQV4ATTD7GNVFEBmk6Ma2pwsa+1whTuc+Ft0TSFhvpWwFvjQL8KuWG4rBrNhDbx
         F1NLBR+rX8EZls2SxgP7Mx+se9uhFlXLB/8z4Y+QY0bflLTpQtj1KV1MS1HJSQs/wdhY
         CCPZklDYdkpJ2kyI8dtTTfxQEiFXErWDkHi1M6F6BlJvBAE1CIhNwf//DovFSC/bmtj4
         2HS6+0LftvJ2ZdbhKg3+ifcHOjyJP/v2+nWq+/ar92q0602RmkRFS3aycVzKtb7EL7X+
         umA4TjXPJ5r/UjdBNCnoIj3jbzlfn6R4JoVcd9x2S0YWJkblT9FSTfKDPZh5tXZFg25a
         RK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Epj4AQG4WvwGi2xLXahHcUHICDObw7tCg8AgI8t3VgI=;
        b=TY2ZJr5ZpqZfpS1iErz+sOOJy8u26GvXr433BA3syodj5omQ2XgqjMlXVf4bSylWpc
         OdB8w5vLky8ir0AGALLlrToZXVPFiMvjaMFf7tsUHXqfQRkJ3sW0BqJ+tXKWWOalVjLw
         3jI03VScn+DNYKAjykmmX7DC4/tBNri/LzCga+iWXPcXGoZsqpgDkOhtQB5M5zoGn1qy
         bTboN8G6rWQ3MB7IeCqqJf3d5baoPptcz8oTUJvcVUIPwFFjD1XY8hB9TeXpPyEjArrb
         Hwhnl5fHiseqtlKTDcQEc507gp9rkqM0tLgrWFcW6HH8s+FVexSvBdSJqf+tuW82A6mU
         C4jw==
X-Gm-Message-State: AOAM530FI5WHwVw+crgeFT6LT1ZsU35QLRYKEqX09TB2gcDiO6DoR2Vb
        Ul0r5Dhs8qQVmAXZXWcgy5hHKw==
X-Google-Smtp-Source: ABdhPJyuibrqgzBQU+AH4VM6Ttmr6ntQpC1enNHnjngJuemocFI4Uwoc5ktXKM0lICIginEzgOgfOg==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr18470125edt.126.1612172327084;
        Mon, 01 Feb 2021 01:38:47 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p2sm1864160ejg.45.2021.02.01.01.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 01:38:46 -0800 (PST)
Subject: Re: [PATCH v2 12/12] arm64: dts: zynqmp: Add description for zcu104
 revC
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1611224800.git.michal.simek@xilinx.com>
 <17f68c235ea1ce96c3293ca0cf3178951d6663f7.1611224800.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <221f2d98-c171-78e2-ca45-948fd5128db1@monstr.eu>
Date:   Mon, 1 Feb 2021 10:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <17f68c235ea1ce96c3293ca0cf3178951d6663f7.1611224800.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 11:27 AM, Michal Simek wrote:
> Xilinx ZynqMP zcu104 revC and newer board revisions have different i2c
> structure compare to revA. The rest of the board is the same from software
> perspective.
> Also enable DMAs and QSPI.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2: None
> 
>  arch/arm64/boot/dts/xilinx/Makefile           |   1 +
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 282 ++++++++++++++++++
>  2 files changed, 283 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> 
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 60f5443f3ef4..11fb4fd3ebd4 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -13,5 +13,6 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> new file mode 100644
> index 000000000000..414f98f1831e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Xilinx ZynqMP ZCU104
> + *
> + * (C) Copyright 2017 - 2020, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk-ccf.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/ {
> +	model = "ZynqMP ZCU104 RevC";
> +	compatible = "xlnx,zynqmp-zcu104-revC", "xlnx,zynqmp-zcu104", "xlnx,zynqmp";
> +
> +	aliases {
> +		ethernet0 = &gem3;
> +		i2c0 = &i2c1;
> +		mmc0 = &sdhci1;
> +		rtc0 = &rtc;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &dcc;
> +	};
> +
> +	chosen {
> +		bootargs = "earlycon";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	ina226 {
> +		compatible = "iio-hwmon";
> +		io-channels = <&u183 0>, <&u183 1>, <&u183 2>, <&u183 3>;
> +	};
> +
> +	clock_8t49n287_5: clk125 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +	};
> +
> +	clock_8t49n287_2: clk26 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +	};
> +
> +	clock_8t49n287_3: clk27 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <27000000>;
> +	};
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&dcc {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan1 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan2 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan3 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan4 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan5 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan6 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan7 {
> +	status = "okay";
> +};
> +
> +&fpd_dma_chan8 {
> +	status = "okay";
> +};
> +
> +&gem3 {
> +	status = "okay";
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	phy0: ethernet-phy@c {
> +		reg = <0xc>;
> +		ti,rx-internal-delay = <0x8>;
> +		ti,tx-internal-delay = <0xa>;
> +		ti,fifo-depth = <0x1>;
> +		ti,dp83867-rxctrl-strap-quirk;
> +	};
> +};
> +
> +&gpio {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	tca6416_u97: gpio@20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		/*
> +		 * IRQ not connected
> +		 * Lines:
> +		 * 0 - IRPS5401_ALERT_B
> +		 * 1 - HDMI_8T49N241_INT_ALM
> +		 * 2 - MAX6643_OT_B
> +		 * 3 - MAX6643_FANFAIL_B
> +		 * 5 - IIC_MUX_RESET_B
> +		 * 6 - GEM3_EXP_RESET_B
> +		 * 7 - FMC_LPC_PRSNT_M2C_B
> +		 * 4, 10 - 17 - not connected
> +		 */
> +	};
> +
> +	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
> +	i2c-mux@74 { /* u34 */
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x74>;
> +		i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +			/*
> +			 * IIC_EEPROM 1kB memory which uses 256B blocks
> +			 * where every block has different address.
> +			 *    0 - 256B address 0x54
> +			 * 256B - 512B address 0x55
> +			 * 512B - 768B address 0x56
> +			 * 768B - 1024B address 0x57
> +			 */
> +			eeprom: eeprom@54 { /* u23 */
> +				compatible = "atmel,24c08";
> +				reg = <0x54>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +			};
> +		};
> +
> +		i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +			clock_8t49n287: clock-generator@6c { /* 8T49N287 - u182 */
> +				reg = <0x6c>;
> +			};
> +		};
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +			irps5401_43: irps5401@43 { /* IRPS5401 - u175 */
> +				compatible = "infineon,irps5401";
> +				reg = <0x43>; /* pmbus / i2c 0x13 */
> +			};
> +			irps5401_44: irps5401@44 { /* IRPS5401 - u180 */
> +				compatible = "infineon,irps5401";
> +				reg = <0x44>; /* pmbus / i2c 0x14 */
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +			u183: ina226@40 { /* u183 */
> +				compatible = "ti,ina226";
> +				#io-channel-cells = <1>;
> +				reg = <0x40>;
> +				shunt-resistor = <5000>;
> +			};
> +		};
> +
> +		i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +		};
> +
> +		i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
> +
> +		/* 4, 6 not connected */
> +	};
> +};
> +
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +	};
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&psgtr {
> +	status = "okay";
> +	/* nc, sata, usb3, dp */
> +	clocks = <&clock_8t49n287_5>, <&clock_8t49n287_2>, <&clock_8t49n287_3>;
> +	clock-names = "ref1", "ref2", "ref3";
> +};
> +
> +&sata {
> +	status = "okay";
> +	/* SATA OOB timing settings */
> +	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
> +	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
> +	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
> +	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
> +	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
> +	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
> +	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
> +	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
> +	phy-names = "sata-phy";
> +	phys = <&psgtr 3 PHY_TYPE_SATA 1 1>;
> +};
> +
> +/* SD1 with level shifter */
> +&sdhci1 {
> +	status = "okay";
> +	no-1-8-v;
> +	xlnx,mio-bank = <1>;
> +	disable-wp;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +/* ULPI SMSC USB3320 */
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&watchdog0 {
> +	status = "okay";
> +};
> 

As I said I applied this but also added revC to
Documentation/devicetree/bindings/arm/xilinx.yaml to be listed.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs




