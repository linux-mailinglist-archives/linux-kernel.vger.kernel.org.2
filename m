Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0833B439C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFYMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhFYMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:53:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE67C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:50:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w13so6190449wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3q2hj4q9wB8qmp/YlfpN0DitbMNMAnSRweZBDiZqwXI=;
        b=nCMQS4V942hTCkeHgxA5/hEOu5cPVhFPhcac/zVO69YAnYxFN/NndoZcso0bfuYydH
         evwv7ssyZd15LAc0o0n7VyiK5oa5Adt1MqboygueCw425lfHchnTOs8B57YnjvNcyBfH
         kCn2U6NXctjo6zE8t02d0a76AfURC4hX8frMXKo73+oGd2X0TcGZcc2IZRMMTS/4QzjZ
         EkzM4vMS5Hdicav8JSuHPiBk4XRQ/CNpJ1aJwFu5V2CpfNmxhgdXAY7CEbKJ2nrzPalm
         mvrzmzWrV4WX2rjjtrtd7cIyXGlsiJHcMF1P75EWSiSHrwSEZ2HPFdUXU/H2DeRhuUWS
         6HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3q2hj4q9wB8qmp/YlfpN0DitbMNMAnSRweZBDiZqwXI=;
        b=HbMSNnqUII2EYaRXae2WoQke1P5NlCCUgQ6w1nomyXw2jJrk9PwD3keV7kVWGiKGDg
         GO9P2lugCNlKeRo4GsagXkz0JbcuT+OWWgJ7W4cd4I2xgzG3j275TS1eckmyOmbWSLEs
         YkkXu8Ve5B3BoT17GPHNuEiND0xGSLoUTd+bvli1e+jZgF617G8GzrWZpdWrQlTZPuTi
         emzrwLIVBo7W8J8Kaah85tBnZqCqqcCyVZJk+PnUrNg2k8L8ZTidFntEOQKL+OsUuhbB
         nRpSpwMbeWRhzsrpohxZ+hOzEQ3GjDvy6Zkm4sqopSzpQIC95+XtR1LCsvfdFkm5HAIo
         mqDg==
X-Gm-Message-State: AOAM530AdUIyV2smSq1MGR1wBSP1/mPOV1xkVd8tbrD2cHRUF0ozNNSf
        NxIrFCvEQTC1CReWoVb5M6THIg==
X-Google-Smtp-Source: ABdhPJwepCnbNjUznqf4+se6+PE93Avwc76AApO0H/TB3qvRp25uhoHT+KCcmO076e1O/A//zhMUAg==
X-Received: by 2002:a1c:f215:: with SMTP id s21mr10500015wmc.179.1624625444006;
        Fri, 25 Jun 2021 05:50:44 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0? ([2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0])
        by smtp.googlemail.com with ESMTPSA id s5sm6177768wrn.38.2021.06.25.05.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 05:50:43 -0700 (PDT)
Subject: Re: Aw: Re: Re: Re: [PATCH] Fix mt7622.dtsi thermal cpu
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
 <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
 <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org>
 <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
 <915b101a-6bea-ae96-78ed-d27fa5bfce3a@linaro.org>
 <trinity-59bd4461-3429-4382-9754-90cf20287cad-1624624111998@3c-app-gmx-bs66>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <67107afb-6ed9-9681-6fce-0d52e567ea12@linaro.org>
Date:   Fri, 25 Jun 2021 14:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-59bd4461-3429-4382-9754-90cf20287cad-1624624111998@3c-app-gmx-bs66>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2021 14:28, Frank Wunderlich wrote:
>> Gesendet: Freitag, 25. Juni 2021 um 13:47 Uhr
>> Von: "Daniel Lezcano" <daniel.lezcano@linaro.org>
> 
>>> but we need to disable the passive trip as cpu-trotteling starts there...the higher temperature trips are currently not reached
>>
>> Sorry, can you rephrase it ? I'm not getting the point.
> 
> the problem currently is that passive is at 47degress Celsius and
> trottles cpu, active (67°C) and hot points are never reached this way.
> so at least we need to change temperatures in dtsi, and maybe disable
> cpu-trotteling on passive trip. imho fan will never start if it is in
> active and cpu is trottled before in passive

Ok, thanks for the clarification.

>>> summary
>>>
>>> moving fan and cpu_thermal-override to bananapi-r64.dts
>>>
>>> passive-trip: cooling-device = <&cpu0/1 0 0> as in erics Patch
>>> active trip: cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> the other 2 unchanged
>>>
>>> but i suggest changing the temperature points in mt7622 dtsi as this is SoC specific
>>>
>>> so basicly:
>>>
>>> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>>> @@ -143,13 +143,13 @@ cpu_thermal: cpu-thermal {
>>>
>>>                         trips {
>>>                                 cpu_passive: cpu-passive {
>>> -                                       temperature = <47000>;
>>> +                                       temperature = <70000>;
>>
>> May be increase the passive temp to 75°C.
>>
>>>                                         hysteresis = <2000>;
>>>                                         type = "passive";
>>>                                 };
>>>
>>>                                 cpu_active: cpu-active {
>>> -                                       temperature = <67000>;
>>> +                                       temperature = <80000>;
>>>                                         hysteresis = <2000>;
>>>                                         type = "active";
>>>                                 };
>>
>> Move the active trip 'cpu_active' to mt7622-bananapi-bpi-r64.dts. and
>> set it to 70°C in the mt7622-bananapi-bpi-r64.dts, so the fan will act
>> before the cpu throttling.
>>
>> The behavior should be the following: The temperature reaches 70°C, the
>> fan will start, if the temperature continues to increase, it will
>> increase the speed. If the temperature reaches 75°C, the fan is still
>> rotating at full speed but the cpu begins to be throttled.
> 
> passive to 75 and active lower to 70? is this as intended that active comes before passive?

Yes. So there is a default passive mitigation temp for the SoC at 75°C.
And the bpi has a setup with a fan mitigating before the cpu throttling.

> mt7622-bananapi-bpi-r64.dts:
> 
> &cpu_thermal {
> 	trips {
> 		cpu_passive: cpu-passive {
> 			temperature = <75000>;
> 			hysteresis = <2000>;
> 			type = "passive";
> 		};

No need to add this trip point, it should be changed to 75°C in SoC DT
mt7622.dtsi. This fragment of DT will concatenate with the previous one.

> 		cpu_active: cpu-active {
> 			temperature = <70000>;
> 			hysteresis = <2000>;
> 			type = "active";
> 		};
> 	};
> 
> 	cooling-maps {
> 		map1 {
> 			trip = <&cpu_active>;
> 			cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 		};
> 	};
> };
> 
> 
>> AFAIU, it is a Cortex-A53 running @1.35GH, so except the board is in a
>> black metal box under the sun, I don't see how we can reach this thermal
>> limits.
>>
>>> @@ -170,8 +170,8 @@ cpu-crit {
>>>                         cooling-maps {
>>>                                 map0 {
>>>                                         trip = <&cpu_passive>;
>>> -                                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>> -                                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>> +                                       cooling-device = <&cpu0 0 0>,
>>> +                                                        <&cpu1 0 0>;
>>
>> You should keep it untouched.
> 
> then cpu is trottled at passive point (currently 47°C) and imho fan does not start at active
> 
>>>                                 };
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
