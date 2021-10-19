Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4A433B41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhJSPy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhJSPyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:54:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF9DC0613DF;
        Tue, 19 Oct 2021 08:52:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so3742039wmz.2;
        Tue, 19 Oct 2021 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tahb42vhWIxe7aQDRTcB+CJ+M3oOryLTbrMHuFirItg=;
        b=oM7DBx5qiYzOh1ouvwxD5AaD77Y6ySL4Iqy3T3LYClN+6MVTmzTBuqxmhEq8IECzIs
         9gSUhzjdEpGkrqM7U/Azasd+H/9iez/wDghg9Er3ZkyfylyBmdB4h0aqXoaGUdpKNDJO
         JWdlY6OybwcQwhd0VyAfdtfslRMg/WdgPGpq7vVkwCn45OVqocaV6QT9W3ykF3V4M8dJ
         3zRBgvw0FylLjbtlDOGAxjfU6lnntxKF1DdYqQLqk/0AcVqFwqqws+DSgulcJ/qsABhY
         lxu7LfZGkbDYDAOWZ3w1eVEYv2uEqd2vDoomB9sfURBAU9srDrAeQoOaOddiSkkrX8jd
         sghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tahb42vhWIxe7aQDRTcB+CJ+M3oOryLTbrMHuFirItg=;
        b=Uvkb19gScaaqSFrMIqIZ6SZ9XKr8HBJJH8M02dtyyhGi9fBZ+5seIlJ6qtZFdLG9fj
         9bYOsE+fz5gcjtALK8uS8S9O/LBl1Sliij9FFuBugHQC3BrNpfwxfapJxekPFuzOUUxR
         evrhjjQltiRsd1GVePmUn0XRndYYoVqAzTWvgNLxDjzanTRKbEENiGoI8+luN4y2bqvJ
         ma27U9uujQ58TWZOfy+jUsj9jzLVrtVTW5XNhgE6zo3ORL/D+zQQ3dN/eF72TPS2tK5Y
         e8aqxUHaySxP5Ro6II36b3MpeIDO5/J+Kk28DrfHOxdJvC0qcLnFROgECZWT4CDsMycz
         UezQ==
X-Gm-Message-State: AOAM530/CKSB2n3qVdJZ0YdPMzeZJIR3ugiN6wLTFh8fo8eHVJiyOS8o
        6B43ehERJ7ETDsyeHM8PBQ==
X-Google-Smtp-Source: ABdhPJx2WUl7NkppItDT/LYD6ezXkFEAkVwlcku30q6Jjk4WKrin4xBzm5d8lCxl+n8MRIRt3I75yA==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr7114221wma.179.1634658727228;
        Tue, 19 Oct 2021 08:52:07 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:4200:c0be:9a16:558c:2838? ([2a02:810b:f40:4200:c0be:9a16:558c:2838])
        by smtp.gmail.com with ESMTPSA id z2sm15165023wrh.44.2021.10.19.08.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:52:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        David Wu <david.wu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Cameron Nemo <cnemo@tutanota.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Trevor Woerner <twoerner@gmail.com>
References: <20211016154548.29555-1-twoerner@gmail.com>
 <3352474.ljgn2FL0hr@archbook>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <5a667361-940e-4653-ac3e-ae26a70255a2@gmail.com>
Date:   Tue, 19 Oct 2021 17:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3352474.ljgn2FL0hr@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.10.21 um 18:49 schrieb Nicolas Frattaroli:
> On Samstag, 16. Oktober 2021 17:45:44 CEST Trevor Woerner wrote:
>> Add an operating-points table and cooling entry to the GPU on the
>> RK3328 SoC to improve its performance. According to its datasheet[1]
>> the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
>> is 500MHz.
>>
>> On my rock64 device, under x11, glmark2-es2 performance increased from
>> around 60 to just over 100. Same device running glmark2-es2 under
>> wayland/weston improved from just over 100 to just over 200.
>>
>> [1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf
>>
>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 +++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi index 8c821acb21ff..5e1dcf71e414
>> 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -532,7 +532,8 @@ map0 {
>>   					cooling-device = <&cpu0
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>   							 <&cpu1
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>   							 <&cpu2
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> -							 <&cpu3
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +							 <&cpu3
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&gpu
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>   					contribution = <4096>;
>>   				};
>>   			};
>> @@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
>>   		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
>>   		clock-names = "bus", "core";
>>   		resets = <&cru SRST_GPU_A>;
>> +		operating-points-v2 = <&gpu_opp_table>;
>> +		#cooling-cells = <2>;
>> +	};
>> +
>> +	gpu_opp_table: gpu-opp-table {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-200000000 {
>> +			opp-hz = /bits/ 64 <200000000>;
>> +			opp-microvolt = <1100000>;
>> +		};
>> +		opp-300000000 {
>> +			opp-hz = /bits/ 64 <300000000>;
>> +			opp-microvolt = <1100000>;
>> +		};
>> +		opp-400000000 {
>> +			opp-hz = /bits/ 64 <400000000>;
>> +			opp-microvolt = <1100000>;
>> +		};
>> +		opp-500000000 {
>> +			opp-hz = /bits/ 64 <500000000>;
>> +			opp-microvolt = <1100000>;
>> +		};
>>   	};
>>
>>   	h265e_mmu: iommu@ff330200 {
> 
> As for whether this works as described on a ROCK64 for glmark2-es2-wayland:

The probably most "convenient" and also future-proof solution upstream 
for that is to define voltage ranges á la



opp-200000000 {

		opp-hz = /bits/ 64 <200000000>;

		opp-microvolt = <950000 950000 1150000>;



};

and so on.

And then adapt the regulator-min-microvolt of the logic regulator like

vdd_logic: DCDC_REG1 {

	regulator-name = "vdd_logic";

	regulator-min-microvolt = <1050000>;

...
};

That way all opp-points will be taken, but its ensured, that vdd_log 
never goes below 1.05 V

> 
> Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> 
> There is some stuff worth noting that LibreELEC does on this SoC[1]:
> 
> 1. they use 1.05V for all OPPs up to and including 400 MHz
> 2. they run 500 MHz at 1.15V instead (though 1.10V seemed to work for both of
> us)

That might be true for your boards, but note that the required voltage 
is per "leakage level" defined in efuse bits - something we do not 
support for Rockchip upstream currently - see [1]

> 3. they disable 500 MHz because 1.15V was apparently too high for rkvdec.
> 
> 3 is currently not very relevant because mainline Linux has no rkvdec node in
> the rk3328 dtsi, and we're not running at 1.15V.
> 
> I've decided to add their rkvdec dtsi patch[2] on top anyway, and saw no
> complaints from the rkvdec module while glmark2-es2-drm was running. However,
> it's not like I tried to actually hardware decode video while it was running
> because the userspace situation still won't let me without compiling entirely
> too much stuff from git. Though the rkvdec module was loaded and present.
You will see no complaints from the module , but you will see the SoC 
crashing if both is running at the same time - see rkvdec-opp-table 
downstream [2]

[1] 
https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3328.dtsi#L750-L751

[2] 
https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3328.dtsi#L840-L867

Alex

> [1]: https://github.com/LibreELEC/LibreELEC.tv/commit/
> 9a6be0d36ba7ff3c3d5df798682d47a1de594ac0
> [2]: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/
> patches/linux/default/linux-1001-v4l2-rockchip.patch#L860-L935
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

