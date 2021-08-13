Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921873EB646
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbhHMNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:52:29 -0400
Received: from foss.arm.com ([217.140.110.172]:53750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235656AbhHMNw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:52:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBB871042;
        Fri, 13 Aug 2021 06:52:01 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854913F718;
        Fri, 13 Aug 2021 06:52:00 -0700 (PDT)
Subject: Re: [PATCH v3] arm64: dts: rockchip: add thermal fan control to
 rockpro64
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210730151727.729822-1-pgwipeout@gmail.com>
 <ad6d8025-977c-9ff2-81ff-a417df48231c@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <893701da-ea17-00ab-5e31-c745051ac9b9@arm.com>
Date:   Fri, 13 Aug 2021 14:51:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ad6d8025-977c-9ff2-81ff-a417df48231c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 13:59, Daniel Lezcano wrote:
> On 30/07/2021 17:17, Peter Geis wrote:
>> The rockpro64 had a fan node since
>> commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
>> however it was never tied into the thermal driver for automatic control.
>>
>> Add the links to the thermal node to permit the kernel to handle this
>> automatically.
>> Borrowed from the (rk3399-khadas-edge.dtsi).
>>
>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>> ---
>>
>> Changelog:
>> v3:
>> Removed the gpu nodes to prevent in-fighting (thanks Robin!)
>>
>> v2:
>> Adjusted fan setpoints for less noise
>>
>>   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 29 +++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> index 6bff8db7d33e..83db4ca67334 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> @@ -69,6 +69,7 @@ diy_led: led-1 {
>>   
>>   	fan: pwm-fan {
>>   		compatible = "pwm-fan";
>> +		cooling-levels = <0 100 150 200 255>;
>>   		#cooling-cells = <2>;
>>   		fan-supply = <&vcc12v_dcin>;
>>   		pwms = <&pwm1 0 50000 0>;
>> @@ -245,6 +246,34 @@ &cpu_b1 {
>>   	cpu-supply = <&vdd_cpu_b>;
>>   };
>>   
>> +&cpu_thermal {
>> +	trips {
>> +		cpu_warm: cpu_warm {
>> +			temperature = <55000>;
>> +			hysteresis = <2000>;
>> +			type = "active";
>> +		};
>> +
>> +		cpu_hot: cpu_hot {
>> +			temperature = <65000>;
>> +			hysteresis = <2000>;
>> +			type = "active";
>> +		};
>> +	};
>> +
> 
> Why two trip points ?
> 
> Why not one functioning temperature and no lower / upper limits for the
> cooling maps ?

Certainly when I first did this for NanoPC-T4, IIRC it was to avoid the 
fan ramping up too eagerly, since level 1 for my fan is effectively 
silent but still cools enough to let a moderate load eventually settle 
to a steady state below the second trip.

Robin.

>> +	cooling-maps {
>> +		map2 {
>> +			trip = <&cpu_warm>;
>> +			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
>> +		};
>> +
>> +		map3 {
>> +			trip = <&cpu_hot>;
>> +			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
>> +		};
>> +	};
>> +};
>> +
>>   &emmc_phy {
>>   	status = "okay";
>>   };
>>
> 
> 
