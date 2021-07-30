Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B545C3DBAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbhG3Ode (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:33:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239042AbhG3Odd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:33:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5902D6D;
        Fri, 30 Jul 2021 07:33:28 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FEBC3F70D;
        Fri, 30 Jul 2021 07:33:26 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add thermal fan control to
 rockpro64
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210730140210.728367-1-pgwipeout@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9bb0e700-eb12-af14-76d6-3a90d434339b@arm.com>
Date:   Fri, 30 Jul 2021 15:33:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730140210.728367-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2021-07-30 15:02, Peter Geis wrote:
> The rockpro64 had a fan node since
> commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
> however it was never tied into the thermal driver for automatic control.
> 
> Add the links to the thermal node to permit the kernel to handle this
> automatically.
> Borrowed from the (rk3399-khadas-edge.dtsi).
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> 
> Changelog:
> v2:
> Adjusted fan setpoints for less noise
> 
>   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 57 +++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 6bff8db7d33e..0d79e6ae1c3a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -69,6 +69,7 @@ diy_led: led-1 {
>   
>   	fan: pwm-fan {
>   		compatible = "pwm-fan";
> +		cooling-levels = <0 100 150 200 255>;
>   		#cooling-cells = <2>;
>   		fan-supply = <&vcc12v_dcin>;
>   		pwms = <&pwm1 0 50000 0>;
> @@ -245,6 +246,34 @@ &cpu_b1 {
>   	cpu-supply = <&vdd_cpu_b>;
>   };
>   
> +&cpu_thermal {
> +	trips {
> +		cpu_warm: cpu_warm {
> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};

(Heh, it still tickles me to see these points I arbitrarily made up 
being faithfully copied around - I guess that means I got them right!)

> +
> +		cpu_hot: cpu_hot {
> +			temperature = <65000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map2 {
> +			trip = <&cpu_warm>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +
> +		map3 {
> +			trip = <&cpu_hot>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>   &emmc_phy {
>   	status = "okay";
>   };
> @@ -281,6 +310,34 @@ &gpu {
>   	status = "okay";
>   };
>   
> +&gpu_thermal {
> +	trips {
> +		gpu_warm: gpu_warm {
> +			temperature = <55000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +
> +		gpu_hot: gpu_hot {
> +			temperature = <65000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map1 {
> +			trip = <&gpu_warm>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> +		};
> +
> +		map2 {
> +			trip = <&gpu_hot>;
> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};

Unless something's changed since commit a793e19c15f2 ("arm64: dts: 
rockchip: Fix NanoPC-T4 cooling maps"), multiple cooling maps don't 
actually share a singe cooling device properly[1]. The Khadas Edge DT 
dates from right around the same time so I guess it crossed over with 
that discussion and never got fixed.

In hindsight, I do seem to remember my fan being a bit more jumpy around 
the trip points than it is today, which may well have been the two maps 
fighting each other...

Robin.

[1] 
https://lore.kernel.org/linux-rockchip/55b9018e-672e-522b-d0a0-c5655be0f353@linaro.org/

> +
>   &i2c0 {
>   	clock-frequency = <400000>;
>   	i2c-scl-rising-time-ns = <168>;
> 
