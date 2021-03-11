Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667DD3371E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhCKL7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhCKL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:59:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC236C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:59:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f12so1541251wrx.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sZHKANcfp4HNPSh4JPMPf2bq7tkkwGzMZt04c3NuqNM=;
        b=slLbTWW+VCiQjXJ0yTY3dZELEMPbF3D/++3Ly5kWq1OvjC25KtW+/hnON08Z7DLU0E
         f6ZRIJhgOPVk49Bl8C2BxCqXG79ROzFy3CnS7RjxVD61hr/tk+uRrSe/eZ2Up5hg6G+F
         EEmkshnsttUouBqiWmrehhJl3E8fFoSh1VMviSypCHWTown2HoXUfxJLttdwklR8FkyF
         w/4qs0fxAI2tEITnk19lYd9EKZ1vqs6J+1oWwsZW0uKRNFBm6C5JOcfRG1eY0Ta6cSO1
         XTYcB3WUISPfERpIlWT+sYSxeruvrA6vdrQHLy5c3jZkjD13ZSY2UybKVS4XMRG3Si4z
         j0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZHKANcfp4HNPSh4JPMPf2bq7tkkwGzMZt04c3NuqNM=;
        b=qcVg6JSvrSDeVHqXGyEszBQiGjvxBqwXFak4SfVqpgGzz5uFeGmK0WgQE572YzykbG
         hXrR6XAzdAcljGofDwhc18c255Uu1HdLDHaU9EhSt4PIhjLRyUg0NYcgIRToQcVsiV3I
         Gqu5SFqpP37+PQJwWpopBDKR9JpVBnPZ6ggWWxcpYWydDCHeZxKRk9/XEUpbFXTqJ7CE
         POt5Mt3gKNXZiNYEhLDdkOtMu/SBneRYOuc0a+wEKPRQWOuWH9zcHFH3il3v6DLywC/e
         4LBhw90lzbTl5D+IFmTBjhiIUBRydltWTSCd/zEI75eS5RFRszAvz8AZfCC2lhMuJb1n
         8WXw==
X-Gm-Message-State: AOAM533HIpEtHKCBom+vMFLnScCq67D+JWR9LY5ciPP2v8E9Y5SufnrF
        gQe67isx8hAs4w7nqK0rbwT6e/r2oQlJ3A==
X-Google-Smtp-Source: ABdhPJyGW237VA0pOXRhgzw1B/QCI5NH543/K3au6kCa1Mi5BCUfrAiNV+sDspN6mup1sB4o/iEoIw==
X-Received: by 2002:adf:a406:: with SMTP id d6mr8435048wra.141.1615463940408;
        Thu, 11 Mar 2021 03:59:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4? ([2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4])
        by smtp.googlemail.com with ESMTPSA id m10sm3455006wmh.13.2021.03.11.03.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 03:59:00 -0800 (PST)
Subject: Re: [RESEND PATCH v5 2/4] arm64: dts: rk3399: Add dfi and dmc nodes.
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
 <20210308233858.24741-2-daniel.lezcano@linaro.org>
 <9c36893a-6ca8-dade-e203-890a4071bf50@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5f66f43e-8b50-39f2-f326-07a9378c0909@linaro.org>
Date:   Thu, 11 Mar 2021 12:58:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c36893a-6ca8-dade-e203-890a4071bf50@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 12:42, Johan Jonker wrote:
> Hi Daniel,
> 
> Some comments. Have a look if it's useful or that you disagree with.
> 
> New nodes should be verifiable if possible.
> Especially with so many properties.
> Could you convert rockchip-dfi.txt and rk3399_dmc.txt to yaml instead of
> changing old txt documents?
> Add rockchip-dfi.yaml and rk3399_dmc.yaml before this patch in version 6.

I don't have a lot of bandwidth to do it but I will give a try.

Thanks for reviewing

  -- Daniel

> Nodes and properties have a sort order. Please fix.
> Some goes for [RESEND PATCH v5 3/4].
> 
> (This is a generic dtsi. How about cooling and dmc ??)
> 
> ----
> Heiko rules:
> 
> compatible
> reg
> interrupts
> [alphabetical]
> status [if needed]
> 
> ----
> My incomplete list:
> 
> For nodes:
> If exists on top: model, compatible and chosen.
> Sort things without reg alphabetical first,
> then sort the rest by reg address.
> 
> Inside nodes:
> If exists on top: compatible, reg and interrupts.
> In alphabetical order the required properties.
> Then in alphabetical order the other properties.
> And as last things that start with '#' in alphabetical order.
> Add status below all other properties for soc internal components with
> any board-specifics.
> Keep an empty line between properties and nodes.
> 
> Exceptions:
> Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
> and dma-names.
> Sort simple-audio-card,name above other simple-audio-card properties.
> Sort regulator-name above other regulator properties.
> Sort regulator-min-microvolt above regulator-max-microvolt.
> 
> On 3/9/21 12:38 AM, Daniel Lezcano wrote:
>> From: Lin Huang <hl@rock-chips.com>
>>
>> These are required to support DDR DVFS on rk3399 platform.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index edbbf35fe19e..6f23d99236fe 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1937,6 +1937,25 @@
>>  		status = "disabled";
>>  	};
>>  
>> +	dfi: dfi@ff630000 {
>> +		reg = <0x00 0xff630000 0x00 0x4000>;
>> +		compatible = "rockchip,rk3399-dfi";
>> +		rockchip,pmu = <&pmugrf>;
>> +		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
>> +		clocks = <&cru PCLK_DDR_MON>;
>> +		clock-names = "pclk_ddr_mon";
>> +		status = "disabled";
>> +	};
>> +
>> +	dmc: dmc {
>> +		compatible = "rockchip,rk3399-dmc";
>> +		rockchip,pmu = <&pmugrf>;
>> +		devfreq-events = <&dfi>;
>> +		clocks = <&cru SCLK_DDRC>;
>> +		clock-names = "dmc_clk";
>> +		status = "disabled";
>> +	};
>> +
>>  	pinctrl: pinctrl {
>>  		compatible = "rockchip,rk3399-pinctrl";
>>  		rockchip,grf = <&grf>;
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
