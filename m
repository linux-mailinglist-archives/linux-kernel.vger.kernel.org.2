Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA3432619
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhJRSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:11:49 -0400
Received: from foss.arm.com ([217.140.110.172]:41298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhJRSLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:11:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090BCD6E;
        Mon, 18 Oct 2021 11:09:33 -0700 (PDT)
Received: from [10.57.27.231] (unknown [10.57.27.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1835D3F694;
        Mon, 18 Oct 2021 11:09:30 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
To:     Trevor Woerner <twoerner@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        David Wu <david.wu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Cameron Nemo <cnemo@tutanota.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211016154548.29555-1-twoerner@gmail.com>
 <67c7c3c6-b946-a6bc-24fd-85f56bcec7f3@gmail.com>
 <20211017152941.GA33697@localhost>
Message-ID: <ecdce799-5b03-9c6b-6a98-e6a893b15900@arm.com>
Date:   Mon, 18 Oct 2021 19:09:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211017152941.GA33697@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-17 16:29, Trevor Woerner wrote:
> On Sat 2021-10-16 @ 10:45:04 PM, Johan Jonker wrote:
>> On 10/16/21 5:45 PM, Trevor Woerner wrote:
>>> Add an operating-points table and cooling entry to the GPU on the
>>> RK3328 SoC to improve its performance. According to its datasheet[1]
>>> the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
>>> is 500MHz.
>>>
>>> On my rock64 device, under x11, glmark2-es2 performance increased from
>>> around 60 to just over 100. Same device running glmark2-es2 under
>>> wayland/weston improved from just over 100 to just over 200.
>>>
>>> [1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf
>>>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 +++++++++++++++++++++++-
>>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>> index 8c821acb21ff..5e1dcf71e414 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>> @@ -532,7 +532,8 @@ map0 {
>>>   					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>   							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>   							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> -							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> +							 <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>   					contribution = <4096>;
>>>   				};
>>>   			};
>>> @@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
>>>   		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
>>>   		clock-names = "bus", "core";
>>>   		resets = <&cru SRST_GPU_A>;
>>> +		operating-points-v2 = <&gpu_opp_table>;
>>> +		#cooling-cells = <2>;
>>> +	};
>>> +
>>
>>> +	gpu_opp_table: gpu-opp-table {
>>
>> After the conversion to YAML of the Operating Performance Points(OPP)
>> binding the operating-points-v2 property expects the nodename to have
>> the '^opp-table(-[a-z0-9]+)?$' format.
>>
>> make ARCH=arm64 dtbs_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/opp/opp-v2.yaml
> 
> Thanks, I wasn't aware.
> 
>>> +		compatible = "operating-points-v2";
>>> +
>>> +		opp-200000000 {
>>> +			opp-hz = /bits/ 64 <200000000>;
>>> +			opp-microvolt = <1100000>;
>>> +		};
>>> +		opp-300000000 {
>>> +			opp-hz = /bits/ 64 <300000000>;
>>> +			opp-microvolt = <1100000>;
>>> +		};
>>> +		opp-400000000 {
>>> +			opp-hz = /bits/ 64 <400000000>;
>>> +			opp-microvolt = <1100000>;
>>> +		};
>>> +		opp-500000000 {
>>> +			opp-hz = /bits/ 64 <500000000>;
>>> +			opp-microvolt = <1100000>;
>>> +		};
>>>   	};
>>
>> opp-microvolt has the same value for every node vs. table below?
> 
> On page 1 of the schematic for the rock64
> https://files.pine64.org/doc/rock64/ROCK64_Schematic_v3.0_20181105.pdf is a
> table ("Power Timing") showing BUCK1 at 1.1V. I interpreted this to mean that
> VDD_LOG should always be at 1.1V, regardless of frequency.

No, that's just the default voltage that BUCK1 itself starts up at - 
looks like that table is an unfinished attempt to summarise the Power 
Sequence section from the RK805 datasheet.

>> See also previous discussion:
>>
>> https://lore.kernel.org/linux-rockchip/3c95c29b-6c07-5945-ac22-d683997e1ca0@arm.com/
>>
>> Is that now fixed/checked?
> 
> I wasn't aware of the previous/on-going discussion regarding a gpu opp table
> for this SoC. Perhaps that explains my suspicions? I couldn't help wonder why
> the frequency is always reported as 163840000 even when I have an opp table
> that only has the 500MHz entry?

FWIW the usual culprit for clocks not changing is inadvertently not 
having devfreq and/or the simple_ondemand governor enabled. However, I 
do seem to recall that devfreq doesn't explicitly fix up an out-of-spec 
clock to a known OPP on startup like cpufreq does - I think it only 
actually touches the clocks and regulators when transitioning between 
OPPs, so if it only has one it might possibly end up in a pathological 
state where that effectively never happens; I don't remember exactly. 
Unfortunately all my boards are out of action for various reasons at the 
moment so I can't readily check how I was running mine, but from memory 
I think I ended up with slightly tweaked voltages based on a survey of 
several other BSP kernels, and the 200-300MHz points just disabled to 
avoid undervolting the memory controller once lima voltage scaling was 
working properly.

Cheers,
Robin.

> 
> I'll investigate whether I can prove or disprove the scaling is actually
> occurring?
> 
> Best regards,
> 	Trevor
> 
