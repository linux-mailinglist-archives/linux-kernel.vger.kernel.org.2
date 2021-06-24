Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290A3B2C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhFXKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhFXKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:23:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:21:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l21-20020a05600c1d15b02901e7513b02dbso493341wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a908WLTP46nDNm7SCDuYPdnHQENHhuim4bqnFOxZpAk=;
        b=MMa/xIIwkruT/appFbtoPVsAwuLDlAzpzSJCF3LAZuRmc7Hw9q4giEWHQQOHNG+SHx
         2oYJmbGGQeMRhCOqPCB8MwrBOpTh91c1TMQsclbwOFu53v7tDnGmQJJsVkjlAvb3YgaS
         NfgnefGcCvIjcgMrp9fQ/At9Za2GNL/DRzYhHdiuV62NcGw3yF5ldzSQ3Tp/RGX0Ccvg
         HqKu52HgHW7WeAYgFi1eqPN1XrUvLkaotXM7vDJyQdXaW0MCAp4oyWC7Wyjnrmq/ow02
         9PKpGSny2VRfIiR4vWIEm5Fy6HkJO0ustS5WnjcZRJg1O3ALA8TEooCqseWk9zmyKUIw
         WyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a908WLTP46nDNm7SCDuYPdnHQENHhuim4bqnFOxZpAk=;
        b=jINQew99bifgepw5M3hxhie/MgmIMEZowWvpfPWCKpbg+bIda3IvzcNiBZ6E41DncY
         mrNOnJNjqIdG3RTuqXR6YI0/07L2x66L87nslE43Zcq+TslEop0+FsV7IYlzrmh+BU17
         cj9TsR3D1zQSJqoggl+e38nXIA1gWBtSEzU+Q1/ydPoxX9yCZk2lXgjSoCAX8H+bRDt/
         f8who5i7SbwayS4V12kAazv+1WFWhvLkX9MxpT9veBtWJazPDC9nKRn7AGKgE6behaC0
         +UJ0pYWm/WwS+eL972MBj42jBPyIcRS6vsPpHEAq8/0VtAaFncGdIhEngR9O3I5/tqWD
         QlDQ==
X-Gm-Message-State: AOAM533QY/axL9SR5Au0nbSJ1S1hClF3wslzbKYNLWqyrAXkfRk7HmUa
        +MQ/bfbWnW6CArvJeHu6np/NfkIg8qVD/fSF
X-Google-Smtp-Source: ABdhPJw032EjZ6nZx0f++iW0xeOXlSOcRbN9ml8vMUHjVwjcQnRj3F9Wrq2UvdUmzN6TH7CnXi2viA==
X-Received: by 2002:a1c:f215:: with SMTP id s21mr3412276wmc.179.1624530071940;
        Thu, 24 Jun 2021 03:21:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8bf5:5c8b:9833:401c? ([2a01:e34:ed2f:f020:8bf5:5c8b:9833:401c])
        by smtp.googlemail.com with ESMTPSA id e15sm2873907wrm.60.2021.06.24.03.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 03:21:11 -0700 (PDT)
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
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
Date:   Thu, 24 Jun 2021 12:21:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2021 11:59, Eric Woudstra wrote:
> 
> For Marvell:
> 
> https://www.google.com/url?sa=t&source=web&rct=j&url=https://wiki.kobol.io/helios4/files/som/brochure_a38x_microsom_2017-09-05.pdf
> 
> Armada38x maximum die temperature 115 degrees Celcius. They really get hotter then 100.
> 
> But for mt7622 I cannot find this value

Found that:

https://download.kamami.pl/p579344-MT7622A_Datasheet_for_BananaPi_Only%281%29.pdf

Chapter 3.3 - Thermal Characteristics

Given the values I suggest:

 - Passive - 80°C

 - Hot - 90°C

 - Critical - 100°C

And passive polling set to 250ms.

It sounds like the sensor is not supporting the interrupt mode yet, so a
big gap is needed with the Tj IMO to give the time to detect the trip
point crossing with the polling.

> ⁣Get BlueMail for Android ​
> 
> On Jun 23, 2021, 10:08 PM, at 10:08 PM, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 23/06/2021 20:43, Eric Woudstra wrote:
>>>
>>> I choose "hot" before, because 87 degrees seems ok to start frequency
>>> throttling. But, yes, it should be passive.
>>>
>>> 87 is still quite low if I compare this temperature with the
>>> wrt3200acm Marvell dual core arm soc. They even went above 100
>>> degrees so I feel for an arm processor inside a router box it is fine
>>> to use 87 degrees But maybe someone at Mediatek can give some more
>>> details about operating temperatures.
>>
>> Sometimes, the SoC vendor puts a high temperature in the DT just to
>> export the thermal zone and deal with it from userspace. So putting the
>> high temp allow the userspace (usually a thermal engine - Android
>> stuff)
>> to deal with the mitigation without a kernel interaction.
>>
>> Having more than 100°C could be this kind of setup. Only the operating
>> temperature from the hardware documentation will tell the safe
>> temperature for the silicon.
>>
>> IMO, 77°C is a good compromise until getting the documented temp. 87°C
>> sounds to me a bit too hot.
>>
>>> It may be possible to leave the active map in the device tree as some
>>> users of the bananapi might choose to install a fan as it is one of
>>> the options.
>>
>> The active trip only makes sense if the cooling device is a fan (or any
>> active device), so the mapping points to a fan node, like:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi#n192
>>
>> If there is no such [pwm] fan output on the board, no active trip point
>> should be added.
>>
>>> ⁣Get BlueMail for Android ​
>>>
>>> On Jun 23, 2021, 5:58 PM, at 5:58 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>> On 23/06/2021 17:35, Eric Woudstra wrote:
>>>>> It is only useful to set 1 map with the regulated temperature for
>>>>> cpu frequency throttling. Same as in the kernel document
>>>>> example.
>>>>>
>>>>>
>>>>> It has no use to set frequency scaling on 2 different
>>>>> temperature trip points, as the lowest one makes sure the higher
>>>>> one(s) are never reached.
>>>>
>>>> I looked more closely the DT and there is a misunderstanding of
>>>> the thermal framework in the definition.
>>>>
>>>> There is one trip point with the passive type and the cpu cooling 
>>>> device, followed by a second trip point with the active type *but*
>>>> the same cpu cooling device. That is wrong.
>>>>
>>>> And finally, there is the hot trip point as a third mapping and
>>>> the same cooling device.
>>>>
>>>> The hot trip point is only there to notify userspace and let it
>>>> take an immediate action to prevent an emergency shutdown when
>>>> reaching the critical temperature.
>>>>
>>>>> It can be applied only at 1 trip point. Multiple trip points is
>>>>> only usefully for fan control to make sure the fan is not too 
>>>>> noisy when it is not necessary to be noisy.
>>>>>
>>>>>
>>>>> The CPU will almost come to a dead stop when it starts to pass
>>>>> the lowest thermal map with frequency throttling.
>>>>>
>>>>> This is why it is a bug and needs a fix, not only adjustment.
>>>>
>>>> Yes, you are right. It should be something like (verbatim copy):
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi 
>>>> b/arch/arm64/boot/dts/mediatek/mt7622.dtsi index
>>>> 890a942ec608..88c81d24f4ff 100644 ---
>>>> a/arch/arm64/boot/dts/mediatek/mt7622.dtsi +++
>>>> b/arch/arm64/boot/dts/mediatek/mt7622.dtsi @@ -136,24 +136,18 @@
>>>> secmon_reserved: secmon@43000000 {
>>>>
>>>> thermal-zones { cpu_thermal: cpu-thermal { -
>>>> polling-delay-passive = <1000>; +			polling-delay-passive = <250>; 
>>>> polling-delay = <1000>;
>>>>
>>>> thermal-sensors = <&thermal 0>;
>>>>
>>>> trips { cpu_passive: cpu-passive { -					temperature = <47000>; +
>>>> temperature = <77000>; hysteresis = <2000>; type = "passive"; };
>>>>
>>>> -				cpu_active: cpu-active { -					temperature = <67000>; -
>>>> hysteresis = <2000>; -					type = "active"; -				}; - cpu_hot:
>>>> cpu-hot { temperature = <87000>; hysteresis = <2000>; @@ -173,18
>>>> +167,6 @@ map0 { cooling-device = <&cpu0 THERMAL_NO_LIMIT
>>>> THERMAL_NO_LIMIT>, <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>; }; - 
>>>> -				map1 { -					trip = <&cpu_active>; -					cooling-device =
>>>> <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>, -							 <&cpu1
>>>> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>; -				}; - -				map2 { -
>>>> trip = <&cpu_hot>; -					cooling-device = <&cpu0 THERMAL_NO_LIMIT
>>>> THERMAL_NO_LIMIT>, -							 <&cpu1 THERMAL_NO_LIMIT
>>>> THERMAL_NO_LIMIT>; -				}; }; }; };
>>>>
>>>>
>>>> -- <http://www.linaro.org/> Linaro.org │ Open source software for
>>>> ARM SoCs
>>>>
>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook | 
>>>> <http://twitter.com/#!/linaroorg> Twitter | 
>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>
>>
>>
>> -- 
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
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
