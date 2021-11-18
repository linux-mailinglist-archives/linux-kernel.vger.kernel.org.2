Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1F4564E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhKRVKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhKRVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:10:31 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA58C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:07:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r26so17108608oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lf6XutU3lhgRs8OdhvDS7O3WkhfKF/INPr7ncB9gWnc=;
        b=JFtES67AYYI+rlth23mEwwR98kfprrzax3xrH3vvwWk4KrqxYTwFdEerB4gA49Nl6O
         Xe1zMNG0E/gAwLV9PDUFIbafGw6DLCTofd7MQN5kqz/oTbAm8RxCRZ8sS8r4VpKul4m6
         XuHOseotKsKaCH2EyHJg8NlRiLwZ0j7sPfFumSc0WOKQWjsj/JiuRza8KfGDAoE71X5P
         dgnd4LdbNjeUmgzPsMzKCX92YI582jMOPtzFU8/CABCM+Q61VQkAv9VeR3H2cJ9D01ao
         ypRV5z/87gHj3s5uczTZJcBeGrUi1PO4DTXN8MYmISSwPu/rpabrCjSztXkWUfhcweGQ
         wDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lf6XutU3lhgRs8OdhvDS7O3WkhfKF/INPr7ncB9gWnc=;
        b=7EV0sMeiN3IhttM3VZu7S0wH/8jvUmxiDARwmdwc8PxH4N0Bp3lL+Mpyp5H1pp95XI
         YX3uGVsrE1DnGMM0Ew6wN5KblWvPYpx2091GYyvQoYU9Zaik/LdL8/jmzfo2Lgs0qL4e
         p+XxW4L73iuHGHz4vvjkrjIGHy9boSJZI718x496nyUUc8rDP2Isi2piwN48ifKTjD+2
         2a2sVoeyg+KRTjN3DRaegCMMk7m8FL9mZlLxQ47n/haGpEYsKQ470sDSq8LKCkzPDHDG
         /DZUCMdz/CHHPKz4FiWJORX5jKBRqX9C1qFiUSsknARSDnIISpZ2+Q5AUc/37WXB/nYW
         qIhA==
X-Gm-Message-State: AOAM533S2GxCyZWqEVMTgMJQ0cny4R08C9OtXY9TScmOfSlL/qRC+f1P
        OQKiH4XWez6eI7DirleJYldzHg==
X-Google-Smtp-Source: ABdhPJxq0r2Vakxt3QaLopMgfKlLx/R7Nm0mb9pHVpf53Ac0JtxKnCAi1/skSBBLoBHhQWN3W6/aGw==
X-Received: by 2002:a54:4707:: with SMTP id k7mr9861988oik.163.1637269650092;
        Thu, 18 Nov 2021 13:07:30 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id be12sm267264oib.50.2021.11.18.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:07:29 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:07:25 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Belokobylskiy <belokobylskij@gmail.com>
Subject: Re: [PATCH] [RFC v2] ARM: dts: nexus4: initial dts
Message-ID: <YZbAjXR3LWmNZQsI@builder.lan>
References: <20211005230329.64604-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005230329.64604-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 18:03 CDT 2021, David Heidelberg wrote:

> From: Ivan Belokobylskiy <belokobylskij@gmail.com>
> 
> Add initial support for LG Nexus 4 (mako).
> 
> Features currently working: regulators, eMMC, WiFi, LCD backlight and volume keys.
> 
> Signed-off-by: Ivan Belokobylskiy <belokobylskij@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2
>  - lge vendor doesn't exist anymore, rename to lg
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/qcom-apq8064-lg-nexus4-mako.dts  | 387 ++++++++++++++++++
>  2 files changed, 388 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-lg-nexus4-mako.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5ffab0486665..97340450d5b8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -948,6 +948,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8064-ifc6410.dtb \
>  	qcom-apq8064-sony-xperia-yuga.dtb \
>  	qcom-apq8064-asus-nexus7-flo.dtb \
> +	qcom-apq8064-lg-nexus4-mako.dtb \
>  	qcom-apq8074-dragonboard.dtb \
>  	qcom-apq8084-ifc6540.dtb \
>  	qcom-apq8084-mtp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-apq8064-lg-nexus4-mako.dts b/arch/arm/boot/dts/qcom-apq8064-lg-nexus4-mako.dts
> new file mode 100644
> index 000000000000..590c5bd2f935
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8064-lg-nexus4-mako.dts
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "qcom-apq8064-v2.0.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/mfd/qcom-rpm.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +/ {
> +	model = "LG Nexus 4 (mako)";
> +	compatible = "lg,nexus4-mako", "qcom,apq8064";
> +
> +	aliases {
> +		serial0 = &gsbi7_serial;
> +		serial1 = &gsbi6_serial;
> +		serial2 = &gsbi4_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		ramoops@88d00000{
> +			compatible = "ramoops";
> +			reg = <0x88d00000 0x100000>;
> +			record-size	 = <0x00020000>;
> +			console-size	= <0x00020000>;
> +			ftrace-size	 = <0x00020000>;
> +		};
> +	};
> +
> +	battery_cell: battery-cell {
> +		compatible = "simple-battery";
> +		constant-charge-current-max-microamp = <900000>;
> +		operating-range-celsius = <0 45>;
> +	};
> +
> +	soc {
> +		pinctrl@800000 {
> +			gsbi4_uart_pin_a: gsbi4-uart-pin-active {
> +				rx {
> +					pins = "gpio11";
> +					function = "gsbi4";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				tx {
> +					pins = "gpio10";
> +					function = "gsbi4";
> +					drive-strength = <4>;
> +					bias-disable;
> +				};
> +			};
> +		};
> +
> +		rpm@108000 {
> +			regulators {
> +				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
> +				vin_lvs1_3_6-supply = <&pm8921_s4>;
> +				vin_lvs4_5_7-supply = <&pm8921_s4>;
> +
> +				vdd_l24-supply = <&pm8921_s1>;
> +				vdd_l25-supply = <&pm8921_s1>;
> +				vin_lvs2-supply = <&pm8921_s1>;
> +
> +				vdd_l26-supply = <&pm8921_s7>;
> +				vdd_l27-supply = <&pm8921_s7>;
> +				vdd_l28-supply = <&pm8921_s7>;
> +
> +				/* Buck SMPS */
> +				s1 {
> +					regulator-always-on;
> +					regulator-min-microvolt = <1225000>;
> +					regulator-max-microvolt = <1225000>;
> +					qcom,switch-mode-frequency = <3200000>;
> +					bias-pull-down;
> +				};
> +				s2 {
> +					regulator-min-microvolt = <1300000>;
> +					regulator-max-microvolt = <1300000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +					bias-pull-down;
> +				};
> +
> +				/* msm otg HSUSB_VDDCX */
> +				s3 {
> +					regulator-min-microvolt = <500000>;
> +					regulator-max-microvolt = <1150000>;
> +					qcom,switch-mode-frequency = <4800000>;
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * msm_sdcc.1-sdc-vdd_io
> +				 * tabla2x-slim-CDC_VDDA_RX
> +				 * tabla2x-slim-CDC_VDDA_TX
> +				 * tabla2x-slim-CDC_VDD_CP
> +				 * tabla2x-slim-VDDIO_CDC
> +				 */
> +				s4 {
> +					regulator-always-on;
> +					regulator-min-microvolt	= <1800000>;
> +					regulator-max-microvolt	= <1800000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +					bias-pull-down;
> +					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
> +				};
> +
> +				/*
> +				 * supply vdd_l26, vdd_l27, vdd_l28
> +				 */
> +				s7 {
> +					regulator-min-microvolt = <1300000>;
> +					regulator-max-microvolt = <1300000>;
> +					qcom,switch-mode-frequency = <3200000>;
> +				};
> +
> +				s8 {
> +					regulator-min-microvolt = <2200000>;
> +					regulator-max-microvolt = <2200000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +				};
> +
> +				l1 {
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi1_pll_vdda */
> +				l2 {
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					bias-pull-down;
> +				};
> +
> +				/* msm_otg-HSUSB_3p3 */
> +				l3 {
> +					regulator-min-microvolt = <3075000>;
> +					regulator-max-microvolt = <3500000>;
> +					bias-pull-down;
> +				};
> +
> +				/* msm_otg-HSUSB_1p8 */
> +				l4 {
> +					regulator-always-on;
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				/* msm_sdcc.1-sdc_vdd */
> +				l5 {
> +					regulator-min-microvolt = <2950000>;
> +					regulator-max-microvolt = <2950000>;
> +					bias-pull-down;
> +				};
> +
> +				/* earjack_debug */
> +				l6 {
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi_vci */
> +				l8 {
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <3000000>;
> +					bias-pull-down;
> +				};
> +
> +				/* wcnss_wlan.0-iris_vddpa */
> +				l10 {
> +					regulator-min-microvolt = <2900000>;
> +					regulator-max-microvolt = <2900000>;
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi1_avdd */
> +				l11 {
> +					regulator-min-microvolt = <2850000>;
> +					regulator-max-microvolt = <2850000>;
> +					bias-pull-down;
> +				};
> +
> +				/* touch_vdd */
> +				l15 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <2950000>;
> +					bias-pull-down;
> +				};
> +
> +				/* slimport_dvdd */
> +				l18 {
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					bias-pull-down;
> +				};
> +
> +				/* touch_io */
> +				l22 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * mipi_dsi.1-dsi_vddio
> +				 * pil_qdsp6v4.1-pll_vdd
> +				 * pil_qdsp6v4.2-pll_vdd
> +				 * msm_ehci_host.0-HSUSB_1p8
> +				 * msm_ehci_host.1-HSUSB_1p8
> +				 */
> +				l23 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * tabla2x-slim-CDC_VDDA_A_1P2V
> +				 * tabla2x-slim-VDDD_CDC_D
> +				 */
> +				l24 {
> +					regulator-min-microvolt = <750000>;
> +					regulator-max-microvolt = <1150000>;
> +					bias-pull-down;
> +				};
> +
> +				l25 {
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
> +					bias-pull-down;
> +				};
> +
> +				l26 {
> +					regulator-min-microvolt = <375000>;
> +					regulator-max-microvolt = <1050000>;
> +					regulator-always-on;
> +					bias-pull-down;
> +				};
> +
> +				l27 {
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +				};
> +
> +				l28 {
> +					regulator-min-microvolt = <1050000>;
> +					regulator-max-microvolt = <1050000>;
> +					bias-pull-down;
> +				};
> +
> +				/* wcnss_wlan.0-iris_vddio */
> +				lvs1 {
> +					bias-pull-down;
> +				};
> +
> +				/* wcnss_wlan.0-iris_vdddig */
> +				lvs2 {
> +					bias-pull-down;
> +				};
> +
> +				lvs3 {
> +					bias-pull-down;
> +				};
> +
> +				lvs4 {
> +					bias-pull-down;
> +				};
> +
> +				lvs5 {
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi_iovcc */
> +				lvs6 {
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * pil_riva-pll_vdd
> +				 * lvds.0-lvds_vdda
> +				 * mipi_dsi.1-dsi1_vddio
> +				 * hdmi_msm.0-hdmi_vdda
> +				 */
> +				lvs7 {
> +					bias-pull-down;
> +				};
> +
> +				ncp {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +				};
> +			};
> +		};
> +
> +		qcom,ssbi@500000 {

Please skip the "qcom," prefix in the node name.

> +			pmic@0 {
> +				keypad@148 {
> +					compatible = "qcom,pm8921-keypad";
> +					reg = <0x148>;
> +					interrupt-parent = <&pmicintc>;
> +					interrupts = <74 1>, <75 1>;
> +					linux,keymap = <
> +						MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)
> +						MATRIX_KEY(0, 1, KEY_VOLUMEUP)
> +					>;
> +
> +					keypad,num-rows = <1>;
> +					keypad,num-columns = <5>;
> +					debounce = <15>;
> +					scan-delay = <32>;
> +					row-hold = <91500>;
> +				};
> +			};
> +		};
> +
> +		gsbi@12440000 {
> +			status = "okay";
> +			qcom,mode = <GSBI_PROT_I2C>;
> +
> +			gsbi1_i2c: i2c@12460000 {
> +				status = "okay";
> +				clock-frequency = <200000>;
> +				pinctrl-0 = <&i2c1_pins>;
> +				pinctrl-names = "default";
> +
> +				backlight: lm3530@38 {
> +					compatible = "backlight,lm3530";

I'm able to find the lm3530 LED driver, but it doesn't seem to have DT
support in the driver and there's no binding for it.

Perhaps I'm missing something?

> +					status = "okay";

"okay" is the default, so no need to specify that for the nodes you
introduce in your dts.

Regards,
Bjorn

> +					reg = <0x38>;
> +					lm3530,en_gpio = <&pm8921_gpio 24 GPIO_ACTIVE_HIGH>;
> +					lm3530,max_current = /bits/ 8 <0x17>;
> +					lm3530,default_brt = /bits/ 8 <0x10>;
> +					lm3530,max_brt = /bits/ 8 <0x72>;
> +					lm3530,mode = /bits/ 8 <0>; /* Manual Mode */
> +					lm3530,linear_map = /bits/ 8 <1>; /* Linear map */
> +					lm3530,brt_ramp_fall = /bits/ 8 <0>;
> +					lm3530,brt_ramp_rise = /bits/ 8 <0>;
> +					lm3530,no_regulator;
> +				};
> +			};
> +		};
> +
> +		gsbi@16300000 {
> +			status = "okay";
> +			qcom,mode = <GSBI_PROT_I2C_UART>;
> +
> +			gsbi4_serial: serial@16340000 {
> +				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> +				reg = <0x16340000 0x1000>,
> +				  <0x16300000 0x1000>;
> +				interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GSBI4_UART_CLK>, <&gcc GSBI4_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "okay";
> +
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&gsbi4_uart_pin_a>;
> +			};
> +		};
> +
> +		amba {
> +			/* eMMC */
> +			sdcc@12400000 {
> +				status = "okay";
> +				vmmc-supply = <&pm8921_l5>;
> +				vqmmc-supply = <&pm8921_s4>;
> +			};
> +		};
> +
> +		riva-pil@3204000 {
> +			status = "okay";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&riva_wlan_pin_a>;
> +		};
> +	};
> +};
> +
> -- 
> 2.33.0
> 
