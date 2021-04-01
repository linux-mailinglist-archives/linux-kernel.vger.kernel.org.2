Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C9350E86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhDAFnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDAFnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:43:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328F260FE9;
        Thu,  1 Apr 2021 05:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617255786;
        bh=gG0lgUbAdmVVbzZ67XW/eaTa2hyRPP2HT9LTS0Rj7hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0KaKE/thqDXIquxlakghIwpGsnjp5TOx/BTjLVxGMZgtHeUVtStUV7HWPFB8W3/+
         /udSyrz4SG2GadZ6W/wsSefENYHwlIe5Hc8Pr2+L6aHxxtN3tmoT9d6bWTHBBHZcHM
         d3qekV1FaVZYR2TKSyM3905Wo2Ad9piKuwKl10E/3IFPhJfhQU38QQMHQKT2I9ogyM
         kXy18XKylGo7DXVAi17g7qA7+5AJFntarERdyVlC6KYFj+oRMXg7fVpoiD5JH5e7fw
         fuAmjEco8FLDtntkwz/F2l6UzQI7lyGPSub8bbIsvR5nYiR4bq1EyulE6lnMbOkZw8
         9PQji/qpNPBMw==
Date:   Thu, 1 Apr 2021 11:13:00 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: dts: owl-s500-roseapplepi: Add ATC2603C PMIC
Message-ID: <20210401054300.GD14052@work>
References: <2e0a2931ae3757f016948e7c78e8e54afa325ae0.1615538629.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0a2931ae3757f016948e7c78e8e54afa325ae0.1615538629.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:49:27AM +0200, Cristian Ciocaltea wrote:
> Add device tree node for ATC2603C PMIC and remove the 'fixed-3.1V'
> dummy regulator used for the uSD supply.
> 
> Additionally, add 'SYSPWR' fixed regulator and provide cpu0 supply.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Applied to for-next after fixing the patch subject as below:

"ARM: dts: owl-s500-roseapplepi: Add ATC2603C PMIC"

Thanks,
Mani

> ---
> Please note the patch depends on the ATC260x PMIC support which is queued
> for merging in v5.13:
> 
> https://lore.kernel.org/lkml/cover.1611653995.git.cristian.ciocaltea@gmail.com/
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next&qt=range&q=a38fd8748464831584a19438cbb3082b5a2dab15..eac013a0b7041f5cfc8feedf429a767675350102
> 
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 132 ++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> index ff91561ca99c..b8c5db2344aa 100644
> --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> @@ -2,7 +2,7 @@
>  /*
>   * Roseapple Pi
>   *
> - * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + * Copyright (C) 2020-2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
>   */
>  
>  /dts-v1/;
> @@ -27,20 +27,140 @@ memory@0 {
>  		reg = <0x0 0x80000000>; /* 2GB */
>  	};
>  
> -	/* Fixed regulator used in the absence of PMIC */
> -	sd_vcc: sd-vcc {
> +	syspwr: regulator-5v0 {
>  		compatible = "regulator-fixed";
> -		regulator-name = "fixed-3.1V";
> -		regulator-min-microvolt = <3100000>;
> -		regulator-max-microvolt = <3100000>;
> +		regulator-name = "SYSPWR";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
>  		regulator-always-on;
>  	};
>  };
>  
> +&cpu0 {
> +	cpu0-supply = <&vdd_cpu>;
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
> +
> +	atc260x: pmic@65 {
> +		compatible = "actions,atc2603c";
> +		reg = <0x65>;
> +		interrupt-parent = <&sirq>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		reset-time-sec = <6>;
> +
> +		regulators {
> +			compatible = "actions,atc2603c-regulator";
> +
> +			dcdc1-supply = <&syspwr>;
> +			dcdc2-supply = <&syspwr>;
> +			dcdc3-supply = <&syspwr>;
> +			ldo1-supply = <&syspwr>;
> +			ldo2-supply = <&syspwr>;
> +			ldo3-supply = <&syspwr>;
> +			ldo5-supply = <&syspwr>;
> +			ldo6-supply = <&syspwr>;
> +			ldo7-supply = <&syspwr>;
> +			ldo8-supply = <&syspwr>;
> +			ldo11-supply = <&syspwr>;
> +			ldo12-supply = <&syspwr>;
> +			switchldo1-supply = <&vcc>;
> +
> +			vdd_cpu: dcdc1 {
> +				regulator-name = "VDD_CPU";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-always-on;
> +			};
> +
> +			vddq: dcdc2 {
> +				regulator-name = "VDDQ";
> +				regulator-min-microvolt = <1300000>;
> +				regulator-max-microvolt = <2150000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vcc: dcdc3 {
> +				regulator-name = "VCC";
> +				regulator-min-microvolt = <2600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vcc_3v3: ldo1 {
> +				regulator-name = "VCC_3V3";
> +				regulator-min-microvolt = <2600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			avcc: ldo2 {
> +				regulator-name = "AVCC";
> +				regulator-min-microvolt = <2600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			vdd_1v8: ldo3 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-always-on;
> +			};
> +
> +			vcc_3v1: ldo5 {
> +				regulator-name = "VCC_3V1";
> +				regulator-min-microvolt = <2600000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			avdd: ldo6 {
> +				regulator-name = "AVDD";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-always-on;
> +			};
> +
> +			sens_1v8: ldo7 {
> +				regulator-name = "SENS_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo8: ldo8 {
> +				regulator-name = "LDO8";
> +				regulator-min-microvolt = <2300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			svcc: ldo11 {
> +				regulator-name = "SVCC";
> +				regulator-min-microvolt = <2600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			rtc_vdd: ldo12 {
> +				regulator-name = "RTC_VDD";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			sd_vcc: switchldo1 {
> +				regulator-name = "SD_VCC";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
>  };
>  
>  &i2c1 {
> -- 
> 2.30.2
> 
