Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4782F3B2195
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFWUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:10:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40961C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:08:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m18so4011428wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fDQ/n6QIAJKpmUfoND9p8+BLVwwuVL87V6voHYHsC3k=;
        b=xS24CJ1rpozxgSv2uvbmxNlR6VjqJjNAoq0xRU5s7zEgdffkyFfqUGPU/kA1BUeHFW
         ekbNh9nuFH8qBAiN+SC7ybGJ0T03RON6wtBnPJ8vVY79o33Q71CO4OCVyxu/f9qI14Nh
         Ba2k318cFUqxEw0A0U0Ubo7bzVs9NnWspNLRAkqGQSQWL0NhJu10wDEl8iFBw7vTuZyL
         HuVC9us/qDN/V3pU5K3gvxmPmL9WzpE2sVIjZi8pMIk+POOIcD10ZQvChWtFntcTN4rt
         ipaE8LndyDLAJYOB1ww3UtMbV963oPYesaBNHOEFoGfM3zfhKwyt94s1LN8X8RuOTcaV
         8u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fDQ/n6QIAJKpmUfoND9p8+BLVwwuVL87V6voHYHsC3k=;
        b=HS8LMoz+sY9vMUxnieIVSJueSmAxFRchW+C3QUDxMyBHpRjRFlqyehtwJy+7VqTi2U
         NlgwVvC1fxVl14QkONJ0q1/7sIYT2cZq3XMoYYXAVuM4932L5hqUoTnpgtcXuyaT2S4g
         P1W2pr0tTSTCY+Kza3zbZ3GzxkuldUqo7gPxM8qu2MJoqepsFx1zTCp6B/icVP3Q23nH
         /FIC1P6EMP4yQV9ixmsYo4NahtJ6ZRx98mvgL4unNNz+1aTfucoLm3rYVteAqG/Wg1Gj
         83ytYdlRoBSgLEnlxKw62ajbGpY3yy10PCGwK5Ot+358HfH2n5V+/PPVrTd3T/GmF40X
         d4+A==
X-Gm-Message-State: AOAM530g92tFCnqFkHlhkpsOn2P+QfPsvRE9VAfFsrf7cNBx/H5o+OYu
        rfeIRP0oNDfW9KVYzT1z58iGboDzSNc0RlHP
X-Google-Smtp-Source: ABdhPJzgEUk2+RPzZJqOl3cQbMW9bslLbEqgO2qiPaZiG8680/7vFCtrFsXwnRmsb2adqROD476/4A==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr2157777wrn.409.1624478904577;
        Wed, 23 Jun 2021 13:08:24 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a562:3d0a:cd98:9ffd? ([2a01:e34:ed2f:f020:a562:3d0a:cd98:9ffd])
        by smtp.googlemail.com with ESMTPSA id f13sm984756wrt.86.2021.06.23.13.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:08:24 -0700 (PDT)
Subject: Re: [PATCH] Fix mt7622.dtsi thermal cpu
To:     Eric Woudstra <ericwouds@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
Date:   Wed, 23 Jun 2021 22:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2021 20:43, Eric Woudstra wrote:
> 
> I choose "hot" before, because 87 degrees seems ok to start frequency
> throttling. But, yes, it should be passive.
> 
> 87 is still quite low if I compare this temperature with the
> wrt3200acm Marvell dual core arm soc. They even went above 100
> degrees so I feel for an arm processor inside a router box it is fine
> to use 87 degrees But maybe someone at Mediatek can give some more
> details about operating temperatures.

Sometimes, the SoC vendor puts a high temperature in the DT just to
export the thermal zone and deal with it from userspace. So putting the
high temp allow the userspace (usually a thermal engine - Android stuff)
to deal with the mitigation without a kernel interaction.

Having more than 100°C could be this kind of setup. Only the operating
temperature from the hardware documentation will tell the safe
temperature for the silicon.

IMO, 77°C is a good compromise until getting the documented temp. 87°C
sounds to me a bit too hot.

> It may be possible to leave the active map in the device tree as some
> users of the bananapi might choose to install a fan as it is one of
> the options.

The active trip only makes sense if the cooling device is a fan (or any
active device), so the mapping points to a fan node, like:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi#n192

If there is no such [pwm] fan output on the board, no active trip point
should be added.

> ⁣Get BlueMail for Android ​
> 
> On Jun 23, 2021, 5:58 PM, at 5:58 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 23/06/2021 17:35, Eric Woudstra wrote:
>>> It is only useful to set 1 map with the regulated temperature for
>>> cpu frequency throttling. Same as in the kernel document
>>> example.
>>> 
>>> 
>>> It has no use to set frequency scaling on 2 different
>>> temperature trip points, as the lowest one makes sure the higher
>>> one(s) are never reached.
>> 
>> I looked more closely the DT and there is a misunderstanding of
>> the thermal framework in the definition.
>> 
>> There is one trip point with the passive type and the cpu cooling 
>> device, followed by a second trip point with the active type *but*
>> the same cpu cooling device. That is wrong.
>> 
>> And finally, there is the hot trip point as a third mapping and
>> the same cooling device.
>> 
>> The hot trip point is only there to notify userspace and let it
>> take an immediate action to prevent an emergency shutdown when
>> reaching the critical temperature.
>> 
>>> It can be applied only at 1 trip point. Multiple trip points is
>>> only usefully for fan control to make sure the fan is not too 
>>> noisy when it is not necessary to be noisy.
>>> 
>>> 
>>> The CPU will almost come to a dead stop when it starts to pass
>>> the lowest thermal map with frequency throttling.
>>> 
>>> This is why it is a bug and needs a fix, not only adjustment.
>> 
>> Yes, you are right. It should be something like (verbatim copy):
>> 
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt7622.dtsi index
>> 890a942ec608..88c81d24f4ff 100644 ---
>> a/arch/arm64/boot/dts/mediatek/mt7622.dtsi +++
>> b/arch/arm64/boot/dts/mediatek/mt7622.dtsi @@ -136,24 +136,18 @@
>> secmon_reserved: secmon@43000000 {
>> 
>> thermal-zones { cpu_thermal: cpu-thermal { -
>> polling-delay-passive = <1000>; +			polling-delay-passive = <250>; 
>> polling-delay = <1000>;
>> 
>> thermal-sensors = <&thermal 0>;
>> 
>> trips { cpu_passive: cpu-passive { -					temperature = <47000>; +
>> temperature = <77000>; hysteresis = <2000>; type = "passive"; };
>> 
>> -				cpu_active: cpu-active { -					temperature = <67000>; -
>> hysteresis = <2000>; -					type = "active"; -				}; - cpu_hot:
>> cpu-hot { temperature = <87000>; hysteresis = <2000>; @@ -173,18
>> +167,6 @@ map0 { cooling-device = <&cpu0 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>, <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>; }; - 
>> -				map1 { -					trip = <&cpu_active>; -					cooling-device =
>> <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>, -							 <&cpu1
>> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>; -				}; - -				map2 { -
>> trip = <&cpu_hot>; -					cooling-device = <&cpu0 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>, -							 <&cpu1 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>; -				}; }; }; };
>> 
>> 
>> -- <http://www.linaro.org/> Linaro.org │ Open source software for
>> ARM SoCs
>> 
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook | 
>> <http://twitter.com/#!/linaroorg> Twitter | 
>> <http://www.linaro.org/linaro-blog/> Blog
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
